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

function(osqueryTablesNetworkingTestsMain)
  generateOsqueryTablesNetworkingTestsNetworkingtablestestsTest()

  if(DEFINED PLATFORM_MACOS)
    generateOsqueryTablesNetworkingTestsWifitestsTest()
  elseif(DEFINED PLATFORM_LINUX)
    generateOsqueryTablesNetworkingTestsIptablestestsTest()
  endif()
endfunction()

function(generateOsqueryTablesNetworkingTestsNetworkingtablestestsTest)
  add_osquery_executable(osquery_tables_networking_tests_networkingtablestests-test networking_tables_tests.cpp)

  target_link_libraries(osquery_tables_networking_tests_networkingtablestests-test PRIVATE
    global_cxx_settings
    osquery_tables_networking
    osquery_core
    osquery_filesystem
    osquery_remote_httpclient
    osquery_utils
    osquery_utils_conversions
    osquery_tables_system_systemtable
    osquery_config_tests_testutils
    osquery_remote_tests_remotetestsutils
    osquery_database
    osquery_database_plugins_ephemeral
    thirdparty_boost
    thirdparty_googletest
    osquery_tools_tests_testfiles
  )
endfunction()

function(generateOsqueryTablesNetworkingTestsWifitestsTest)
  add_osquery_executable(osquery_tables_networking_tests_wifitests-test darwin/wifi_tests.mm)

  target_link_libraries(osquery_tables_networking_tests_wifitests-test PRIVATE
    global_cxx_settings
    osquery_tables_networking
    osquery_core
    osquery_filesystem
    osquery_remote_httpclient
    osquery_utils
    osquery_utils_conversions
    osquery_tables_system_systemtable
    osquery_config_tests_testutils
    osquery_remote_tests_remotetestsutils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    thirdparty_boost
    thirdparty_googletest
    osquery_tools_tests_plistfiles
  )
endfunction()

function(generateOsqueryTablesNetworkingTestsIptablestestsTest)
  add_osquery_executable(osquery_tables_networking_tests_iptablestests-test linux/iptables_tests.cpp)

  target_link_libraries(osquery_tables_networking_tests_iptablestests-test PRIVATE
    global_cxx_settings
    osquery_tables_networking
    osquery_core
    osquery_filesystem
    osquery_remote_httpclient
    osquery_utils
    osquery_utils_conversions
    osquery_tables_system_systemtable
    osquery_config_tests_testutils
    osquery_remote_tests_remotetestsutils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    thirdparty_boost
    thirdparty_googletest
  )
endfunction()

osqueryTablesNetworkingTestsMain()