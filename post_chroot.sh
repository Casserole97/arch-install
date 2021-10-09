#!/bin/bash
echo "\nCHROOTED\n"

#Configures pacman and installs more packages
sed -i "s/#Color/Color\nILoveCandy/" /etc/pacman.conf
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/" /etc/pacman.conf
(
echo [multilib]
echo Include = /etc/pacman.d/mirrorlist
) >> /etc/pacman.conf
pacman -Sy --noconfirm
pacman -S --needed --noconfirm iwd dhcpcd grub intel-ucode vim sudo git base-devel bind nftables
echo "\nINSTALLED MORE PACKAGES\n"

#Takes user input
echo "PLEASE INPUT THESE PARAMETERS"
read -p "Hostname: " hostname
read -p "Username: " username
read -s -p "Password: " password

#Misc configurations
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
sed -i "s/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "\nCONFIGURED SOME THINGS\n"

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
echo "\nCONFIGURED HOST STUFF AND PASSWORD\n"

#Bootloader
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo "\nINSTALLED AND CONFIGURED GRUB\n"

#Finishing touches
systemctl enable iwd dhcpcd named nftables
ip link set wlan0 up
useradd -m $username
(
echo $password
echo $password
) | passwd $username
echo "$username ALL=(ALL) ALL" | EDITOR="tee -a" visudo
echo "\nEXITING CHROOT\n"
