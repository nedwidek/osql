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

function(testsMain)
  generateTestsHelper()
endfunction()

function(generateTestsHelper)
  add_osquery_library(tests_helper test_util.cpp)

  set(public_header_files
    test_util.h
  )

  generateIncludeNamespace(tests_helper "osquery/tests" "FILE_ONLY" ${public_header_files})

  target_link_libraries(tests_helper PUBLIC
    global_cxx_settings
    osquery_database_plugins_ephemeral
    osquery_sql
    osquery_utils
    thirdparty_boost
    thirdparty_googletest_headers
    osquery_core
    osquery_filesystem
    osquery_remote_serializers_json
    osquery_utils_system_time
    specs_tables
    osquery_utils_conversions
    osquery_process
  )
endfunction()

testsMain()