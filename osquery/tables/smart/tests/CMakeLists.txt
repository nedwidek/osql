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
    generateOsqueryTablesSmartTestsSmartDrives()
  endif()
endfunction()

function(generateOsqueryTablesSmartTestsSmartDrives)
  add_osquery_executable(osquery_tables_smart_tests_smartdrives smart_drives_tests.cpp)

  target_link_libraries(osquery_tables_smart_tests_smartdrives PRIVATE
    global_cxx_settings
    osquery_core
    osquery_tables_events
    osquery_config_parsers
    osquery_config
    osquery_logger
    osquery_registry
    osquery_headers
    specs_tables
    osquery_config_tests_testutils
    osquery_config_plugins_tlsconfig
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_extensions
    osquery_remote_enroll_tlsenroll
    thirdparty_googletest
    thirdparty_smartmontools
  )
endfunction()

osqueryTablesSmartTestsMain()