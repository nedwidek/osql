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

function(boostMain)
  set(name "boost")
  set(version "1.66.0")

  set(anchor_file "lib/libboost_system-mt.a")

  set(additional_libraries
    lib/libboost_chrono-mt.a
    lib/libboost_context-mt.a
    lib/libboost_coroutine-mt.a
    lib/libboost_filesystem-mt.a
    lib/libboost_regex-mt.a
    lib/libboost_thread-mt.a
  )

  if(DEFINED PLATFORM_LINUX)
    set(hash "3a24d65730beb3a718ee443eaedac40033d349582eeb83664ea2529080c812ba")
  elseif(DEFINED PLATFORM_MACOS)
    set(hash "69c884d27838a11f9a45b78e03eb12a425d554dac4ad8c6ef19f91e63e945286")
  elseif(DEFINED PLATFORM_WINDOWS)
    set(hash "5530174b75b67c3c8e59f2ae62c3e18fea1b5e55c795ff19b40fb75cf93dfb51")
    set(anchor_file "lib/libboost_system-mt-s.lib")

    set(additional_libraries
      lib/libboost_chrono-mt-s.lib
      lib/libboost_context-mt-s.lib
      lib/libboost_coroutine-mt-s.lib
      lib/libboost_filesystem-mt-s.lib
      lib/libboost_regex-mt-s.lib
      lib/libboost_thread-mt-s.lib
    )
  else()
    message(SEND_ERROR "Unsupported platform")
  endif()

  importThirdPartyBinaryLibrary("${name}" "${version}" "${hash}" "${anchor_file}" ${additional_libraries})
endfunction()

boostMain()
