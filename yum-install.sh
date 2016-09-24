#!/bin/sh
#使用： ./yum-install.sh
#安装必要插件
yum install -y yum-fastestmirror
yum install -y yum-priorities
#vi /etc/yum/pluginconf.d/priorities.conf    #确认 enabled = 1
#准备目录
cd /etc/yum.repos.d/
mkdir repobak.d
mv *.repo repobak.d
yum install -y wget
#下载安装rpmforge
#从 http://repoforge.org/use/ 下载rpmforge的最新rpm包
if [ "$HOSTTYPE" == "i686" ]
then
    wget http://pkgs.repoforge.org/rpmforge-release/apt-0.5.15lorg3.94a-5.el5.rf.i386.rpm
    wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.i686.rpm
elif [ "$HOSTTYPE" == "x86_64" ]
then
    wget http://pkgs.repoforge.org/rpmforge-release/apt-0.5.15lorg3.94a-5.el5.rf.x86_64.rpm
    wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
fi
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
rpm -Uvh *.rpm
mv *.rpm repobak.d
#安装其他插件
yum install -y yum-downloadonly

