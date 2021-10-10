#!/bin/sh
echo "CHROOTED"

#Takes user input
echo "INPUT THESE PARAMETERS"
read -p "Hostname: " hostname
read -p "Username: " username
read -p "Password: " password

#Misc configurations
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
sed -i "s/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "CONFIGURED SOME THINGS"

#Hostname and password
echo $hostname > /etc/hostname
echo "127.0.0.1        localhost
::1              localhost
127.0.1.1        $hostname" >> /etc/hosts
(
echo $password
echo $password
) | passwd
echo "CONFIGURED HOST STUFF AND PASSWORD"

#Bootloader
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo "INSTALLED AND CONFIGURED GRUB"

#Finishing touches
useradd -m -s /bin/fish $username
(
echo $password
echo $password
) | passwd $username
echo "$username ALL=(ALL) ALL" | EDITOR="tee -a" visudo
echo "EXITING CHROOT"
