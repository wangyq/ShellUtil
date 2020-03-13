#!/bin/sh

# run in rc.local file
#ssh -f -6 -N -D :2080 localhost
#runuser -l user -s "/bin/sh"  -c "nohup ssh -f -6 -N -D :2080 user@localhost >/dev/null 2>&1"

ssh -f -6 -N -D :2080 user@localhost >/dev/null 2>&1

