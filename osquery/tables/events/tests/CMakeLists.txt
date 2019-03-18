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

function(osqueryTablesEventsTestsMain)
  generateOsqueryTablesEventsTestsFileeventstestsTest()

  if(DEFINED PLATFORM_LINUX)
    generateOsqueryTablesEventsTestsSelinuxeventstestsTest()
  endif()
endfunction()

function(generateOsqueryTablesEventsTestsFileeventstestsTest)
  add_osquery_executable(osquery_tables_events_tests_fileeventstests-test file_events_tests.cpp)

  target_link_libraries(osquery_tables_events_tests_fileeventstests-test PRIVATE
    global_cxx_settings
    osquery_headers
    osquery_config
    osquery_config_tests_testutils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_extensions
    osquery_logger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_tables_events_eventstable
    plugins_config_tlsconfig
    plugins_config_parsers
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryTablesEventsTestsSelinuxeventstestsTest)
  add_osquery_executable(osquery_tables_events_tests_selinuxeventstests-test linux/selinux_events_tests.cpp)

  target_link_libraries(osquery_tables_events_tests_selinuxeventstests-test PRIVATE
    global_cxx_settings
    osquery_headers
    osquery_core
    osquery_config
    osquery_config_tests_testutils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_extensions
    osquery_logger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_tables_events_eventstable
    plugins_config_tlsconfig
    plugins_config_parsers
    specs_tables
    thirdparty_googletest
  )
endfunction()

osqueryTablesEventsTestsMain()