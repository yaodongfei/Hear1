param environment string = 'dev'

param serviceName string
var serviceName = if(environment == 'dev'){
    'dev-apim'
}else if(environment == 'uat'){
    'ust-apim'
}else if(environment == 'uat'){
    'prd-apim'
}else{
    'dev-apim'
}


resource apiManagementService 'Microsoft.ApiManagement/service@2021-08-01' existing = {
  name: serviceName
}


param swaggerContent object ={{swaggerContent}}

resource apiDefinition 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementService
  name: 'apisName'
  properties: {
    apiVersion: '{{info.version}}'
    description: '{{info.description}}'
    displayName: '{{info.title}}'
    contact: {{info.contact}}
    serverUrl: '{{servers.url}}',
    protocols: ['https','http']
    contentFormat: '{{contentFormat}}'
    contentValue: swaggerContent
  }
}


{{#apiPolicies}}
resource apisPolicy 'Microsoft.ApiManagement/service/apis/policies@2021-01-01-preview' = {
  parent: apiDefinition
  name: 'policy'
  properties: {
    format: 'xml'
    value: loadTextContent('{{filePath}}','{{encoding}}')
  }
}
{{/apiPolicies}}




{{#paths_2}}
resource {{detail.operationId}} 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  parent: apiDefinition,
  name: '{{detail.operationId}}',
  properties: {
    description: '{{detail.description}}'
    displayName: '{{detail.summary}}'
    method: '{{method}}'
    urlTemplate: '{{path}}'

  }
}
{{/paths_2}}




{{#policy_mappings}}
resource {{pathOperationId}}Policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  parent: {{pathOperationId}}
  name: 'policy'
  properties: {
    format: 'xml'
    value: loadTextContent('{{filePath}}','{{encoding}}')
  }
}
{{/policy_mappings}}

