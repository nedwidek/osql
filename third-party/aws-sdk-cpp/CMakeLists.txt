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

function(awsSdkCppMain)
  set(name "aws-sdk-cpp")
  set(version "1.4.55")

  set(anchor_file "lib/libtesting-resources.a")

  set(additional_libraries
    lib/libaws-cpp-sdk-ec2.a
    lib/libaws-cpp-sdk-firehose.a
    lib/libaws-cpp-sdk-kinesis.a
    lib/libaws-cpp-sdk-sts.a
    lib/libaws-cpp-sdk-core.a
  )

  if(DEFINED PLATFORM_LINUX)
    set(hash "38d8ab7feccc25ba89adb49ffbcbe8c9b274191f2eb9172371c94f2ceb5a1159")
  elseif(DEFINED PLATFORM_MACOS)
    set(hash "1d1974a6bb22dbe40ebd98547e775364357e65e81cda52b6fb2485250fdd15ba")
  elseif(DEFINED PLATFORM_WINDOWS)
    set(hash "71b575fc0ade0ae22239c4bdb2ba2f09a90d67c44425196aaffc96a14cb9a4fc")
    set(anchor_file "lib/aws-cpp-sdk-core.lib")

    set(additional_libraries
      lib/aws-cpp-sdk-ec2.lib
      lib/aws-cpp-sdk-firehose.lib
      lib/aws-cpp-sdk-kinesis.lib
      lib/aws-cpp-sdk-sts.lib
    )
  else()
    return()
  endif()

  importThirdPartyBinaryLibrary("${name}" "${version}" "${hash}" "${anchor_file}" ${additional_libraries})
endfunction()

awsSdkCppMain()
