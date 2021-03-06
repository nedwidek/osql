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

function(osqueryUtilsCachesMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryUtilsCachesLru()
endfunction()

function(generateOsqueryUtilsCachesLru)
  add_library(osquery_utils_caches_lru INTERFACE)

  set(public_header_files
    lru.h
    lru-impl.h
  )

  generateIncludeNamespace(osquery_utils_caches_lru "osquery/utils/caches" "FILE_ONLY" ${public_header_files})

  add_test(NAME osquery_utils_caches_tests_lrutests-test COMMAND osquery_utils_caches_tests_lrutests-test)
endfunction()

osqueryUtilsCachesMain()