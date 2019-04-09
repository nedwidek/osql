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

function(osquerySystemNetworkMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsquerySystemNetworkHostname()
endfunction()

function(generateOsquerySystemNetworkHostname)
  add_osquery_library(osquery_system_network_hostname EXCLUDE_FROM_ALL hostname.cpp)

  target_link_libraries(osquery_system_network_hostname PUBLIC
    global_cxx_settings
    osquery_core
    osquery_utils_schemer
    osquery_utils_status
  )

  set(public_header_files
    hostname.h
  )

  generateIncludeNamespace(osquery_system_network_hostname "osquery/system/network" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_system_network_tests_hostnamehostidentitytests-test COMMAND osquery_system_network_tests_hostnamehostidentitytests-test)
endfunction()

osquerySystemNetworkMain()