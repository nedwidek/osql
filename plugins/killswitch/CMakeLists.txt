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

function(pluginsKillswitchMain)
  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generatePluginsKillswitchFilesystem()
  generatePluginsKillswitchTls()
endfunction()

function(generatePluginsKillswitchFilesystem)
  add_osquery_library(plugins_killswitch_filesystem EXCLUDE_FROM_ALL
    killswitch_filesystem.cpp
  )

  enableLinkWholeArchive(plugins_killswitch_filesystem)

  target_link_libraries(plugins_killswitch_filesystem PUBLIC
    global_cxx_settings
    osquery_killswitch
    osquery_utils_config
  )

  set(public_header_files
    killswitch_filesystem.h
  )

  generateIncludeNamespace(plugins_killswitch_filesystem "osquery/killswitch/plugins" "FILE_ONLY" ${public_header_files})

  add_test(NAME plugins_killswitch_killswitchfilesystemplugintests-test COMMAND plugins_killswitch_killswitchfilesystemplugintests-test)

  set_tests_properties(
    plugins_killswitch_killswitchfilesystemplugintests-test
    PROPERTIES ENVIRONMENT "TEST_CONF_FILES_DIR=${TEST_CONFIGS_DIR}"
  )
endfunction()

function(generatePluginsKillswitchTls)
  add_osquery_library(plugins_killswitch_tls EXCLUDE_FROM_ALL
    killswitch_tls.cpp
  )

  enableLinkWholeArchive(plugins_killswitch_tls)

  target_link_libraries(plugins_killswitch_tls PUBLIC
    global_cxx_settings
    osquery_killswitch
    osquery_remote_utility
    osquery_remote_serializers_json
  )

  set(public_header_files
    killswitch_tls.h
  )

  generateIncludeNamespace(plugins_killswitch_tls "osquery/killswitch/plugins" "FILE_ONLY" ${public_header_files})
endfunction()

pluginsKillswitchMain()
