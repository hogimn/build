#******************************************************************************
#
# Modified by Hoki Min, 2021.
#
# Makefile - Makefile of u-boot & goldfish kernel
#
# Copyright (c) 2014 Roger Ye.  All rights reserved.
# Software License Agreement
# 
# 
# THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
# NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
# NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. The AUTHOR SHALL NOT, UNDER
# ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
# DAMAGES, FOR ANY REASON WHATSOEVER.
#
#******************************************************************************

# This is the makefile for goldfish serial device testing

#
# The base directory.
#
D_CUR=$(shell pwd)
D_UBOOT=${D_CUR}/../u-boot
D_LINUX=${D_CUR}/../kernel
D_BIN=${D_CUR}/../bin/arm-2010q1/bin
D_FLASH=${D_CUR}/sm5s4210/Image
D_ANDROID=${D_CUR}/../android-2.3.5_r1

all: config u-boot_build linux_build

config: u-boot_config linux_config

clean: u-boot_clean linux_clean

distclean: u-boot_distclean linux_distclean

u-boot_config:
	cd ${D_UBOOT}; \
	make sm5s4210_android_config \
		ARCH=arm CROSS_COMPILE=${D_BIN}/arm-none-eabi-; \
	cd ${D_CUR};

u-boot_build:
	cd ${D_UBOOT}; \
	make -j4 \
        ARCH=arm CROSS_COMPILE=${D_BIN}/arm-none-eabi-; \
	cd ${D_CUR};

u-boot_clean:
	cd ${D_UBOOT}; \
	make clean \
		ARCH=arm CROSS_COMPILE=${D_BIN}/arm-none-eabi-; \
	cd ${D_CUR};

u-boot_distclean:
	cd ${D_UBOOT}; \
	make distclean \
		ARCH=arm CROSS_COMPILE=${D_BIN}/arm-none-eabi-; \
	cd ${D_CUR};

linux_config:
	cd ${D_LINUX}; \
	make sm5s4210_android_defconfig \
		ARCH=arm CROSS_COMPILE=${D_BIN}/arm-none-eabi-; \
	cd ${D_CUR};

linux_menuconfig:
	cd ${D_LINUX}; \
	make menuconfig \
		ARCH=arm CROSS_COMPILE=${D_BIN}/arm-none-eabi-; \
	cd ${D_CUR};

linux_build:
	cd ${D_LINUX}; \
	make -j4 \
		ARCH=arm CROSS_COMPILE=${D_BIN}/arm-none-eabi-; \
	cd ${D_CUR};

linux_clean:
	cd ${D_LINUX}; \
	make clean \
		ARCH=arm CROSS_COMPILE=${D_BIN}/arm-none-eabi-; \
	cd ${D_CUR};

linux_distclean:
	cd ${D_LINUX}; \
	make distclean \
		ARCH=arm CROSS_COMPILE=${D_BIN}/arm-none-eabi-; \
	cd ${D_CUR};

aosp_build:
	cd ${D_ANDROID}/device/hanback/sm5s4210; \
	./build_android.sh \
	cd ${D_CUR};

deploy:
	cp ${D_UBOOT}/u-boot.bin ${D_FLASH};
	cp ${D_LINUX}/arch/arm/boot/zImage ${D_FLASH};
	rm ${D_FLASH}/system -rf
	cp ${D_ANDROID}/sm5s4210-img/system ${D_FLASH} -r;
	cp ${D_ANDROID}/sm5s4210-img/ramdisk-uboot.img ${D_FLASH};
