.
├── OpenAPI.json         This is swagger json file
├── bicep_generator.py   Python script for generating bicep files
├── main.bicep           When executing bicep_Generator.py will generate this file
├── policy_mappings.json Mapping operations/apis and policy
└── template.bicep       A template engine similar to Mustache used in Python


1.install python 3.X
2.install python package by blew command:
pip install -r requirements.txt
3.run command:
python /Users/yaodong/gushi_ai/aia/test/bicep_generator.py /Users/yaodong/gushi_ai/aia
 '/Users/yaodong/gushi_ai/aia/test/bicep_generator.py': the python file path
'/Users/yaodong/gushi_ai/aia': the swagger file and policy mappings file's path


3.policy_mappings.json Configuration Details：
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
