
@ECHO OFF
COLOR 0A
REM ����default����ʱ����Port 8083 already in use�������¶˿�ռ������������Ǳ��ѹ������ռ���ˣ���Ѿ��8081��ʼһֱ�õ�8084���湻�ڵģ�
REM û�취���Ҿ������ѹ����������Ҳ�������޸Ķ˿ڣ�����ֻ��ȥ�޸�jboss�������˿��ˣ����ϲ��˺ܶ����ϣ���û���ҵ����������޸�8083�˿ڡ�
REM �����һ���������վ���ҵ��ˣ��������������������Լ���ͬ�Ž����Ҳ��ŵط���

REM ${jboss_home}\server\default\conf\bindingservice.beans\META-INF\bindings-jboss-beans.xml

REM ======================================
REM ����JAVA�Ľű�

::��ǰ·��
SET CUR_DIR=%CD%

CALL SET_JAVA.BAT

CD %CUR_DIR%\jboss-6.0.0.Final\bin
CALL run.bat
