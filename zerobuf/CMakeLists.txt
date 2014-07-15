# Copyright (c) BBP/EPFL 2011-2014
#                        Stefan.Eilemann@epfl.ch
# All rights reserved. Do not distribute without further notice.

source_group(\\ FILES CMakeLists.txt)

FLATC_TARGET(SCHEMER schema.fbs)

set(ZEROBUF_PUBLIC_HEADERS ${COMMON_INCLUDES} world.h)
set(ZEROBUF_HEADERS ${SCHEMER_OUTPUTS})
set(ZEROBUF_SOURCES ${COMMON_SOURCES} world.cpp)
set(ZEROBUF_LINK_LIBRARIES ${Boost_PROGRAM_OPTIONS_LIBRARY})

common_library(Zerobuf)
