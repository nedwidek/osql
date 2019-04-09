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

function(osquerySystemNetworkTestsMain)
  generateOsquerySystemNetworkTestsHostnamehostidentitytestsTest()
endfunction()

function(generateOsquerySystemNetworkTestsHostnamehostidentitytestsTest)
  add_osquery_executable(osquery_system_network_tests_hostnamehostidentitytests-test host_identity.cpp)

  target_link_libraries(osquery_system_network_tests_hostnamehostidentitytests-test PRIVATE
    global_cxx_settings
    osquery_system_network_hostname
    thirdparty_boost
    osquery_config_tests_testutils
    osquery_core
    osquery_core_sql
    osquery_dispatcher
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_info
    plugins_config_tlsconfig
    tests_helper
    specs_tables
    thirdparty_googletest
  )
endfunction()

osquerySystemNetworkTestsMain()