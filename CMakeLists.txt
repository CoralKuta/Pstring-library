cmake_minimum_required(VERSION 3.20)
project(ex3 C)

set(CMAKE_C_STANDARD 99)

add_executable(ex3 main.c pstring.h run_main-test.c pstring.c)
