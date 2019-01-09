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

function(rocksdbMain)
  set(name "rocksdb")
  set(version "5.7.2")

  set(anchor_file "lib/librocksdb_lite.a")

  if(DEFINED PLATFORM_LINUX)
    set(hash "12c8abadd96ae8ac38327e8b30c195c18f30001025f400efcac82053057d9834")
  elseif(DEFINED PLATFORM_MACOS)
    set(hash "95b161e7d3def2d4f9241c57061ea1cab4f64e51f0015db490ef99eff890354d")
  elseif(DEFINED PLATFORM_WINDOWS)
    set(hash "2c6d47cbc32063e420965c4949832d1c5f253da282949f81d9de4d1faeb00fa8")
    set(anchor_file "lib/rocksdb.lib")
  else()
    return()
  endif()

  importThirdPartyBinaryLibrary("${name}" "${version}" "${hash}" "${anchor_file}")

  target_link_libraries("thirdparty_${name}" INTERFACE thirdparty_bzip2)

endfunction()

rocksdbMain()
