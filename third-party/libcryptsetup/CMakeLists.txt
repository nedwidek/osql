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

function(libcryptsetupMain)
	if(NOT DEFINED PLATFORM_LINUX)
		return()
	endif()

  set(name "libcryptsetup")
  set(version "1.7.5")
  set(hash "ebb53650592212d67ea8c0e49b48891eec64ef370743678881985490c09adeac")
  set(anchor_file "lib/libcryptsetup.a")

  importThirdPartyBinaryLibrary("${name}" "${version}" "${hash}" "${anchor_file}")

  target_link_libraries("thirdparty_${name}" INTERFACE thirdparty_libgcrypt)

endfunction()

libcryptsetupMain()
