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

function(osqueryDatabasePluginsTestsMain)
  generateOsqueryDatabasePluginsTestsSqlitePluginTests()
  generateOsqueryDatabasePluginsTestsRocksDBTests()
  generateOsqueryDatabasePluginsTestsDatabaseTestUtils()
endfunction()

function(generateOsqueryDatabasePluginsTestsSqlitePluginTests)
  add_osquery_executable(osquery_database_plugins_tests_sqliteplugintests sqlite.cpp)

  target_link_libraries(osquery_database_plugins_tests_sqliteplugintests PRIVATE
    global_cxx_settings
    osquery_config_plugins_tlsconfig
    osquery_core
    osquery_database_plugins_ephemeral
    osquery_database_plugins_sqlite
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    specs_tables
    osquery_database_plugins_tests_databasetestutils
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryDatabasePluginsTestsRocksDBTests)
  add_osquery_executable(osquery_database_plugins_tests_rocksdbtests rocksdb.cpp)

  target_link_libraries(osquery_database_plugins_tests_rocksdbtests PRIVATE
    global_cxx_settings
    osquery_config_plugins_tlsconfig
    osquery_core
    osquery_database_plugins_ephemeral
    osquery_database_plugins_rocksdb
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    specs_tables
    osquery_database_plugins_tests_databasetestutils
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryDatabasePluginsTestsDatabaseTestUtils)
  add_osquery_library(osquery_database_plugins_tests_databasetestutils utils.cpp)

  set(public_header_files
    utils.h
  )

  generateIncludeNamespace(osquery_database_plugins_tests_databasetestutils "osquery/database/plugins/tests" "FILE_ONLY" ${public_header_files})

  target_link_libraries(osquery_database_plugins_tests_databasetestutils PRIVATE
    osquery_filesystem
    osquery_utils_json
    thirdparty_googletest_headers
  )
endfunction()

osqueryDatabasePluginsTestsMain()