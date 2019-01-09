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

function(osqueryTablesSystemTestsMain)

  generateOsqueryTablesSystemTestsCommonDeps()

  if(DEFINED PLATFORM_LINUX)
    generateOsqueryTablesSystemTestsMd()
    generateOsqueryTablesSystemTestsPcidevices()
    generateOsqueryTablesSystemTestsPortage()
  endif()

  if(DEFINED PLATFORM_POSIX)
    generateOsqueryTablesSystemTestsKnownhosts()
    generateOsqueryTablesSystemTestsShellhistory()
    generateOsqueryTablesSystemTestsSudoers()
    generateOsqueryTablesSystemTestsYumsources()
  endif()

  generateOsqueryTablesSystemTests()

  if(DEFINED PLATFORM_MACOS)
    generateOsqueryTablesSystemTestsApps()
    generateOsqueryTablesSystemTestsAsl()
    generateOsqueryTablesSystemTestsCertificates()
    generateOsqueryTablesSystemTestsExtendedattributes()
    generateOsqueryTablesSystemTestsFirewall()
    generateOsqueryTablesSystemTestsLaunchd()
    generateOsqueryTablesSystemTestsMdfind()
    generateOsqueryTablesSystemTestsProcesses()
    generateOsqueryTablesSystemTestsSmc()
    generateOsqueryTablesSystemTestsStartupitems()
    generateOsqueryTablesSystemTestsSignature()
  endif()
endfunction()

function(generateOsqueryTablesSystemTestsCommonDeps)
  add_osquery_library(osquery_tables_system_tests_commondeps INTERFACE)

  target_link_libraries(osquery_tables_system_tests_commondeps INTERFACE
    global_cxx_settings
    osquery_tables_system
    osquery_core
    osquery_filesystem
    osquery_utils
    osquery_utils_conversions
    osquery_config_tests_testutils
    osquery_remote_tests_utils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryTablesSystemTestsMd)
  add_osquery_executable(osquery_tables_system_tests_md linux/md_tables_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_md PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsPcidevices)
  add_osquery_executable(osquery_tables_system_tests_pcidevices linux/pci_devices_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_pcidevices PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsPortage)
  add_osquery_executable(osquery_tables_system_tests_portage linux/portage_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_portage PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsKnownhosts)
  add_osquery_executable(osquery_tables_system_tests_knownhosts posix/known_hosts_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_knownhosts PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsShellhistory)
  add_osquery_executable(osquery_tables_system_tests_shellhistory posix/shell_history_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_shellhistory PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsSudoers)
  add_osquery_executable(osquery_tables_system_tests_sudoers posix/sudoers_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_sudoers PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsYumsources)
  add_osquery_executable(osquery_tables_system_tests_yumsources posix/yum_sources_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_yumsources PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTests)
  add_osquery_executable(osquery_tables_system_tests system_tables_tests.cpp)

  target_link_libraries(osquery_tables_system_tests PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsApps)
  add_osquery_executable(osquery_tables_system_tests_apps darwin/apps_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_apps PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_plistfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsAsl)
  add_osquery_executable(osquery_tables_system_tests_asl darwin/asl_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_asl PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsCertificates)
  add_osquery_executable(osquery_tables_system_tests_certificates darwin/certificates_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_certificates PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_testfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsExtendedattributes)
  add_osquery_executable(osquery_tables_system_tests_extendedattributes darwin/extended_attributes_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_extendedattributes PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_testfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsFirewall)
  add_osquery_executable(osquery_tables_system_tests_firewall darwin/firewall_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_firewall PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_plistfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsLaunchd)
  add_osquery_executable(osquery_tables_system_tests_launchd darwin/launchd_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_launchd PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_plistfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsMdfind)
  add_osquery_executable(osquery_tables_system_tests_mdfind darwin/mdfind_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_mdfind PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsProcesses)
  add_osquery_executable(osquery_tables_system_tests_processes darwin/processes_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_processes PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsSmc)
  add_osquery_executable(osquery_tables_system_tests_smc darwin/smc_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_smc PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsStartupitems)
  add_osquery_executable(osquery_tables_system_tests_startupitems darwin/startup_items_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_startupitems PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_plistfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsSignature)
  add_osquery_executable(osquery_tables_system_tests_signature darwin/signature_tests.mm)

  target_link_libraries(osquery_tables_system_tests_signature PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

osqueryTablesSystemTestsMain()