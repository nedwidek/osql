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

function(pluginsRemoteEnrollMain)
	generatePluginsRemoteEnrollTlsenrollplugin()
endfunction()

function(generatePluginsRemoteEnrollTlsenrollplugin)
	add_osquery_library(plugins_remote_enroll_tlsenrollplugin EXCLUDE_FROM_ALL tls_enroll_plugin.cpp)

  enableLinkWholeArchive(plugins_remote_enroll_tlsenrollplugin)

  target_link_libraries(plugins_remote_enroll_tlsenrollplugin PUBLIC
    global_cxx_settings
    osquery_remote_enroll_tlsenroll
  )
endfunction()

pluginsRemoteEnrollMain()