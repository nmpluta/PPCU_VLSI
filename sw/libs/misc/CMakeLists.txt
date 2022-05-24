cmake_minimum_required(VERSION 3.19)

add_library(misc)

target_link_libraries(misc PRIVATE
    drivers
)

target_include_directories(misc PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_sources(misc PRIVATE
    src/debug.cpp
    src/delay.cpp
    src/pixel_matrix.cpp
    src/string.cpp
    src/ui.cpp
)
