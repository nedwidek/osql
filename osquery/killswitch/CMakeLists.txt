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

function(osqueryKillswitchMain)
  add_subdirectory("plugins")
  generateOsqueryKillswitch()

  if(BUILD_TESTING)
    generateOsqueryKillswitchTests()
  endif()
endfunction()

function(generateOsqueryKillswitch)
  add_osquery_library(osquery_killswitch EXCLUDE_FROM_ALL
    killswitch.cpp
    killswitch_plugin.cpp
    killswitch_refreshable_plugin.cpp
  )

  enableLinkWholeArchive(osquery_killswitch)

  target_link_libraries(osquery_killswitch PUBLIC
    global_cxx_settings
    osquery_core
    thirdparty_googletest_headers
  )

  set(public_header_files
    killswitch_plugin.h
    killswitch_refreshable_plugin.h
  )

  generateIncludeNamespace(osquery_killswitch "osquery/killswitch" "FILE_ONLY" ${public_header_files})

  add_test(
    NAME osquery_killswitch_tests_test
    COMMAND "${CMAKE_COMMAND}" -E env
            "TEST_CONF_FILES_DIR=$<TARGET_PROPERTY:osquery_tools_tests_conffiles,INTERFACE_BINARY_DIR>"
            "$<TARGET_FILE:osquery_killswitch_tests>"
  )
endfunction()

function(generateOsqueryKillswitchTests)
  add_osquery_executable(osquery_killswitch_tests tests/killswitch_tests.cpp)

  target_link_libraries(osquery_killswitch_tests PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_config_plugins_tlsconfig
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_events
    osquery_extensions
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_info
    osquery_killswitch_plugins_filesystem
    tests_helper
    osquery_tools_tests_conffiles
    thirdparty_googletest
  )
endfunction()

osqueryKillswitchMain()
