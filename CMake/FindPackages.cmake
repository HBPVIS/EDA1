# generated by Buildyard, do not edit.

include(System)
list(APPEND FIND_PACKAGES_DEFINES ${SYSTEM})
find_package(PkgConfig)

set(ENV{PKG_CONFIG_PATH} "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig:$ENV{PKG_CONFIG_PATH}")
if(PKG_CONFIG_EXECUTABLE)
  find_package(libzmq 4)
  if((NOT libzmq_FOUND) AND (NOT LIBZMQ_FOUND))
    pkg_check_modules(libzmq libzmq>=4)
  endif()
  if((NOT libzmq_FOUND) AND (NOT LIBZMQ_FOUND))
    message(FATAL_ERROR "Could not find libzmq")
  endif()
else()
  find_package(libzmq 4  REQUIRED)
endif()

if(PKG_CONFIG_EXECUTABLE)
  find_package(flatbuffers )
  if((NOT flatbuffers_FOUND) AND (NOT FLATBUFFERS_FOUND))
    pkg_check_modules(flatbuffers flatbuffers)
  endif()
  if((NOT flatbuffers_FOUND) AND (NOT FLATBUFFERS_FOUND))
    message(FATAL_ERROR "Could not find flatbuffers")
  endif()
else()
  find_package(flatbuffers   REQUIRED)
endif()


if(EXISTS ${CMAKE_SOURCE_DIR}/CMake/FindPackagesPost.cmake)
  include(${CMAKE_SOURCE_DIR}/CMake/FindPackagesPost.cmake)
endif()

if(LIBZMQ_FOUND)
  set(libzmq_name LIBZMQ)
  set(libzmq_FOUND TRUE)
elseif(libzmq_FOUND)
  set(libzmq_name libzmq)
  set(LIBZMQ_FOUND TRUE)
endif()
if(libzmq_name)
  list(APPEND FIND_PACKAGES_DEFINES EDA1_USE_LIBZMQ)
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} libzmq")
  link_directories(${${libzmq_name}_LIBRARY_DIRS})
  if(NOT "${${libzmq_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${libzmq_name}_INCLUDE_DIRS})
  endif()
endif()

if(FLATBUFFERS_FOUND)
  set(flatbuffers_name FLATBUFFERS)
  set(flatbuffers_FOUND TRUE)
elseif(flatbuffers_FOUND)
  set(flatbuffers_name flatbuffers)
  set(FLATBUFFERS_FOUND TRUE)
endif()
if(flatbuffers_name)
  list(APPEND FIND_PACKAGES_DEFINES EDA1_USE_FLATBUFFERS)
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} flatbuffers")
  link_directories(${${flatbuffers_name}_LIBRARY_DIRS})
  if(NOT "${${flatbuffers_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${flatbuffers_name}_INCLUDE_DIRS})
  endif()
endif()

set(EDA1_BUILD_DEBS autoconf;automake;cmake;doxygen;git;git-review;pkg-config;subversion)

set(EDA1_DEPENDS libzmq;flatbuffers)

# Write defines.h and options.cmake
if(NOT PROJECT_INCLUDE_NAME)
  message(WARNING "PROJECT_INCLUDE_NAME not set, old or missing Common.cmake?")
  set(PROJECT_INCLUDE_NAME ${CMAKE_PROJECT_NAME})
endif()
if(NOT OPTIONS_CMAKE)
  set(OPTIONS_CMAKE ${CMAKE_BINARY_DIR}/options.cmake)
endif()
set(DEFINES_FILE "${CMAKE_BINARY_DIR}/include/${PROJECT_INCLUDE_NAME}/defines${SYSTEM}.h")
list(APPEND COMMON_INCLUDES ${DEFINES_FILE})
set(DEFINES_FILE_IN ${DEFINES_FILE}.in)
file(WRITE ${DEFINES_FILE_IN}
  "// generated by CMake/FindPackages.cmake, do not edit.\n\n"
  "#ifndef ${CMAKE_PROJECT_NAME}_DEFINES_${SYSTEM}_H\n"
  "#define ${CMAKE_PROJECT_NAME}_DEFINES_${SYSTEM}_H\n\n")
file(WRITE ${OPTIONS_CMAKE} "# Optional modules enabled during build\n"
  "list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})\n")
foreach(DEF ${FIND_PACKAGES_DEFINES})
  add_definitions(-D${DEF}=1)
  file(APPEND ${DEFINES_FILE_IN}
  "#ifndef ${DEF}\n"
  "#  define ${DEF} 1\n"
  "#endif\n")
if(NOT DEF STREQUAL SYSTEM)
  file(APPEND ${OPTIONS_CMAKE} "set(${DEF} ON)\n")
endif()
endforeach()
if(CMAKE_MODULE_INSTALL_PATH)
  install(FILES ${OPTIONS_CMAKE} DESTINATION ${CMAKE_MODULE_INSTALL_PATH}
    COMPONENT dev)
else()
  message(WARNING "CMAKE_MODULE_INSTALL_PATH not set, old or missing Common.cmake?")
endif()
file(APPEND ${DEFINES_FILE_IN}
  "\n#endif\n")

include(UpdateFile)
configure_file(${DEFINES_FILE_IN} ${DEFINES_FILE} COPYONLY)
if(Boost_FOUND) # another WAR for broken boost stuff...
  set(Boost_VERSION ${Boost_MAJOR_VERSION}.${Boost_MINOR_VERSION}.${Boost_SUBMINOR_VERSION})
endif()
if(CUDA_FOUND)
  string(REPLACE "-std=c++11" "" CUDA_HOST_FLAGS "${CUDA_HOST_FLAGS}")
  string(REPLACE "-std=c++0x" "" CUDA_HOST_FLAGS "${CUDA_HOST_FLAGS}")
endif()
if(OPENMP_FOUND)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
endif()
if(QT4_FOUND)
  if(WIN32)
    set(QT_USE_QTMAIN TRUE)
  endif()
  # Configure a copy of the 'UseQt4.cmake' system file.
  if(NOT EXISTS ${QT_USE_FILE})
    message(WARNING "Can't find QT_USE_FILE!")
  else()
    set(_customUseQt4File "${CMAKE_BINARY_DIR}/UseQt4.cmake")
    file(READ ${QT_USE_FILE} content)
    # Change all include_directories() to use the SYSTEM option
    string(REPLACE "include_directories(" "include_directories(SYSTEM " content ${content})
    string(REPLACE "INCLUDE_DIRECTORIES(" "INCLUDE_DIRECTORIES(SYSTEM " content ${content})
    file(WRITE ${_customUseQt4File} ${content})
    set(QT_USE_FILE ${_customUseQt4File})
    include(${QT_USE_FILE})
  endif()
endif()
if(FIND_PACKAGES_FOUND)
  if(MSVC)
    message(STATUS "Configured with ${FIND_PACKAGES_FOUND}")
  else()
    message(STATUS "Configured with ${CMAKE_BUILD_TYPE}${FIND_PACKAGES_FOUND}")
  endif()
endif()
