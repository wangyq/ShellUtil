#!/bin/sh


ODL=/home/user/data/opendaylight-dev/boron/distribution
ODLPATH=$ODL/distribution-karaf/target/assembly

HELLO=/home/user/data/opendaylight-dev/boron/hello
HELLOPATH=$HELLO/karaf/target/assembly


install()
{
    #echo $CURDIR
    mvn clean install -DskipTests
    copy
    #cp -Ru $HELLOPATH/system/org/bupt $ODLPATH/system/org

}

uninstall()
{
    remove
    #rm -rf $ODLPATH/system/org/bupt
}

copy()
{
    cp -Ru $HELLOPATH/system/org/bupt $ODLPATH/system/org
    echo "Copy Done."
}

remove()
{
    rm -rf $ODLPATH/system/org/bupt
    echo "Remove Done."
}
#----------------------------------------------------#
# shell entry to exec!
#
#----------------------------------------------------#
main()
{

case $1 in
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
    echo "Usage: $0 run | install | uninstall | cp | rm"
esac
}

# == shell entry to start == 
main $@


