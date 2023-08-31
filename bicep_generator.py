import json
import os
import chevron

swaggerContent = {}
with open('OpenAPI.json', 'r') as f:
    swaggerContent = json.load(f)

# Read and parse the swagger.json file in the current directory
with open('OpenAPI.json', 'r') as f:
    data = json.load(f)
    data['swaggerContent'] = swaggerContent

    paths_2 = []
    for key, value in data['paths'].items():
        tmp_path = {'path': key}
        for key2, value2 in value.items():
            tmp_path['method'] = key2
            tmp_path['detail'] = value2
        paths_2.append(tmp_path)
    data['paths_2'] = paths_2

    # read and parse policy_mappings.json file in current directory
    policy_mappings = []
    with open('policy_mappings.json', 'r') as f2:
        policy_mappings2 = json.load(f2)
        for policy_mapping in policy_mappings2:
            if (policy_mapping['filePath'] is not None and policy_mapping['filePath']
                    and policy_mapping['pathOperationId'] is not None and policy_mapping['pathOperationId']):
                policy_mappings.append(policy_mapping)
    data['policy_mappings'] = policy_mappings

    # Reade the template.bicep in current directory
    template_bicep = ''
    with open('template.bicep', 'r') as f3:
        template_bicep = f3.read()
    # Render the template with the data from the swagger.json file
    rendered = chevron.render(template_bicep, data)

    # Write the rendered template to a new file
    with open('main.bicep', 'w') as f:
        f.write(rendered)
