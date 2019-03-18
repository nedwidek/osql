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

function(osqueryDistributedTests)
  generateOsqueryDistributedTestsTest()
endfunction()

function(generateOsqueryDistributedTestsTest)
  add_osquery_executable(osquery_distributed_tests-test distributed_tests.cpp)

  target_link_libraries(osquery_distributed_tests-test PRIVATE
    global_cxx_settings
    osquery_core_plugins
    osquery_utils_conversions
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_extensions
    osquery_logger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_info
    osquery_utils_system_time
    osquery_remote_tests_remotetestsutils
    plugins_config_tlsconfig
    specs_tables
    thirdparty_googletest
  )
endfunction()

osqueryDistributedTests()