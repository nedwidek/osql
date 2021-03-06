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

function(osqueryExperimentalTracingLinuxMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateExperimentalTracingLinuxProbesevents()
endfunction()

function(generateExperimentalTracingLinuxProbesevents)
  set(library_name "osquery_experimental_tracing_linux_probesevents")

  if (DEFINED PLATFORM_LINUX)
    set(source_files
      ebpf_tracepoint.cpp
      probes.cpp
      syscall_event.cpp
      syscalls_programs.cpp
    )

    add_osquery_library("${library_name}" EXCLUDE_FROM_ALL ${source_files})

    target_link_libraries("${library_name}" PUBLIC
      global_cxx_settings
      osquery_logger
      osquery_utils_conversions
      osquery_utils_expected
      osquery_utils_system_linux_ebpf
      osquery_utils_system_linux_tracing
      osquery_utils
      thirdparty_boost
    )

    set(public_header_files
      ebpf_tracepoint.h
      probes.h
      syscall_event.h
      syscalls_programs.h
    )

    generateIncludeNamespace("${library_name}" "osquery/experimental/tracing/linux" "FILE_ONLY" ${public_header_files})

    add_test(NAME osquery_experimental_tracing_linux_tests_ebpftracepointtests-test COMMAND osquery_experimental_tracing_linux_tests_ebpftracepointtests-test)
  else()
    add_osquery_library("${library_name}" INTERFACE)
  endif()
endfunction()

osqueryExperimentalTracingLinuxMain()

