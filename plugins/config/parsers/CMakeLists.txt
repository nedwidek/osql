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

function(pluginsConfigParsersMain)
  if (BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generatePluginsConfigParsers()
endfunction()

function(generatePluginsConfigParsers)
  add_osquery_library(plugins_config_parsers EXCLUDE_FROM_ALL
    auto_constructed_tables.cpp
    decorators.cpp
    events_parser.cpp
    feature_vectors.cpp
    file_paths.cpp
    kafka_topics.cpp
    logger.cpp
    options.cpp
    prometheus_targets.cpp
    views.cpp
  )

  enableLinkWholeArchive(plugins_config_parsers)

  target_link_libraries(plugins_config_parsers PUBLIC
    global_cxx_settings
    osquery_headers
    osquery_config
    osquery_core
    osquery_database
    osquery_filesystem
    osquery_logger_datalogger
    osquery_registry
    osquery_sql
    osquery_utils
    osquery_utils_json
  )

  set(public_header_files
    auto_constructed_tables.h
    decorators.h
    feature_vectors.h
    kafka_topics.h
    logger.h
    prometheus_targets.h
  )

  generateIncludeNamespace(plugins_config_parsers "plugins/config/parsers" "FILE_ONLY" ${public_header_files})

  add_test(
    NAME plugins_config_parsers_tests_decoratorstests_test
    COMMAND "${CMAKE_COMMAND}" -E env
            "TEST_CONF_FILES_DIR=${TEST_CONFIGS_DIR}"
            "$<TARGET_FILE:plugins_config_parsers_tests_decoratorstests>"
  )

  add_test(
    NAME plugins_carver_tests_eventsparsertests_test
    COMMAND "${CMAKE_COMMAND}" -E env
            "TEST_CONF_FILES_DIR=${TEST_CONFIGS_DIR}"
            "$<TARGET_FILE:plugins_config_parsers_tests_eventsparsertests>"
  )

  add_test(
    NAME plugins_carver_tests_filepathstests_test
    COMMAND "${CMAKE_COMMAND}" -E env
            "TEST_CONF_FILES_DIR=${TEST_CONFIGS_DIR}"
            "$<TARGET_FILE:plugins_config_parsers_tests_filepathstests>"
  )

  add_test(
    NAME plugins_carver_tests_optionstests_test
    COMMAND "${CMAKE_COMMAND}" -E env
            "TEST_CONF_FILES_DIR=${TEST_CONFIGS_DIR}"
            "$<TARGET_FILE:plugins_config_parsers_tests_optionstests>"
  )

  add_test(
    NAME plugins_carver_tests_viewstests_test
    COMMAND "${CMAKE_COMMAND}" -E env
            "TEST_CONF_FILES_DIR=${TEST_CONFIGS_DIR}"
            "$<TARGET_FILE:plugins_config_parsers_tests_viewstests>"
  )
endfunction()

pluginsConfigParsersMain()
