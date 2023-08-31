@description('The name of the API Management service instance')
param apiManagementServiceName string = '{{info.title}}'

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

resource apiManagementService 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: apiManagementServiceName
  location: location
  sku: {
    name: sku
    capacity: skuCount
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}


param serviceName string
param swaggerContent object ={{swaggerContent}}



{{#paths_2}}

resource {{detail.operationId}} 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
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

resource {{pathOperationId}}Policy 'Microsoft.ApiManagement/service/apis/policies@2021-01-01-preview' = {
  parent: {{pathOperationId}}
  name: 'policy'
  properties: {
    format: 'rawxml'
    value: file('{{filePath}}')
  }
}
{{/policy_mappings}}
