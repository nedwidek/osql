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

function(osqueryRemoteSerializersMain)

  if(BUILD_TESTING)
    generateOsqueryRemoteserializersjsontestsTest()
  endif()

  generateOsqueryRemoteSerializersSerializerjson()
endfunction()

function(generateOsqueryRemoteSerializersSerializerjson)
  add_osquery_library(osquery_remote_serializers_serializerjson EXCLUDE_FROM_ALL
    json.cpp
  )

  target_link_libraries(osquery_remote_serializers_serializerjson PUBLIC
    global_cxx_settings
    osquery_remote_requests
    osquery_utils_json
    thirdparty_boost
  )

  set(public_header_files
    json.h
  )

  generateIncludeNamespace(osquery_remote_serializers_serializerjson "osquery/remote/serializers" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_remote_serializers_remotejsonserializerstests-test COMMAND osquery_remote_serializers_remotejsonserializerstests-test)
endfunction()

function(generateOsqueryRemoteserializersjsontestsTest)
  add_osquery_executable(osquery_remote_serializers_remotejsonserializerstests-test tests/json_serializers_tests.cpp)

  target_link_libraries(osquery_remote_serializers_remotejsonserializerstests-test PRIVATE
    global_cxx_settings
    osquery_remote_serializers_serializerjson
    thirdparty_googletest
  )
endfunction()

osqueryRemoteSerializersMain()
