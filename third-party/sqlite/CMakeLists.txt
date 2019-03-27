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

function(sqliteMain)
  set(base_url "${THIRD_PARTY_REPOSITORY_URL}/third-party/src")
  set(archive_name "sqlite-amalgamation-3260000")
  set(archive_type "tar.gz")
  set(hash "a1ecb747d33d9ffae110c3e836f0094f0b172190807cb1d76568bb167b84b641")
  set(identifier "thirdparty_sqlite")
  set(source_code "${archive_name}/sqlite3.c")

  downloadRemoteFile("${identifier}" "${base_url}" "${archive_name}.${archive_type}" "${hash}")

  extractLocalArchive("${identifier}" "${source_code}" "${downloadRemoteFile_destination}" "${CMAKE_CURRENT_BINARY_DIR}")

  add_osquery_library("${identifier}" EXCLUDE_FROM_ALL "${CMAKE_CURRENT_BINARY_DIR}/${source_code}")
  add_dependencies("${identifier}" "${identifier}_extractor")

  # So that's possible to download and extract dependencies before building, to have the IDE working correctly
  add_dependencies("prepare_for_ide" "${identifier}_extractor")

  # This is a trick we use to have the locally specified flags to appear after the global ones,
  # using the order in which the interface target are linked
  add_osquery_library("${identifier}_local_flags" INTERFACE)

  target_compile_definitions("${identifier}_local_flags" INTERFACE
    -DSQLITE_ENABLE_COLUMN_METADATA=1
    -DSQLITE_MAX_VARIABLE_NUMBER=250000
    -DSQLITE_ENABLE_RTREE=1
    -DSQLITE_ENABLE_FTS3=1
    -DSQLITE_ENABLE_FTS3_PARENTHESIS=1
    -DSQLITE_ENABLE_FTS5=1
    -DSQLITE_SECURE_DELETE=1
    -DSQLITE_ENABLE_UNLOCK_NOTIFY=1
    -DSQLITE_ENABLE_DBSTAT_VTAB=1
    -DSQLITE_ENABLE_JSON1=1
    -DSQLITE_ENABLE_PREUPDATE_HOOK=1
    -DSQLITE_ENABLE_SESSION=1
    -DSQLITE_SOUNDEX
    -DSQLITE_VERSION="3.26.0"
  )

  target_include_directories("${identifier}" INTERFACE "${CMAKE_CURRENT_BINARY_DIR}/${archive_name}/include")

  if (DEFINED PLATFORM_WINDOWS)
    target_compile_options("${identifier}_local_flags" INTERFACE /EHsc)
  elseif(DEFINED PLATFORM_POSIX)
    target_link_libraries("${identifier}" PUBLIC dl)
    target_compile_options("${identifier}_local_flags" INTERFACE
      -Wno-array-bounds
      -Wno-error
      -Wno-missing-braces
      -Wno-overlength-strings
      -Wno-parentheses-equality
      -Wno-unused-value
    )
  endif()

  target_link_libraries("${identifier}" PRIVATE global_c_settings)
  target_link_libraries("${identifier}" PRIVATE "${identifier}_local_flags")

endfunction()

sqliteMain()
