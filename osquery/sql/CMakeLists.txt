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

function(osquery_sql_main)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsquerySql()
endfunction()

function(generateOsquerySql)
  set(source_files
    dynamic_table_row.cpp
    sql.cpp
    sqlite_encoding.cpp
    sqlite_filesystem.cpp
    sqlite_hashing.cpp
    sqlite_math.cpp
    sqlite_operations.cpp
    sqlite_util.cpp
    virtual_sqlite_table.cpp
    virtual_table.cpp
  )

  if(DEFINED PLATFORM_LINUX OR DEFINED PLATFORM_MACOS OR DEFINED PLATFORM_WINDOWS)
    list(APPEND source_files
      sqlite_string.cpp
    )
  endif()

  add_osquery_library(osquery_sql EXCLUDE_FROM_ALL
    ${source_files}
  )

  enableLinkWholeArchive(osquery_sql)

  target_link_libraries(osquery_sql PUBLIC
    global_cxx_settings
    osquery_carver
    osquery_core
    osquery_core_plugins
    osquery_hashing
    osquery_process
    osquery_utils
    osquery_utils_system_errno
    thirdparty_boost
    thirdparty_googletest_headers
    thirdparty_sqlite
    thirdparty_gflags
    thirdparty_ssdeep-cpp
  )

  set(public_header_files
    dynamic_table_row.h
    sqlite_util.h
    virtual_table.h
  )

  generateIncludeNamespace(osquery_sql "osquery/sql" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_sql_tests-test COMMAND osquery_sql_tests-test)
  add_test(NAME osquery_sql_tests_virtualtabletests-test COMMAND osquery_sql_tests_virtualtabletests-test)
  add_test(NAME osquery_sql_tests_sqliteutilstests-test COMMAND osquery_sql_tests_sqliteutilstests-test)
endfunction()

osquery_sql_main()
