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

function(googletestMain)
  set(version "1.8.1")
  set(archive_name "gtest-${version}")
  set(archive_type "tar.gz")
  set(extract_folder "${CMAKE_CURRENT_BINARY_DIR}/googletest-release-${version}")
  set(hash "9bf1fe5182a604b4135edc1a425ae356c9ad15e9b23f9f12a02e80184c3a249c")
  set(anchor_file "${extract_folder}/googletest/include/gtest/gtest.h")

  set(base_url "${THIRD_PARTY_REPOSITORY_URL}/third-party/src")

  downloadRemoteFile(thirdparty_googletest "${base_url}" "${archive_name}.${archive_type}" "${hash}")

  set(gtest_source_code
    "${extract_folder}/googletest/src/gtest-all.cc"
    "${extract_folder}/googletest/src/gtest_main.cc"
  )

  set(gmock_source_code
    "${extract_folder}/googlemock/src/gmock-all.cc"
  )

  list(APPEND additional_anchors ${gtest_source_code})
  list(APPEND additional_anchors ${gmock_source_code})

  extractLocalArchive(thirdparty_googletest "${anchor_file}" "${downloadRemoteFile_destination}" "${CMAKE_CURRENT_BINARY_DIR}" ${additional_anchors})

  # So that's possible to download and extract dependencies before building, to have the IDE working correctly
  add_dependencies("prepare_for_ide" "thirdparty_googletest_extractor")

  add_osquery_library(thirdparty_googletest EXCLUDE_FROM_ALL
    "${gtest_source_code}"
    "${gmock_source_code}"
  )

  add_dependencies(thirdparty_googletest thirdparty_googletest_extractor)

  add_osquery_library(thirdparty_googletest_headers INTERFACE)
  target_include_directories(thirdparty_googletest_headers INTERFACE "${extract_folder}/googletest/include")

  add_osquery_library(thirdparty_googlemock_headers INTERFACE)
  target_include_directories(thirdparty_googlemock_headers INTERFACE "${extract_folder}/googlemock/include")

  add_dependencies(thirdparty_googletest_headers thirdparty_googletest_extractor)
  add_dependencies(thirdparty_googlemock_headers thirdparty_googletest_extractor)

  target_include_directories(thirdparty_googletest PRIVATE "${extract_folder}/googletest")
  target_include_directories(thirdparty_googletest PRIVATE "${extract_folder}/googlemock")

  target_link_libraries(thirdparty_googletest PUBLIC
    thirdparty_global_cxx_settings
    thirdparty_googletest_headers
    thirdparty_googlemock_headers
    thirdparty_pthread
  )

  if (DEFINED PLATFORM_WINDOWS)
    target_compile_options(thirdparty_googletest PRIVATE /EHsc)
  endif()
endfunction()

googletestMain()
