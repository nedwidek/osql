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

function(pluginsLoggerMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  add_osquery_library(plugins_logger_commondeps INTERFACE)
  target_link_libraries(plugins_logger_commondeps INTERFACE
    osquery_core
    osquery_core_plugins
    osquery_database
    osquery_logger
    osquery_registry
    thirdparty_glog
    thirdparty_gflags
  )

  generatePluginsLoggerAwsfirehose()
  generatePluginsLoggerAwskinesis()
  generatePluginsLoggerAwslogforwarder()
  generatePluginsLoggerBuffered()
  generatePluginsLoggerFilesystem()
  generatePluginsLoggerKafkaproducer()
  generatePluginsLoggerStdout()
  generatePluginsLoggerSyslog()
  generatePluginsLoggerTlslogger()
  generatePluginsLoggerWindowseventlog()
endfunction()

function(generatePluginsLoggerAwsfirehose)
  add_osquery_library(plugins_logger_awsfirehose EXCLUDE_FROM_ALL
    aws_firehose.cpp
  )

  enableLinkWholeArchive(plugins_logger_awsfirehose)

  target_link_libraries(plugins_logger_awsfirehose PUBLIC
    global_cxx_settings
    osquery_dispatcher
    plugins_logger_awslogforwarder
  )

  set(public_header_files
    aws_firehose.h
  )

  generateIncludeNamespace(plugins_logger_awsfirehose "plugins/logger" "FILE_ONLY" ${public_header_files})
endfunction()

function(generatePluginsLoggerAwskinesis)
  add_osquery_library(plugins_logger_awskinesis EXCLUDE_FROM_ALL
    aws_kinesis.cpp
  )

  enableLinkWholeArchive(plugins_logger_awskinesis)

  target_link_libraries(plugins_logger_awskinesis PUBLIC
    global_cxx_settings
    osquery_headers
    osquery_dispatcher
    osquery_process
    osquery_registry
    plugins_logger_awslogforwarder
  )

  set(public_header_files
    aws_kinesis.h
  )

  generateIncludeNamespace(plugins_logger_awskinesis "plugins/logger" "FILE_ONLY" ${public_header_files})
  add_test(NAME plugins_logger_tests_awskinesistests_test COMMAND plugins_logger_tests_awskinesistests)
endfunction()

function(generatePluginsLoggerAwslogforwarder)
  add_osquery_library(plugins_logger_awslogforwarder INTERFACE)

  target_link_libraries(plugins_logger_awslogforwarder INTERFACE
    global_cxx_settings
    osquery_utils_aws
    plugins_logger_buffered
  )

  set(public_header_files
    aws_log_forwarder.h
  )

  generateIncludeNamespace(plugins_logger_awslogforwarder "plugins/logger" "FILE_ONLY" ${public_header_files})
endfunction()

function(generatePluginsLoggerBuffered)
  add_osquery_library(plugins_logger_buffered EXCLUDE_FROM_ALL
    buffered.cpp
  )

  enableLinkWholeArchive(plugins_logger_buffered)

  target_link_libraries(plugins_logger_buffered PUBLIC
    global_cxx_settings
    plugins_logger_commondeps
    osquery_utils
    osquery_utils_json
    osquery_utils_system_time
    plugins_config_parsers
  )

  set(public_header_files
    buffered.h
  )

  generateIncludeNamespace(plugins_logger_buffered "plugins/logger" "FILE_ONLY" ${public_header_files})
  add_test(NAME plugins_logger_tests_bufferedtests_test COMMAND plugins_logger_tests_bufferedtests)
endfunction()

function(generatePluginsLoggerFilesystem)
  add_osquery_library(plugins_logger_filesystem EXCLUDE_FROM_ALL
    filesystem_logger.cpp
  )

  enableLinkWholeArchive(plugins_logger_filesystem)

  target_link_libraries(plugins_logger_filesystem PUBLIC
    global_cxx_settings
    plugins_logger_commondeps
    osquery_filesystem
    osquery_utils_config
  )

  set(public_header_files
    filesystem_logger.h
  )

  generateIncludeNamespace(plugins_logger_filesystem "plugins/logger" "FILE_ONLY" ${public_header_files})
  add_test(NAME plugins_logger_tests_filesystemtests_test COMMAND plugins_logger_tests_filesystemtests)
endfunction()

function(generatePluginsLoggerKafkaproducer)

  if (DEFINED PLATFORM_LINUX OR DEFINED PLATFORM_MACOS)
    add_osquery_library(plugins_logger_kafkaproducer EXCLUDE_FROM_ALL
      kafka_producer.cpp
    )

    enableLinkWholeArchive(plugins_logger_kafkaproducer)

    target_link_libraries(plugins_logger_kafkaproducer PUBLIC
      global_cxx_settings
      plugins_logger_commondeps
      osquery_dispatcher
      osquery_utils_config
      thirdparty_librdkafka
    )

    set(public_header_files
      kafka_producer.h
    )

    generateIncludeNamespace(plugins_logger_kafkaproducer "plugins/logger" "FILE_ONLY" ${public_header_files})
    add_test(NAME plugins_logger_tests_kafkaproducertests_test COMMAND plugins_logger_tests_kafkaproducertests)
  else()
    add_osquery_library(plugins_logger_kafkaproducer INTERFACE)
  endif()
endfunction()

function(generatePluginsLoggerStdout)
  add_osquery_library(plugins_logger_stdout EXCLUDE_FROM_ALL
    stdout.cpp
  )

  enableLinkWholeArchive(plugins_logger_stdout)

  target_link_libraries(plugins_logger_stdout PUBLIC
    global_cxx_settings
    plugins_logger_commondeps
  )

  set(public_header_files
    stdout.h
  )

  generateIncludeNamespace(plugins_logger_stdout "plugins/logger" "FILE_ONLY" ${public_header_files})
endfunction()

function(generatePluginsLoggerSyslog)

  if (DEFINED PLATFORM_POSIX)
    add_osquery_library(plugins_logger_syslog EXCLUDE_FROM_ALL
      syslog_logger.cpp
    )

    enableLinkWholeArchive(plugins_logger_syslog)

    target_link_libraries(plugins_logger_syslog PUBLIC
      global_cxx_settings
      plugins_logger_commondeps
    )

    set(public_header_files syslog_logger.h)

    generateIncludeNamespace(plugins_logger_syslog "plugins/logger" "FILE_ONLY" ${public_header_files})

    add_test(
      NAME plugins_logger_tests_syslogtests_test
      COMMAND "${CMAKE_COMMAND}" -E env
              "TEST_CONF_FILES_DIR=${TEST_CONFIGS_DIR}"
              "$<TARGET_FILE:plugins_logger_tests_syslogtests>"
    )
  else()
     add_osquery_library(plugins_logger_syslog INTERFACE)
  endif()
endfunction()

function(generatePluginsLoggerTlslogger)
  add_osquery_library(plugins_logger_tlslogger EXCLUDE_FROM_ALL
    tls_logger.cpp
  )

  enableLinkWholeArchive(plugins_logger_tlslogger)

  target_link_libraries(plugins_logger_tlslogger PUBLIC
    global_cxx_settings
    plugins_logger_commondeps
    osquery_dispatcher
    osquery_remote_serializers_json
    osquery_remote_utility
    plugins_config_parsers
    plugins_logger_buffered
  )

  set(public_header_files
    tls_logger.h
  )

  generateIncludeNamespace(plugins_logger_tlslogger "plugins/logger" "FILE_ONLY" ${public_header_files})
  add_test(
    NAME osquery_logger_plugins_tests_tlstests_test
    COMMAND "${CMAKE_COMMAND}" -E env
            "TEST_CONF_FILES_DIR=${TEST_CONFIGS_DIR}"
            "$<TARGET_FILE:plugins_logger_tests_tlstests>"
  )
endfunction()

function(generatePluginsLoggerWindowseventlog)
  add_osquery_library(plugins_logger_windowseventlog EXCLUDE_FROM_ALL
    windows_event_log.cpp
  )

  enableLinkWholeArchive(plugins_logger_windowseventlog)

  target_link_libraries(plugins_logger_windowseventlog PUBLIC
    global_cxx_settings
    plugins_logger_commondeps
  )

  set(public_header_files
    windows_event_log.h
    generated_wel.h
  )

  generateIncludeNamespace(plugins_logger_windowseventlog "plugins/logger" "FILE_ONLY" ${public_header_files})
endfunction()

pluginsLoggerMain()
