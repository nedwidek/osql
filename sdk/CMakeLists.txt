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

function(sdkMain)
  generateSdkPluginPluginsdk()
endfunction()

function(generateSdkPluginPluginsdk)
  add_osquery_library(sdk_plugin_pluginsdk INTERFACE)

  target_link_libraries(sdk_plugin_pluginsdk INTERFACE
    osquery_utils_conversions
    osquery_utils_debug
    osquery_utils_expected
    osquery_utils_info
    osquery_utils_macros
    osquery_utils_status
    osquery_utils_system_env
    osquery_utils_system_errno
    osquery_utils_system_filepath
    osquery_utils_system_systemutils
    osquery_utils_system_time
    osquery_utils_system_uptime
    osquery_utils_attribute
    osquery_utils
    osquery_headers
  )

  set(public_headers
    plugin_sdk.h
  )

  generateIncludeNamespace(sdk_plugin_pluginsdk "osquery/sdk" "FILE_ONLY" ${public_headers})
endfunction()

sdkMain()