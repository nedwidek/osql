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

function(osqueryPluginsDatabaseTestsMain)
  generatePluginsDatabaseTestsSqliteplugintestsTest()
  generatePluginsDatabaseTestsRocksdbtestsTest()
  generatePluginsDatabaseTestsDatabasetestutils()
endfunction()

function(generatePluginsDatabaseTestsSqliteplugintestsTest)
  add_osquery_executable(plugins_database_tests_sqliteplugintests-test sqlite.cpp)

  target_link_libraries(plugins_database_tests_sqliteplugintests-test PRIVATE
    global_cxx_settings
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    plugins_config_tlsconfig
    plugins_database_ephemeral
    plugins_database_sqliteplugin
    specs_tables
    plugins_database_tests_databasetestutils
    thirdparty_googletest
  )
endfunction()

function(generatePluginsDatabaseTestsRocksdbtestsTest)
  add_osquery_executable(plugins_database_tests_rocksdbtests-test rocksdb.cpp)

  target_link_libraries(plugins_database_tests_rocksdbtests-test PRIVATE
    global_cxx_settings
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    plugins_config_tlsconfig
    plugins_database_ephemeral
    plugins_database_rocksdbplugin
    specs_tables
    plugins_database_tests_databasetestutils
    thirdparty_googletest
  )
endfunction()

function(generatePluginsDatabaseTestsDatabasetestutils)
  add_osquery_library(plugins_database_tests_databasetestutils EXCLUDE_FROM_ALL utils.cpp)

  set(public_header_files
    utils.h
  )

  generateIncludeNamespace(plugins_database_tests_databasetestutils "plugins/database/tests" "FILE_ONLY" ${public_header_files})

  target_link_libraries(plugins_database_tests_databasetestutils PRIVATE
    osquery_filesystem
    osquery_utils_json
    thirdparty_googletest_headers
  )
endfunction()

osqueryPluginsDatabaseTestsMain()