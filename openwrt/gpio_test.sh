#!/bin/sh
GPIO_SYSPATH=/sys/class/gpio



#----------------------------------------------------#
# shell entry to exec!
#
#----------------------------------------------------#
main()
{

case $1 in
        run)
                run ;;
        start)
                restart ;;
        stop)
                stop ;;
        restart)
                stop
                start  ;;
        reload)
                reload ;;
        *)
        echo "Usage: $0 start | stop | restart | reload | run"
esac
}

# shell entry to start
main $@

