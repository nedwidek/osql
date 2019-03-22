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

function(osqueryExperimentalEventsstreamMain)
  generateOsqueryExperimentalEventsstreamEventsstreamregistry()
  generateOsqueryExperimentalEventsstream()
endfunction()

function(generateOsqueryExperimentalEventsstreamEventsstreamregistry)
  add_osquery_library(osquery_experimental_eventsstream_eventsstreamregistry EXCLUDE_FROM_ALL events_stream_registry.cpp)

  enableLinkWholeArchive(osquery_experimental_eventsstream_eventsstreamregistry)

  target_link_libraries(osquery_experimental_eventsstream_eventsstreamregistry PUBLIC
    global_cxx_settings
    osquery_core
    osquery_utils
    thirdparty_boost
  )

  set(public_header_files
    events_stream_registry.h
  )

  generateIncludeNamespace(osquery_experimental_eventsstream_eventsstreamregistry "osquery/experimental/events_stream" "FILE_ONLY" ${public_header_files})
endfunction()

function(generateOsqueryExperimentalEventsstream)
  add_osquery_library(osquery_experimental_eventsstream EXCLUDE_FROM_ALL events_stream.cpp)

  target_link_libraries(osquery_experimental_eventsstream PUBLIC
    global_cxx_settings
    osquery_experimental_eventsstream_eventsstreamregistry
    osquery_core
    osquery_utils
    thirdparty_boost
  )

  set(public_header_files
    events_stream.h
  )

  generateIncludeNamespace(osquery_experimental_eventsstream "osquery/experimental/events_stream" "FILE_ONLY" ${public_header_files})
endfunction()

osqueryExperimentalEventsstreamMain()