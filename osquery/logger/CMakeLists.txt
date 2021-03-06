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

function(osqueryLoggerMain)

  if(BUILD_TESTING)
    add_subdirectory("tests")
  endif()

  generateOsqueryLogger()
  generateOsqueryLoggerDatalogger()
endfunction()

function(generateOsqueryLogger)
  add_osquery_library(osquery_logger INTERFACE)

  target_link_libraries(osquery_logger INTERFACE
    thirdparty_glog
  )

  set(public_header_files
    logger.h
  )

  generateIncludeNamespace(osquery_logger "osquery" "FILE_ONLY" ${public_header_files})
endfunction()

function(generateOsqueryLoggerDatalogger)
  add_osquery_library(osquery_logger_datalogger EXCLUDE_FROM_ALL
    logger.cpp
  )

  target_link_libraries(osquery_logger_datalogger PUBLIC
    global_cxx_settings
    osquery_core
    osquery_core_plugins
    osquery_database
    osquery_filesystem
    osquery_killswitch
    osquery_numericmonitoring
    osquery_registry
    osquery_utils_conversions
    osquery_utils_info
    osquery_utils_system_time
    osquery_logger
  )

  add_test(NAME osquery_logger_tests-test COMMAND osquery_logger_tests-test)
endfunction()

osqueryLoggerMain()
