@description('The email address of the owner of the service')
param publisherEmail string ='{{info.contact.eamil}}'

@description('The name of the owner of the service')
@minLength(0)
param publisherName string  ='{{info.contact.name}}'

@description('The pricing tier of this API Management service')
@allowed([
  'Developer'
  'Standard'
  'Premium'
])
param sku string = 'Developer'

@description('The instance size of this API Management service.')
@allowed([
  1
  2
])
param skuCount int = 1

@description('Location for all resources.')
param location string = resourceGroup().location

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
  name: '{{detail.operationId}}'
  properties: {
    path: '{{path}}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent
  }
}


{{#apiPolicies}}
resource apisPolicy 'Microsoft.ApiManagement/service/apis/policies@2021-01-01-preview' = {
  parent: apiDefinition
  name: 'policy'
  properties: {
    format: 'rawxml'
    value: file('{{.}}')
  }
}
{{/apiPolicies}}




{{#paths_2}}
resource {{detail.operationId}} 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  parent: apiDefinition
  name: '{{detail.operationId}}'
  properties: {
    path: '{{path}}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}
{{/paths_2}}




{{#policy_mappings}}
resource {{pathOperationId}}Policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  parent: {{pathOperationId}}
  name: 'policy'
  properties: {
    format: 'rawxml'
    value: file('{{filePath}}')
  }
}
{{/policy_mappings}}


