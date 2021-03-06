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
project(osquery)

if (BUILD_TESTING)
  enable_testing()
endif()

include(cmake/globals.cmake)
include(cmake/utilities.cmake)
include(cmake/options.cmake)
include(cmake/packaging.cmake)

function(main)
  message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
  message(STATUS "Shared libraries: ${BUILD_SHARED_LIBS}")

  if (NOT DEFINED PLATFORM_WINDOWS)
    if(NOT "${CMAKE_C_COMPILER_ID}" STREQUAL "Clang" OR
       NOT "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
      message(STATUS "Warning: the selected C or C++ compiler is not clang/clang++. Compilation may fail")
    endif()
  endif()

  generateGlobalSettingsTargets()

  findPythonExecutablePath()

  # Used to generate all the files necessary to have a complete view of the project in the IDE
  add_custom_target(prepare_for_ide)

  add_subdirectory("third-party")
  add_subdirectory("osquery")
  add_subdirectory("plugins")
  add_subdirectory("tools")
  add_subdirectory("specs")

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  identifyPackagingSystem()
  generateInstallTargets()
  generatePackageTarget()

endfunction()

main()
