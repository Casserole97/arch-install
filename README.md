## What is this?
Just a personal arch install script. You can check it out if you need some pointers on how to make your own, but I'm not claiming that it's perfect; I'm only an amateur myself.

**I don't suggest running it on your machine.**

## Usage
1. Boot into the live arch environment
2. Connect to the internet
3. Update pacman repos and download git
4. Clone the repo
5. Change directory to the repo
6. 
```
chmod a+x pre_chroot.sh
./pre_chroot.sh
```
4. Sit back and relax
5. After the reboot, log in as the new User and do:
```
sudo /home/post_install.sh
```
6. Done!

## Q&A
> If it's only for your usage, then why do you need instructions?

Good question! Let's just say I forget things easily...

> Should I run this script on my machine?

No. You may try, but it probably won't lead to anything good. Almost everything is hard coded and configured to my liking, needs and hardware.
