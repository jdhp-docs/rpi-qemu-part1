#!/bin/sh

RASPBIAN_IMAGE_FILE=raspbian.img
MOUNT_PATH=/mnt/loop0p2

# Umount the partition
umount ${MOUNT_PATH}
kpartx -d ${RASPBIAN_IMAGE_FILE}

