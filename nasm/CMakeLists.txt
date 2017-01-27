enable_language(ASM_NASM)
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "gcc -o <TARGET> <OBJECTS>")
#set(CMAKE_ASM_NASM_LINK_EXECUTABLE "gcc -o <TARGET> <OBJECTS> -L${CMAKE_CURRENT_SOURCE_DIR}/ -lIUT -lncurses")

add_executable(first first.nasm)
