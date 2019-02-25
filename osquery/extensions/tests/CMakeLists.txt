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

function(osqueryExtensionsTestsMain)
  generateOsqueryExtensionsTests()
endfunction()

function(generateOsqueryExtensionsTests)
  add_osquery_executable(osquery_extensions_tests extensions.cpp)

  target_link_libraries(osquery_extensions_tests PRIVATE
    global_cxx_settings
    osquery_config
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_process
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_remote_utility
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

osqueryExtensionsTestsMain()