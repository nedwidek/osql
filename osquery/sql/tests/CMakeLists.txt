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

function(osquerySqlMain)
  generateOsquerySqlTestsSqltestutils()
  generateOsquerySqlTestsTest()
  generateOsquerySqlTestsVirtualtableTestsTest()
  generateOsquerySqlTestsSqliteutiltestsTest()
endfunction()

function(generateOsquerySqlTestsSqltestutils)
  add_osquery_library(osquery_sql_tests_sqltestutils EXCLUDE_FROM_ALL sql_test_utils.cpp)

  set(public_header_files
    sql_test_utils.h
  )

  generateIncludeNamespace(osquery_sql_tests_sqltestutils "osquery/sql/tests" "FILE_ONLY" ${public_header_files})

  target_link_libraries(osquery_sql_tests_sqltestutils PUBLIC
    global_cxx_settings
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_sql
    plugins_config_tlsconfig
    specs_tables
  )
endfunction()

function(generateOsquerySqlTestsTest)
  add_osquery_executable(osquery_sql_tests-test sql.cpp)

  target_link_libraries(osquery_sql_tests-test PRIVATE
    global_cxx_settings
    osquery_database
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_sql
    osquery_sql_tests_sqltestutils
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsquerySqlTestsVirtualtableTestsTest)
  add_osquery_executable(osquery_sql_tests_virtualtabletests-test virtual_table.cpp)

  target_link_libraries(osquery_sql_tests_virtualtabletests-test PRIVATE
    global_cxx_settings
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_sql
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsquerySqlTestsSqliteutiltestsTest)
  add_osquery_executable(osquery_sql_tests_sqliteutilstests-test sqlite_util_tests.cpp)

  target_link_libraries(osquery_sql_tests_sqliteutilstests-test PRIVATE
    global_cxx_settings
    osquery_database
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_sql
    osquery_sql_tests_sqltestutils
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

osquerySqlMain()