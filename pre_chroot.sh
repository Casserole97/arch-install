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
echo "Partitioned the disks and everything else"

#Installs essential packages to root
pacstrap /mnt base linux linux-firmware iwd vim grub intel-ucode man-db man-pages texinfo dhcpcd sudo git
echo "Installed packages"

#Generates an fstab file
genfstab -U /mnt >> /mnt/etc/fstab
echo "Generated fstab"

#Copies file to /mnt
cp 

#Chroots into the new system
arch-chroot /mnt bash 
echo "Chrooted"
