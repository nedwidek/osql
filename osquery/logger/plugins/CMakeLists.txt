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

function(osquery_logger_plugins_main)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  add_osquery_library(osquery_logger_plugins_commondeps INTERFACE)
  target_link_libraries(osquery_logger_plugins_commondeps INTERFACE
    thirdparty_glog
    thirdparty_gflags
    osquery_core
    osquery_logger
    osquery_registry
    osquery_core_plugins
    osquery_database
  )

  generateOsqueryLoggerPluginsAwsfirehose()
  generateOsqueryLoggerPluginsAwskinesis()
  generateOsqueryLoggerPluginsAwslogforwarder()
  generateOsqueryLoggerPluginsBuffered()
  generateOsqueryLoggerPluginsFilesystem()
  generateOsqueryLoggerPluginsKafkaproducer()
  generateOsqueryLoggerPluginsStdout()
  generateOsqueryLoggerPluginsSyslog()
  generateOsqueryLoggerPluginsTlslogger()
  generateOsqueryLoggerPluginsWindowseventlog()
endfunction()

function(generateOsqueryLoggerPluginsAwsfirehose)
  add_osquery_library(osquery_logger_plugins_awsfirehose EXCLUDE_FROM_ALL
    aws_firehose.cpp
  )

  enableLinkWholeArchive(osquery_logger_plugins_awsfirehose)

  target_link_libraries(osquery_logger_plugins_awsfirehose PUBLIC
    global_cxx_settings
    osquery_dispatcher
    osquery_logger_plugins_awslogforwarder
    thirdparty_gflags
    thirdparty_glog
  )

  set(public_header_files
    aws_firehose.h
  )

  generateIncludeNamespace(osquery_logger_plugins_awsfirehose "osquery/logger/plugins" "FILE_ONLY" ${public_header_files})
endfunction()

function(generateOsqueryLoggerPluginsAwskinesis)
  add_osquery_library(osquery_logger_plugins_awskinesis EXCLUDE_FROM_ALL
    aws_kinesis.cpp
  )

  enableLinkWholeArchive(osquery_logger_plugins_awskinesis)

  target_link_libraries(osquery_logger_plugins_awskinesis PUBLIC
    global_cxx_settings
    osquery_headers
    osquery_dispatcher
    osquery_process
    osquery_registry
    osquery_logger_plugins_awslogforwarder
    thirdparty_gflags
    thirdparty_glog
  )

  set(public_header_files
    aws_kinesis.h
  )

  generateIncludeNamespace(osquery_logger_plugins_awskinesis "osquery/logger/plugins" "FILE_ONLY" ${public_header_files})
  add_test(NAME osquery_logger_plugins_tests_awskinesistests_test COMMAND osquery_logger_plugins_tests_awskinesistests)
endfunction()

function(generateOsqueryLoggerPluginsAwslogforwarder)
  add_osquery_library(osquery_logger_plugins_awslogforwarder INTERFACE)

  target_link_libraries(osquery_logger_plugins_awslogforwarder INTERFACE
    global_cxx_settings
    osquery_utils_aws
    osquery_logger_plugins_buffered
    thirdparty_gflags
    thirdparty_glog
  )

  set(public_header_files
    aws_log_forwarder.h
  )

  generateIncludeNamespace(osquery_logger_plugins_awslogforwarder "osquery/logger/plugins" "FILE_ONLY" ${public_header_files})
endfunction()

function(generateOsqueryLoggerPluginsBuffered)
  add_osquery_library(osquery_logger_plugins_buffered EXCLUDE_FROM_ALL
    buffered.cpp
  )

  enableLinkWholeArchive(osquery_logger_plugins_buffered)

  target_link_libraries(osquery_logger_plugins_buffered PUBLIC
    global_cxx_settings
    osquery_logger_plugins_commondeps
    osquery_utils_json
    osquery_config_parsers
    osquery_utils_system_time
    osquery_utils
    thirdparty_gflags
    thirdparty_glog
  )

  set(public_header_files
    buffered.h
  )

  generateIncludeNamespace(osquery_logger_plugins_buffered "osquery/logger/plugins" "FILE_ONLY" ${public_header_files})
  add_test(NAME osquery_logger_plugins_tests_bufferedtests_test COMMAND osquery_logger_plugins_tests_bufferedtests)
endfunction()

function(generateOsqueryLoggerPluginsFilesystem)
  add_osquery_library(osquery_logger_plugins_filesystem EXCLUDE_FROM_ALL
    filesystem_logger.cpp
  )

  enableLinkWholeArchive(osquery_logger_plugins_filesystem)

  target_link_libraries(osquery_logger_plugins_filesystem PUBLIC
    global_cxx_settings
    osquery_logger_plugins_commondeps
    osquery_utils_config
    osquery_filesystem
    thirdparty_gflags
    thirdparty_glog
  )

  set(public_header_files
    filesystem_logger.h
  )

  generateIncludeNamespace(osquery_logger_plugins_filesystem "osquery/logger/plugins" "FILE_ONLY" ${public_header_files})
  add_test(NAME osquery_logger_plugins_tests_filesystemtests_test COMMAND osquery_logger_plugins_tests_filesystemtests)
endfunction()

function(generateOsqueryLoggerPluginsKafkaproducer)

  if (DEFINED PLATFORM_LINUX OR DEFINED PLATFORM_MACOS)
    add_osquery_library(osquery_logger_plugins_kafkaproducer EXCLUDE_FROM_ALL
      kafka_producer.cpp
    )

    enableLinkWholeArchive(osquery_logger_plugins_kafkaproducer)

    target_link_libraries(osquery_logger_plugins_kafkaproducer PUBLIC
      global_cxx_settings
      osquery_logger_plugins_commondeps
      osquery_dispatcher
      osquery_utils_config
      thirdparty_librdkafka
    )

    set(public_header_files
      kafka_producer.h
    )

    generateIncludeNamespace(osquery_logger_plugins_kafkaproducer "osquery/logger/plugins" "FILE_ONLY" ${public_header_files})
    add_test(NAME osquery_logger_plugins_tests_kafkaproducertests_test COMMAND osquery_logger_plugins_tests_kafkaproducertests)
  else()
    add_osquery_library(osquery_logger_plugins_kafkaproducer INTERFACE)
  endif()
endfunction()

function(generateOsqueryLoggerPluginsStdout)
  add_osquery_library(osquery_logger_plugins_stdout EXCLUDE_FROM_ALL
    stdout.cpp
  )

  enableLinkWholeArchive(osquery_logger_plugins_stdout)

  target_link_libraries(osquery_logger_plugins_stdout PUBLIC
    global_cxx_settings
    osquery_logger_plugins_commondeps
    thirdparty_gflags
    thirdparty_glog
  )

  set(public_header_files
    stdout.h
  )

  generateIncludeNamespace(osquery_logger_plugins_stdout "osquery/logger/plugins" "FILE_ONLY" ${public_header_files})
endfunction()

function(generateOsqueryLoggerPluginsSyslog)

  if (DEFINED PLATFORM_POSIX)
    add_osquery_library(osquery_logger_plugins_syslog EXCLUDE_FROM_ALL
      syslog_logger.cpp
    )

    enableLinkWholeArchive(osquery_logger_plugins_syslog)

    target_link_libraries(osquery_logger_plugins_syslog PUBLIC
      global_cxx_settings
      osquery_logger_plugins_commondeps
      thirdparty_gflags
      thirdparty_glog
    )

    set(public_header_files syslog_logger.h)

    generateIncludeNamespace(osquery_logger_plugins_syslog "osquery/logger/plugins" "FILE_ONLY" ${public_header_files})

    add_test(
      NAME osquery_logger_plugins_tests_syslogtests_test
      COMMAND "${CMAKE_COMMAND}" -E env
              "TEST_CONF_FILES_DIR=$<TARGET_PROPERTY:osquery_tools_tests_testfiles,INTERFACE_BINARY_DIR>"
              "$<TARGET_FILE:osquery_logger_plugins_tests_syslogtests>"
    )
  else()
     add_osquery_library(osquery_logger_plugins_syslog INTERFACE)
  endif()
endfunction()

function(generateOsqueryLoggerPluginsTlslogger)
  add_osquery_library(osquery_logger_plugins_tlslogger EXCLUDE_FROM_ALL
    tls_logger.cpp
  )

  enableLinkWholeArchive(osquery_logger_plugins_tlslogger)

  target_link_libraries(osquery_logger_plugins_tlslogger PUBLIC
    global_cxx_settings
    osquery_logger_plugins_commondeps
    osquery_logger_plugins_buffered
    osquery_remote_serializers_json
    osquery_remote_utility
    osquery_config_parsers
    osquery_dispatcher
    thirdparty_gflags
    thirdparty_glog
  )

  set(public_header_files
    tls_logger.h
  )

  generateIncludeNamespace(osquery_logger_plugins_tlslogger "osquery/logger/plugins" "FILE_ONLY" ${public_header_files})
  add_test(
    NAME osquery_logger_plugins_tests_tlstests_test
    COMMAND "${CMAKE_COMMAND}" -E env
            "TEST_CONF_FILES_DIR=$<TARGET_PROPERTY:osquery_tools_tests_testfiles,INTERFACE_BINARY_DIR>"
            "$<TARGET_FILE:osquery_logger_plugins_tests_tlstests>"
  )
endfunction()

function(generateOsqueryLoggerPluginsWindowseventlog)
  add_osquery_library(osquery_logger_plugins_windowseventlog EXCLUDE_FROM_ALL
    windows_event_log.cpp
  )

  enableLinkWholeArchive(osquery_logger_plugins_windowseventlog)

  target_link_libraries(osquery_logger_plugins_windowseventlog PUBLIC
    global_cxx_settings
    osquery_logger_plugins_commondeps
  )

  set(public_header_files
    windows_event_log.h
    generated_wel.h
  )

  generateIncludeNamespace(osquery_logger_plugins_windowseventlog "osquery/logger/plugins" "FILE_ONLY" ${public_header_files})
endfunction()

osquery_logger_plugins_main()
