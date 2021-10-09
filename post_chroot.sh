#!/bin/bash

echo "Chrooted into /mnt"

#Installs more packages
pacman -S --needed -noconfirm iwd dhcpcd grub intel-ucode vim sudo git base-devel
echo "Installed more packages"

#Takes user input
echo "Please input these parameters"
read -p "Hostname: " hostname
read -p "Username: " username
read -s -p "Password: " password

#Misc configurations
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
sed -i "s/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > locale.conf
echo "Configured some things"

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
echo "Configured host stuff and password"

#Bootloader
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo "Installed and configured grub"

#Finishing touches
echo "Done!"
