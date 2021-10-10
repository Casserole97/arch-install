#!/bin/sh

#Updates the system clock
timedatectl set-ntp true
echo "UPDATED SYSTEM CLOCK"

#Partitions the disk, formats the partitions, mounts root and enables swap
sfdisk -W always /dev/sda < sda.dump
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
mount /dev/sda1 /mnt
swapon /dev/sda2
echo "PARTITIONED THE DISK, FORMATTED AND MOUNTED ROOT AND ENABLED SWAP"

#Installs essential packages
pacstrap /mnt base linux linux-firmware man-db man-pages texinfo iwd dhcpcd bind nftables grub intel-ucode vim sudo fish
echo "INSTALLED PACKAGES"

#Generates an fstab file
genfstab -U /mnt >> /mnt/etc/fstab
echo "GENERATED FSTAB"

#Copies post chroot script to /mnt, executes it with arch-chroot and finishes the process
cp {post_chroot.sh,post_install.sh} /mnt
chmod a+x /mnt/{post_chroot.sh,post_install.sh}
arch-chroot /mnt ./post_chroot.sh

#Finishing steps
rm /mnt/post_chroot.sh
umount -R /mnt
echo "DONE! REMOVE USB AFTER POWEROFF IN 5 SECONDS"
sleep 5s
poweroff
