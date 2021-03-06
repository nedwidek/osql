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

function(osqueryHashingMain)
  generateOsqueryHashing()
endfunction()

function(generateOsqueryHashing)
  add_osquery_library(osquery_hashing EXCLUDE_FROM_ALL
    hashing.cpp
  )

  target_link_libraries(osquery_hashing PUBLIC
    global_cxx_settings
    osquery_filesystem
    osquery_utils
    osquery_utils_info
    thirdparty_openssl
  )

  set(public_header_files
    hashing.h
  )

  generateIncludeNamespace(osquery_hashing "osquery/hashing" "FILE_ONLY" ${public_header_files})
endfunction()

osqueryHashingMain()
