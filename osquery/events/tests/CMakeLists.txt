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

function(osqueryEventsTestsMain)
  generateOsqueryEventsTestsTest()
  generateOsqueryEventsTestsEventsdatabasetestsTest()

  if(DEFINED PLATFORM_LINUX)
    generateOsqueryEventsTestsSyslogtestsTest()
    generateOsqueryEventsTestsAudittestsTest()
    generateOsqueryEventsTestsProcessfileeventstestsTest()
    generateOsqueryEventsTestsInotifytestsTest()
  endif()

  if(DEFINED PLATFORM_MACOS)
    generateOsqueryEventsTestsFseventstestsTest()
  endif()

endfunction()

function(generateOsqueryEventsTestsTest)
  add_osquery_executable(osquery_events_tests-test events_tests.cpp)

  target_link_libraries(osquery_events_tests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_database
    osquery_events
    osquery_filesystem
    osquery_remote_tests_remotetestutils
    osquery_tables_system_systemtable
    osquery_utils
    osquery_utils_conversions
    plugins_database_ephemeral
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsEventsdatabasetestsTest)
  add_osquery_executable(osquery_events_tests_eventsdatabasetests-test events_database_tests.cpp)

  target_link_libraries(osquery_events_tests_eventsdatabasetests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_database
    osquery_events
    osquery_filesystem
    osquery_remote_tests_remotetestutils
    osquery_tables_system_systemtable
    osquery_utils
    osquery_utils_conversions
    plugins_database_ephemeral
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsSyslogtestsTest)
  add_osquery_executable(osquery_events_tests_syslogtests-test linux/syslog_tests.cpp)

  target_link_libraries(osquery_events_tests_syslogtests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_database
    osquery_events
    osquery_filesystem
    osquery_remote_tests_remotetestutils
    osquery_tables_system_systemtable
    osquery_utils
    osquery_utils_conversions
    plugins_database_ephemeral
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsAudittestsTest)
  add_osquery_executable(osquery_events_tests_audittests-test linux/audit_tests.cpp)

  target_link_libraries(osquery_events_tests_audittests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_database
    osquery_events
    osquery_filesystem
    osquery_remote_tests_remotetestutils
    osquery_tables_system_systemtable
    osquery_utils
    osquery_utils_conversions
    plugins_database_ephemeral
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsProcessfileeventstestsTest)
  add_osquery_executable(osquery_events_tests_processfileeventstests-test linux/process_file_events_tests.cpp)

  target_link_libraries(osquery_events_tests_processfileeventstests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_database
    osquery_events
    osquery_filesystem
    osquery_remote_tests_remotetestutils
    osquery_tables_system_systemtable
    osquery_utils
    osquery_utils_conversions
    plugins_database_ephemeral
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsInotifytestsTest)
  add_osquery_executable(osquery_events_tests_inotifytests-test linux/inotify_tests.cpp)

  target_link_libraries(osquery_events_tests_inotifytests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_database
    osquery_events
    osquery_filesystem
    osquery_remote_tests_remotetestutils
    osquery_tables_system_systemtable
    osquery_utils
    osquery_utils_conversions
    plugins_database_ephemeral
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsFseventstestsTest)
  add_osquery_executable(osquery_events_tests_fseventstests-test darwin/fsevents_tests.cpp)

  target_link_libraries(osquery_events_tests_fseventstests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_database
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_filesystem
    osquery_remote_tests_remotetestutils
    osquery_tables_system_systemtable
    osquery_utils
    osquery_utils_conversions
    plugins_database_ephemeral
    specs_tables
    thirdparty_googletest
  )
endfunction()

osqueryEventsTestsMain()