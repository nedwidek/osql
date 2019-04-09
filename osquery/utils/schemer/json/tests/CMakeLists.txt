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

function(osqueryUtilsSchemerJsonTestsMain)
  generateOsqueryUtilsSchemerJsonTestsSchemerjsontestsTest()
endfunction()

function(generateOsqueryUtilsSchemerJsonTestsSchemerjsontestsTest)
  add_osquery_executable(osquery_utils_schemer_json_tests_schemerjsontests-test schemer_json.cpp)

  target_link_libraries(osquery_utils_schemer_json_tests_schemerjsontests-test PRIVATE
    global_cxx_settings
    osquery_utils_schemer_json
    thirdparty_googletest
  )
endfunction()

osqueryUtilsSchemerJsonTestsMain()