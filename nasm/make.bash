#!/bin/bash

nasm -f elf64 "$1"
name="$(basename "$1" .nasm)"
gcc -o "$name" "$name".o -L. -lIUT -lncurses
rm "$name".o
