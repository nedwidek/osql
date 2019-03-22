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

function(pluginsNumericmonitoringTestsMain)
  pluginsNumericmonitoringTestsFilesystemtestsTest()
endfunction()

function(pluginsNumericmonitoringTestsFilesystemtestsTest)
  # Originally plugins_numericmonitoring_tests_numericmonitoringfilesystemtests-test, shortened due to MSBuild not supporting long paths
  add_osquery_executable(plugins_numericmonitoring_tests_filesystem-test filesystem.cpp)

  target_link_libraries(plugins_numericmonitoring_tests_filesystem-test PRIVATE
    global_cxx_settings
    osquery_database
    osquery_extensions
    osquery_extensions_implthrift
    osquery_numericmonitoring
    osquery_remote_enroll_tlsenroll
    plugins_config_tlsconfig
    plugins_database_ephemeral
    plugins_numericmonitoring_filesystem
    specs_tables
    thirdparty_googletest
  )
endfunction()

pluginsNumericmonitoringTestsMain()