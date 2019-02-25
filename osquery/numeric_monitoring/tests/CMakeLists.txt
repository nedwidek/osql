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

function(osqueryNumericmonitoringTestsMain)
  osqueryNumericmonitoringTests()
  osqueryNumericmonitoringTestsPreaggregationcache()
endfunction()

function(osqueryNumericmonitoringTests)
  add_osquery_executable(osquery_numericmonitoring_tests numeric_monitoring.cpp)

  target_link_libraries(osquery_numericmonitoring_tests PRIVATE
    global_cxx_settings
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_events
    osquery_extensions
    osquery_numericmonitoring
    osquery_registry
    osquery_remote_enroll_tlsenroll
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(osqueryNumericmonitoringTestsPreaggregationcache)
  add_osquery_executable(osquery_numericmonitoring_tests_preaggregationcache pre_aggregation_cache.cpp)

  target_link_libraries(osquery_numericmonitoring_tests_preaggregationcache PRIVATE
    global_cxx_settings
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_dispatcher
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_numericmonitoring
    osquery_registry
    osquery_remote_enroll_tlsenroll
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

osqueryNumericmonitoringTestsMain()