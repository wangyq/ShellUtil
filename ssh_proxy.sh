#!/bin/sh

# run in rc.local file
#ssh -f -6 -N -D :2080 localhost
#runuser -l user -s "/bin/sh"  -c "ssh -f -6 -N -D :2080 localhost"

ssh -f -6 -N -D :2080 localhost

