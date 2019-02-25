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

function(pluginsLoggerTestsMain)
  generatePluginsLoggerTestsFilesystemTests()
  generatePluginsLoggerTestsBufferedTests()

  if(DEFINED PLATFORM_LINUX OR DEFINED PLATFORM_MACOS)
    generatePluginsLoggerTestsKafkaProducerTests()
  endif()

  generatePluginsLoggerTestsAwsKinesisTests()
  generatePluginsLoggerTestsTlsTests()

  if (DEFINED PLATFORM_POSIX)
    generatePluginsLoggerTestsSyslogTests()
  endif()
endfunction()

function(generatePluginsLoggerTestsFilesystemTests)
  add_osquery_executable(plugins_logger_tests_filesystemtests filesystem_logger.cpp)

  target_link_libraries(plugins_logger_tests_filesystemtests PRIVATE
    global_cxx_settings
    osquery_core
    osquery_core_plugins
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_extensions
    osquery_logger_datalogger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_info
    osquery_utils_system_time
    plugins_config_tlsconfig
    plugins_logger_filesystem
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generatePluginsLoggerTestsBufferedTests)
  add_osquery_executable(plugins_logger_tests_bufferedtests buffered_tests.cpp)

  target_link_libraries(plugins_logger_tests_bufferedtests PRIVATE
    global_cxx_settings
    osquery_core
    osquery_core_plugins
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_extensions
    osquery_logger_datalogger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_info
    osquery_utils_system_time
    plugins_config_tlsconfig
    plugins_logger_buffered
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generatePluginsLoggerTestsKafkaProducerTests)
  add_osquery_executable(plugins_logger_tests_kafkaproducertests kafka_producer_tests.cpp)

  target_link_libraries(plugins_logger_tests_kafkaproducertests PRIVATE
    global_cxx_settings
    osquery_core
    osquery_core_plugins
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_extensions
    osquery_logger_datalogger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_info
    osquery_utils_system_time
    plugins_config_tlsconfig
    plugins_logger_kafkaproducer
    specs_tables
    thirdparty_googletest
    thirdparty_gflags
  )
endfunction()

function(generatePluginsLoggerTestsAwsKinesisTests)
  add_osquery_executable(plugins_logger_tests_awskinesistests aws_kinesis_logger_tests.cpp)

  target_link_libraries(plugins_logger_tests_awskinesistests PRIVATE
    global_cxx_settings
    osquery_core
    osquery_core_plugins
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_extensions
    osquery_logger_datalogger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_info
    osquery_utils_system_time
    plugins_config_tlsconfig
    plugins_logger_awskinesis
    plugins_logger_buffered
    specs_tables
    thirdparty_googletest
    thirdparty_gflags
  )
endfunction()

function(generatePluginsLoggerTestsTlsTests)
  add_osquery_executable(plugins_logger_tests_tlstests tls_logger_tests.cpp)

  target_link_libraries(plugins_logger_tests_tlstests PRIVATE
    global_cxx_settings
    osquery_core
    osquery_core_plugins
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_extensions
    osquery_logger_datalogger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_remote_tests_utils
    osquery_utils_conversions
    osquery_utils_info
    osquery_utils_system_time
    plugins_config_tlsconfig
    plugins_logger_tlslogger
    specs_tables
    thirdparty_googletest
    thirdparty_gflags
    osquery_tools_tests_testfiles
  )
endfunction()

function(generatePluginsLoggerTestsSyslogTests)
  add_osquery_executable(plugins_logger_tests_syslogtests syslog_logger_tests.cpp)

  target_link_libraries(plugins_logger_tests_syslogtests PRIVATE
    global_cxx_settings
    osquery_core
    osquery_core_plugins
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_extensions
    osquery_logger_datalogger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_conversions
    osquery_utils_info
    osquery_utils_system_time
    plugins_config_tlsconfig
    plugins_logger_syslog
    specs_tables
    thirdparty_googletest
    thirdparty_gflags
    osquery_remote_tests_utils
    osquery_tools_tests_testfiles
  )
endfunction()

pluginsLoggerTestsMain()