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

function(osqueryTablesApplicationsMain)

  if(BUILD_TESTING)
    add_subdirectory("posix/tests")
  endif()

  generateOsqueryTablesApplications()
endfunction()

function(generateOsqueryTablesApplications)
  set(source_files
    browser_chrome.cpp
    browser_utils.cpp
  )

  if(DEFINED PLATFORM_POSIX)
    list(APPEND source_files
      posix/browser_firefox.cpp
      posix/browser_opera.cpp
      posix/carbon_black.cpp
      posix/docker.cpp
      posix/prometheus_metrics.cpp
    )
  endif()

  if(DEFINED PLATFORM_MACOS)
    list(APPEND source_files
      atom_packages.cpp
      darwin/browser_plugins.cpp
    )
  elseif(DEFINED PLATFORM_WINDOWS)
    list(APPEND source_files
      windows/carbon_black.cpp
    )
  elseif(DEFINED PLATFORM_LINUX)
    list(APPEND source_files
      atom_packages.cpp
    )
  endif()

  add_osquery_library(osquery_tables_applications EXCLUDE_FROM_ALL
    ${source_files}
  )

  target_link_libraries(osquery_tables_applications PUBLIC
    global_cxx_settings
    osquery_config
    osquery_filesystem
    osquery_tables_system_systemtable
    osquery_utils_conversions
    osquery_utils_info
    osquery_utils_json
    plugins_config_parsers
    thirdparty_boost
  )

  set(public_header_files
    browser_utils.h
  )

  if(DEFINED PLATFORM_POSIX)
    list(APPEND public_header_files
      posix/prometheus_metrics.h
    )
  endif()

  generateIncludeNamespace(osquery_tables_applications "osquery/tables/applications" "FULL_PATH" ${public_header_files})

  if(DEFINED PLATFORM_POSIX)
    add_test(NAME osquery_tables_applications_posix_tests_prometheusmetricstests-test COMMAND osquery_tables_applications_posix_tests_prometheusmetricstests-test)
  endif()
endfunction()

osqueryTablesApplicationsMain()
