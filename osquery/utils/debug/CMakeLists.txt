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

function(osqueryUtilsDebugMain)

  if(BUILD_TESTING)
    generateOsqueryUtilsDebugDebugtestsTest()
  endif()

  generateOsqueryUtilsDebug()
endfunction()

function(generateOsqueryUtilsDebug)
  add_osquery_library(osquery_utils_debug INTERFACE)

  target_link_libraries(osquery_utils_debug INTERFACE
    global_cxx_settings
    thirdparty_boost
  )

  set(public_header_files
    debug_only.h
  )

  generateIncludeNamespace(osquery_utils_debug "osquery/utils/debug" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_utils_debug_debugtests-test COMMAND osquery_utils_debug_debugtests-test)

endfunction()

function(generateOsqueryUtilsDebugDebugtestsTest)
  add_osquery_executable(osquery_utils_debug_debugtests-test tests/debug_only.cpp)

  target_link_libraries(osquery_utils_debug_debugtests-test PRIVATE
    global_cxx_settings
    osquery_utils_debug
    thirdparty_googletest
  )
endfunction()

osqueryUtilsDebugMain()
