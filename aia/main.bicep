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

resource apiDefinition 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementService
  name: 'apisName'
  properties: {
    apiVersion: '1.0'
    description: '# Knife4j RESTful APIs'
    displayName: ''
    contact: {
        email:''
        name:'yd'
        url:''
    }
    serviceUrl: 'https://demo.gigantic-server.com:8443/'
    path: 'v2'
    protocols: ['https','http']
    format: 'swagger-link-json'
    value: loadTextContent('','')
  }
}


resource apisPolicy 'Microsoft.ApiManagement/service/apis/policies@2021-01-01-preview' = {
  parent: apiDefinition
  name: 'policy'
  properties: {
    format: 'xml'
    value: loadTextContent('policy.xml','utf-8')
  }
}




resource updatePublishStatusUsingPOST 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  parent: apiDefinition
  name: 'updatePublishStatusUsingPOST'
  properties: {
    description: '关联发布状态修改'
    displayName: '关联发布状态修改'
    method: 'post'
    urlTemplate: '/devlopview/log-publish-relation/updatePublishStatus'

  }
}




resource updatePublishStatusUsingPOSTPolicy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  parent: updatePublishStatusUsingPOST
  name: 'policy'
  properties: {
    format: 'xml'
    value: loadTextContent('policy.xml','utf-8')
  }
}


