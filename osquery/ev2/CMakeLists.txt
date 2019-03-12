# Copyright (c) 2018-present, Trail of Bits, Inc.
#
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required(VERSION 3.13.3)

function(osqueryEV2Main)
  generateOsqueryEV2()

  if(BUILD_TESTING)
    generateOsqueryEV2testsTest()
  endif()
endfunction()

function(generateOsqueryEV2)
  set(source_files
    manager.cpp
    publisher.cpp
    subscription.cpp
  )

  add_osquery_library(osquery_ev2 EXCLUDE_FROM_ALL ${source_files})

  target_link_libraries(osquery_ev2 PUBLIC
    global_cxx_settings
    osquery_expected
  )

  set(public_header_files
    buffered_subscription.h
    manager.h
    publisher.h
    simple_publisher.h
    subscription.h
  )

  generateIncludeNamespace(osquery_ev2 "osquery/ev2" "FILE_ONLY" ${public_header_files})
endfunction()

function(generateOsqueryEV2testsTest)
  set(source_files
    tests/buffered_subscription.cpp
    tests/manager.cpp
    tests/simple_publisher.cpp
    tests/utils.cpp
  )

  add_osquery_executable(osquery_ev2_ev2tests-test ${source_files})

  target_link_libraries(osquery_ev2_ev2tests-test PRIVATE
    global_cxx_settings
    osquery_ev2
  )

  set(public_header_files
    tests/utils.h
  )

  generateIncludeNamespace(osquery_ev2_ev2tests-test "osquery/ev2" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_ev2_ev2tests-test COMMAND osquery_ev2_ev2tests-test)
endfunction()

osqueryEV2Main()