#!/bin/bash

nasm -f bin another_example.asm -o another_example
dd if=/dev/zero of=bootdisk.img bs=512 count=2880
dd conv=notrunc if=another_example of=bootdisk.img bs=512 count=1 seek=0
qemu-system-i386 -machine q35 -fda bootdisk.img -gdb tcp::26000 -S
