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

function(osqueryUtilsSystemLinuxTracingMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryUtilsSystemLinuxTracing()
endfunction()

function(generateOsqueryUtilsSystemLinuxTracing)

  if (DEFINED PLATFORM_LINUX)
    set(source_files
      native_event.cpp
    )

    add_osquery_library(osquery_utils_system_linux_tracing EXCLUDE_FROM_ALL
      ${source_files}
    )

    target_link_libraries(osquery_utils_system_linux_tracing PUBLIC
      global_cxx_settings
      osquery_utils_conversions
      osquery_utils_expected
      osquery_logger
      thirdparty_boost
      thirdparty_googletest_headers
    )

    set(public_header_files
      native_event.h
      types.h
    )

    generateIncludeNamespace(osquery_utils_system_linux_tracing "osquery/utils/system/linux/tracing" "FILE_ONLY" ${public_header_files})

    add_test(NAME osquery_utils_system_linux_tracing_tests-test COMMAND osquery_utils_system_linux_tracing_tests-test)
  else()
    add_osquery_library(osquery_utils_system_linux_tracing INTERFACE)
  endif()
endfunction()

osqueryUtilsSystemLinuxTracingMain()