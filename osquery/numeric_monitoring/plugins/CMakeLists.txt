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

function(osqueryNumericmonitoringPluginsMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryNumericmonitoringPluginsNumericmonitoringfilesystem()
endfunction()

function(generateOsqueryNumericmonitoringPluginsNumericmonitoringfilesystem)
  add_osquery_library(osquery_numericmonitoring_plugins_numericmonitoringfilesystem EXCLUDE_FROM_ALL
    filesystem.cpp
  )

  target_link_libraries(osquery_numericmonitoring_plugins_numericmonitoringfilesystem PUBLIC
    global_cxx_settings
    osquery_filesystem
    osquery_numericmonitoring
  )

  set(public_header_files
    filesystem.h
  )

  generateIncludeNamespace(osquery_numericmonitoring_plugins_numericmonitoringfilesystem "osquery/numeric_monitoring/plugins" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_numericmonitoring_plugins_tests_numericmonitoringfilesystemtests-test COMMAND osquery_numericmonitoring_plugins_tests_numericmonitoringfilesystemtests-test)
endfunction()

osqueryNumericmonitoringPluginsMain()
