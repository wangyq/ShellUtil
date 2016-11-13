#!/bin/sh

VER=release/boron

DIST_PROJECT="integration/distribution controller l2switch openflowjava openflowplugin"
PROJECT="cardinal groupbasedpolicy honeycomb-vbd centinel sdninterfaceapp distribution"

check()
{
	VER=release/beryllium-sr4

    CUR=`pwd` #~/data/opendaylight-dev

	for project in ${DIST_PROJECT} ; do
		git clone https://git.opendaylight.org/gerrit/${project}.git ${project} 
		
		cd ${project}
		git checkout $VER
		cd $CUR

		echo "${project} Done"
	done

}

make()
{   
    #for PROJECT in cardinal groupbasedpolicy honeycomb-vbd centinel sdninterfaceapp distribution
    #for PROJECT in distribution controller l2switch openflowjava openflowplugin

	#VER=release/boron-sr1
	VER=release/beryllium-sr4

    CUR=`pwd` # Donn't using var PWD

	for project in $PROJECT
     do 
        echo "Start ${project}"
        
        cd ${project}
        git checkout $VER
        mvn clean install
        #mvn clean
        
        cd $CUR

        echo "${project} Done"
    done

}

#====================
#
# usage:
#	create <version>
#		where: version = usage:
#	create <version>
#
#		where: version = 1.2.1-Boron-SR1, 1.1.4-Beryllium-SR4 
#
create()
{
# archetype version: 
#https://nexus.opendaylight.org/content/repositories/public/org/opendaylight/controller/opendaylight-startup-archetype/

	#APPVER=1.2.1-Boron-SR1
	APPVER=1.1.4-Beryllium-SR4

	if [ "$1" != "" ]; then
		APPVER=$1
	fi	

	echo "==> archtypeVersion = $APPVER"

	mvn archetype:generate -DarchetypeGroupId=org.opendaylight.controller \
		-DarchetypeArtifactId=opendaylight-startup-archetype\
		-DarchetypeVersion=$APPVER \
		-DarchetypeRepository=https://nexus.opendaylight.org/content/repositories/public/\
		-DarchetypeCatalog=https://nexus.opendaylight.org/content/repositories/public/archetype-catalog.xml
}

#----------------------------------------------------#
# shell entry to exec!
#
#----------------------------------------------------#
main()
{

case $1 in
	create)
		create $2 ;;
	make)
		make ;;
	check)
		check ;;
    run)
        run ;;
    install)
        install ;;
    uninstall)
        uninstall ;;
    cp)
        copy ;;
    rm)
        remove ;;
    *)
    echo "Usage: $0 run | check | make | create <arch-version>"
esac
}

# == shell entry to start == 
main $@
