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

function(osqueryRemoteTestsMain)
  generateOsqueryRemoteTestsUtils()
  generateOsqueryRemoteTestsRequestsTests()
endfunction()

function(generateOsqueryRemoteTestsUtils)
  add_osquery_library(osquery_remote_tests_utils EXCLUDE_FROM_ALL test_utils.cpp)

  set(public_header_files
    test_utils.h
  )

  generateIncludeNamespace(osquery_remote_tests_utils "osquery/remote/tests" "FILE_ONLY" ${public_header_files})

  target_link_libraries(osquery_remote_tests_utils PUBLIC
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_events
    osquery_extensions
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_info
    plugins_config_tlsconfig
    plugins_killswitch_filesystem
    tests_helper
  )
endfunction()

function(generateOsqueryRemoteTestsRequestsTests)
  add_osquery_executable(osquery_remote_tests_requeststests requests_tests.cpp)

  target_link_libraries(osquery_remote_tests_requeststests PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_events
    osquery_extensions
    osquery_remote_enroll_tlsenroll
    osquery_remote_tests_utils
    osquery_utils_conversions
    osquery_utils_info
    plugins_config_tlsconfig
    plugins_killswitch_filesystem
    tests_helper
    thirdparty_googletest
  )
endfunction()

osqueryRemoteTestsMain()