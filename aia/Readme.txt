.
├── OpenAPI.json         This is swagger json file
├── bicep_generator.py   Python script for generating bicep files
├── main.bicep           When executing bicep_Generator.py will generate this file
├── policy_mappings.json Mapping operations/apis and policy
└── template.bicep       A template engine similar to Mustache used in Python


1.policy_mappings.json Configuration Details：
{
  "apisPolicy": {
    "filePath": The file path of apis' policy
    "encoding": file's encoding,default value 'utf-8'
  },
  "operationPolices": [
    {
      "pathOperationId": The operationId is the specific path operationId from the swagger file (OpenApi.json)
      "filePath": The file path of operations' policy
      "encoding": file's encoding,default value 'utf-8'
    }
  ]
}