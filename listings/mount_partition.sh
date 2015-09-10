#!/bin/sh

RASPBIAN_IMAGE_FILE=raspbian.img
MOUNT_PATH=/mnt/loop0p2

# Mount the partition
kpartx -av ${RASPBIAN_IMAGE_FILE}
mkdir -v ${MOUNT_PATH} 2> /dev/null
mount /dev/mapper/loop0p2 ${MOUNT_PATH}

