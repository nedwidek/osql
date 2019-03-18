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
  generatePluginsLoggerTestsFilesystemloggertestsTest()
  generatePluginsLoggerTestsBufferedloggertestsTest()

  if(DEFINED PLATFORM_LINUX OR DEFINED PLATFORM_MACOS)
    generatePluginsLoggerTestsKafkaproducerloggertestsTest()
  endif()

  generatePluginsLoggerTestsAwskinesisloggertestsTest()
  generatePluginsLoggerTestsTlsloggertestsTest()

  if (DEFINED PLATFORM_POSIX)
    generatePluginsLoggerTestsSyslogloggertestsTest()
  endif()
endfunction()

function(generatePluginsLoggerTestsFilesystemloggertestsTest)
  add_osquery_executable(plugins_logger_tests_filesystemloggertests-test filesystem_logger.cpp)

  target_link_libraries(plugins_logger_tests_filesystemloggertests-test PRIVATE
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
    plugins_logger_filesystemlogger
    specs_tables
    thirdparty_googletest
  )
endfunction()

function(generatePluginsLoggerTestsBufferedloggertestsTest)
  add_osquery_executable(plugins_logger_tests_bufferedloggertests-test buffered_tests.cpp)

  target_link_libraries(plugins_logger_tests_bufferedloggertests-test PRIVATE
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

function(generatePluginsLoggerTestsKafkaproducerloggertestsTest)
  add_osquery_executable(plugins_logger_tests_kafkaproducerloggertests-test kafka_producer_tests.cpp)

  target_link_libraries(plugins_logger_tests_kafkaproducerloggertests-test PRIVATE
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

function(generatePluginsLoggerTestsAwskinesisloggertestsTest)
  add_osquery_executable(plugins_logger_tests_awskinesisloggertests-test aws_kinesis_logger_tests.cpp)

  target_link_libraries(plugins_logger_tests_awskinesisloggertests-test PRIVATE
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

function(generatePluginsLoggerTestsTlsloggertestsTest)
  add_osquery_executable(plugins_logger_tests_tlsloggertests-test tls_logger_tests.cpp)

  target_link_libraries(plugins_logger_tests_tlsloggertests-test PRIVATE
    global_cxx_settings
    osquery_core
    osquery_core_plugins
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_extensions
    osquery_logger_datalogger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_remote_tests_remotetestsutils
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

function(generatePluginsLoggerTestsSyslogloggertestsTest)
  add_osquery_executable(plugins_logger_tests_syslogloggertests-test syslog_logger_tests.cpp)

  target_link_libraries(plugins_logger_tests_syslogloggertests-test PRIVATE
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
    osquery_remote_tests_remotetestsutils
    osquery_tools_tests_testfiles
  )
endfunction()

pluginsLoggerTestsMain()