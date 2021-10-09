#!/bin/bash

#Takes user input
read -p "Hostname: " hostname
read -p "Username: " username
echo -s -p "Password: " password

#Updates the system clock
timedatectl set-ntp true

#Partitions the disk, formats the partitions, mounts root and enables swap
sfdisk -W always /dev/sda < sda.dump
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
mount /dev/sda1 /mnt
swapon /dev/sda2

#Installs essential packages to root
pacstrap /mnt base linux linux-firmware iwd vim grub intel-ucode man-db man-pages texinfo dhcpcd sudo base-devel git

#Generates an fstab file
genfstab -U /mnt >> /mnt/etc/fstab

#Chroots into the new system
arch-chroot /mnt

#Misc configurations
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
sed -i "s/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > locale.conf

#Hostname and password
echo $hostname > /etc/hostname
(
echo
echo 127.0.0.1        localhost
echo ::1              localhost
echo 127.0.1.1        $hostname
) >> /etc/hosts

(
echo $password
echo $password
) | passwd

grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
