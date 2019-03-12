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

if(NOT DEFINED PLATFORM_WINDOWS)
  cmake_policy(SET CMP0083 NEW)
endif()

function(osqueryUtilsSystemLinuxTracingTestsMain)
  generateOsqueryUtilsSystemLinuxTracingTestsTest()
endfunction()

function(generateOsqueryUtilsSystemLinuxTracingTestsTest)

  set(source_files
    empty.cpp
  )

  if(DEFINED PLATFORM_LINUX)
    set(platform_source_files
      native_event.cpp
    )

    list(APPEND source_files ${platform_source_files})
  endif()

  add_osquery_executable(osquery_utils_system_linux_tracing_tests-test ${source_files})

  target_link_libraries(osquery_utils_system_linux_tracing_tests-test PRIVATE
    global_cxx_settings
    osquery_utils_system_linux_tracing
    thirdparty_googletest
  )
endfunction()

osqueryUtilsSystemLinuxTracingTestsMain()