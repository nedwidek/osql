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

function(osqueryCoreTestsMain)
  generateOsqueryCoreTestsFlagsTests()
  generateOsqueryCoreTestsSystemTests()
  generateOsqueryCoreTestsTablesTests()
  generateOsqueryCoreTestsWatcherPermissionsTests()
  generateOsqueryCoreTestsQueryTests()
endfunction()

function(generateOsqueryCoreTestsFlagsTests)
  add_osquery_executable(osquery_core_tests_flagstests flags_tests.cpp)

  target_link_libraries(osquery_core_tests_flagstests PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_dispatcher
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    tests_helper
    osquery_utils_info
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryCoreTestsSystemTests)
  add_osquery_executable(osquery_core_tests_systemtests system_test.cpp)

  target_link_libraries(osquery_core_tests_systemtests PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_dispatcher
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    tests_helper
    osquery_utils_info
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryCoreTestsTablesTests)
  add_osquery_executable(osquery_core_tests_tablestests tables_tests.cpp)

  target_link_libraries(osquery_core_tests_tablestests PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_dispatcher
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    tests_helper
    osquery_utils_info
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryCoreTestsWatcherPermissionsTests)

  set(source_files
    watcher_tests.cpp
  )

  if(DEFINED PLATFORM_POSIX)
    list(APPEND source_files posix/permissions_tests.cpp)
  endif()

  add_osquery_executable(osquery_core_tests_watcherpermissionstests ${source_files})

  target_link_libraries(osquery_core_tests_watcherpermissionstests PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_dispatcher
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_process
    osquery_registry
    osquery_remote_enroll_tlsenroll
    tests_helper
    osquery_utils_info
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryCoreTestsQueryTests)
  add_osquery_executable(osquery_core_tests_querytests query_tests.cpp)

  target_link_libraries(osquery_core_tests_querytests PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_dispatcher
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_sql_tests_testutils
    tests_helper
    osquery_utils_info
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

osqueryCoreTestsMain()