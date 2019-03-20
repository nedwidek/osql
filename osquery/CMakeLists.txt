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

function(osqueryMain)
  add_subdirectory("process")
  add_subdirectory("profiler")
  add_subdirectory("dispatcher")
  add_subdirectory("sql")
  add_subdirectory("numeric_monitoring")
  add_subdirectory("killswitch")
  add_subdirectory("registry")
  add_subdirectory("logger")
  add_subdirectory("distributed")
  add_subdirectory("carver")
  add_subdirectory("tables")
  add_subdirectory("hashing")
  add_subdirectory("remote")
  add_subdirectory("core")
  add_subdirectory("config")
  add_subdirectory("utils")
  add_subdirectory("filesystem")
  add_subdirectory("database")
  add_subdirectory("main")
  add_subdirectory("devtools")
  add_subdirectory("extensions")
  add_subdirectory("events")
  add_subdirectory("ev2")

  generateOsqueryHeaders()
  generateOsqueryd()
endfunction()

function(generateOsqueryHeaders)
  add_osquery_library(osquery_headers INTERFACE)
  target_include_directories(osquery_headers INTERFACE "${OSQUERY_SOURCE_DIR}/osquery/include")

  target_link_libraries(osquery_headers INTERFACE
    global_cxx_settings
    osquery_core_plugins
    osquery_utils_info
    osquery_utils_macros
    osquery_utils_system_systemutils
    thirdparty_gflags
    thirdparty_sqlite
    thirdparty_googletest_headers
  )
endfunction()

function(generateOsqueryd)
  # Upstream uses an empty executable that links to a library with a
  # a main() entry point; try to emulate this.
  set(source_file "${CMAKE_CURRENT_BINARY_DIR}/empty_osqueryd_target_source_file.cpp")
  generateBuildTimeSourceFile(${source_file} "extern int main(int argc, char* argv[]);")

  add_osquery_executable(osqueryd "${source_file}")
  set_target_properties(osqueryd PROPERTIES POSITION_INDEPENDENT_CODE true)

  target_link_libraries(osqueryd PRIVATE
    global_cxx_settings
    osquery_main
  )
endfunction()

osqueryMain()
