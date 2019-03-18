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

function(osqueryDatabaseMain)
  add_subdirectory("plugins")

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryDatabase()
endfunction()

function(generateOsqueryDatabase)
  add_osquery_library(osquery_database EXCLUDE_FROM_ALL
    database.cpp
  )

  target_link_libraries(osquery_database PUBLIC
    global_cxx_settings
    osquery_core
    osquery_utils
    osquery_utils_conversions
    thirdparty_boost
  )

  add_test(NAME osquery_database_tests-test COMMAND osquery_database_tests-test)
  add_test(NAME osquery_database_tests_results-test COMMAND osquery_database_tests_results-test)
endfunction()

osqueryDatabaseMain()
