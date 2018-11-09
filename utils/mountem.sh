#!/bin/bash

# Function:
#     Mounts Jessie's USERDATA partition and creates a user-readable mirror of it
#     (Offset was found via "mmls")
# Requirements:
#     Samsung disk images extracted to /home/sift/samsung/
#     User id "sift"
#     "sift" is a sudoer

RAWMNT=/mnt/userdata_raw
NICEMNT=/mnt/userdata

# Offset found via "mmls"
USERDATA_IMG=/home/sift/dfrws/samsung/blk0_sda.bin
USERDATA_OFFSET=4329570304

# exit on fail
set -e

if [ "$1" == "-u" ] ; then
        sudo umount "${NICEMNT}"
        sudo umount "${RAWMNT}"
        echo "Samsung USERDATA volume umounted successfully."
else
        sudo mkdir -p "${RAWMNT}"
        sudo mkdir -p "${NICEMNT}"

        sudo mount -o loop,offset=${USERDATA_OFFSET},ro "${USERDATA_IMG}" "${RAWMNT}"
        sudo bindfs -u sift -p 555 "${RAWMNT}" "${NICEMNT}"

        echo "Samsung USERDATA volume is user-readable at ${NICEMNT} and root-readable at ${RAWMNT}"
fi
