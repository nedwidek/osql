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

function(archiveMain)
  set(name "libarchive")
  set(version "3.3.2")

  set(anchor_file "lib/libarchive.a")

  if(DEFINED PLATFORM_LINUX)
    set(hash "6818c2d6c8067918365cb81992f7853b100ef3244b8767bf2d182a1974f225a3")
  elseif(DEFINED PLATFORM_MACOS)
    set(hash "a3ec7af1618116fca2008838ef18d2028148b34e215c748da3f25e4053bfe6e8")
  elseif(DEFINED PLATFORM_WINDOWS)
    set(hash "cb1fc7e7ed1c652d7c322f629145749a60586eb8ec033a76025a04f4a42117a5")
    set(anchor_file "lib/archive_static.lib")
  else()
    return()
  endif()

  importThirdPartyBinaryLibrary("${name}" "${version}" "${hash}" "${anchor_file}")

endfunction()

archiveMain()
