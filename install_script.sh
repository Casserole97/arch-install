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
echo y
echo n
echo p
echo 2
echo
echo
echo y
echo t
echo 2
echo 82
echo w
) | fdisk /dev/sda
