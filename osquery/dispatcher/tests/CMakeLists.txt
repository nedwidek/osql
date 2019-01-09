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

function(osqueryDispatcherTestsMain)
  generateOsqueryDispatcherTests()
  generateOsqueryDispatcherTestsScheduler()
endfunction()

function(generateOsqueryDispatcherTests)
  add_osquery_executable(osquery_dispatcher_tests dispatcher.cpp)

  target_link_libraries(osquery_dispatcher_tests PRIVATE
    global_cxx_settings
    osquery_config_plugins_tlsconfig
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryDispatcherTestsScheduler)
  add_osquery_executable(osquery_dispatcher_tests_scheduler scheduler.cpp)

    target_link_libraries(osquery_dispatcher_tests_scheduler PRIVATE
    global_cxx_settings
    osquery_config_plugins_tlsconfig
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    specs_tables
    osquery_utils_system_time
    thirdparty_googletest
  )
endfunction()

osqueryDispatcherTestsMain()