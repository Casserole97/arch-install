#!/bin/bash

read -p "How much swap in GiB?: " swap_amount
read -p "What hostname?: " new_hostname
read -p "What username?: " new_username
read -ps "What password?: " new_password
timedatectl set-ntp true
