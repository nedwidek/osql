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

function(osqueryUtilsSystemLinuxPerfeventMain)
  generateOsqueryUtilsSystemLinuxPerfevent()
endfunction()

function(generateOsqueryUtilsSystemLinuxPerfevent)

  if (DEFINED PLATFORM_LINUX)
    set(source_files
      perf_event.cpp
    )

    add_osquery_library(osquery_utils_system_linux_perfevent EXCLUDE_FROM_ALL
      ${source_files}
    )

    target_link_libraries(osquery_utils_system_linux_perfevent PUBLIC
      global_cxx_settings
      osquery_utils_expected
      osquery_utils_system_errno
      thirdparty_boost
    )

    set(public_header_files
      perf_event.h
    )

    generateIncludeNamespace(osquery_utils_system_linux_perfevent "osquery/utils/system/linux/perf_event" "FILE_ONLY" ${public_header_files})
  else()
    add_osquery_library(osquery_utils_system_linux_perfevent INTERFACE)
  endif()
endfunction()

osqueryUtilsSystemLinuxPerfeventMain()