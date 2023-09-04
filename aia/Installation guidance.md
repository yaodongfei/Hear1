## Preparation before installation
准备好python3.X环境
```shell
python -V
```
## Installation python script
1. Copy the <font color= "#FF0000">**bicep**</font> directory to the specified path <font color= "#FF0000">**/home/pipeline**</font>
2. 执行命令，安装脚本的依赖包
```shell
pip install -r /home/pipeline/bicep/requirements.txt
```


## Run Pipeline script
1. Swagger directory 
>* swagger file: OpenAPI.json/OpenAPI.yaml/OpenApi.yml
>* policies file if exists
>* policy_mappings.json: Mapping API and policy files
2. Enter the swagger directory for publishing apim<br>
for example:
```shell
cd /home/test/project1
```
2. Run the python script to create  <font color= "#FF0000">**main.bicep**</font> file
```shell
python /home/pipeline/bicep/bicep_generator.py $PWD
```
