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

function(osqueryPluginsDatabaseMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generatePluginsDatabaseEphemeral()
  generatePluginsDatabaseRocksdbplugin()
  generatePluginsDatabaseSqliteplugin()
endfunction()

function(generatePluginsDatabaseEphemeral)
  add_osquery_library(plugins_database_ephemeral EXCLUDE_FROM_ALL
    ephemeral.cpp
  )

  enableLinkWholeArchive(plugins_database_ephemeral)

  target_link_libraries(plugins_database_ephemeral PUBLIC
    global_cxx_settings
    osquery_core
    osquery_database
    osquery_registry
    osquery_utils
  )

  set(public_header_files
    ephemeral.h
  )

  generateIncludeNamespace(plugins_database_ephemeral "plugins/database" "FILE_ONLY" ${public_header_files})
endfunction()

function(generatePluginsDatabaseRocksdbplugin)
  add_osquery_library(plugins_database_rocksdbplugin EXCLUDE_FROM_ALL
    rocksdb.cpp
  )

  enableLinkWholeArchive(plugins_database_rocksdbplugin)

  target_link_libraries(plugins_database_rocksdbplugin PUBLIC
    global_cxx_settings
    osquery_core
    osquery_database
    osquery_registry
    osquery_utils
    thirdparty_googletest_headers
    thirdparty_rocksdb
  )

  set(public_header_files
    rocksdb.h
  )

  generateIncludeNamespace(plugins_database_rocksdbplugin "plugins/database" "FILE_ONLY" ${public_header_files})

  add_test(NAME plugins_database_tests_rocksdbtests-test COMMAND plugins_database_tests_rocksdbtests-test)

  set_tests_properties(plugins_database_tests_rocksdbtests-test PROPERTIES
    DISABLED True
  )
endfunction()

function(generatePluginsDatabaseSqliteplugin)
  add_osquery_library(plugins_database_sqliteplugin EXCLUDE_FROM_ALL
    sqlite.cpp
  )

  enableLinkWholeArchive(plugins_database_sqliteplugin)

  target_link_libraries(plugins_database_sqliteplugin PUBLIC
    global_cxx_settings
    osquery_core
    osquery_database
    osquery_filesystem
    osquery_registry
    osquery_utils
    thirdparty_sqlite
  )

  set(public_header_files
    sqlite.h
  )

  generateIncludeNamespace(plugins_database_sqliteplugin "plugins/database" "FILE_ONLY" ${public_header_files})

  add_test(NAME plugins_database_tests_sqliteplugintests-test COMMAND plugins_database_tests_sqliteplugintests-test)
endfunction()

osqueryPluginsDatabaseMain()
