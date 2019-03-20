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

function(osqueryEventsLinuxProbesTestsMain)

  if(DEFINED PLATFORM_LINUX)
    generateOsqueryEventsLinuxProbesTestsEbpftracepointtestsTest()
  endif()
endfunction()

function(generateOsqueryEventsLinuxProbesTestsEbpftracepointtestsTest)

  set(source_files
    empty.cpp
  )

  if(DEFINED PLATFORM_LINUX)
    list(APPEND source_files syscall_event.cpp)
  endif()

  add_osquery_executable(osquery_events_linux_probes_tests_ebpftracepointtests-test ${source_files})

  target_link_libraries(osquery_events_linux_probes_tests_ebpftracepointtests-test PRIVATE
    global_cxx_settings
    osquery_events_linux_probes_probesevents
    thirdparty_googletest
  )
endfunction()

osqueryEventsLinuxProbesTestsMain()