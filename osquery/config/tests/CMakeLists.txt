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

function(osqueryConfigTestsMain)
  generateOsqueryConfigTestsTestUtils()
  generateOsqueryConfigTestsTest()
  generateOsqueryConfigTestsPacksTest()
endfunction()

function(generateOsqueryConfigTestsTestUtils)
  add_osquery_library(osquery_config_tests_testutils EXCLUDE_FROM_ALL test_utils.cpp)

  set(public_header_files
    test_utils.h
  )

  generateIncludeNamespace(osquery_config_tests_testutils "osquery/config/tests" "FILE_ONLY" ${public_header_files})

  target_link_libraries(osquery_config_tests_testutils PUBLIC
    global_cxx_settings
    osquery_filesystem
    osquery_utils_json
    osquery_utils_system_env
  )
endfunction()

function(generateOsqueryConfigTestsTest)
  add_osquery_executable(osquery_config_tests-test config_tests.cpp)

  target_link_libraries(osquery_config_tests-test PRIVATE
    global_cxx_settings
    osquery_config
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_filesystem_mockfilestructure
    osquery_killswitch
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_system_time
    plugins_config_tlsconfig
    plugins_database_ephemeral
    specs_tables
    osquery_config_tests_testutils
    osquery_tools_tests_conffiles
    thirdparty_googletest
  )

endfunction()

function(generateOsqueryConfigTestsPacksTest)
  add_osquery_executable(osquery_config_tests_packs-test packs.cpp)

  target_link_libraries(osquery_config_tests_packs-test PRIVATE
    global_cxx_settings
    osquery_config
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_filesystem_mockfilestructure
    osquery_killswitch
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_system_time
    plugins_config_tlsconfig
    plugins_database_ephemeral
    specs_tables
    osquery_config_tests_testutils
    osquery_tools_tests_conffiles
    thirdparty_googletest
  )

endfunction()

osqueryConfigTestsMain()