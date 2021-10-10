#!/bin/bash

#Since this script is ran with sudo, I need to do this to keep track of the user's actual username
username=$(logname)

#Bash config

#Manages the wifi connection
ip link set wlan0 up
systemctl enable --now iwd dhcpcd named nftables
echo "CONNECT TO THE INTERNET:"
iwctl
echo "WAIT FOR 5 SECONDS..."
sleep 5s
echo "CONNECTION (SHOULD BE) ESTABILISHED!"

#Configures pacman and installs more packages
sed -i "s/#Color/Color\nILoveCandy/" /etc/pacman.conf
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/" /etc/pacman.conf
(
echo [multilib]
echo Include = /etc/pacman.d/mirrorlist
) >> /etc/pacman.conf
pacman -Syu --noconfirm
pacman -S --needed --noconfirm base-devel git nvidia nvidia-utils lib32-nvidia-utils xorg-server xorg-xinit xorg-xrandr
echo "INSTALLED MORE PACKAGES AND MODIFIED PACMAN"

#Nvidia config
cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nvidia.drm_modeset=1"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
echo "
Section "OutputClass"
    Identifier "intel"
    MatchDriver "i915"
    Driver "modesetting"
EndSection

Section "OutputClass"
    Identifier "nvidia"
    MatchDriver "nvidia-drm"
    Driver "nvidia"
    Option "AllowEmptyInitialConfiguration"
    Option "PrimaryGPU" "yes"
    ModulePath "/usr/lib/nvidia/xorg"
    ModulePath "/usr/lib/xorg/modules"
EndSection
" >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
sed -i '1a xrandr --setprovideroutputsource modesetting NVIDIA-0\nxrandr --auto' ~/.xinitrc

#Installs paru
sudo -u $username git clone https://aur.archlinux.org/paru.git
cd paru
sudo -u $username makepkg -si --noconfirm --needed
cd
rm -r paru
echo "INSTALLED PARU"

#Finishing steps
rm /post_install.sh
echo "FINISHED. REBOOT IN 5 SECONDS"
sleep 5
reboot
