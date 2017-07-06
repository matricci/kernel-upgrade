#!/bin/bash  
# stage 4 - install 
cd ~/kernelbuild/
sudo make modules_install 
sudo cp -v ~/kernelbuild/arch/$arch/boot/bzImage /boot/vmlinuz-linux-CUSTOM-KERNEL
sudo mkinitcpio -p linux-CUSTOM-KERNEL 
sudo update-grub 
