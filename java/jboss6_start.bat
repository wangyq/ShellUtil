
@ECHO OFF
COLOR 0A
REM 采用default启动时，报Port 8083 already in use，查了下端口占用情况，发现是被搜狗浏览器占用了（这丫从8081开始一直用到8084，真够黑的）
REM 没办法，我经常用搜狗浏览器，它也不让我修改端口，于是只有去修改jboss的启动端口了，网上查了很多资料，都没有找到在哪里能修改8083端口。
REM 最后在一个国外的网站上找到了，特意把它贴出来，免得自己和同僚将来找不着地方。

REM ${jboss_home}\server\default\conf\bindingservice.beans\META-INF\bindings-jboss-beans.xml

REM ======================================
REM 运行JAVA的脚本

::当前路径
SET CUR_DIR=%CD%

CALL SET_JAVA.BAT

CD %CUR_DIR%\jboss-6.0.0.Final\bin
CALL run.bat
