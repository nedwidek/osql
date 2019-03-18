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

function(osqueryDatabasePluginsMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryDatabasePluginsEphemeral()
  generateOsqueryDatabasePluginsRocksdbplugin()
  generateOsqueryDatabasePluginsSqliteplugin()
endfunction()

function(generateOsqueryDatabasePluginsEphemeral)
  add_osquery_library(osquery_database_plugins_ephemeral EXCLUDE_FROM_ALL
    ephemeral.cpp
  )

  enableLinkWholeArchive(osquery_database_plugins_ephemeral)

  target_link_libraries(osquery_database_plugins_ephemeral PUBLIC
    global_cxx_settings
    osquery_core
    osquery_database
    osquery_registry
    osquery_utils
  )

  set(public_header_files
    ephemeral.h
  )

  generateIncludeNamespace(osquery_database_plugins_ephemeral "osquery/database/plugins" "FILE_ONLY" ${public_header_files})
endfunction()

function(generateOsqueryDatabasePluginsRocksdbplugin)
  add_osquery_library(osquery_database_plugins_rocksdbplugin EXCLUDE_FROM_ALL
    rocksdb.cpp
  )

  enableLinkWholeArchive(osquery_database_plugins_rocksdbplugin)

  target_link_libraries(osquery_database_plugins_rocksdbplugin PUBLIC
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

  generateIncludeNamespace(osquery_database_plugins_rocksdbplugin "osquery/database/plugins" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_database_plugins_tests_rocksdbtests-test COMMAND osquery_database_plugins_tests_rocksdbtests-test)
endfunction()

function(generateOsqueryDatabasePluginsSqliteplugin)
  add_osquery_library(osquery_database_plugins_sqliteplugin EXCLUDE_FROM_ALL
    sqlite.cpp
  )

  enableLinkWholeArchive(osquery_database_plugins_sqliteplugin)

  target_link_libraries(osquery_database_plugins_sqliteplugin PUBLIC
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

  generateIncludeNamespace(osquery_database_plugins_sqliteplugin "osquery/database/plugins" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_database_plugins_tests_sqliteplugintests-test COMMAND osquery_database_plugins_tests_sqliteplugintests-test)
endfunction()

osqueryDatabasePluginsMain()
