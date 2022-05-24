cmake_minimum_required(VERSION 3.19)

add_library(drivers)

target_include_directories(drivers PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/include/pmc_regs
    ${CMAKE_CURRENT_SOURCE_DIR}/include/spi_regs
    ${CMAKE_CURRENT_SOURCE_DIR}/include/timer_regs
    ${CMAKE_CURRENT_SOURCE_DIR}/include/uart_regs
)

target_sources(drivers PRIVATE
    src/code_ram.cpp
    src/core.cpp
    src/gpio.cpp
    src/pmc.cpp
    src/pmcc.cpp
    src/spi.cpp
    src/timer.cpp
    src/uart.cpp
)
