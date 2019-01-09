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

function(thrifMain)
  set(name "thrift")
  set(version "0.11.0")

  set(anchor_file "lib/libthrift.a")

  set(additional_library
    "lib/libthriftz.a"
  )

  if(DEFINED PLATFORM_LINUX)
    set(hash "32d0a6c2220114272fe6819a30b5ddfe000d9bed03f0d1fc3b6b68d438b5cc1e")
  elseif(DEFINED PLATFORM_MACOS)
    set(hash "11a4f8565728e73a54808bf55517014cc69597ef965c3b2b7ebeb52f6dd43c26")
  elseif(DEFINED PLATFORM_WINDOWS)
    set(hash "8b115b46d7fbae38eafbd50c4fabca1dd7e14a86ad52bda601ec374b44dc5373")

    set(anchor_file "lib/parse.lib")

    set(additional_libraries
      lib/thriftzmt.lib
      lib/thriftmt.lib
    )
  else()
    return()
  endif()

  importThirdPartyBinaryLibrary("${name}" "${version}" "${hash}" "${anchor_file}" ${additional_libraries})

  target_link_libraries("thirdparty_${name}" INTERFACE thirdparty_boost)
endfunction()

thrifMain()
