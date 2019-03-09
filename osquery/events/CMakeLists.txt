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

function(osqueryEventsMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryEvents()
  generateOsqueryEventsRegistry()
endfunction()

function(generateOsqueryEvents)

  if(DEFINED PLATFORM_LINUX)
    list(APPEND source_files
      linux/auditdnetlink.cpp
      linux/auditeventpublisher.cpp
      linux/inotify.cpp
      linux/syslog.cpp
      linux/udev.cpp
    )

  elseif(DEFINED PLATFORM_MACOS)
    list(APPEND source_files
      darwin/diskarbitration.cpp
      darwin/event_taps.cpp
      darwin/fsevents.cpp
      darwin/iokit.cpp
      darwin/openbsm.cpp
      darwin/scnetwork.cpp
    )

  elseif(DEFINED PLATFORM_WINDOWS)
    list(APPEND source_files
      windows/windows_event_log.cpp
    )
  endif()

  add_osquery_library(osquery_events EXCLUDE_FROM_ALL
    ${source_files}
  )

  enableLinkWholeArchive(osquery_events)

  target_link_libraries(osquery_events PUBLIC
    global_cxx_settings
    osquery_headers
    osquery_core
    osquery_config
    osquery_events_registry
    osquery_hashing
    osquery_sql
    osquery_utils_conversions
    osquery_utils_expected
    osquery_utils_system_time
    thirdparty_boost
  )

  if(DEFINED PLATFORM_LINUX)
    target_link_libraries(osquery_events PUBLIC
      thirdparty_libaudit
      thirdparty_libudev
      thirdparty_util-linux
    )
  endif()

  set(public_header_files
    pathset.h
  )

  generateIncludeNamespace(osquery_events "osquery/events" "FILE_ONLY" ${public_header_files})

  if(DEFINED PLATFORM_LINUX)
    set(platform_public_header_files
      linux/auditdnetlink.h
      linux/auditeventpublisher.h
      linux/inotify.h
      linux/process_events.h
      linux/process_file_events.h
      linux/selinux_events.h
      linux/socket_events.h
      linux/syslog.h
      linux/udev.h
    )

  elseif(DEFINED PLATFORM_MACOS)
    set(platform_public_header_files
      darwin/diskarbitration.h
      darwin/event_taps.h
      darwin/fsevents.h
      darwin/iokit.h
      darwin/openbsm.h
      darwin/scnetwork.h
    )

  elseif(DEFINED PLATFORM_WINDOWS)
    set(platform_public_header_files
      windows/windows_event_log.h
    )
  endif()

  generateIncludeNamespace(osquery_events "osquery/events" "FULL_PATH" ${platform_public_header_files})

  add_test(NAME osquery_events_tests_databasetests_test COMMAND osquery_events_tests_databasetests)

  if(DEFINED PLATFORM_LINUX)
    add_test(NAME osquery_events_tests_syslogtests_test COMMAND osquery_events_tests_syslogtests)
    add_test(NAME osquery_events_tests_audittests_test COMMAND osquery_events_tests_audittests)
    add_test(NAME osquery_events_tests_processfileeventstests_test COMMAND osquery_events_tests_processfileeventstests)
    add_test(NAME osquery_events_tests_inotifytests_test COMMAND osquery_events_tests_inotifytests)
  endif()

  if(DEFINED PLATFORM_MACOS)
    add_test(NAME osquery_events_tests_fseventstests_test COMMAND osquery_events_tests_fseventstests)
  endif()
endfunction()

function(generateOsqueryEventsRegistry)
  add_osquery_library(osquery_events_registry EXCLUDE_FROM_ALL events.cpp)

  target_link_libraries(osquery_events_registry PUBLIC
    global_cxx_settings
    osquery_core
    osquery_sql
    osquery_headers
  )

  add_test(NAME osquery_events_tests_test COMMAND osquery_events_tests)
endfunction()

osqueryEventsMain()
