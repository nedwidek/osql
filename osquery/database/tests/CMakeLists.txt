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

function(osqueryDatabaseTestsMain)
  generateOsqueryDatabaseTests()
  generateOsqueryDatabaseTestsResults()
endfunction()

function(generateOsqueryDatabaseTests)
  add_osquery_executable(osquery_database_tests database.cpp)

  target_link_libraries(osquery_database_tests PRIVATE
    global_cxx_settings
    osquery_database_plugins_ephemeral
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryDatabaseTestsResults)
  add_osquery_executable(osquery_database_tests_results results.cpp)

  target_link_libraries(osquery_database_tests_results PRIVATE
    global_cxx_settings
    osquery_database_plugins_ephemeral
    osquery_core_sql
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    osquery_sql_tests_testutils
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

osqueryDatabaseTestsMain()