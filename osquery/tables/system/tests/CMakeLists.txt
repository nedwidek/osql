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

  generateOsqueryTablesSystemTestsCommondeps()

  if(DEFINED PLATFORM_LINUX)
    generateOsqueryTablesSystemTestsMdtablestestsTest()
    generateOsqueryTablesSystemTestsPcidevicestestsTest()
    generateOsqueryTablesSystemTestsPortagetestsTest()
  endif()

  if(DEFINED PLATFORM_POSIX)
    generateOsqueryTablesSystemTestsKnownhoststestsTest()
    generateOsqueryTablesSystemTestsShellhistorytestsTest()
    generateOsqueryTablesSystemTestsSudoerstestsTest()
    generateOsqueryTablesSystemTestsYumsourcestestsTest()
  endif()

  generateOsqueryTablesSystemTestsSystemtablestestsTest()

  if(DEFINED PLATFORM_MACOS)
    generateOsqueryTablesSystemTestsAppstestsTest()
    generateOsqueryTablesSystemTestsAsltestsTest()
    generateOsqueryTablesSystemTestsCertificatestestsTest()
    generateOsqueryTablesSystemTestsExtendedattributestestsTest()
    generateOsqueryTablesSystemTestsFirewalltestsTest()
    generateOsqueryTablesSystemTestsLaunchdtestsTest()
    generateOsqueryTablesSystemTestsMdfindtestsTest()
    generateOsqueryTablesSystemTestsProcessestestsTest()
    generateOsqueryTablesSystemTestsSmctestsTest()
    generateOsqueryTablesSystemTestsStartupitemstestsTest()
    generateOsqueryTablesSystemTestsSignaturetestsTest()
  endif()
endfunction()

function(generateOsqueryTablesSystemTestsCommondeps)
  add_osquery_library(osquery_tables_system_tests_commondeps INTERFACE)

  target_link_libraries(osquery_tables_system_tests_commondeps INTERFACE
    global_cxx_settings
    osquery_tables_system_systemtable
    osquery_core
    osquery_filesystem
    osquery_utils
    osquery_utils_conversions
    osquery_config_tests_testutils
    osquery_remote_tests_remotetestsutils
    osquery_database
    osquery_database_plugins_ephemeral
    osquery_core_sql
    thirdparty_googletest
  )
endfunction()

function(generateOsqueryTablesSystemTestsMdtablestestsTest)
  add_osquery_executable(osquery_tables_system_tests_mdtablestests-test linux/md_tables_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_mdtablestests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsPcidevicestestsTest)
  add_osquery_executable(osquery_tables_system_tests_pcidevicestests-test linux/pci_devices_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_pcidevicestests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsPortagetestsTest)
  add_osquery_executable(osquery_tables_system_tests_portagetests-test linux/portage_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_portagetests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsKnownhoststestsTest)
  add_osquery_executable(osquery_tables_system_tests_knownhoststests-test posix/known_hosts_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_knownhoststests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsShellhistorytestsTest)
  add_osquery_executable(osquery_tables_system_tests_shellhistorytests-test posix/shell_history_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_shellhistorytests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsSudoerstestsTest)
  add_osquery_executable(osquery_tables_system_tests_sudoerstests-test posix/sudoers_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_sudoerstests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsYumsourcestestsTest)
  add_osquery_executable(osquery_tables_system_tests_yumsourcestests-test posix/yum_sources_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_yumsourcestests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsSystemtablestestsTest)
  add_osquery_executable(osquery_tables_system_tests_systemtablestests-test system_tables_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_systemtablestests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsAppstestsTest)
  add_osquery_executable(osquery_tables_system_tests_appstests-test darwin/apps_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_appstests-test PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_plistfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsAsltestsTest)
  add_osquery_executable(osquery_tables_system_tests_asltests-test darwin/asl_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_asltests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsCertificatestestsTest)
  add_osquery_executable(osquery_tables_system_tests_certificatestests-test darwin/certificates_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_certificatestests-test PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_testfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsExtendedattributestestsTest)
  add_osquery_executable(osquery_tables_system_tests_extendedattributestests-test darwin/extended_attributes_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_extendedattributestests-test PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_testfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsFirewalltestsTest)
  add_osquery_executable(osquery_tables_system_tests_firewalltests-test darwin/firewall_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_firewalltests-test PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_plistfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsLaunchdtestsTest)
  add_osquery_executable(osquery_tables_system_tests_launchdtests-test darwin/launchd_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_launchdtests-test PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_plistfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsMdfindtestsTest)
  add_osquery_executable(osquery_tables_system_tests_mdfindtests-test darwin/mdfind_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_mdfindtests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsProcessestestsTest)
  add_osquery_executable(osquery_tables_system_tests_processestests-test darwin/processes_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_processestests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsSmctestsTest)
  add_osquery_executable(osquery_tables_system_tests_smctests-test darwin/smc_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_smctests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

function(generateOsqueryTablesSystemTestsStartupitemstestsTest)
  add_osquery_executable(osquery_tables_system_tests_startupitemstests-test darwin/startup_items_tests.cpp)

  target_link_libraries(osquery_tables_system_tests_startupitemstests-test PRIVATE
    osquery_tables_system_tests_commondeps
    osquery_tools_tests_plistfiles
  )
endfunction()

function(generateOsqueryTablesSystemTestsSignaturetestsTest)
  add_osquery_executable(osquery_tables_system_tests_signaturetests-test darwin/signature_tests.mm)

  target_link_libraries(osquery_tables_system_tests_signaturetests-test PRIVATE
    osquery_tables_system_tests_commondeps
  )
endfunction()

osqueryTablesSystemTestsMain()