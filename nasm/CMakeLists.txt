#marche pas
enable_language(ASM_NASM)
#set(CMAKE_ASM_NASM_LINK_EXECUTABLE "gcc -o <TARGET> <OBJECTS>")
set(CMAKE_ASM_NASM_FLAGS "${CMAKE_ASM_NASM_FLAGS} -g -f elf32")
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "gcc -m32 -o <TARGET> <OBJECTS> -L${CMAKE_CURRENT_SOURCE_DIR}/libIUT -lIUT -lpanel -lncurses")

#add_executable(first first.nasm iut.inc)
