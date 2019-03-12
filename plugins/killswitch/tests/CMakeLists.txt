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

function(pluginsKillswitchTestsMain)
  generatePluginsKillswitchKillswitchfilesystemplugintestsTest()
endfunction()

function(generatePluginsKillswitchKillswitchfilesystemplugintestsTest)
  add_osquery_executable(plugins_killswitch_killswitchfilesystemplugintests-test killswitch_filesystem_tests.cpp)

  target_link_libraries(plugins_killswitch_killswitchfilesystemplugintests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_events
    osquery_extensions
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_info
    plugins_config_tlsconfig
    plugins_killswitch_filesystem
    tests_helper
    osquery_tools_tests_conffiles
    thirdparty_googletest
  )
endfunction()

pluginsKillswitchTestsMain()