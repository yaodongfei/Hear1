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


param swaggerContent string ='{
  &quot;swagger&quot;: &quot;2.0&quot;,
  &quot;servers&quot;: {
    &quot;url&quot;: &quot;https//test.aiaazure.biz/test&quot;
  },
  &quot;info&quot;: {
    &quot;description&quot;: &quot;# Knife4j RESTful APIs&quot;,
    &quot;version&quot;: &quot;1.0&quot;,
    &quot;termsOfService&quot;: &quot;https://doc.xiaominfo.com/&quot;,
    &quot;contact&quot;: {
      &quot;name&quot;: &quot;yd&quot;
    }
  },
  &quot;host&quot;: &quot;localhost:9001&quot;,
  &quot;basePath&quot;: &quot;/&quot;,
  &quot;tags&quot;: [
  ],
  &quot;paths&quot;: {
    &quot;/devlopview/log-publish-relation/updatePublishStatus&quot;: {
      &quot;post&quot;: {
        &quot;tags&quot;: [
          &quot;关联发布&quot;
        ],
        &quot;summary&quot;: &quot;关联发布状态修改&quot;,
        &quot;operationId&quot;: &quot;updatePublishStatusUsingPOST&quot;,
        &quot;description&quot;: &quot;关联发布状态修改&quot;,
        &quot;consumes&quot;: [
          &quot;application/json&quot;
        ],
        &quot;produces&quot;: [
          &quot;*/*&quot;
        ],
        &quot;parameters&quot;: [
          {
            &quot;in&quot;: &quot;body&quot;,
            &quot;name&quot;: &quot;command&quot;,
            &quot;description&quot;: &quot;command&quot;,
            &quot;required&quot;: true,
            &quot;schema&quot;: {
              &quot;$ref&quot;: &quot;#/definitions/LogUpdatePublishStatusSave&quot;
            }
          },
          {
            &quot;name&quot;: &quot;token&quot;,
            &quot;in&quot;: &quot;header&quot;,
            &quot;description&quot;: &quot;用户token信息&quot;,
            &quot;required&quot;: false,
            &quot;type&quot;: &quot;string&quot;
          }
        ],
        &quot;responses&quot;: {
          &quot;200&quot;: {
            &quot;description&quot;: &quot;OK&quot;
          },
          &quot;201&quot;: {
            &quot;description&quot;: &quot;Created&quot;
          },
          &quot;401&quot;: {
            &quot;description&quot;: &quot;Unauthorized&quot;
          },
          &quot;403&quot;: {
            &quot;description&quot;: &quot;Forbidden&quot;
          },
          &quot;404&quot;: {
            &quot;description&quot;: &quot;Not Found&quot;
          }
        }
      }
    }
  }
}'

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






