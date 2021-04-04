#!/bin/bash

#<Message Display>
print_success()
{
    if [ "$1" == 0 ]; then
        echo "Image is dumped successfully."
    else
        echo "Image dump is failed."
        exit -1
    fi
}

dmesg | tail -10

echo "Input SD Reader's device file?(ex, /dev/sdb)"
read SD_Type

umount /media/android
umount /media/data
umount /media/cache
umount /media/Storage

echo "Dump Recovery Image to sm5s4210_recovery.img."
rm -rf sm5s4210_recovery.img
dd if=$SD_Type of=./sm5s4210_recovery.img bs=512 count=4206592

print_success "$?"


####################################

