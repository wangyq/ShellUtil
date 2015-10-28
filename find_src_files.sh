#!/bin/bash
for dir in `find -type d`
do 
	cd $dir;echo -n `find *.c`;echo -n " ";cd - >/dev/null
done
