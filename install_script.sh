#!/bin/bash

read -p "How much swap in GiB?: " swap_amount
read -p "What hostname?: " new_hostname
read -p "What username?: " new_username
read -ps "What password?: " new_password
timedatectl set-ntp true
(
echo o
echo n
echo p
echo 1
echo
echo -$swap_amount"G"
echo
echo n
echo p
echo 2
echo
echo
echo
echo t
echo 2
echo 82
echo w
) | fdisk /dev/sda
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
mount /dev/sda1 /mnt
swapon /dev/sda2
pacstrap /mnt base linux linux-firmware iwd vim grub intel-ucode man-db man-pages texinfo dhcpcd sudo
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
