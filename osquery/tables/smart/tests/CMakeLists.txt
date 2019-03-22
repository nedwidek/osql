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

function(osqueryTablesSmartTestsMain)
  if(DEFINED PLATFORM_POSIX)
    generateOsqueryTablesSmartTestsSmartdrivestestsTest()
  endif()
endfunction()

function(generateOsqueryTablesSmartTestsSmartdrivestestsTest)
  add_osquery_executable(osquery_tables_smart_tests_smartdrivestests-test smart_drives_tests.cpp)

  target_link_libraries(osquery_tables_smart_tests_smartdrivestests-test PRIVATE
    global_cxx_settings
    osquery_headers
    osquery_core
    osquery_config
    osquery_config_tests_testutils
    osquery_database
    osquery_extensions
    osquery_extensions_implthrift
    osquery_logger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_tables_events_eventstable
    plugins_config_tlsconfig
    plugins_config_parsers
    plugins_database_ephemeral
    specs_tables
    thirdparty_smartmontools
    thirdparty_googletest
  )
endfunction()

osqueryTablesSmartTestsMain()