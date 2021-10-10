#!/bin/bash

username=$(logname)

#Manages the wifi connection
ip link set wlan0 up
systemctl enable --now iwd dhcpcd named nftables
echo "Connect to the internet:"
iwctl
echo "Wait for 5 seconds..." #Doing this because sometimes it doesn't connect fast enough before pacman is used
sleep 5s
echo "Connection (should be) estabilished!"

#Configures pacman and installs more packages
sed -i "s/#Color/Color\nILoveCandy/" /etc/pacman.conf
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/" /etc/pacman.conf
(
echo [multilib]
echo Include = /etc/pacman.d/mirrorlist
) >> /etc/pacman.conf
pacman -Syu --noconfirm
pacman -S --needed --noconfirm base-devel git nvidia nvidia-utils lib32-nvidia-utils xorg-server xorg-xinit
echo "INSTALLED MORE PACKAGES AND MODIFIED PACMAN"

#Installs paru
sudo -u $username git clone https://aur.archlinux.org/paru.git
cd paru
sudo -u $username makepkg -si --noconfirm --needed
cd
rm -r paru
echo "INSTALLED PARU"

