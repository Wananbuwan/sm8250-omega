#!/bin/bash

echo
echo "Clean Build Directory"
echo 

make clean && make mrproper
rm -rf out

echo
echo "Create Working Directory"
echo

mkdir -p out

echo
echo "Set DEFCONFIG"
echo 
time make O=out CC=clang omega_defconfig
export PATH="/mnt/Building/lolz_clang/bin:${PATH}"
export LD_LIBRARY_PATH="/mnt/Building/lolz_clang/lib:/mnt/Building/lolz_clang/lib64:$LD_LIBRARY_PATH"

echo
echo "Build The Kernel"
echo 

time make -j$(nproc --all) O=out CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-gnu-
find /out/arch/arm64/boot/dts/vendor/qcom -name '*.dtb' -exec cat {} + > dtb
