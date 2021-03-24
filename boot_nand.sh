#!/bin/bash

DEBUG=$1
D_CUR=$(pwd)
D_EMU=$D_CUR/../bin/adt-bundle-linux-x86_64-20140702/sdk/tools
D_OUT=$D_CUR/../android-4.4.4_r2/out/target/product/goldfish2
D_CROSSCOMPILER=$D_CUR/../bin/arm-2013.11/bin

# Boot in debug mode
if [ "$DEBUG" == "d" ]; then
    ddd --debugger $D_CROSSCOMPILER/arm-none-eabi-gdb $D_OUT/obj/U-BOOT_OBJ/u-boot &
    $D_EMU/emulator -netfast -verbose -show-kernel -avd goldfish2 -shell -system $D_OUT/system.img -ramdisk $D_OUT/ramdisk.img -qemu -s -S -kernel $D_OUT/u-boot.bin
# Boot normally
else
    $D_EMU/emulator -netfast -verbose -show-kernel -avd goldfish2 -shell -system $D_OUT/system.img -ramdisk $D_OUT/ramdisk.img -qemu -kernel $D_OUT/u-boot.bin
fi
