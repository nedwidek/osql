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

function(osqueryExperimentalTracingMain)
  generateOsqueryExperimentalTracingSyscallstracing()
endfunction()

function(generateOsqueryExperimentalTracingSyscallstracing)

  set(source_files
    syscalls_tracing.cpp
  )

  if(DEFINED PLATFORM_LINUX)
    list(APPEND source_files
      syscalls_tracing_impl.cpp
    )
  endif()

  add_osquery_library(osquery_experimental_tracing_syscallstracing EXCLUDE_FROM_ALL ${source_files})

  target_link_libraries(osquery_experimental_tracing_syscallstracing PUBLIC
    global_cxx_settings
    osquery_core
    osquery_dispatcher
    osquery_events_linux_probes_probesevents
    osquery_experimental_eventsstream
    osquery_utils_caches_lru
    osquery_utils_conversions
    osquery_utils_json
    osquery_utils_system_linux_proc
    osquery_utils_system_time
  )

  set(public_header_files
    syscalls_tracing.h
  )

  if(DEFINED PLATFORM_LINUX)
    list(APPEND public_header_files
      syscalls_tracing_impl.h
    )
  endif()

  generateIncludeNamespace(osquery_experimental_tracing_syscallstracing "osquery/experimental/tracing" "FILE_ONLY" ${public_header_files})

endfunction()

osqueryExperimentalTracingMain()