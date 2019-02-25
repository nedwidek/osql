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

function(osqueryRemoteTransportsMain)
  generateOsqueryRemoteTransportsTls()

  if(BUILD_TESTING AND DEFINED PLATFORM_POSIX)
    generateOsqueryRemoteTransportsTlsTests()
  endif()
endfunction()

function(generateOsqueryRemoteTransportsTls)
  add_osquery_library(osquery_remote_transports_tls EXCLUDE_FROM_ALL
    tls.cpp
  )

  target_link_libraries(osquery_remote_transports_tls PUBLIC
    global_cxx_settings
    osquery_headers
    osquery_core
    osquery_remote_httpclient
    osquery_remote_requests
    osquery_utils_json
    thirdparty_boost
  )

  set(public_header_files
    tls.h
  )

  generateIncludeNamespace(osquery_remote_transports_tls "osquery/remote/transports" "FILE_ONLY" ${public_header_files})

  if(DEFINED PLATFORM_POSIX)
    add_test(
      NAME osquery_remote_transports_tlstests_test
      COMMAND "${CMAKE_COMMAND}" -E env
              "TEST_CONF_FILES_DIR=$<TARGET_PROPERTY:osquery_tools_tests_testfiles,INTERFACE_BINARY_DIR>"
              "$<TARGET_FILE:osquery_remote_transports_tlstests>"
    )
  endif()
endfunction()


function(generateOsqueryRemoteTransportsTlsTests)

  add_osquery_executable(osquery_remote_transports_tlstests tests/tls_transports_tests.cpp)

  target_link_libraries(osquery_remote_transports_tlstests PRIVATE
    global_cxx_settings
    osquery_config_tests_testutils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_events
    osquery_extensions
    osquery_remote_enroll_tlsenroll
    osquery_remote_tests_utils
    osquery_utils_conversions
    osquery_utils_info
    plugins_config_tlsconfig
    plugins_killswitch_filesystem
    tests_helper
    thirdparty_googletest
    osquery_tools_tests_testfiles
  )
endfunction()

osqueryRemoteTransportsMain()
