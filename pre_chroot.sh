#!/bin/bash

#Updates the system clock
timedatectl set-ntp true
echo "\nUPDATED SYSTEM CLOCK\n"

#Partitions the disk, formats the partitions, mounts root and enables swap
sfdisk -W always /dev/sda < sda.dump
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
mount /dev/sda1 /mnt
swapon /dev/sda2
echo "\nPARTITIONED THE DISK, FORMATTED AND MOUNTED ROOT AND ENABLED SWAP\n"

#Installs essential packages to root
pacstrap /mnt base linux linux-firmware man-db man-pages texinfo
echo "\nINSTALLED PACKAGES\n"

#Generates an fstab file
genfstab -U /mnt >> /mnt/etc/fstab
echo "\nGENERATED FSTAB\n"

#Copies post chroot script to /mnt, executes it with arch-chroot and finishes the process
cp post_chroot.sh /mnt
arch-chroot /mnt bash post_chroot.sh
rm /mnt/post_chroot.sh
umount -R /mnt
echo "\nDONE! REMOVE USB AFTER POWEROFF\n"
poweroff
