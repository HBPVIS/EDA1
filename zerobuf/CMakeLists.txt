# Copyright (c) BBP/EPFL 2011-2014
#                        Stefan.Eilemann@epfl.ch
# All rights reserved. Do not distribute without further notice.

source_group(\\ FILES CMakeLists.txt)

set(ZEROBUF_PUBLIC_HEADERS ${COMMON_INCLUDES} world.h)
set(ZEROBUF_HEADERS)
set(ZEROBUF_SOURCES ${COMMON_SOURCES} world.cpp)
set(ZEROBUF_LINK_LIBRARIES ${Boost_PROGRAM_OPTIONS_LIBRARY})

common_library(Zerobuf)
