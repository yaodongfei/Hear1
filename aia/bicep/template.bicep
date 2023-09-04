param environment string = 'dev'
var serviceName = if(environment == 'dev'){
    'dev-apim'
}else if(environment == 'uat'){
    'ust-apim'
}else if(environment == 'uat'){
    'prd-apim'
}else{
    'dev-apim'
}


resource apiManagementService 'Microsoft.ApiManagement/service@2023-01-01-preview' existing = {
  name: serviceName
}

resource apiDefinition 'Microsoft.ApiManagement/service/apis@2023-01-01-preview' = {
  parent: apiManagementService
  name: 'apisName'
  properties: {
    apiVersion: '{{info.version}}'
    description: '{{info.description}}'
    displayName: '{{info.title}}'
    contact: {
        email:'{{info.contact.email}}'
        name:'{{info.contact.name}}'
        url:'{{info.contact.url}}'
    }
    serviceUrl: '{{server.url}}'
    path: '{{server.basePath}}'
    protocols: ['https','http']
    format: '{{swaggerFormat}}'
    value: loadTextContent('{{path_prefix}}{{swaggerFile}}','utf-8')
  }
}


{{#apiPolicies}}
resource apisPolicy 'Microsoft.ApiManagement/service/apis/policies@2023-01-01-preview' = {
  parent: apiDefinition
  name: 'policy'
  properties: {
    format: 'xml'
    value: loadTextContent('{{path_prefix}}{{filePath}}','{{encoding}}')
  }
}
{{/apiPolicies}}




{{#paths_2}}
resource {{detail.operationId}} 'Microsoft.ApiManagement/service/apis/operations@2023-01-01-preview' = {
  parent: apiDefinition
  name: '{{detail.operationId}}'
  properties: {
    description: '{{detail.description}}'
    displayName: '{{detail.summary}}'
    method: '{{method}}'
    urlTemplate: '{{path}}'

  }
}
{{/paths_2}}




{{#policy_mappings}}
resource {{pathOperationId}}Policy 'Microsoft.ApiManagement/service/apis/operations/policies@2023-01-01-preview' = {
  parent: {{pathOperationId}}
  name: 'policy'
  properties: {
    format: 'xml'
    value: loadTextContent('{{path_prefix}}{{filePath}}','{{encoding}}')
  }
}
{{/policy_mappings}}


