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

function(osquery_config_main)
  if (BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryConfig()
endfunction()

function(generateOsqueryConfig)
  add_osquery_library(osquery_config EXCLUDE_FROM_ALL
    config.cpp
    packs.cpp
    update.cpp
  )

  enableLinkWholeArchive(osquery_config)

  target_link_libraries(osquery_config PUBLIC
    global_cxx_settings
    osquery_headers
    osquery_filesystem
    osquery_hashing
    osquery_utils
    osquery_utils_system_time
  )

  set(public_header_files
    config.h
  )

  generateIncludeNamespace(osquery_config "osquery/config" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_config_tests_test COMMAND osquery_config_tests)

  add_test(NAME osquery_config_tests_packs_test COMMAND osquery_config_tests_packs)

  set_tests_properties(
    osquery_config_tests_test
    osquery_config_tests_packs_test
    PROPERTIES ENVIRONMENT "TEST_CONF_FILES_DIR=${TEST_CONFIGS_DIR}"
  )

endfunction()

osquery_config_main()
