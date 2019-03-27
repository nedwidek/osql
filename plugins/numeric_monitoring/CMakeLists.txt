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
  # Originally plugins_numericmonitoring_numericmonitoringfilesystem, shortened due to MSBuild not supporting long paths
  add_osquery_library(plugins_numericmonitoring_filesystem EXCLUDE_FROM_ALL
    filesystem.cpp
  )

  enableLinkWholeArchive(plugins_numericmonitoring_filesystem)

  target_link_libraries(plugins_numericmonitoring_filesystem PUBLIC
    global_cxx_settings
    osquery_filesystem
    osquery_numericmonitoring
  )

  set(public_header_files
    filesystem.h
  )

  generateIncludeNamespace(plugins_numericmonitoring_filesystem "plugins/numeric_monitoring" "FILE_ONLY" ${public_header_files})

  add_test(NAME plugins_numericmonitoring_tests_filesystem-test COMMAND plugins_numericmonitoring_tests_filesystem-test)
endfunction()

osqueryNumericmonitoringPluginsMain()
