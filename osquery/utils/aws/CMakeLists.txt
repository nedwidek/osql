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

function(osqueryUtilsAwsMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryUtilsAws()
endfunction()

function(generateOsqueryUtilsAws)
  add_osquery_library(osquery_utils_aws EXCLUDE_FROM_ALL
    aws_util.cpp
  )

  target_link_libraries(osquery_utils_aws PUBLIC
    global_cxx_settings
    osquery_remote_httpclient
    osquery_remote_transports_tls
    osquery_utils_json
    osquery_utils_status
    thirdparty_aws-sdk-cpp
  )

  set(public_header_files
    aws_util.h
  )

  generateIncludeNamespace(osquery_utils_aws "osquery/utils/aws" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_utils_aws_tests-test COMMAND osquery_utils_aws_tests-test)

  set_tests_properties(
    osquery_utils_aws_tests-test
    PROPERTIES ENVIRONMENT "TEST_CONF_FILES_DIR=${TEST_CONFIGS_DIR}"
  )
endfunction()

osqueryUtilsAwsMain()
