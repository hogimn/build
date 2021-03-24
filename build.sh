# !/bin/bash

D_CUR=$(pwd)
D_AOSP=$D_CUR/../android-4.4.4_r2

# Copy configuration files to AOSP source tree
cp init.goldfish.rc fstab.goldfish.rc $D_AOSP/device/generic/goldfish/

# Build device armemu
cd $D_AOSP
. build/envsetup.sh
lunch goldfish2-eng
m -j8
cd $D_CUR

# . bring_images.sh

# Overwrite AOSP tools path by Android Sdk tools path
export PATH=$D_CUR/../bin/adt-bundle-linux-x86_64-20140702/sdk/tools:$PATH
export ANDROID_SWT=$D_CUR/../android-4.4.4_r2/prebuilts/tools/linux-x86_64/swt/
