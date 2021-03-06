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

function(osqueryUtilsStatusMain)

  if(BUILD_TESTING)
    generateOsqueryUtilsStatusStatustestsTest()
  endif()

  generateOsqueryUtilsStatus()
endfunction()

function(generateOsqueryUtilsStatus)
  add_osquery_library(osquery_utils_status EXCLUDE_FROM_ALL
    status.cpp
  )

  target_link_libraries(osquery_utils_status PUBLIC
    global_cxx_settings
    osquery_utils_error
    osquery_utils_expected
  )

  set(public_header_files
    status.h
  )

  generateIncludeNamespace(osquery_utils_status "osquery/utils/status" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_utils_status_statustests-test COMMAND osquery_utils_status_statustests-test)

endfunction()

function(generateOsqueryUtilsStatusStatustestsTest)
  add_osquery_executable(osquery_utils_status_statustests-test tests/status.cpp)

  target_link_libraries(osquery_utils_status_statustests-test PRIVATE
    global_cxx_settings
    osquery_utils_status
    thirdparty_googletest
  )
endfunction()

osqueryUtilsStatusMain()
