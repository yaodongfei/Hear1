@description('The name of the API Management service instance')
param apiManagementServiceName string = ''

@description('The email address of the owner of the service')
param publisherEmail string =''

@description('The name of the owner of the service')
@minLength(0)
param publisherName string  ='yd'

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
param swaggerContent object ={'swagger': '2.0', 'info': {'description': '# Knife4j RESTful APIs', 'version': '1.0', 'termsOfService': 'https://doc.xiaominfo.com/', 'contact': {'name': 'yd'}}, 'host': 'localhost:9001', 'basePath': '/', 'tags': [{'name': 'node-controller', 'description': 'Node Controller'}, {'name': '关联发布', 'description': 'Log Publish Relation Controller'}, {'name': '关联测试', 'description': 'Log Test Relation Controller'}, {'name': '构建版本', 'description': 'Node Pipeline Log Controller'}, {'name': '测试测试！！', 'description': 'Test Controller'}, {'name': '用户管理中心', 'description': 'User Controller'}, {'name': '结构节点视图', 'description': 'Node Controller'}, {'name': '节点类型', 'description': 'Node Type Controller'}, {'name': '节点配置信息', 'description': 'Node Info Controller'}, {'name': '规划版本', 'description': 'Version Plan Controller'}, {'name': '规划版本-关联构建版本', 'description': 'Version Plan Node Pipeline Log Relation Controller'}, {'name': '规划版本-关联规划版本', 'description': 'Version Plan Relation Controller'}], 'paths': {'/devlopview/log-publish-relation/detail/{logId}': {'get': {'tags': ['关联发布'], 'summary': '查询关联发布详情', 'operationId': 'getDetailUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'logId', 'in': 'path', 'description': 'logId', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/LogPublishRelationVo'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/devlopview/log-publish-relation/updatePublishStatus': {'post': {'tags': ['关联发布'], 'summary': '关联发布状态修改', 'operationId': 'updatePublishStatusUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/LogUpdatePublishStatusSave'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/node/add': {'get': {'tags': ['node-controller'], 'summary': 'add', 'operationId': 'addUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'head': {'tags': ['node-controller'], 'summary': 'add', 'operationId': 'addUsingHEAD', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'post': {'tags': ['node-controller'], 'summary': 'add', 'operationId': 'addUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'put': {'tags': ['node-controller'], 'summary': 'add', 'operationId': 'addUsingPUT', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'delete': {'tags': ['node-controller'], 'summary': 'add', 'operationId': 'addUsingDELETE', 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'options': {'tags': ['node-controller'], 'summary': 'add', 'operationId': 'addUsingOPTIONS', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'patch': {'tags': ['node-controller'], 'summary': 'add', 'operationId': 'addUsingPATCH', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}}, '/node/delete': {'get': {'tags': ['node-controller'], 'summary': 'delete', 'operationId': 'deleteUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'query', 'description': 'id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'head': {'tags': ['node-controller'], 'summary': 'delete', 'operationId': 'deleteUsingHEAD', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'query', 'description': 'id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'post': {'tags': ['node-controller'], 'summary': 'delete', 'operationId': 'deleteUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'query', 'description': 'id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'put': {'tags': ['node-controller'], 'summary': 'delete', 'operationId': 'deleteUsingPUT', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'query', 'description': 'id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'delete': {'tags': ['node-controller'], 'summary': 'delete', 'operationId': 'deleteUsingDELETE', 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'query', 'description': 'id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'options': {'tags': ['node-controller'], 'summary': 'delete', 'operationId': 'deleteUsingOPTIONS', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'query', 'description': 'id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'patch': {'tags': ['node-controller'], 'summary': 'delete', 'operationId': 'deleteUsingPATCH', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'query', 'description': 'id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}}, '/node/list': {'get': {'tags': ['node-controller'], 'summary': 'page', 'operationId': 'pageUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'maxLevel', 'in': 'query', 'description': '最大级别 查询不大于此level的数据', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'pageNo', 'in': 'query', 'description': '当前页码', 'required': True, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 1}, {'name': 'pageSize', 'in': 'query', 'description': '每页最大记录数', 'required': True, 'type': 'integer', 'maximum': 9223372036854775807, 'exclusiveMaximum': False, 'minimum': 0, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 15}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/带分页结果的数据«节点树»'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'head': {'tags': ['node-controller'], 'summary': 'page', 'operationId': 'pageUsingHEAD', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'maxLevel', 'in': 'query', 'description': '最大级别 查询不大于此level的数据', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'pageNo', 'in': 'query', 'description': '当前页码', 'required': True, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 1}, {'name': 'pageSize', 'in': 'query', 'description': '每页最大记录数', 'required': True, 'type': 'integer', 'maximum': 9223372036854775807, 'exclusiveMaximum': False, 'minimum': 0, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 15}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/带分页结果的数据«节点树»'}}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'post': {'tags': ['node-controller'], 'summary': 'page', 'operationId': 'pageUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'maxLevel', 'in': 'query', 'description': '最大级别 查询不大于此level的数据', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'pageNo', 'in': 'query', 'description': '当前页码', 'required': True, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 1}, {'name': 'pageSize', 'in': 'query', 'description': '每页最大记录数', 'required': True, 'type': 'integer', 'maximum': 9223372036854775807, 'exclusiveMaximum': False, 'minimum': 0, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 15}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/带分页结果的数据«节点树»'}}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'put': {'tags': ['node-controller'], 'summary': 'page', 'operationId': 'pageUsingPUT', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'maxLevel', 'in': 'query', 'description': '最大级别 查询不大于此level的数据', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'pageNo', 'in': 'query', 'description': '当前页码', 'required': True, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 1}, {'name': 'pageSize', 'in': 'query', 'description': '每页最大记录数', 'required': True, 'type': 'integer', 'maximum': 9223372036854775807, 'exclusiveMaximum': False, 'minimum': 0, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 15}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/带分页结果的数据«节点树»'}}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'delete': {'tags': ['node-controller'], 'summary': 'page', 'operationId': 'pageUsingDELETE', 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'maxLevel', 'in': 'query', 'description': '最大级别 查询不大于此level的数据', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'pageNo', 'in': 'query', 'description': '当前页码', 'required': True, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 1}, {'name': 'pageSize', 'in': 'query', 'description': '每页最大记录数', 'required': True, 'type': 'integer', 'maximum': 9223372036854775807, 'exclusiveMaximum': False, 'minimum': 0, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 15}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/带分页结果的数据«节点树»'}}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'options': {'tags': ['node-controller'], 'summary': 'page', 'operationId': 'pageUsingOPTIONS', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'maxLevel', 'in': 'query', 'description': '最大级别 查询不大于此level的数据', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'pageNo', 'in': 'query', 'description': '当前页码', 'required': True, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 1}, {'name': 'pageSize', 'in': 'query', 'description': '每页最大记录数', 'required': True, 'type': 'integer', 'maximum': 9223372036854775807, 'exclusiveMaximum': False, 'minimum': 0, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 15}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/带分页结果的数据«节点树»'}}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'patch': {'tags': ['node-controller'], 'summary': 'page', 'operationId': 'pageUsingPATCH', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'maxLevel', 'in': 'query', 'description': '最大级别 查询不大于此level的数据', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'pageNo', 'in': 'query', 'description': '当前页码', 'required': True, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 1}, {'name': 'pageSize', 'in': 'query', 'description': '每页最大记录数', 'required': True, 'type': 'integer', 'maximum': 9223372036854775807, 'exclusiveMaximum': False, 'minimum': 0, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 15}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/带分页结果的数据«节点树»'}}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}}, '/node/update': {'get': {'tags': ['node-controller'], 'summary': 'update', 'operationId': 'updateUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'head': {'tags': ['node-controller'], 'summary': 'update', 'operationId': 'updateUsingHEAD', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'post': {'tags': ['node-controller'], 'summary': 'update', 'operationId': 'updateUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'put': {'tags': ['node-controller'], 'summary': 'update', 'operationId': 'updateUsingPUT', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}, 'delete': {'tags': ['node-controller'], 'summary': 'update', 'operationId': 'updateUsingDELETE', 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'options': {'tags': ['node-controller'], 'summary': 'update', 'operationId': 'updateUsingOPTIONS', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}, 'patch': {'tags': ['node-controller'], 'summary': 'update', 'operationId': 'updateUsingPATCH', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'aliasName', 'in': 'query', 'description': '节点别名', 'required': False, 'type': 'string'}, {'name': 'createTime', 'in': 'query', 'description': '创建时间', 'required': False, 'type': 'string', 'format': 'date-time'}, {'name': 'creator', 'in': 'query', 'description': '创建人员工编号', 'required': False, 'type': 'string'}, {'name': 'creatorName', 'in': 'query', 'description': '创建人员工姓名', 'required': False, 'type': 'string'}, {'name': 'description', 'in': 'query', 'description': '描述', 'required': False, 'type': 'string'}, {'name': 'developTeam', 'in': 'query', 'description': '开发团队', 'required': False, 'type': 'string'}, {'name': 'domain', 'in': 'query', 'description': '所属域', 'required': False, 'type': 'string'}, {'name': 'domainEngineer', 'in': 'query', 'description': '域总师', 'required': False, 'type': 'string'}, {'name': 'id', 'in': 'query', 'description': '主键id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'level', 'in': 'query', 'description': '节点类型级别 1：顶级', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'modifier', 'in': 'query', 'description': '更新人员工编号', 'required': False, 'type': 'string'}, {'name': 'modifierName', 'in': 'query', 'description': '更新人员工姓名', 'required': False, 'type': 'string'}, {'name': 'name', 'in': 'query', 'description': '节点名称', 'required': False, 'type': 'string'}, {'name': 'nodeNo', 'in': 'query', 'description': '节点唯一标识', 'required': False, 'type': 'string'}, {'name': 'nodeTypeCode', 'in': 'query', 'description': '节点类型编码', 'required': False, 'type': 'string'}, {'name': 'owner', 'in': 'query', 'description': '负责人', 'required': False, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': '所属父级id. 0表示是顶级id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'projectCode', 'in': 'query', 'description': '项目代号', 'required': False, 'type': 'string'}, {'name': 'rootId', 'in': 'query', 'description': '所属顶级id.（用于分页检索使用索引）', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'updateTime', 'in': 'query', 'description': '更新时间', 'required': False, 'type': 'string', 'format': 'date-time'}], 'responses': {'200': {'description': 'OK'}, '204': {'description': 'No Content'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}}}}, '/v1/devlopview/log-test-relation/detail/{logId}': {'get': {'tags': ['关联测试'], 'summary': '查询关联测试详情', 'operationId': 'logTestRelationDetailUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'logId', 'in': 'path', 'description': 'logId', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/LogTestRelationVo'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/log-test-relation/saveOrUpdate': {'post': {'tags': ['关联测试'], 'summary': '保存关联测试信息', 'operationId': 'logTestRelationSaveOrUpdateUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/LogTestRelationSave'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/node/add': {'post': {'tags': ['结构节点视图'], 'summary': '添加节点', 'operationId': 'nodeAddUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/NodeAddCommand'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'integer', 'format': 'int64'}}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/node/delete/{id}': {'post': {'tags': ['结构节点视图'], 'summary': '删除节点', 'operationId': 'nodeDeleteUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'path', 'description': 'id', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/node/detail/{id}': {'get': {'tags': ['结构节点视图'], 'summary': '查询节点信息', 'operationId': 'nodeDetailUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'path', 'description': 'id', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/NodeVo'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/node/getNodeAliasName': {'get': {'tags': ['结构节点视图'], 'summary': '获取节点别名', 'operationId': 'getNodeAliasNameUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'name', 'in': 'query', 'description': 'name', 'required': True, 'type': 'string'}, {'name': 'parentId', 'in': 'query', 'description': 'parentId', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/NodeAliasNameVo'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/node/getParentNode': {'get': {'tags': ['结构节点视图'], 'summary': '根据级别获取上层节点信息', 'operationId': 'getParentNodeUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'level', 'in': 'query', 'description': 'level', 'required': True, 'type': 'integer', 'minimum': 2, 'exclusiveMinimum': False, 'format': 'int32'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'array', 'items': {'$ref': '#/definitions/NodeBaseVo'}}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/node/listNodeTree': {'get': {'tags': ['结构节点视图'], 'summary': '查询结构视图的节点树-非分页', 'operationId': 'listNodeTreeUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'maxLevel', 'in': 'query', 'description': '最大级别 查询不大于此level的数据', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'array', 'items': {'$ref': '#/definitions/节点树'}}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/node/pageTree': {'get': {'tags': ['结构节点视图'], 'summary': '获取结构视图的树', 'operationId': 'pageNodeTreeUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'maxLevel', 'in': 'query', 'description': '最大级别 查询不大于此level的数据', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'pageNo', 'in': 'query', 'description': '当前页码', 'required': True, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 1}, {'name': 'pageSize', 'in': 'query', 'description': '每页最大记录数', 'required': True, 'type': 'integer', 'maximum': 9223372036854775807, 'exclusiveMaximum': False, 'minimum': 0, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 15}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/带分页结果的数据«节点树»'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/node/update': {'post': {'tags': ['结构节点视图'], 'summary': '修改节点', 'operationId': 'nodeUpdateUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/NodeUpdateCommand'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodeInfo/detail/{nodeId}': {'get': {'tags': ['节点配置信息'], 'summary': '获取节点配置信息', 'operationId': 'detailNodeInfoUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'nodeId', 'in': 'path', 'description': 'nodeId', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/NodeInfoVo'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodeInfo/getNode': {'get': {'tags': ['节点配置信息'], 'summary': '通过流水线名称获取节点别名信息', 'operationId': 'getNodeUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'pipelineName', 'in': 'query', 'description': '流水线名称', 'required': True, 'type': 'string'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/NodeDto'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodeInfo/listPipelineInfo': {'get': {'tags': ['节点配置信息'], 'summary': '查询流水线信息', 'operationId': 'listPipelineUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'pipelineName', 'in': 'query', 'description': '流水线名称 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'array', 'items': {'$ref': '#/definitions/NodePipelineVo'}}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodeInfo/save': {'post': {'tags': ['节点配置信息'], 'summary': '添加/修改节点配置信息', 'operationId': 'updateNodeInfoUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/NodeInfoSaveCommand'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/buildVersion': {'post': {'tags': ['构建版本'], 'summary': '新建手工构建', 'operationId': 'buildVersionAddUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/PipelineLogAddCommand'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/buildVersion/detail/{id}': {'get': {'tags': ['构建版本'], 'summary': '查看构建版本详情-查看页面', 'operationId': 'logDetailUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'path', 'description': 'id', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/LogDetailVo'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/buildVersion/update': {'post': {'tags': ['构建版本'], 'summary': '编辑手工构建', 'operationId': 'buildVersionUpdateUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/PipelineLogUpdateCommand'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/detail/{id}': {'get': {'tags': ['构建版本'], 'summary': '查询构建版本详情-编辑页面', 'operationId': 'buildVersionDetailUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'path', 'description': 'id', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/NodePipelineLogDetailVo'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/downloadPackage/{id}': {'get': {'tags': ['构建版本'], 'summary': '下载构建版本的软件包', 'operationId': 'downloadPackageUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'path', 'description': 'id', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/genericUpload': {'post': {'tags': ['构建版本'], 'summary': '上传文件到产物平台', 'operationId': 'genericUploadUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'query', 'name': 'file', 'description': '文件', 'required': True, 'schema': {'type': 'array', 'items': {'type': 'file'}}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'version', 'in': 'query', 'description': '构建版本号', 'required': True, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/UploadResultDto'}}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/list': {'get': {'tags': ['构建版本'], 'summary': '查询构建版本列表', 'operationId': 'listLogUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'nodeId', 'in': 'query', 'description': '节点id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'versionNo', 'in': 'query', 'description': '构建版本号 模糊匹配', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'array', 'items': {'$ref': '#/definitions/NodePipelineLogListVo'}}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/listNodeVersionTree': {'get': {'tags': ['构建版本'], 'summary': '查询待选子模块的构建版本树结构', 'operationId': 'listNodeVersionTreeUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'nodeId', 'in': 'query', 'description': 'nodeId', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/节点树'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/listVersionPlan': {'get': {'tags': ['构建版本'], 'summary': '查询待选关联规划版本', 'operationId': 'listVersionPlanUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'nodeId', 'in': 'query', 'description': '节点id', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'array', 'items': {'$ref': '#/definitions/LogVersionPlanVo'}}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/page': {'get': {'tags': ['构建版本'], 'summary': '查询构建版本列表-分页', 'operationId': 'pageNodeTreeUsingGET_1', 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字 长度[0-255]', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'nodeId', 'in': 'query', 'description': '节点id', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'pageNo', 'in': 'query', 'description': '当前页码', 'required': True, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 1}, {'name': 'pageSize', 'in': 'query', 'description': '每页最大记录数', 'required': True, 'type': 'integer', 'maximum': 9223372036854775807, 'exclusiveMaximum': False, 'minimum': 0, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 15}, {'name': 'status', 'in': 'query', 'description': '状态 范围[0-2]', 'required': False, 'type': 'integer', 'format': 'int32'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/带分页结果的数据«NodePipelineLogListVo»'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/publish/{id}': {'post': {'tags': ['构建版本'], 'summary': '发布指定版本', 'operationId': 'publishUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'path', 'description': 'id', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodePipelineLog/refresh/{nodeId}': {'post': {'tags': ['构建版本'], 'summary': '刷新构建版本', 'operationId': 'refreshUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'nodeId', 'in': 'path', 'description': 'nodeId', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/devlopview/nodeType/list': {'get': {'tags': ['节点类型'], 'summary': '获取节点类型列表', 'operationId': 'listNodeTypeUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'array', 'items': {'$ref': '#/definitions/节点类型'}}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/test/add': {'post': {'tags': ['测试测试！！'], 'summary': '测试事务1', 'operationId': 'addUsingPOST_1', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/test/add2': {'post': {'tags': ['测试测试！！'], 'summary': '测试事务传播-子事务提交，主事务回滚', 'operationId': 'add2UsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/test/add3': {'post': {'tags': ['测试测试！！'], 'summary': '子事务未提交主事务回滚', 'operationId': '子事务未提交主事务回滚UsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/test/add4': {'post': {'tags': ['测试测试！！'], 'summary': '私有方法事务也生效', 'operationId': '私有方法事务也生效UsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/test/addFail': {'post': {'tags': ['测试测试！！'], 'summary': '测试事务1', 'operationId': 'addFailUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/user/login': {'get': {'tags': ['用户管理中心'], 'summary': '用户登录', 'operationId': 'loginUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/user/user/list': {'post': {'tags': ['用户管理中心'], 'summary': '获取用户列表', 'operationId': 'userListUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'query', 'description': 'query', 'required': True, 'schema': {'$ref': '#/definitions/SdasUserQuery'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'array', 'items': {'$ref': '#/definitions/sdas用户信息'}}}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/user/userinfo': {'get': {'tags': ['用户管理中心'], 'summary': '获取登录用户', 'operationId': 'userInfoUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/sdas用户信息'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan-relation-log/add': {'post': {'tags': ['规划版本-关联构建版本'], 'summary': '添加关联规划版本', 'operationId': 'addPlanLogUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/PlanLogAdd'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan-relation-log/delete': {'post': {'tags': ['规划版本-关联构建版本'], 'summary': '删除关联规划版本', 'operationId': 'deletePlanLogUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/PlanLogDelete'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan-relation-log/list': {'get': {'tags': ['规划版本-关联构建版本'], 'summary': '查询规划版本关联构建版本列表', 'operationId': 'listPlanLogUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'versionPlanId', 'in': 'query', 'description': '规划版本id', 'required': False, 'type': 'integer', 'format': 'int64'}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'array', 'items': {'$ref': '#/definitions/PlanLogListVo'}}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan-relation-log/listLogs': {'get': {'tags': ['规划版本-关联构建版本'], 'summary': '查询待选择的构建版本列表', 'operationId': 'listLogsUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '根据构建版本号和负责人模糊匹配', 'required': False, 'type': 'string'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'versionPlanId', 'in': 'query', 'description': '规划版本id', 'required': False, 'type': 'integer', 'format': 'int64'}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'array', 'items': {'$ref': '#/definitions/LogListVo'}}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan-relation/add': {'post': {'tags': ['规划版本-关联规划版本'], 'summary': '添加关联规划版本', 'operationId': 'addVersionPlanRelationUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/VersionPlanRelationAdd'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan-relation/delete': {'post': {'tags': ['规划版本-关联规划版本'], 'summary': '删除关联规划版本', 'operationId': 'deleteVersionPlanRelationUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/VersionPlanRelationDelete'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan-relation/list': {'get': {'tags': ['规划版本-关联规划版本'], 'summary': '查询关联规划版本页面详情', 'operationId': 'listVersionPlanRelationUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'versionPlanId', 'in': 'query', 'description': '规划版本id', 'required': True, 'type': 'integer', 'format': 'int64'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/VersionPlanRelationVo'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan/add': {'post': {'tags': ['规划版本'], 'summary': '添加规划版本', 'operationId': 'versionPlanAddUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/VersionPlanAddCommand'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'type': 'integer', 'format': 'int64'}}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan/delete/{id}': {'post': {'tags': ['规划版本'], 'summary': '删除规划版本', 'operationId': 'deleteVersionPlanUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'path', 'description': 'id', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan/detail/{id}': {'get': {'tags': ['规划版本'], 'summary': '查询规划版本概览信息', 'operationId': 'detailVersionPlanUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'id', 'in': 'path', 'description': 'id', 'required': True, 'type': 'integer', 'format': 'int64'}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/VersionPlanVo'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan/page': {'get': {'tags': ['规划版本'], 'summary': '查询规划版本列表-分页', 'operationId': 'pageVersionPlanUsingGET', 'produces': ['*/*'], 'parameters': [{'name': 'keyword', 'in': 'query', 'description': '关键字搜索 支持：规划版本号或者版本负责人模糊搜索', 'required': False, 'type': 'string', 'maxLength': 255, 'minLength': 0}, {'name': 'level', 'in': 'query', 'description': '当前节点级别level （查询上级或下级的规划版本）', 'required': False, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32'}, {'name': 'nodeId', 'in': 'query', 'description': '当前节点', 'required': False, 'type': 'integer', 'format': 'int64'}, {'name': 'pageNo', 'in': 'query', 'description': '当前页码', 'required': True, 'type': 'integer', 'minimum': 1, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 1}, {'name': 'pageSize', 'in': 'query', 'description': '每页最大记录数', 'required': True, 'type': 'integer', 'maximum': 9223372036854775807, 'exclusiveMaximum': False, 'minimum': 0, 'exclusiveMinimum': False, 'format': 'int32', 'x-example': 15}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}, {'name': 'versionPlanId', 'in': 'query', 'description': '规划版本id （筛选已经关联过的规划版本）', 'required': False, 'type': 'integer', 'format': 'int64'}], 'responses': {'200': {'description': 'OK', 'schema': {'$ref': '#/definitions/带分页结果的数据«VersionPlanListVo»'}}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}, '/v1/versionplan/version-plan/update': {'post': {'tags': ['规划版本'], 'summary': '修改规划版本', 'operationId': 'versionPlanUpdateUsingPOST', 'consumes': ['application/json'], 'produces': ['*/*'], 'parameters': [{'in': 'body', 'name': 'command', 'description': 'command', 'required': True, 'schema': {'$ref': '#/definitions/VersionPlanUpdateCommand'}}, {'name': 'token', 'in': 'header', 'description': '用户token信息', 'required': False, 'type': 'string'}], 'responses': {'200': {'description': 'OK'}, '201': {'description': 'Created'}, '401': {'description': 'Unauthorized'}, '403': {'description': 'Forbidden'}, '404': {'description': 'Not Found'}}}}}, 'definitions': {'LogDetailVo': {'type': 'object', 'properties': {'accessType': {'type': 'integer', 'format': 'int32', 'description': '接入类型 1：接入CICD 0:手工构建'}, 'aliasName': {'type': 'string', 'description': '软件别名'}, 'buildNo': {'type': 'string', 'description': 'cicd构建号'}, 'buildTime': {'type': 'string', 'format': 'date-time', 'description': '构建时间'}, 'commitNo': {'type': 'string', 'description': 'commit号'}, 'createTime': {'type': 'string', 'format': 'date-time', 'description': '创建时间'}, 'creatorName': {'type': 'string', 'description': '创建人'}, 'dependency': {'type': 'string', 'description': '版本依赖'}, 'deployTime': {'type': 'string', 'format': 'date-time', 'description': '版本发布时间'}, 'description': {'type': 'string', 'description': '版本说明'}, 'developTeam': {'type': 'string', 'description': '开发团队'}, 'developer': {'type': 'string', 'description': '开发者'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '构建版本主键id'}, 'md5': {'type': 'string', 'description': 'md5码'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'nodeName': {'type': 'string', 'description': '节点名称'}, 'packageName': {'type': 'string', 'description': '软件包名'}, 'pipelineId': {'type': 'integer', 'format': 'int64', 'description': '流水线id'}, 'pipelineName': {'type': 'string', 'description': '流水线号'}, 'pipelineType': {'type': 'string', 'description': '流水线类型'}, 'planVersionId': {'type': 'integer', 'format': 'int64', 'description': '规划版本号ID'}, 'planVersionNo': {'type': 'string', 'description': '规划版本号'}, 'productName': {'type': 'string', 'description': '产品名称'}, 'productUrl': {'type': 'string', 'description': '产物地址(软件包地址)'}, 'projectCode': {'type': 'string', 'description': '项目代号'}, 'projectLeader': {'type': 'string', 'description': '负责人'}, 'publisher': {'type': 'string', 'description': '发布者'}, 'purpose': {'type': 'string', 'description': '版本用途'}, 'relation': {'description': '关联的构建版本列表', '$ref': '#/definitions/节点树'}, 'sha256': {'type': 'string', 'description': 'SHA256'}, 'status': {'type': 'integer', 'format': 'int32', 'description': '状态 0未发布 1已发布 2发布失败'}, 'uploadPackage': {'type': 'integer', 'format': 'int32', 'description': '是否上传软件包 1：是 0：否'}, 'versionNo': {'type': 'string', 'description': '构建版本号'}}, 'title': 'LogDetailVo'}, 'LogListVo': {'type': 'object', 'required': ['id'], 'properties': {'accessType': {'type': 'integer', 'format': 'int32', 'description': '构建类型 1：接入CICD 0:手工构建'}, 'aliasName': {'type': 'string'}, 'buildTime': {'type': 'string', 'format': 'date-time', 'description': '版本构建时间'}, 'commitNo': {'type': 'string', 'description': '构建号'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '构建版本id'}, 'md5': {'type': 'string', 'description': 'md5码'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'nodeName': {'type': 'string', 'description': '节点名称'}, 'packageName': {'type': 'string', 'description': '软件包名'}, 'pipelineName': {'type': 'string', 'description': '流水线号（名称）'}, 'productName': {'type': 'string', 'description': '产品名称'}, 'productUrl': {'type': 'string', 'description': '软件包地址'}, 'projectLeader': {'type': 'string', 'description': '负责人'}, 'sha256': {'type': 'string', 'description': 'SHA256'}, 'status': {'type': 'integer', 'format': 'int32', 'description': '状态 0未发布 1已发布 2发布失败'}, 'versionNo': {'type': 'string', 'description': '构建版本号'}}, 'title': 'LogListVo'}, 'LogPublishRelationVo': {'type': 'object', 'properties': {'aliasName': {'type': 'string', 'description': '软件别名'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '构建版本主键id'}, 'nodePipelineLogs': {'type': 'array', 'description': '关联子模块', 'items': {'$ref': '#/definitions/VersionRelationVo'}}, 'productName': {'type': 'string', 'description': '产品名称'}, 'projectCode': {'type': 'string', 'description': '项目代号'}, 'publishDesc': {'type': 'string', 'description': '发布说明'}, 'publishLevel': {'type': 'integer', 'format': 'int32', 'description': '发布级别 1:平台级 2：控制器级 3：系统级 &gt;3：模块级'}, 'publishNo': {'type': 'string', 'description': '发布单号'}, 'publishPurpose': {'type': 'string', 'description': '发布用途'}, 'publishTime': {'type': 'string', 'format': 'date-time', 'description': '版本发布时间'}, 'publisher': {'type': 'string', 'description': '发布者'}, 'versionNo': {'type': 'string', 'description': '构建版本号'}}, 'title': 'LogPublishRelationVo'}, 'LogTestRelationSave': {'type': 'object', 'properties': {'componentUnitTestResultUrl': {'type': 'string', 'description': '零部件单体测试结果地址', 'minLength': 0, 'maxLength': 500}, 'componentUnitTestStatus': {'type': 'integer', 'format': 'int32', 'description': '零部件单体测试状态 0：不通过 1：通过'}, 'logId': {'type': 'integer', 'format': 'int64', 'description': '关联构建版本id'}, 'selfTestResultUrl': {'type': 'string', 'description': '自测结果地址', 'minLength': 0, 'maxLength': 500}, 'selfTestStatus': {'type': 'integer', 'format': 'int32', 'description': '自测状态 1：通过 0：未通过'}, 'softTestResultUrl': {'type': 'string', 'description': '软件集成测试结果地址', 'minLength': 0, 'maxLength': 500}, 'softTestStatus': {'type': 'integer', 'format': 'int32', 'description': '软件集成测试状态 0：不通过 1：通过'}, 'systemTestResultUrl': {'type': 'string', 'description': '系统集成测试结果地址', 'minLength': 0, 'maxLength': 500}, 'systemTestStatus': {'type': 'integer', 'format': 'int32', 'description': '系统集成测试状态 0：不通过 1：通过'}, 'unitTestResultUrl': {'type': 'string', 'description': '单元测试结果地址', 'minLength': 0, 'maxLength': 500}, 'unitTestStatus': {'type': 'integer', 'format': 'int32', 'description': '单元测试状态 1：通过 0：未通过 2：未执行'}}, 'title': 'LogTestRelationSave'}, 'LogTestRelationVo': {'type': 'object', 'properties': {'componentUnitTestResultUrl': {'type': 'string', 'description': '零部件单体测试结果地址'}, 'componentUnitTestStatus': {'type': 'integer', 'format': 'int32', 'description': '零部件单体测试状态 0：不通过 1：通过'}, 'logId': {'type': 'integer', 'format': 'int64', 'description': '关联构建版本id'}, 'selfTestResultUrl': {'type': 'string', 'description': '自测结果地址'}, 'selfTestStatus': {'type': 'integer', 'format': 'int32', 'description': '自测状态 1：通过 0：未通过'}, 'softTestResultUrl': {'type': 'string', 'description': '软件集成测试结果地址'}, 'softTestStatus': {'type': 'integer', 'format': 'int32', 'description': '软件集成测试状态 0：不通过 1：通过'}, 'systemTestResultUrl': {'type': 'string', 'description': '系统集成测试结果地址'}, 'systemTestStatus': {'type': 'integer', 'format': 'int32', 'description': '系统集成测试状态 0：不通过 1：通过'}, 'unitTestResultUrl': {'type': 'string', 'description': '单元测试结果地址'}, 'unitTestStatus': {'type': 'integer', 'format': 'int32', 'description': '单元测试状态 1：通过 0：未通过 2：未执行'}}, 'title': 'LogTestRelationVo'}, 'LogUpdatePublishStatusSave': {'type': 'object', 'properties': {'logId': {'type': 'integer', 'format': 'int64', 'description': '关联构建版本id'}, 'publishDesc': {'type': 'string', 'description': '发布说明', 'minLength': 0, 'maxLength': 200}, 'publishPurpose': {'type': 'string', 'description': '发布用途', 'minLength': 0, 'maxLength': 100}, 'status': {'type': 'integer', 'format': 'int32', 'description': '状态 0未发布 1已发布 2发布失败', 'minimum': 0, 'maximum': 9223372036854775807, 'exclusiveMinimum': False, 'exclusiveMaximum': False}}, 'title': 'LogUpdatePublishStatusSave'}, 'LogVersionPlanVo': {'type': 'object', 'properties': {'aliasName': {'type': 'string', 'description': '软件别名'}, 'director': {'type': 'string', 'description': '负责人'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '规划版本id'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'nodeName': {'type': 'string', 'description': '节点名称'}, 'productName': {'type': 'string', 'description': '产品名称'}, 'versionNo': {'type': 'string', 'description': '规划版本号'}}, 'title': 'LogVersionPlanVo'}, 'NodeAddCommand': {'type': 'object', 'required': ['name', 'nodeTypeCode'], 'properties': {'aliasName': {'type': 'string', 'description': '节点别名', 'minLength': 0, 'maxLength': 200, 'enum': ['[0-200]']}, 'connectCicd': {'type': 'integer', 'format': 'int32', 'description': '是否接入CICD 0:手工构建 1：接入CICD'}, 'description': {'type': 'string', 'description': '描述', 'minLength': 0, 'maxLength': 1000, 'enum': ['[0-1000]']}, 'developTeam': {'type': 'string', 'description': '开发团队', 'minLength': 0, 'maxLength': 50, 'enum': ['[0-50]']}, 'domain': {'type': 'string', 'description': '所属域', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'domainEngineer': {'type': 'string', 'description': '域总师', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'name': {'type': 'string', 'description': '节点名称不能为空，命名规则：中文、英文、数字组成', 'minLength': 1, 'maxLength': 25, 'pattern': '^[\\u4e00-\\u9fa5A-Za-z0-9]+$', 'enum': ['[1-25]']}, 'nodeTypeCode': {'type': 'string', 'description': '节点类型编码', 'minLength': 0, 'maxLength': 255, 'enum': ['[1-255]']}, 'owner': {'type': 'string', 'description': '负责人', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'parentId': {'type': 'integer', 'format': 'int64', 'description': '所属父级id.0表示是顶级id', 'minimum': 0, 'maximum': 9223372036854775807, 'exclusiveMinimum': False, 'exclusiveMaximum': False}, 'pipelines': {'type': 'array', 'description': '关联流水线列表', 'items': {'$ref': '#/definitions/PipelineAddCommand'}}, 'projectCode': {'type': 'string', 'description': '项目代号', 'minLength': 0, 'maxLength': 40, 'enum': ['[0-40]']}, 'sourceCodeName': {'type': 'string', 'description': '源码仓库名称', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'sourceCodeUrl': {'type': 'string', 'description': '源码仓库地址', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}}, 'title': 'NodeAddCommand'}, 'NodeAliasNameVo': {'type': 'object', 'properties': {'aliasName': {'type': 'string', 'description': '节点别名', 'enum': ['[0-255]']}}, 'title': 'NodeAliasNameVo'}, 'NodeBaseVo': {'type': 'object', 'properties': {'id': {'type': 'integer', 'format': 'int64', 'description': '主键id'}, 'name': {'type': 'string', 'description': '节点名称'}}, 'title': 'NodeBaseVo'}, 'NodeDto': {'type': 'object', 'properties': {'aliasName': {'type': 'string', 'description': '节点别名', 'enum': ['[0-255]']}, 'pipelineName': {'type': 'string', 'description': '流水线名称', 'enum': ['[0-255]']}, 'planVersionNo': {'type': 'string', 'description': '规划版本号'}}, 'title': 'NodeDto'}, 'NodeInfoSaveCommand': {'type': 'object', 'properties': {'connectCicd': {'type': 'integer', 'format': 'int32', 'description': '是否接入CICD 0:手工构建 1：接入CICD'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'pipelines': {'type': 'array', 'description': '关联流水线列表', 'items': {'$ref': '#/definitions/PipelineAddCommand'}}, 'productWarehouseName': {'type': 'string', 'description': '产物仓库名称', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'productWarehouseUrl': {'type': 'string', 'description': '产物仓库地址', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'sourceCodeName': {'type': 'string', 'description': '源码仓库名称', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'sourceCodeUrl': {'type': 'string', 'description': '源码仓库地址', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}}, 'title': 'NodeInfoSaveCommand'}, 'NodeInfoVo': {'type': 'object', 'properties': {'connectCicd': {'type': 'integer', 'format': 'int32', 'description': '是否接入cicd 0否 1是'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '主键id'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'pipelines': {'type': 'array', 'description': '节点-流水线关联列表', 'items': {'$ref': '#/definitions/NodePipelineVo'}}, 'productWarehouseName': {'type': 'string', 'description': '产物仓库名称'}, 'productWarehouseUrl': {'type': 'string', 'description': '产物仓库地址'}, 'sourceCodeName': {'type': 'string', 'description': '源码仓库名称'}, 'sourceCodeUrl': {'type': 'string', 'description': '源码仓库地址'}}, 'title': 'NodeInfoVo'}, 'NodePipelineLogDetailVo': {'type': 'object', 'properties': {'accessType': {'type': 'integer', 'format': 'int32', 'description': '接入类型 1：接入CICD 0:手工构建'}, 'buildNo': {'type': 'string', 'description': 'cicd构建号'}, 'buildTime': {'type': 'string', 'format': 'date-time', 'description': '构建时间'}, 'commitNo': {'type': 'string', 'description': 'commit号'}, 'dependency': {'type': 'string', 'description': '版本依赖'}, 'deployTime': {'type': 'string', 'format': 'date-time', 'description': '版本发布时间'}, 'description': {'type': 'string', 'description': '版本说明'}, 'developTeam': {'type': 'string', 'description': '开发团队'}, 'developer': {'type': 'string', 'description': '开发者'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '构建版本主键id'}, 'md5': {'type': 'string', 'description': 'md5码'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'nodePipelineLogs': {'type': 'array', 'description': '关联的构建版本列表', 'items': {'$ref': '#/definitions/VersionRelationVo'}}, 'packageName': {'type': 'string', 'description': '软件包名'}, 'pipelineId': {'type': 'integer', 'format': 'int64', 'description': '流水线id'}, 'pipelineName': {'type': 'string', 'description': '流水线号'}, 'pipelineType': {'type': 'string', 'description': '流水线类型'}, 'planVersionId': {'type': 'integer', 'format': 'int64', 'description': '规划版本号ID'}, 'planVersionNo': {'type': 'string', 'description': '规划版本号'}, 'productName': {'type': 'string', 'description': '产品名称'}, 'productUrl': {'type': 'string', 'description': '产物地址(软件包地址)'}, 'projectCode': {'type': 'string', 'description': '项目代号'}, 'projectLeader': {'type': 'string', 'description': '负责人'}, 'publisher': {'type': 'string', 'description': '发布者'}, 'purpose': {'type': 'string', 'description': '版本用途'}, 'remark': {'type': 'string', 'description': '备注'}, 'sha256': {'type': 'string', 'description': 'SHA256'}, 'status': {'type': 'integer', 'format': 'int32', 'description': '状态 0未发布 1已发布 2发布失败'}, 'uploadPackage': {'type': 'integer', 'format': 'int32', 'description': '是否上传软件包 1：是 0：否'}, 'versionNo': {'type': 'string', 'description': '构建版本号'}}, 'title': 'NodePipelineLogDetailVo'}, 'NodePipelineLogListVo': {'type': 'object', 'properties': {'accessType': {'type': 'integer', 'format': 'int32', 'description': '接入类型 1：接入CICD 0:手工构建'}, 'aliasName': {'type': 'string', 'description': '软件别名'}, 'buildNo': {'type': 'string', 'description': 'cicd构建号'}, 'buildTime': {'type': 'string', 'format': 'date-time', 'description': '版本构建时间'}, 'commitNo': {'type': 'string', 'description': '构建号'}, 'dependency': {'type': 'string', 'description': '版本依赖'}, 'deployTime': {'type': 'string', 'format': 'date-time', 'description': '版本发布时间'}, 'developTeam': {'type': 'string', 'description': '开发团队'}, 'developer': {'type': 'string', 'description': '开发者'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '主键id'}, 'md5': {'type': 'string', 'description': 'md5码'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'packageName': {'type': 'string', 'description': '软件包名'}, 'pipelineId': {'type': 'integer', 'format': 'int64', 'description': '流水线id'}, 'pipelineName': {'type': 'string', 'description': '流水线号'}, 'pipelineType': {'type': 'string', 'description': '流水线类型'}, 'planVersionId': {'type': 'integer', 'format': 'int64', 'description': '规划版本号ID'}, 'planVersionNo': {'type': 'string', 'description': '规划版本号'}, 'productUrl': {'type': 'string', 'description': '产物地址(软件包地址)'}, 'projectCode': {'type': 'string', 'description': '项目代号'}, 'projectLeader': {'type': 'string', 'description': '负责人'}, 'publisher': {'type': 'string', 'description': '发布者'}, 'sha256': {'type': 'string', 'description': 'SHA256'}, 'status': {'type': 'integer', 'format': 'int32', 'description': '状态 0未发布 1已发布 2发布失败'}, 'versionNo': {'type': 'string', 'description': '构建版本号'}}, 'title': 'NodePipelineLogListVo'}, 'NodePipelineVo': {'type': 'object', 'properties': {'pipelineId': {'type': 'integer', 'format': 'int64', 'description': '流水线id'}, 'pipelineName': {'type': 'string', 'description': '流水线名称'}, 'pipelineType': {'type': 'string', 'description': '流水线类型'}}, 'title': 'NodePipelineVo'}, 'NodeUpdateCommand': {'type': 'object', 'required': ['nodeTypeCode'], 'properties': {'connectCicd': {'type': 'integer', 'format': 'int32', 'description': '是否接入CICD 0:手工构建 1：接入CICD'}, 'description': {'type': 'string', 'description': '描述', 'minLength': 0, 'maxLength': 1000, 'enum': ['[0-1000]']}, 'developTeam': {'type': 'string', 'description': '开发团队', 'minLength': 0, 'maxLength': 50, 'enum': ['[0-50]']}, 'domain': {'type': 'string', 'description': '所属域', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'domainEngineer': {'type': 'string', 'description': '域总师', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'id': {'type': 'integer', 'format': 'int64', 'description': '节点主键id'}, 'nodeTypeCode': {'type': 'string', 'description': '节点类型编码', 'minLength': 0, 'maxLength': 255, 'enum': ['[1-255]']}, 'owner': {'type': 'string', 'description': '负责人', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'parentId': {'type': 'integer', 'format': 'int64', 'description': '所属父级id.0表示是顶级id', 'minimum': 0, 'maximum': 9223372036854775807, 'exclusiveMinimum': False, 'exclusiveMaximum': False}, 'pipelines': {'type': 'array', 'description': '关联流水线列表', 'items': {'$ref': '#/definitions/PipelineAddCommand'}}, 'projectCode': {'type': 'string', 'description': '项目代号', 'minLength': 0, 'maxLength': 40, 'enum': ['[0-40]']}, 'sourceCodeName': {'type': 'string', 'description': '源码仓库名称', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'sourceCodeUrl': {'type': 'string', 'description': '源码仓库地址', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}}, 'title': 'NodeUpdateCommand'}, 'NodeVo': {'type': 'object', 'required': ['name', 'nodeTypeCode'], 'properties': {'aliasName': {'type': 'string', 'description': '节点别名', 'minLength': 0, 'maxLength': 200, 'enum': ['[0-200]']}, 'connectCicd': {'type': 'integer', 'format': 'int32', 'description': '是否接入CICD 0:手工构建 1：接入CICD'}, 'createTime': {'type': 'string', 'format': 'date-time', 'description': '创建时间'}, 'creator': {'type': 'string', 'description': '创建人'}, 'creatorName': {'type': 'string', 'description': '创建人名称'}, 'description': {'type': 'string', 'description': '描述', 'minLength': 0, 'maxLength': 1000, 'enum': ['[0-1000]']}, 'developTeam': {'type': 'string', 'description': '开发团队', 'minLength': 0, 'maxLength': 50, 'enum': ['[0-50]']}, 'domain': {'type': 'string', 'description': '所属域', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'domainEngineer': {'type': 'string', 'description': '域总师', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'id': {'type': 'integer', 'format': 'int64', 'description': '主键id'}, 'name': {'type': 'string', 'description': '节点名称不能为空，命名规则：中文、英文、数字组成', 'minLength': 1, 'maxLength': 25, 'pattern': '^[\\u4e00-\\u9fa5A-Za-z0-9]+$', 'enum': ['[1-25]']}, 'nodeNo': {'type': 'string', 'description': '节点唯一标识'}, 'nodeTypeCode': {'type': 'string', 'description': '节点类型编码', 'minLength': 0, 'maxLength': 255, 'enum': ['[1-255]']}, 'owner': {'type': 'string', 'description': '负责人', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'parentId': {'type': 'integer', 'format': 'int64', 'description': '所属父级id.0表示是顶级id', 'minimum': 0, 'maximum': 9223372036854775807, 'exclusiveMinimum': False, 'exclusiveMaximum': False}, 'pipelines': {'type': 'array', 'description': '关联流水线列表', 'items': {'$ref': '#/definitions/PipelineAddCommand'}}, 'projectCode': {'type': 'string', 'description': '项目代号', 'minLength': 0, 'maxLength': 40, 'enum': ['[0-40]']}, 'sourceCodeName': {'type': 'string', 'description': '源码仓库名称', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'sourceCodeUrl': {'type': 'string', 'description': '源码仓库地址', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}}, 'title': 'NodeVo'}, 'PipelineAddCommand': {'type': 'object', 'properties': {'pipelineId': {'type': 'integer', 'format': 'int64', 'description': '流水线id'}, 'pipelineName': {'type': 'string', 'description': '流水线名称', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}, 'pipelineType': {'type': 'string', 'description': '流水线类型', 'minLength': 0, 'maxLength': 255, 'enum': ['[0-255]']}}, 'title': 'PipelineAddCommand'}, 'PipelineLogAddCommand': {'type': 'object', 'required': ['nodeId'], 'properties': {'description': {'type': 'string', 'description': '版本说明', 'minLength': 0, 'maxLength': 2000}, 'developTeam': {'type': 'string', 'description': '开发团队', 'minLength': 0, 'maxLength': 50}, 'developer': {'type': 'string', 'description': '开发者', 'minLength': 0, 'maxLength': 20}, 'md5': {'type': 'string', 'description': 'MD5编码'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'nodePipelineLogId': {'type': 'array', 'description': '关联子模块的构建版本', 'items': {'type': 'integer', 'format': 'int64'}}, 'packageName': {'type': 'string', 'description': '软件包名称'}, 'planVersionId': {'type': 'integer', 'format': 'int64', 'description': '规划版本ID'}, 'productName': {'type': 'string', 'description': '产品名称', 'minLength': 0, 'maxLength': 30}, 'productUrl': {'type': 'string', 'description': '产物地址（软件包地址）'}, 'projectCode': {'type': 'string', 'description': '项目代号', 'minLength': 0, 'maxLength': 40}, 'projectLeader': {'type': 'string', 'description': '负责人', 'minLength': 0, 'maxLength': 20}, 'publisher': {'type': 'string', 'description': '发布者', 'minLength': 0, 'maxLength': 20}, 'uploadPackage': {'type': 'integer', 'format': 'int32', 'description': '是否上传软件包 1：是 0：否', 'minimum': 0, 'maximum': 9223372036854775807, 'exclusiveMinimum': False, 'exclusiveMaximum': False}, 'versionNo': {'type': 'string', 'description': '构建版本号'}}, 'title': 'PipelineLogAddCommand'}, 'PipelineLogUpdateCommand': {'type': 'object', 'required': ['id', 'nodeId'], 'properties': {'description': {'type': 'string', 'description': '版本说明', 'minLength': 0, 'maxLength': 2000}, 'developTeam': {'type': 'string', 'description': '开发团队', 'minLength': 0, 'maxLength': 50}, 'developer': {'type': 'string', 'description': '开发者', 'minLength': 0, 'maxLength': 20}, 'id': {'type': 'integer', 'format': 'int64', 'description': '构建版本主键id'}, 'md5': {'type': 'string', 'description': 'MD5编码'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'nodePipelineLogId': {'type': 'array', 'description': '关联子模块的构建版本', 'items': {'type': 'integer', 'format': 'int64'}}, 'packageName': {'type': 'string', 'description': '软件包名称'}, 'planVersionId': {'type': 'integer', 'format': 'int64', 'description': '规划版本ID'}, 'productName': {'type': 'string', 'description': '产品名称', 'minLength': 0, 'maxLength': 30}, 'productUrl': {'type': 'string', 'description': '产物地址（软件包地址）'}, 'projectCode': {'type': 'string', 'description': '项目代号', 'minLength': 0, 'maxLength': 40}, 'projectLeader': {'type': 'string', 'description': '负责人', 'minLength': 0, 'maxLength': 20}, 'publisher': {'type': 'string', 'description': '发布者', 'minLength': 0, 'maxLength': 20}, 'uploadPackage': {'type': 'integer', 'format': 'int32', 'description': '是否上传软件包 1：是 0：否', 'minimum': 0, 'maximum': 9223372036854775807, 'exclusiveMinimum': False, 'exclusiveMaximum': False}, 'versionNo': {'type': 'string', 'description': '构建版本号'}}, 'title': 'PipelineLogUpdateCommand'}, 'PlanLogAdd': {'type': 'object', 'required': ['nodePipelineLogIds', 'versionPlanId'], 'properties': {'nodePipelineLogIds': {'type': 'array', 'description': '关联构建版本的id列表', 'items': {'type': 'integer', 'format': 'int64'}}, 'versionPlanId': {'type': 'integer', 'format': 'int64', 'description': '规划版本id'}}, 'title': 'PlanLogAdd'}, 'PlanLogDelete': {'type': 'object', 'required': ['nodePipelineLogId', 'versionPlanId'], 'properties': {'nodePipelineLogId': {'type': 'integer', 'format': 'int64', 'description': '待删除的关联构建版本的id'}, 'versionPlanId': {'type': 'integer', 'format': 'int64', 'description': '规划版本id'}}, 'title': 'PlanLogDelete'}, 'PlanLogListVo': {'type': 'object', 'required': ['id'], 'properties': {'accessType': {'type': 'integer', 'format': 'int32', 'description': '构建类型 1：接入CICD 0:手工构建'}, 'aliasName': {'type': 'string'}, 'buildTime': {'type': 'string', 'format': 'date-time', 'description': '版本构建时间'}, 'commitNo': {'type': 'string', 'description': '构建号'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '构建版本id'}, 'md5': {'type': 'string', 'description': 'md5码'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'packageName': {'type': 'string', 'description': '软件包名'}, 'pipelineName': {'type': 'string', 'description': '流水线号（名称）'}, 'productUrl': {'type': 'string', 'description': '软件包地址'}, 'sha256': {'type': 'string', 'description': 'SHA256'}, 'status': {'type': 'integer', 'format': 'int32', 'description': '状态 0未发布 1已发布 2发布失败'}, 'versionNo': {'type': 'string', 'description': '构建版本号'}}, 'title': 'PlanLogListVo'}, 'SdasUserQuery': {'type': 'object', 'properties': {'keyword': {'type': 'string', 'description': '用户工号或姓名'}}, 'title': 'SdasUserQuery'}, 'UploadResultDto': {'type': 'object', 'properties': {'md5': {'type': 'string'}, 'oid': {'type': 'integer', 'format': 'int64', 'description': '文件对象id'}, 'url': {'type': 'string', 'description': '产物地址'}}, 'title': 'UploadResultDto'}, 'VersionPlanAddCommand': {'type': 'object', 'required': ['description', 'nodeId', 'versionNo'], 'properties': {'description': {'type': 'string', 'description': '版本描述', 'minLength': 0, 'maxLength': 2000, 'enum': ['[1-2000]']}, 'director': {'type': 'string', 'description': '负责人', 'minLength': 0, 'maxLength': 20, 'enum': ['[1-20]']}, 'endTime': {'type': 'string', 'format': 'date-time', 'description': '计划结束日期 时期格式：yyyy-mm-dd'}, 'iteration': {'type': 'string', 'description': '所属迭代', 'minLength': 0, 'maxLength': 20, 'enum': ['[0-20]']}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'planPublishTime': {'type': 'string', 'format': 'date-time', 'description': '计划发布日期 时期格式：yyyy-mm-dd'}, 'productName': {'type': 'string', 'description': '产品名称', 'minLength': 0, 'maxLength': 30, 'enum': ['[0-30]']}, 'startTime': {'type': 'string', 'format': 'date-time', 'description': '计划开始日期 时期格式：yyyy-mm-dd'}, 'versionNo': {'type': 'string', 'description': '版本号', 'pattern': 'SW[ABCD]\\.\\d{3}\\.\\d{3}'}}, 'title': 'VersionPlanAddCommand'}, 'VersionPlanListVo': {'type': 'object', 'required': ['id', 'nodeId', 'versionNo'], 'properties': {'aliasName': {'type': 'string'}, 'createTime': {'type': 'string', 'format': 'date-time', 'description': '创建时间'}, 'director': {'type': 'string', 'description': '负责人', 'enum': ['[1-20]']}, 'endTime': {'type': 'string', 'format': 'date-time', 'description': '计划结束日期 时期格式：yyyy-MM-dd'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '规划版本id'}, 'iteration': {'type': 'string', 'description': '所属迭代', 'enum': ['[0-20]']}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'productName': {'type': 'string', 'description': '产品名称', 'enum': ['[0-30]']}, 'startTime': {'type': 'string', 'format': 'date-time', 'description': '计划开始日期 时期格式：yyyy-MM-dd'}, 'versionNo': {'type': 'string', 'description': '规划版本号'}}, 'title': 'VersionPlanListVo'}, 'VersionPlanRelationAdd': {'type': 'object', 'required': ['masterVersionPlanId', 'otherVersionPlanIds'], 'properties': {'masterVersionPlanId': {'type': 'integer', 'format': 'int64', 'description': '规划版本id'}, 'otherVersionPlanIds': {'type': 'array', 'description': '关联规划版本id列表不能为空', 'items': {'type': 'integer', 'format': 'int64'}}}, 'title': 'VersionPlanRelationAdd'}, 'VersionPlanRelationDelete': {'type': 'object', 'required': ['masterVersionPlanId', 'otherVersionPlanIds'], 'properties': {'masterVersionPlanId': {'type': 'integer', 'format': 'int64', 'description': '规划版本id'}, 'otherVersionPlanIds': {'type': 'integer', 'format': 'int64', 'description': '待删除的关联规划版本id'}}, 'title': 'VersionPlanRelationDelete'}, 'VersionPlanRelationListVo': {'type': 'object', 'required': ['id', 'nodeId', 'versionNo'], 'properties': {'aliasName': {'type': 'string', 'description': '软件别名'}, 'director': {'type': 'string', 'description': '负责人', 'enum': ['[1-20]']}, 'endTime': {'type': 'string', 'format': 'date-time', 'description': '计划结束日期 时期格式：yyyy-MM-dd'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '规划版本id'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'startTime': {'type': 'string', 'format': 'date-time', 'description': '计划开始日期 时期格式：yyyy-MM-dd'}, 'versionNo': {'type': 'string', 'description': '规划版本号'}}, 'title': 'VersionPlanRelationListVo'}, 'VersionPlanRelationVo': {'type': 'object', 'properties': {'currentLevel': {'type': 'integer', 'format': 'int32', 'description': '当前规划版本所属节点级别 1：展示下级规划版本 2：展示上级和下级规划版本 3：展示上级规划版本'}, 'subordinate': {'type': 'array', 'description': '关联下级规划版本', 'items': {'$ref': '#/definitions/VersionPlanRelationListVo'}}, 'superior': {'type': 'array', 'description': '关联上级规划版本', 'items': {'$ref': '#/definitions/VersionPlanRelationListVo'}}}, 'title': 'VersionPlanRelationVo'}, 'VersionPlanUpdateCommand': {'type': 'object', 'required': ['description', 'id', 'nodeId', 'versionNo'], 'properties': {'description': {'type': 'string', 'description': '版本描述', 'minLength': 0, 'maxLength': 2000, 'enum': ['[1-2000]']}, 'director': {'type': 'string', 'description': '负责人', 'minLength': 0, 'maxLength': 20, 'enum': ['[1-20]']}, 'endTime': {'type': 'string', 'format': 'date-time', 'description': '计划结束日期 时期格式：yyyy-mm-dd'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '规划版本id'}, 'iteration': {'type': 'string', 'description': '所属迭代', 'minLength': 0, 'maxLength': 20, 'enum': ['[0-20]']}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'planPublishTime': {'type': 'string', 'format': 'date-time', 'description': '计划发布日期 时期格式：yyyy-mm-dd'}, 'productName': {'type': 'string', 'description': '产品名称', 'minLength': 0, 'maxLength': 30, 'enum': ['[0-30]']}, 'startTime': {'type': 'string', 'format': 'date-time', 'description': '计划开始日期 时期格式：yyyy-mm-dd'}, 'versionNo': {'type': 'string', 'description': '版本号', 'pattern': 'SW[ABCD]\\.\\d{3}\\.\\d{3}'}}, 'title': 'VersionPlanUpdateCommand'}, 'VersionPlanVo': {'type': 'object', 'required': ['description', 'nodeId', 'versionNo'], 'properties': {'aliasName': {'type': 'string', 'description': '软件别名'}, 'createTime': {'type': 'string', 'format': 'date-time', 'description': '创建时间'}, 'creator': {'type': 'string', 'description': '创建人id'}, 'creatorName': {'type': 'string', 'description': '创建人名称'}, 'description': {'type': 'string', 'description': '版本描述', 'enum': ['[1-2000]']}, 'director': {'type': 'string', 'description': '负责人', 'enum': ['[1-20]']}, 'endTime': {'type': 'string', 'format': 'date-time', 'description': '计划结束日期 时期格式：yyyy-MM-dd'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '规划版本主键id'}, 'iteration': {'type': 'string', 'description': '所属迭代', 'enum': ['[0-20]']}, 'level': {'type': 'integer', 'format': 'int32', 'description': '节点类型级别 1：顶级'}, 'modifierName': {'type': 'string', 'description': '修改人名称'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'nodeName': {'type': 'string', 'description': '节点名称'}, 'planPublishTime': {'type': 'string', 'format': 'date-time', 'description': '计划发布日期 时期格式：yyyy-MM-dd'}, 'productName': {'type': 'string', 'description': '产品名称', 'enum': ['[0-30]']}, 'startTime': {'type': 'string', 'format': 'date-time', 'description': '计划开始日期 时期格式：yyyy-MM-dd'}, 'transMap': {'type': 'object', 'description': '扩展翻译属性map', 'additionalProperties': {'type': 'string'}}, 'versionNo': {'type': 'string', 'description': '版本号'}}, 'title': 'VersionPlanVo'}, 'VersionRelationVo': {'type': 'object', 'properties': {'aliasName': {'type': 'string', 'description': '软件别名'}, 'description': {'type': 'string', 'description': '版本说明'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '构建版本主键id'}, 'nodeId': {'type': 'integer', 'format': 'int64', 'description': '节点id'}, 'parentId': {'type': 'integer', 'format': 'int64', 'description': '父级节点id'}, 'projectLeader': {'type': 'string', 'description': '负责人'}, 'versionNo': {'type': 'string', 'description': '构建版本号'}}, 'title': 'VersionRelationVo'}, 'sdas用户信息': {'type': 'object', 'properties': {'degree': {'type': 'string'}, 'dept': {'type': 'string'}, 'educational': {'type': 'string'}, 'email': {'type': 'string'}, 'entryDate': {'type': 'string'}, 'entryReason': {'type': 'string'}, 'expAbility': {'type': 'string'}, 'gender': {'type': 'string'}, 'key': {'type': 'integer', 'format': 'int64'}, 'nation': {'type': 'string'}, 'nativePlace': {'type': 'string'}, 'nickname': {'type': 'string'}, 'postName': {'type': 'string'}, 'standGrade': {'type': 'string'}, 'status': {'type': 'string'}, 'techGrade': {'type': 'string'}, 'uid': {'type': 'integer', 'format': 'int64'}, 'username': {'type': 'string'}, 'weixinid': {'type': 'string'}}, 'title': 'sdas用户信息', 'description': 'sdas用户信息'}, '带分页结果的数据«NodePipelineLogListVo»': {'type': 'object', 'required': ['pageNo'], 'properties': {'pageNo': {'type': 'integer', 'format': 'int32', 'example': 1, 'description': '当前页码', 'minimum': 1, 'exclusiveMinimum': False}, 'pageSize': {'type': 'integer', 'format': 'int32', 'example': 15, 'description': '每页最大记录数', 'minimum': 0, 'maximum': 9223372036854775807, 'exclusiveMinimum': False, 'exclusiveMaximum': False}, 'pages': {'type': 'integer', 'format': 'int64', 'description': '总页数'}, 'records': {'type': 'array', 'description': '数据列表', 'items': {'$ref': '#/definitions/NodePipelineLogListVo'}}, 'total': {'type': 'integer', 'format': 'int64', 'description': '总条数'}}, 'title': '带分页结果的数据«NodePipelineLogListVo»'}, '带分页结果的数据«VersionPlanListVo»': {'type': 'object', 'required': ['pageNo'], 'properties': {'pageNo': {'type': 'integer', 'format': 'int32', 'example': 1, 'description': '当前页码', 'minimum': 1, 'exclusiveMinimum': False}, 'pageSize': {'type': 'integer', 'format': 'int32', 'example': 15, 'description': '每页最大记录数', 'minimum': 0, 'maximum': 9223372036854775807, 'exclusiveMinimum': False, 'exclusiveMaximum': False}, 'pages': {'type': 'integer', 'format': 'int64', 'description': '总页数'}, 'records': {'type': 'array', 'description': '数据列表', 'items': {'$ref': '#/definitions/VersionPlanListVo'}}, 'total': {'type': 'integer', 'format': 'int64', 'description': '总条数'}}, 'title': '带分页结果的数据«VersionPlanListVo»'}, '带分页结果的数据«节点树»': {'type': 'object', 'required': ['pageNo'], 'properties': {'pageNo': {'type': 'integer', 'format': 'int32', 'example': 1, 'description': '当前页码', 'minimum': 1, 'exclusiveMinimum': False}, 'pageSize': {'type': 'integer', 'format': 'int32', 'example': 15, 'description': '每页最大记录数', 'minimum': 0, 'maximum': 9223372036854775807, 'exclusiveMinimum': False, 'exclusiveMaximum': False}, 'pages': {'type': 'integer', 'format': 'int64', 'description': '总页数'}, 'records': {'type': 'array', 'description': '数据列表', 'items': {'$ref': '#/definitions/节点树'}}, 'total': {'type': 'integer', 'format': 'int64', 'description': '总条数'}}, 'title': '带分页结果的数据«节点树»'}, '节点树': {'type': 'object', 'properties': {'aliasName': {'type': 'string', 'description': '节点别名'}, 'children': {'type': 'array', 'description': '子节点列表', 'items': {'$ref': '#/definitions/节点树'}}, 'count': {'type': 'integer', 'format': 'int32', 'description': '可选版本数量'}, 'developTeam': {'type': 'string', 'description': '开发团队'}, 'flag': {'type': 'boolean', 'description': '可选版本数量'}, 'id': {'type': 'integer', 'format': 'int64', 'description': '主键id'}, 'level': {'type': 'integer', 'format': 'int32', 'description': '节点类型级别 1：顶级'}, 'name': {'type': 'string', 'description': '节点名称'}, 'nodeNo': {'type': 'string', 'description': '节点唯一标识'}, 'nodeTypeCode': {'type': 'string', 'description': '节点类型编码'}, 'parentId': {'type': 'integer', 'format': 'int64', 'description': '所属父级id. 0表示是顶级id'}, 'projectCode': {'type': 'string', 'description': '项目代号'}, 'rootId': {'type': 'integer', 'format': 'int64', 'description': '所属顶级id.（用于分页检索使用索引）'}, 'versionList': {'type': 'array', 'description': '构建版本列表', 'items': {'$ref': '#/definitions/VersionRelationVo'}}}, 'title': '节点树'}, '节点类型': {'type': 'object', 'properties': {'code': {'type': 'string', 'description': '节点类型编码'}, 'level': {'type': 'integer', 'format': 'int32', 'description': '节点类型级别 1：顶级'}, 'name': {'type': 'string', 'description': '节点类型名称'}}, 'title': '节点类型'}}}




resource getDetailUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'getDetailUsingGET'
  properties: {
    path: '/devlopview/log-publish-relation/detail/{logId}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource updatePublishStatusUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'updatePublishStatusUsingPOST'
  properties: {
    path: '/devlopview/log-publish-relation/updatePublishStatus'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource addUsingPATCH 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'addUsingPATCH'
  properties: {
    path: '/node/add'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource deleteUsingPATCH 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'deleteUsingPATCH'
  properties: {
    path: '/node/delete'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource pageUsingPATCH 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'pageUsingPATCH'
  properties: {
    path: '/node/list'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource updateUsingPATCH 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'updateUsingPATCH'
  properties: {
    path: '/node/update'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource logTestRelationDetailUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'logTestRelationDetailUsingGET'
  properties: {
    path: '/v1/devlopview/log-test-relation/detail/{logId}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource logTestRelationSaveOrUpdateUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'logTestRelationSaveOrUpdateUsingPOST'
  properties: {
    path: '/v1/devlopview/log-test-relation/saveOrUpdate'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource nodeAddUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'nodeAddUsingPOST'
  properties: {
    path: '/v1/devlopview/node/add'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource nodeDeleteUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'nodeDeleteUsingPOST'
  properties: {
    path: '/v1/devlopview/node/delete/{id}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource nodeDetailUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'nodeDetailUsingGET'
  properties: {
    path: '/v1/devlopview/node/detail/{id}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource getNodeAliasNameUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'getNodeAliasNameUsingGET'
  properties: {
    path: '/v1/devlopview/node/getNodeAliasName'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource getParentNodeUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'getParentNodeUsingGET'
  properties: {
    path: '/v1/devlopview/node/getParentNode'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource listNodeTreeUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'listNodeTreeUsingGET'
  properties: {
    path: '/v1/devlopview/node/listNodeTree'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource pageNodeTreeUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'pageNodeTreeUsingGET'
  properties: {
    path: '/v1/devlopview/node/pageTree'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource nodeUpdateUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'nodeUpdateUsingPOST'
  properties: {
    path: '/v1/devlopview/node/update'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource detailNodeInfoUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'detailNodeInfoUsingGET'
  properties: {
    path: '/v1/devlopview/nodeInfo/detail/{nodeId}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource getNodeUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'getNodeUsingGET'
  properties: {
    path: '/v1/devlopview/nodeInfo/getNode'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource listPipelineUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'listPipelineUsingGET'
  properties: {
    path: '/v1/devlopview/nodeInfo/listPipelineInfo'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource updateNodeInfoUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'updateNodeInfoUsingPOST'
  properties: {
    path: '/v1/devlopview/nodeInfo/save'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource buildVersionAddUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'buildVersionAddUsingPOST'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/buildVersion'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource logDetailUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'logDetailUsingGET'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/buildVersion/detail/{id}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource buildVersionUpdateUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'buildVersionUpdateUsingPOST'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/buildVersion/update'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource buildVersionDetailUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'buildVersionDetailUsingGET'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/detail/{id}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource downloadPackageUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'downloadPackageUsingGET'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/downloadPackage/{id}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource genericUploadUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'genericUploadUsingPOST'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/genericUpload'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource listLogUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'listLogUsingGET'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/list'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource listNodeVersionTreeUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'listNodeVersionTreeUsingGET'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/listNodeVersionTree'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource listVersionPlanUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'listVersionPlanUsingGET'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/listVersionPlan'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource pageNodeTreeUsingGET_1 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'pageNodeTreeUsingGET_1'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/page'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource publishUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'publishUsingPOST'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/publish/{id}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource refreshUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'refreshUsingPOST'
  properties: {
    path: '/v1/devlopview/nodePipelineLog/refresh/{nodeId}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource listNodeTypeUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'listNodeTypeUsingGET'
  properties: {
    path: '/v1/devlopview/nodeType/list'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource addUsingPOST_1 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'addUsingPOST_1'
  properties: {
    path: '/v1/test/add'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource add2UsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'add2UsingPOST'
  properties: {
    path: '/v1/test/add2'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource 子事务未提交主事务回滚UsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: '子事务未提交主事务回滚UsingPOST'
  properties: {
    path: '/v1/test/add3'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource 私有方法事务也生效UsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: '私有方法事务也生效UsingPOST'
  properties: {
    path: '/v1/test/add4'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource addFailUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'addFailUsingPOST'
  properties: {
    path: '/v1/test/addFail'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource loginUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'loginUsingGET'
  properties: {
    path: '/v1/user/login'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource userListUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'userListUsingPOST'
  properties: {
    path: '/v1/user/user/list'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource userInfoUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'userInfoUsingGET'
  properties: {
    path: '/v1/user/userinfo'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource addPlanLogUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'addPlanLogUsingPOST'
  properties: {
    path: '/v1/versionplan/version-plan-relation-log/add'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource deletePlanLogUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'deletePlanLogUsingPOST'
  properties: {
    path: '/v1/versionplan/version-plan-relation-log/delete'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource listPlanLogUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'listPlanLogUsingGET'
  properties: {
    path: '/v1/versionplan/version-plan-relation-log/list'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource listLogsUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'listLogsUsingGET'
  properties: {
    path: '/v1/versionplan/version-plan-relation-log/listLogs'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource addVersionPlanRelationUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'addVersionPlanRelationUsingPOST'
  properties: {
    path: '/v1/versionplan/version-plan-relation/add'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource deleteVersionPlanRelationUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'deleteVersionPlanRelationUsingPOST'
  properties: {
    path: '/v1/versionplan/version-plan-relation/delete'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource listVersionPlanRelationUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'listVersionPlanRelationUsingGET'
  properties: {
    path: '/v1/versionplan/version-plan-relation/list'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource versionPlanAddUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'versionPlanAddUsingPOST'
  properties: {
    path: '/v1/versionplan/version-plan/add'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource deleteVersionPlanUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'deleteVersionPlanUsingPOST'
  properties: {
    path: '/v1/versionplan/version-plan/delete/{id}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource detailVersionPlanUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'detailVersionPlanUsingGET'
  properties: {
    path: '/v1/versionplan/version-plan/detail/{id}'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource pageVersionPlanUsingGET 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'pageVersionPlanUsingGET'
  properties: {
    path: '/v1/versionplan/version-plan/page'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}


resource versionPlanUpdateUsingPOST 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  parent: apiManagementServiceName
  name: 'versionPlanUpdateUsingPOST'
  properties: {
    path: '/v1/versionplan/version-plan/update'
    protocols: ['https','http']
    contentFormat: 'swagger-link-json'
    contentValue: swaggerContent

  }
}



