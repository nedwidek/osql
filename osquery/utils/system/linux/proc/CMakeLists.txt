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

function(osqueryUtilsSystemLinuxProcMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryUtilsSystemLinuxProc()
endfunction()

function(generateOsqueryUtilsSystemLinuxProc)

  if(DEFINED PLATFORM_LINUX)
    add_osquery_library(osquery_utils_system_linux_proc EXCLUDE_FROM_ALL proc.cpp)

    target_link_libraries(osquery_utils_system_linux_proc PUBLIC
      global_cxx_settings
      thirdparty_boost
    )

    set(public_header_files
      proc.h
    )

    generateIncludeNamespace(osquery_utils_system_linux_proc "osquery/utils/system/linux/proc" "FILE_ONLY" ${public_header_files})
  else()
    add_library(osquery_utils_system_linux_proc INTERFACE)
  endif()

  # This is a special case for this test, since it requires that its process name starts with proc_tests
  add_test(NAME osquery_utils_system_linux_proc_proctests-test COMMAND proc_tests-test)
endfunction()

osqueryUtilsSystemLinuxProcMain()