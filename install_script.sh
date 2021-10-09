#!/bin/bash

read -p "Hostname: " new_hostname
read -p "Username: " new_username
read -ps "Password: " new_password
timedatectl set-ntp true
sfdisk /dev/sda < sda.dump
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
mount /dev/sda1 /mnt
swapon /dev/sda2
pacstrap /mnt base linux linux-firmware iwd vim grub intel-ucode man-db man-pages texinfo dhcpcd sudo
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
