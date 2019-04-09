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

function(osqueryUtilsSchemerJsonMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryUtilsSchemerJson()
endfunction()

function(generateOsqueryUtilsSchemerJson)
  add_library(osquery_utils_schemer_json INTERFACE)

  target_link_libraries(osquery_utils_schemer_json INTERFACE
    global_cxx_settings
    osquery_utils_expected
    osquery_utils_json
    osquery_utils_schemer
    thirdparty_rapidjson
  )

  set(public_header_files
    schemer_json.h
    schemer_json_error.h
    schemer_json_impl.h
  )

  generateIncludeNamespace(osquery_utils_schemer_json "osquery/utils/schemer/json" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_utils_schemer_json_tests_schemerjsontests-test COMMAND osquery_utils_schemer_json_tests_schemerjsontests-test)
endfunction()

osqueryUtilsSchemerJsonMain()