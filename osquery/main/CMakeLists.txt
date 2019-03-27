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

function(osqueryMainMain)
  generateOsqueryMain()
endfunction()

function(generateOsqueryMain)
  set(source_files
    main.cpp
  )

  if(DEFINED PLATFORM_POSIX)
    list(APPEND source_files
      posix/main.cpp
    )

  elseif(DEFINED PLATFORM_WINDOWS)
    list(APPEND source_files
      windows/main.cpp
    )
  endif()

  add_osquery_library(osquery_main EXCLUDE_FROM_ALL
    ${source_files}
  )

  target_link_libraries(osquery_main PUBLIC
    global_cxx_settings
    osquery_headers
    osquery_core
    osquery_core_plugins
    osquery_core_sql
    osquery_database
    osquery_devtools
    osquery_dispatcher
    osquery_experimental_eventsstream_registry
    osquery_experimental_tracing_syscallstracing
    osquery_extensions
    osquery_extensions_implthrift
    osquery_killswitch
    osquery_logger_datalogger
    osquery_process
    osquery_numericmonitoring
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_sql
    plugins_config_filesystemconfig
    plugins_config_tlsconfig
    plugins_config_parsers
    plugins_config_updateconfigplugin
    plugins_database_ephemeral
    plugins_database_rocksdbplugin
    plugins_database_sqliteplugin
    plugins_distributed_tls_distributedtls
    plugins_logger_buffered
    plugins_logger_filesystemlogger
    plugins_logger_stdout
    plugins_logger_syslog
    plugins_logger_tlslogger
    plugins_killswitch_killswitchfilesystem
    plugins_killswitch_killswitchtls
    plugins_numericmonitoring_filesystem
    plugins_remote_enroll_tlsenrollplugin
    specs_tables
    thirdparty_boost
  )

  if(DEFINED PLATFORM_LINUX)
    target_link_libraries(osquery_main PUBLIC
      plugins_logger_awsfirehose
      plugins_logger_awskinesis
      plugins_logger_awslogforwarder
      plugins_logger_kafkaproducer
    )

  elseif(DEFINED PLATFORM_MACOS)
    target_link_libraries(osquery_main PUBLIC
      plugins_logger_awsfirehose
      plugins_logger_awskinesis
      plugins_logger_awslogforwarder
      plugins_logger_kafkaproducer
    )

  elseif(DEFINED PLATFORM_WINDOWS)
    target_link_libraries(osquery_main PUBLIC
      plugins_logger_awsfirehose
      plugins_logger_awskinesis
      plugins_logger_awslogforwarder
      plugins_logger_windowseventlog
    )
  endif()

  set(public_header_files
    main.h
  )

  generateIncludeNamespace(osquery_main "osquery/main" "FILE_ONLY" ${public_header_files})
endfunction()

osqueryMainMain()
