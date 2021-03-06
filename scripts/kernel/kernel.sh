#!/bin/bash

#
# This scripts is used to download/update/compile kernel 
# (C) 2017.11.11 <buddy.zhang@aliyun.com>
#

# $1: ROOT
# $2: kernel version / menuconfig
# $3: git_site 
# $4: command

ROOT=$1
STAGING_KERNEL=${ROOT}/kernel

# prepare source code of kernel
if [ ! -d ${STAGING_KERNEL}/.git ]; then
  git clone $3 ${STAGING_KERNEL}
fi

# config kernel
if [ ! -f ${STAGING_KERNEL}/.config ]; then
  ${MAKE} -C ${STAGING_KERNEL} defconfig
fi

# configure kernel
if [ $2 == "menuconfig" ]; then
  ${MAKE} -C ${STAGING_KERNEL} menuconfig
  exit 0
fi

# compile kernel
if [ $4 == "make" ]; then
  ${MAKE} -C ${STAGING_KERNEL}
fi

# build kernel image
if [ ! -d ${ROOT}/output/kernel ]; then
  mkdir -p ${ROOT}/output/kernel
fi
cp -rfa ${STAGING_KERNEL}/arch/x86/kernel/BiscuitOS ${ROOT}/output/kernel/Image

