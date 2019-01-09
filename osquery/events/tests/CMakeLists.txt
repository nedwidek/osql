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
  generateOsqueryEventsTests()
  generateOsqueryEventsTestsDatabaseTests()

  if(DEFINED PLATFORM_LINUX)
    generateOsqueryEventsTestsSyslogTests()
    generateOsqueryEventsTestsAuditTests()
    generateOsqueryEventsTestsProcessFileEventsTests()
    generateOsqueryEventsTestsInotifyTests()
  endif()

  if(DEFINED PLATFORM_MACOS)
    generateOsqueryEventsTestsFsEventsTests()
  endif()

endfunction()

function(generateOsqueryEventsTests)
  add_osquery_executable(osquery_events_tests events_tests.cpp)

  target_link_libraries(osquery_events_tests PRIVATE
    global_cxx_settings
    osquery_tables_system
    osquery_core
    osquery_events
    osquery_filesystem
    osquery_utils
    osquery_utils_conversions
    osquery_config_tests_testutils
    osquery_remote_tests_utils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsDatabaseTests)
  add_osquery_executable(osquery_events_tests_databasetests events_database_tests.cpp)

  target_link_libraries(osquery_events_tests_databasetests PRIVATE
    global_cxx_settings
    osquery_tables_system
    osquery_core
    osquery_events
    osquery_filesystem
    osquery_utils
    osquery_utils_conversions
    osquery_config_tests_testutils
    osquery_remote_tests_utils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsSyslogTests)
  add_osquery_executable(osquery_events_tests_syslogtests linux/syslog_tests.cpp)

  target_link_libraries(osquery_events_tests_syslogtests PRIVATE
    global_cxx_settings
    osquery_tables_system
    osquery_core
    osquery_events
    osquery_filesystem
    osquery_utils
    osquery_utils_conversions
    osquery_config_tests_testutils
    osquery_remote_tests_utils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsAuditTests)
  add_osquery_executable(osquery_events_tests_audittests linux/audit_tests.cpp)

  target_link_libraries(osquery_events_tests_audittests PRIVATE
    global_cxx_settings
    osquery_tables_system
    osquery_core
    osquery_events
    osquery_filesystem
    osquery_utils
    osquery_utils_conversions
    osquery_config_tests_testutils
    osquery_remote_tests_utils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsProcessFileEventsTests)
  add_osquery_executable(osquery_events_tests_processfileeventstests linux/process_file_events_tests.cpp)

  target_link_libraries(osquery_events_tests_processfileeventstests PRIVATE
    global_cxx_settings
    osquery_tables_system
    osquery_core
    osquery_events
    osquery_filesystem
    osquery_utils
    osquery_utils_conversions
    osquery_config_tests_testutils
    osquery_remote_tests_utils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsInotifyTests)
  add_osquery_executable(osquery_events_tests_inotifytests linux/inotify_tests.cpp)

  target_link_libraries(osquery_events_tests_inotifytests PRIVATE
    global_cxx_settings
    osquery_tables_system
    osquery_core
    osquery_events
    osquery_filesystem
    osquery_utils
    osquery_utils_conversions
    osquery_config_tests_testutils
    osquery_remote_tests_utils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryEventsTestsFseventsTests)
  add_osquery_executable(osquery_events_tests_fseventstests darwin/fsevents_tests.cpp)

  target_link_libraries(osquery_events_tests_fseventstests PRIVATE
    global_cxx_settings
    osquery_tables_system
    osquery_core
    osquery_events
    osquery_filesystem
    osquery_utils
    osquery_utils_conversions
    osquery_config_tests_testutils
    osquery_remote_tests_utils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    specs_tables
    thirdparty_googletest
  )
endfunction()

osqueryEventsTestsMain()