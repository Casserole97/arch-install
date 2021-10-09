#!/bin/bash

git base-devel bind nftables

sed -i "s/#Color/Color\nILoveCandy/" /etc/pacman.conf
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/" /etc/pacman.conf
(
echo [multilib]
echo Include = /etc/pacman.d/mirrorlist
) >> /etc/pacman.conf
pacman -Sy --noconfirm
pacman -S --needed --noconfirm 
echo "INSTALLED MORE PACKAGES"

systemctl enable iwd dhcpcd named nftables
ip link set wlan0 up
