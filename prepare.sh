#!/bin/bash
# I made this script to upgrade the kernel, using your custom .config file, and it shoud to be on youur home folder and called '.custom-kernel'
# 
# 
#
# Stage 0.1 - Version chooser 
verch(){	
	echo 'which kernel version EG: 3.x'
	echo 'series supported : 3.x and 4.x '
	read ser
	echo 'which version do you want to install EG: 4.4.1'
	read ver
}

# Stage 1 - Creating and/or changing to build diretory 
dirch(){
	if [ -e ~/kernelbuild ];
	then 
		cd  /home/$USER/kernelbuild
		echo  'exist'	
		
	else
		echo 'creating the build directory'
		mkdir -v /home/$USER/kernelbuild
		cd ~/kernelbuild
		
	fi
}

# Stage 2 - Download and extracting the source code
sourced(){
	if [ -e ~/kernelbuild/linux-$ver ] ;
	then 
		echo "you has downloaded and extracted source code of this verson"
		cd linux-$ver
		
	else
		echo $ver
		wget https://cdn.kernel.org/pub/linux/kernel/v$ser/linux-$ver.tar.xz 
		tar xf linux-$ver.tar.xz
		cd linux-$ver
		
	fi
}

# Stage - 3 Preparing the compiling 
preparemake(){
	make clean && make mrproper 
	if [ -e ~/.custom-kernel ];
	then 
		cp -v ~/.custom-kernel .config
	else
		make menuconfig
		cp -v .config ~/.custom-kernel 
	fi
	
	echo "how many cores your CPU have?"
	read $cores		## It is for optimization of the make process 
	
}

# Stage 3.1 - removing the old modules and boot image 
rem_old(){
	sudo rm -rf /usr/lib/modules/*-CUSTOM-KERNEL 
	sudo rm -rf /usr/lib64/modules/*-CUSTOM-KERNEL 
	sudo rm /boot/*-CUSTOM-KERNEL*   
echo "now you can type 'make'" 
}
verch && dirch && sourced && preparemake && rem_old && exit 0

