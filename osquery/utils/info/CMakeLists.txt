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

function(osqueryUtilsInfoMain)
  generateOsqueryUtilsInfo()
endfunction()

function(generateOsqueryUtilsInfo)
  add_osquery_library(osquery_utils_info EXCLUDE_FROM_ALL
    platform_type.cpp
    tool_type.cpp
    version.cpp
  )

  target_link_libraries(osquery_utils_info PUBLIC
    global_cxx_settings
    osquery_utils_conversions
    osquery_utils_macros
  )

  target_compile_definitions(osquery_utils_info PUBLIC
    OSQUERY_VERSION=${OSQUERY_VERSION}
    OSQUERY_BUILD_VERSION=${OSQUERY_VERSION}
    OSQUERY_BUILD_SDK_VERSION=${OSQUERY_VERSION}
  )

  set(public_header_files
    platform_type.h
    tool_type.h
    version.h
  )

  generateIncludeNamespace(osquery_utils_info "osquery/utils/info" "FILE_ONLY" ${public_header_files})

endfunction()

osqueryUtilsInfoMain()
