# Copyright (c) 2018-present, Trail of Bits, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required(VERSION 3.13.3)

# Set the build type
if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "Build type (default RelWithDebInfo)" FORCE)
endif()

# Always generate the compile_commands.json file
set(CMAKE_EXPORT_COMPILE_COMMANDS true)

# Show verbose compilation messages when building Debug binaries
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set(CMAKE_VERBOSE_MAKEFILE true)
endif()

# This is the destination for the remotely imported Python modules, used when
# setting up the PYTHONPATH folder
set(PYTHON_PATH "${CMAKE_BINARY_DIR}/python_path")

# TODO(alessandro): Add missing defines: PLATFORM_FREEBSD
if("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
  set(PLATFORM_POSIX 1)
  set(PLATFORM_LINUX 1)

elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Darwin")
  set(PLATFORM_POSIX 1)
  set(PLATFORM_MACOS 1)
elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
  set(PLATFORM_WINDOWS 1)
else()
	message(FATAL_ERROR "Unrecognized platform")
endif()

# Use ccache when available
if(DEFINED PLATFORM_POSIX)
  find_program(ccache_command ccache)

  if(NOT "${ccache_command}" STREQUAL "ccache_command-NOTFOUND")
    message(STATUS "Found ccache: ${ccache_command}")
    set(CMAKE_CXX_COMPILER_LAUNCHER "${ccache_command}" CACHE FILEPATH "")
  else()
    message(STATUS "Not found: ccache. Install it and put it into the PATH if you want to speed up partial builds.")
  endif()

endif()

set(TEST_CONFIGS_DIR "${CMAKE_BINARY_DIR}/test_configs")

# osquery versions
set(OSQUERY_VERSION 3.3.2)

set(OSQUERY_SOURCE_DIR "${CMAKE_SOURCE_DIR}/osquery-src")
