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


param swaggerContent object ={'swagger': '2.0', 'servers': {'url': 'https//test.aiaazure.biz/test'}, 'info': {'description': '# Knife4j RESTful APIs', 'version': '1.0', 'termsOfService': 'https://doc.xiaominfo.com/', 'contact': {'name': 'yd'}}, 'host': 'localhost:9001', 'basePath': '/', 'tags': [], 'paths': {'/devlopview/log-publish-relation/updatePublishStatus': {'post': {'tags': ['关联发布'], 'summary': '关联发布状态修改', 'operationId': 'updatePublishStatusUsingPOST', 'description': '关联发布状态修改', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/LogUpdatePublishStatusSave'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}}}

resource apiDefinition 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementService
  name: 'apisName'
  properties: {
    apiVersion: '1.0'
    description: '# Knife4j RESTful APIs'
    displayName: ''
    contact: {'name': 'yd'}
    serverUrl: 'https//test.aiaazure.biz/test',
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent
  }
}






resource updatePublishStatusUsingPOST 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  parent: apiDefinition,
  name: 'updatePublishStatusUsingPOST',
  properties: {
    description: '关联发布状态修改'
    displayName: '关联发布状态修改'
    method: 'post'
    urlTemplate: '/devlopview/log-publish-relation/updatePublishStatus'

  }
}






