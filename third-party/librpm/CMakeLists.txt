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

function(librpmMain)
  if(NOT DEFINED PLATFORM_LINUX)
    return()
  endif()

  set(name "librpm")
  set(version "4.14.1")
  set(hash "5aca71879ab793c1029684dfa59baec462584ba3f4e3f6444c374b160b5afde8")
  set(anchor_file "lib/librpm.a")

  set(additional_libraries
    lib/librpmbuild.a
    lib/librpmio.a
    lib/librpmsign.a
  )

  importThirdPartyBinaryLibrary("${name}" "${version}" "${hash}" "${anchor_file}" ${additional_libraries})

  target_link_libraries("thirdparty_${name}" INTERFACE
    thirdparty_berkeley-db
    thirdparty_bzip2
    thirdparty_lzma
    thirdparty_openssl
    thirdparty_popt
    thirdparty_zlib
  )

  target_link_libraries("thirdparty_${name}_librpm" INTERFACE
    "thirdparty_${name}_librpmio"
  )

  target_link_libraries("thirdparty_${name}_librpmio" INTERFACE thirdparty_zlib)
endfunction()

librpmMain()
