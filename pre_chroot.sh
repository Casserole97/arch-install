#!/bin/bash

#Updates the system clock
timedatectl set-ntp true
echo "Updated system clock"

#Partitions the disk, formats the partitions, mounts root and enables swap
sfdisk -W always /dev/sda < sda.dump
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
mount /dev/sda1 /mnt
swapon /dev/sda2
echo "Partitioned the disk, formatted and mounted root and enabled swap"

#Installs essential packages to root
pacstrap /mnt base linux linux-firmware man-db man-pages texinfo
echo "Installed packages"

#Generates an fstab file
genfstab -U /mnt >> /mnt/etc/fstab
echo "Generated fstab"

#Copies post chroot script to /mnt and executes it with arch-chroot
cp post_chroot.sh /mnt
arch-chroot /mnt bash post_chroot.sh
rm post_chroot.sh /mnt
