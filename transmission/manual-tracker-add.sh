#!/bin/bash
# Get transmission credentials
auth=user:password
host=localhost

add_trackers () {
    torrent_hash=$1
 for base_url in https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt ; do
    echo -e "\e[1m\e[5m"
    echo "URL for ${base_url}"
    echo -e "Adding trackers for \e[91m$torrent_name..."
    echo -en "\e[0m"
    echo -e "\e[2m\e[92m"
for tracker in $(curl -# "${base_url}") ; do
    echo -en "\e[0m"
    echo -ne "\e[93m*\e[0m ${tracker}..."
if transmission-remote "$host" --auth="$auth" --torrent "${torrent_hash}" -td "${tracker}" | grep -q 'success'; then
    echo -e '\e[91m failed.'
    echo -en "\e[0m"
else
    echo -e '\e[92m done.'
    echo -en "\e[0m"
fi
 done
done
}

# Get list of active torrents
ids="$(transmission-remote "$host" --auth="$auth" --list | grep -vE 'Seeding|Stopped|Finished' | grep '^ ' | awk '{ print $1 }')"

for id in $ids ; do
    hash="$(transmission-remote "$host" --auth="$auth"  --torrent "$id" --info | grep '^  Hash: ' | awk '{ print $2 }')"
    torrent_name="$(transmission-remote "$host" --auth="$auth"  --torrent "$id" --info | grep '^  Name: ' |cut -c 9-)"
    add_trackers "$hash"
done
