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

function(osqueryConfigParsersTestsMain)
  generateOsqueryConfigParsersTestsDecoratorsTests()
  generateOsqueryConfigParsersTestsEventsParserTests()
  generateOsqueryConfigParsersTestsFilePathsTests()
  generateOsqueryConfigParsersTestsOptionsTests()
  generateOsqueryConfigParsersTestsViewsTests()
endfunction()

function(generateOsqueryConfigParsersTestsDecoratorsTests)
  add_osquery_executable(osquery_config_parsers_tests_decoratorstests decorators_tests.cpp)

  target_link_libraries(osquery_config_parsers_tests_decoratorstests PRIVATE
    global_cxx_settings
    osquery_tools_tests_conffiles
    osquery_config_parsers
    osquery_config_tests_testutils
    osquery_config_plugins_tlsconfig
    osquery_database_plugins_ephemeral
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryConfigParsersTestsEventsParserTests)

  add_osquery_executable(osquery_config_parsers_tests_eventsparsertests events_parser_tests.cpp)

  target_link_libraries(osquery_config_parsers_tests_eventsparsertests PRIVATE
    global_cxx_settings
    osquery_tools_tests_conffiles
    osquery_filesystem
    osquery_config_tests_testutils
    osquery_config_plugins_tlsconfig
    osquery_database_plugins_ephemeral
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    specs_tables
    thirdparty_googletest
  )

endfunction()

function(generateOsqueryConfigParsersTestsFilePathsTests)
  add_osquery_executable(osquery_config_parsers_tests_filepathstests file_paths_tests.cpp)

  target_link_libraries(osquery_config_parsers_tests_filepathstests PRIVATE
    global_cxx_settings
    osquery_tools_tests_conffiles
    osquery_utils_conversions
    osquery_filesystem
    osquery_config_tests_testutils
    osquery_config_plugins_tlsconfig
    osquery_database_plugins_ephemeral
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryConfigParsersTestsOptionsTests)

  add_osquery_executable(osquery_config_parsers_tests_optionstests options_tests.cpp)

  target_link_libraries(osquery_config_parsers_tests_optionstests PRIVATE
    global_cxx_settings
    osquery_tools_tests_conffiles
    osquery_utils_conversions
    osquery_filesystem
    osquery_config_tests_testutils
    osquery_config_plugins_tlsconfig
    osquery_database_plugins_ephemeral
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryConfigParsersTestsViewsTests)
  add_osquery_executable(osquery_config_parsers_tests_viewstests views_tests.cpp)

  target_link_libraries(osquery_config_parsers_tests_viewstests PRIVATE
    global_cxx_settings
    osquery_config_parsers
    osquery_filesystem
    osquery_config_tests_testutils
    osquery_config_plugins_tlsconfig
    osquery_database_plugins_ephemeral
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    specs_tables
    thirdparty_googletest
  )
endfunction()

osqueryConfigParsersTestsMain()