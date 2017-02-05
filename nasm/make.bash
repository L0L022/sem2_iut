#!/bin/bash

if [ ! -f "libIUT/libIUT.a" ]; then
  cd libIUT || exit
  make libIUT.a
  cd ..
fi

nasm -g -f elf32 "$1"
name="$(basename "$1" .nasm)"
gcc -m32 -o "$name".out "$name".o -LlibIUT -lIUT -lpanel -lncurses
rm "$name".o
