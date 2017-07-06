#!/bin/bash
echo 'processor type'
read arch 
export ARCH=$(echo $arch)
$PWD/check-depends.sh
$PWD/prepare.sh
$PWD/make.sh
$PWD/install.sh
