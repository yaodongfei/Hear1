import json
import os
import re
import yaml

import chevron


# Parse the swagger file and generate the bicep file
def handler_data(data):
    global value
    data['contentFormat'] = 'swagger-link-json'
    paths_2 = []
    for key, value in data['paths'].items():
        tmp_path = {'path': key}
        for key2, value2 in value.items():
            tmp_path['method'] = key2
            tmp_path['detail'] = value2
        paths_2.append(tmp_path)
    data['paths_2'] = paths_2

    # use the last one server in servers
    for server in data['servers']:
        tmp_server = {}
        url = server['url']
        server_variables = server['variables']
        for match in re.finditer(r'{(.*?)}', url):
            placeholder = match.group(0)
            key = match.group(1)
            if key in server_variables:
                url = url.replace(placeholder, server_variables[key]['default'])
        tmp_server['url'] = url
        parts = url.split("/", 3)

        if len(parts) > 3:
            result = "/".join(parts[3:])
            tmp_server['basePath'] = result
            tmp_server['url'] = parts[0] + "//" + parts[2] + "/"
        else:
            pass

        data['server'] = tmp_server
    # read and parse policy_mappings.json file in current directory
    policy_mappings = []
    with open('policy_mappings.json', 'r') as f2:
        policy_mappings2 = json.load(f2)
        # check if exist apis policy
        apis_policy = policy_mappings2.get('apisPolicy')
        if apis_policy is not None and apis_policy.get('filePath') is not None and apis_policy['filePath']:
            if not (apis_policy.get('encoding') is not None and apis_policy['encoding']):
                apis_policy['encoding'] = 'utf-8'
            data['apiPolicies'] = [apis_policy]
        else:
            data['apiPolicies'] = []

        for policy_mapping in policy_mappings2['operationPolices']:
            # check mapping values
            if (policy_mapping.get('filePath') is not None and policy_mapping['filePath']
                    and policy_mapping.get('pathOperationId') is not None and policy_mapping['pathOperationId']):
                if not (policy_mapping.get('encoding') is not None and policy_mapping['encoding']):
                    policy_mapping['encoding'] = 'utf-8'
                policy_mappings.append(policy_mapping)
    data['policy_mappings'] = policy_mappings
    # Reade the template.bicep in current directory
    template_bicep = ''
    with open('template.bicep', 'r') as f3:
        template_bicep = f3.read()
    # Render the template with the data from the swagger.json file
    rendered = chevron.render(template_bicep, data)
    # Write the rendered template to a new file
    with open('main.bicep', 'w') as f4:
        f4.write(rendered)


swagger_file_yaml = 'OpenAPI.yaml'
swagger_file_yml = 'OpenAPI.yml'
swagger_file_json = 'OpenAPI.json'

if os.path.exists(swagger_file_yaml):
    # Read and parse the swagger.json file in the current directory
    with open(swagger_file_yaml, 'r') as yaml_file:
        data = yaml.safe_load(yaml_file)
elif os.path.exists(swagger_file_yml):
    with open(swagger_file_yml, 'r') as yaml_file:
        data = yaml.safe_load(yaml_file)
elif os.path.exists(swagger_file_json):
    # Read and parse the swagger.json file in the current directory
    with open(swagger_file_json, 'r') as f:
        data = json.load(f)
        handler_data(data)
