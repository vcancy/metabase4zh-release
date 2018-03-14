# Metabase BI查询系统

Metabase是一个开源的BI系统，能实现多数据库支持，简单易用。
metabase4jar是metabase的编译版本，在metabase4jar基础上一定程度的二次开发，实现部分中文国际化的功能。


![capture](http://gitlab.source3g.com:10080/platform/metabase4jar/raw/master/metabse4jar.png)

### JVM Jar
```sh
java -jar metabase.jar
```

### Docker

```sh
docker run -d -p 3000:3000 --name metabase docker.source3g.com:5000/platform/metabase4jar:master 
```
`环境变量设置
JAVA_TIMEZONE			Asia/Shanghai	
JAVA_TOOL_OPTIONS	-Xmx4g	
MB_DB_DBNAME			metabase	
MB_DB_HOST			mysql	
MB_DB_PASS			2dd7ce4c5a3144ea520f89b1ec61fa2b
MB_DB_PORT			3306	
MB_DB_TYPE			mysql	
MB_DB_USER			root`

### 更多参考
[metabase.com](http://www.metabase.com)
[简要中文教程](http://gitlab.source3g.com:10080/platform/metabase4jar/blob/master/Tutorial/metabase-Tutorial.zip)