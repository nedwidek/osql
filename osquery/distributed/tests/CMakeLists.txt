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

function(osqueryDistributedTests)
  generateOsqueryDistributesTests()
endfunction()

function(generateOsqueryDistributesTests)
  add_osquery_executable(osquery_distributed_tests distributed_tests.cpp)

        #   osquery_target("osquery/config/plugins:tls_config"),
        # osquery_target("osquery/core/plugins:plugins"),
        # osquery_target("osquery/core:core"),
        # osquery_target("osquery/utils/conversions:conversions"),
        # osquery_target("osquery/database/plugins:ephemeral"),
        # osquery_target("osquery/distributed:distributed"),
        # osquery_target("osquery/extensions:extensions"),
        # osquery_target("osquery/logger:logger"),
        # osquery_target("osquery/registry:registry"),
        # osquery_target("osquery/remote/enroll:tls_enroll"),
        # osquery_target("osquery/utils/info:info"),
        # osquery_target("osquery/utils/system:time"),
        # osquery_target("osquery/remote/tests:remote_test_utils"),
        # osquery_target("specs:tables"),

  target_link_libraries(osquery_distributed_tests PRIVATE
    global_cxx_settings
    osquery_config_plugins_tlsconfig
    osquery_core_plugins
    osquery_utils_conversions
    osquery_database_plugins_ephemeral
    osquery_distributed
    osquery_extensions
    osquery_logger
    osquery_registry
    osquery_remote_enroll_tlsenroll
    osquery_utils_info
    osquery_utils_system_time
    osquery_remote_tests_utils
    specs_tables
    thirdparty_googletest
  )
endfunction()

osqueryDistributedTests()