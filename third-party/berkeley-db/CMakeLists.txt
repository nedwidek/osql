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

function(berkeleydbMain)
  if(NOT DEFINED PLATFORM_LINUX)
    return()
  endif()

  set(name "berkeley-db")
  set(version "5.3.28")
  set(hash "793ab1515833c680ef3054f6a16781fa766699395ffbb6810635d36f2e8f6cb0")
  set(anchor_file "lib/libdb.a")

  set(additional_libraries
    lib/libdb-5.3.a
    lib/libdb_cxx-5.3.a
    lib/libdb_cxx.a
  )

  importThirdPartyBinaryLibrary("${name}" "${version}" "${hash}" "${anchor_file}" ${additional_libraries})

endfunction()

berkeleydbMain()
