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

function(pluginsConfigParsersTestsMain)
  generatePluginsConfigParsersTestsDecoratorstestsTest()
  generatePluginsConfigParsersTestsEventsparsertestsTest()
  generatePluginsConfigParsersTestsFilepathstestsTest()
  generatePluginsConfigParsersTestsOptionstestsTest()
  generatePluginsConfigParsersTestsViewstestsTest()
endfunction()

function(generatePluginsConfigParsersTestsDecoratorstestsTest)
  add_osquery_executable(plugins_config_parsers_tests_decoratorstests-test decorators_tests.cpp)

  target_link_libraries(plugins_config_parsers_tests_decoratorstests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_filesystem
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    plugins_config_tlsconfig
    plugins_config_parsers
    plugins_database_ephemeral
    specs_tables
    osquery_tools_tests_conffiles
    thirdparty_googletest
  )
endfunction()

function(generatePluginsConfigParsersTestsEventsparsertestsTest)

  add_osquery_executable(plugins_config_parsers_tests_eventsparsertests-test events_parser_tests.cpp)

  target_link_libraries(plugins_config_parsers_tests_eventsparsertests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_filesystem
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_json
    plugins_config_tlsconfig
    plugins_config_parsers
    plugins_database_ephemeral
    specs_tables
    osquery_tools_tests_conffiles
    thirdparty_googletest
  )

endfunction()

function(generatePluginsConfigParsersTestsFilepathstestsTest)
  add_osquery_executable(plugins_config_parsers_tests_filepathstests-test file_paths_tests.cpp)

  target_link_libraries(plugins_config_parsers_tests_filepathstests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_filesystem
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_json
    plugins_config_tlsconfig
    plugins_config_parsers
    plugins_database_ephemeral
    specs_tables
    osquery_tools_tests_conffiles
    thirdparty_googletest
  )
endfunction()

function(generatePluginsConfigParsersTestsOptionstestsTest)

  add_osquery_executable(plugins_config_parsers_tests_optionstests-test options_tests.cpp)

  target_link_libraries(plugins_config_parsers_tests_optionstests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_filesystem
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_json
    plugins_config_tlsconfig
    plugins_config_parsers
    plugins_database_ephemeral
    specs_tables
    osquery_tools_tests_conffiles
    thirdparty_googletest
  )
endfunction()

function(generatePluginsConfigParsersTestsViewstestsTest)
  add_osquery_executable(plugins_config_parsers_tests_viewstests-test views_tests.cpp)

  target_link_libraries(plugins_config_parsers_tests_viewstests-test PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_core
    osquery_database
    osquery_dispatcher
    osquery_events
    osquery_extensions
    osquery_extensions_implthrift
    osquery_filesystem
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_json
    plugins_config_tlsconfig
    plugins_config_parsers
    plugins_database_ephemeral
    specs_tables
    thirdparty_googletest
  )
endfunction()

pluginsConfigParsersTestsMain()