cmake_minimum_required(VERSION 3.19)

add_executable(bootloader)

target_link_libraries(bootloader PRIVATE
    libs
)

target_link_options(bootloader PRIVATE
    -T ${CMAKE_CURRENT_SOURCE_DIR}/link.ld
)

target_include_directories(bootloader PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_sources(bootloader PRIVATE
    crt0.S
    src/code_loader.cpp
    src/main.cpp
)

add_custom_command(TARGET bootloader POST_BUILD
    COMMAND ${CMAKE_OBJDUMP} -SD bootloader > bootloader.dis
    COMMAND ${CMAKE_OBJCOPY} -O binary bootloader bootloader.bin
    COMMAND srec_cat bootloader.bin -binary -fill 0x00 --within bootloader.bin -binary --range-padding 4 -offset 0x0000 -byte-swap 4 -o bootloader.vmem -vmem
)
