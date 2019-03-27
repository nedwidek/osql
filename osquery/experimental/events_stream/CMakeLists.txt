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
  # Originally osquery_experimental_eventsstream_eventsstreamregistry, shortened due to MSBuild not supporting long paths
  add_osquery_library(osquery_experimental_eventsstream_registry EXCLUDE_FROM_ALL events_stream_registry.cpp)

  enableLinkWholeArchive(osquery_experimental_eventsstream_registry)

  target_link_libraries(osquery_experimental_eventsstream_registry PUBLIC
    global_cxx_settings
    osquery_core
    osquery_utils
    thirdparty_boost
  )

  set(public_header_files
    events_stream_registry.h
  )

  generateIncludeNamespace(osquery_experimental_eventsstream_registry "osquery/experimental/events_stream" "FILE_ONLY" ${public_header_files})
endfunction()

function(generateOsqueryExperimentalEventsstream)
  add_osquery_library(osquery_experimental_eventsstream EXCLUDE_FROM_ALL events_stream.cpp)

  target_link_libraries(osquery_experimental_eventsstream PUBLIC
    global_cxx_settings
    osquery_experimental_eventsstream_registry
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