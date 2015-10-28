echo Begin install "$1" ...
if [ -z $1 ]; then
        echo "need vm_name as parameter"
        exit
fi

#osvar=freebsd8
#osvar=winxp
osvar=win2k3
#cdrom=/opt/WinXP_Plus_20110209.iso
cdrom=/opt/XLJS_GHOST_Win2003_V2.0.iso

virt-install \
--name $1 \
--ram 1024 \
--vcpus=2 \
--disk path=/var/vm_data/images/$1.img \
--network bridge=br0,model=e1000 \
--os-variant=${osvar} \
--accelerate \
--cdrom ${cdrom} \
--vnc

