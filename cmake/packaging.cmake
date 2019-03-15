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

set(linux_supported_packaging_systems
  DEB
  RPM
)

set(windows_supported_packaging_system
  # NSIS
  # NSIS64
  WIX
)

set(macos_supported_packaging_system
  productbuild
  # Bundle
)

function(identifyPackagingSystem)
  if(NOT PACKAGING_SYSTEM)
      identifyPackagingSystemFromPlatform()
  endif()

  if(DEFINED PLATFORM_LINUX)
    if(NOT ${PACKAGING_SYSTEM} IN_LIST linux_supported_packaging_systems)
      message(WARNING "Selected an unsupported packaging system, please choose from this list: ${linux_supported_packaging_systems}")
    endif()
  elseif(DEFINED PLATFORM_WINDOWS)
    if(NOT ${PACKAGING_SYSTEM} IN_LIST windows_supported_packaging_system)
      message(WARNING "Selected an unsupported packaging system, please choose from this list: ${windows_supported_packaging_system}")
    endif()
  elseif(DEFINED PLATFORM_MACOS)
    if(NOT ${PACKAGING_SYSTEM} IN_LIST macos_supported_packaging_system)
      message(WARNING "Selected an unsupported packaging system, please choose from this list: ${macos_supported_packaging_system}")
    endif()
  endif()

  findPackagingTool()
endfunction()

function(identifyPackagingSystemFromPlatform)
  if(DEFINED PLATFORM_LINUX)
    find_program(lsb_release_exec lsb_release)

    if(NOT "${lsb_release_exec}" STREQUAL "lsb_release_exec_NOTFOUND")
      execute_process(COMMAND ${lsb_release_exec} -is
                      OUTPUT_VARIABLE lsb_release_id_short
                      OUTPUT_STRIP_TRAILING_WHITESPACE
      )
    endif()

    set(deb_distros
      Ubuntu
      Debian
    )

    set(rpm_distros
      Fedora
    )

    if("${lsb_release_id_short}" IN_LIST deb_distros)
      set(platform_packaging_system "DEB")
    elseif("${lsb_release_id_short}" IN_LIST rpm_distros)
      set(platform_packaging_system "RPM")
    else()
      message(WARNING
        "Failed to identify Linux flavor, either lsb_release is missing or we couldn't identify your distro.\n"
        "If you want to generate packages, please either install lsb_release or set the CMake variable PACKAGING_SYSTEM to DEB or RPM depending on your distro."
      )
    endif()
  elseif(DEFINED PLATFORM_WINDOWS)
    set(platform_packaging_system "WIX")
  elseif(DEFINED PLATFORM_MACOS)
    set(platform_packaging_system "productbuild")
  endif()

  overwrite_cache_variable("PACKAGING_SYSTEM" "${platform_packaging_system}")
endfunction()

function(findPackagingTool)
  if(PACKAGING_SYSTEM STREQUAL "DEB")
    unset(PACKAGING_TOOL_PATH_INTERNAL CACHE)
    unset(deb_packaging_tool CACHE)
    find_program(deb_packaging_tool dpkg)

    if("${deb_packaging_tool}" STREQUAL "deb_packaging_tool-NOTFOUND")
      message(WARNING "Packaging tool dpkg needed to create DEB packages has not been found, please install it if you want to create packages")
    endif()
  elseif(PACKAGING_SYSTEM STREQUAL "RPM")
    unset(PACKAGING_TOOL_PATH_INTERNAL CACHE)
    unset(rpm_packaging_tool CACHE)
    find_program(rpm_packaging_tool rpmbuild)

    if("${rpm_packaging_tool}" STREQUAL "rpm_packaging_tool-NOTFOUND")
      message(WARNING "Packaging tool rpmbuild needed to create RPM packages has not been found, please install it if you want to create packages")
    endif()
  elseif(PACKAGING_SYSTEM STREQUAL "WIX")
    find_program(candle_exec NAMES candle.exe PATHS "${WIX_ROOT_FOLDER_PATH}\\bin" "$ENV{WIX}\\bin")

    if(NOT "${candle_exec}" STREQUAL "candle_exec-NOTFOUND")
      get_filename_component(wix_root_path "${candle_exec}" DIRECTORY)
      get_filename_component(wix_root_path "${wix_root_path}" DIRECTORY)
      message(STATUS "Found WIX toolset at: ${wix_root_path}")
      set(CPACK_WIX_ROOT "${wix_root_path}")
      overwrite_cache_variable("WIX_ROOT_FOLDER_PATH" "${wix_root_path}")
    else()
      message(WARNING
        "Could not find the WIX packaging tools, either install it or if it's already installed, please set the WIX_ROOT_FOLDER_PATH variable to the root folder of the WIX installation."
      )
    endif()
  endif()
endfunction()

function(generateInstallTargets)

  if (DEFINED PLATFORM_LINUX)
    # bin
    install(TARGETS osqueryd DESTINATION bin)
    install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink osqueryd osqueryi)")
    install(FILES "${CMAKE_BINARY_DIR}/osqueryi" DESTINATION bin)
    install(PROGRAMS "${OSQUERY_SOURCE_DIR}/tools/deployment/osqueryctl" DESTINATION bin)

    # lib
    install(FILES "${OSQUERY_SOURCE_DIR}/tools/deployment/osqueryd.service" DESTINATION lib/systemd/system)

    # share
    install(FILES "${OSQUERY_SOURCE_DIR}/tools/deployment/osquery.example.conf" DESTINATION share/osquery)

    get_target_property(augeas_binary_dir thirdparty_augeas INTERFACE_BINARY_DIR)
    install(DIRECTORY "${augeas_binary_dir}/share/augeas/lenses/dist/"
            DESTINATION share/osquery/lenses
            FILES_MATCHING PATTERN "*.aug"
            PATTERN "tests" EXCLUDE)

    install(DIRECTORY "${OSQUERY_SOURCE_DIR}/packs" DESTINATION share/osquery)

    # etc
    if ("${PACKAGING_SYSTEM}"  STREQUAL "DEB")
      install(FILES "${OSQUERY_SOURCE_DIR}/tools/deployment/osqueryd.sysconfig" DESTINATION /etc/default RENAME osqueryd)
    else()
      install(FILES "${OSQUERY_SOURCE_DIR}/tools/deployment/osqueryd.sysconfig" DESTINATION /etc/sysconfig RENAME osqueryd)
    endif()

    install(PROGRAMS "${OSQUERY_SOURCE_DIR}/tools/deployment/osqueryd.initd" DESTINATION /etc/init.d RENAME osqueryd)
    install(DIRECTORY DESTINATION /etc/osquery)
    # var
    install(DIRECTORY DESTINATION /var/log/osquery)
    install(DIRECTORY DESTINATION /var/osquery)
  elseif(DEFINED PLATFORM_WINDOWS)
    # .
    install(PROGRAMS "$<TARGET_FILE:osqueryd>" DESTINATION . RENAME osqueryi.exe)
    install(FILES "${OSQUERY_SOURCE_DIR}/tools/deployment/osquery.example.conf" DESTINATION . RENAME osquery.conf)
    install(FILES "${OSQUERY_SOURCE_DIR}/tools/wel/osquery.man" DESTINATION .)
    install(FILES "${OSQUERY_SOURCE_DIR}/tools/manage-osqueryd.ps1" DESTINATION .)
    install(FILES "${OSQUERY_SOURCE_DIR}/tools/provision/chocolatey/osquery_utils.ps1" DESTINATION .)
    file(WRITE "${CMAKE_BINARY_DIR}/package/wix/osquery.flags")
    install(FILES "${CMAKE_BINARY_DIR}/package/wix/osquery.flags" DESTINATION .)

    # osqueryd
    install(TARGETS osqueryd DESTINATION osqueryd)

    # log
    install(DIRECTORY DESTINATION log)

    # packs
    install(DIRECTORY "${OSQUERY_SOURCE_DIR}/packs" DESTINATION .)

  elseif(DEFINED PLATFORM_MACOS)
    # bin
    install(TARGETS osqueryd DESTINATION bin COMPONENT osquery)
    install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink osqueryd osqueryi)" COMPONENT osquery)
    install(FILES "${CMAKE_BINARY_DIR}/osqueryi" DESTINATION bin COMPONENT osquery)
    install(PROGRAMS "${OSQUERY_SOURCE_DIR}/tools/deployment/osqueryctl" DESTINATION bin COMPONENT osquery)

    # /private/var
    install(DIRECTORY COMPONENT osquery DESTINATION /private/var/log/osquery)
    install(DIRECTORY COMPONENT osquery DESTINATION /private/var/osquery)

    get_target_property(augeas_binary_dir thirdparty_augeas INTERFACE_BINARY_DIR)
    install(DIRECTORY "${augeas_binary_dir}/share/augeas/lenses/dist/" COMPONENT osquery
            DESTINATION /private/var/osquery/lenses
            FILES_MATCHING PATTERN "*.aug"
            PATTERN "tests" EXCLUDE)

    install(DIRECTORY "${OSQUERY_SOURCE_DIR}/packs" COMPONENT osquery DESTINATION /private/var/osquery)

    install(FILES "${OSQUERY_SOURCE_DIR}/tools/deployment/com.facebook.osqueryd.conf" DESTINATION /private/var/osquery RENAME com.TrailofBits.osqueryd.conf COMPONENT osquery)

    file(READ "${OSQUERY_SOURCE_DIR}/tools/deployment/com.facebook.osqueryd.plist" osquery_service_plist)
    string(REPLACE "com.facebook.osqueryd" "com.TrailofBits.osqueryd" osquery_service_plist "${osquery_service_plist}")
    file(WRITE "${CMAKE_BINARY_DIR}/package/productbuild/com.TrailofBits.osqueryd.plist" "${osquery_service_plist}")

    install(FILES "${CMAKE_BINARY_DIR}/package/productbuild/com.TrailofBits.osqueryd.plist" DESTINATION /private/var/osquery COMPONENT osquery)

    install(FILES "${OSQUERY_SOURCE_DIR}/tools/deployment/osquery.example.conf" DESTINATION /private/var/osquery COMPONENT osquery)
  endif()
endfunction()

function(generatePackageTarget)

string(REPLACE "." ";" osquery_version_components "${OSQUERY_VERSION}")

list(GET osquery_version_components 0 CPACK_PACKAGE_VERSION_MAJOR)
list(GET osquery_version_components 1 CPACK_PACKAGE_VERSION_MINOR)
list(GET osquery_version_components 2 CPACK_PACKAGE_VERSION_PATCH)

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "osquery is an operating system instrumentation toolchain.")
set(CPACK_PACKAGE_VENDOR "TrailofBits")
set(CPACK_PACKAGE_CONTACT "osql@trailofbits.com")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://osql.io")
set(CPACK_PROJECT_CONFIG_FILE "${CMAKE_BINARY_DIR}/package/CPackConfig.cmake")
set(CPACK_PACKAGE_RELOCATABLE ON)

configure_file(cmake/CPackConfig.cmake.in package/CPackConfig.cmake @ONLY)

set(CPACK_GENERATOR "${PACKAGING_SYSTEM}")

if(DEFINED PLATFORM_LINUX)
  if(CPACK_GENERATOR STREQUAL "DEB")
    set(CPACK_DEBIAN_PACKAGE_PRIORITY "extra")
    set(CPACK_DEBIAN_PACKAGE_SECTION "default")
    set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>=2.12), zlib1g")
  elseif(CPACK_GENERATOR STREQUAL "RPM")
    set(CPACK_RPM_PACKAGE_DESCRIPTION "osquery is an operating system instrumentation toolchain.")
    set(CPACK_RPM_PACKAGE_GROUP "default")
    set(CPACK_RPM_PACKAGE_LICENSE "BSD")
    set(CPACK_RPM_PACKAGE_REQUIRES "glibc >= 2.12, zlib")
    list(APPEND CPACK_RPM_EXCLUDE_FROM_AUTO_FILELIST_ADDITION
      /etc/sysconfig
      /var
      /var/log
      /usr/lib/systemd
      /usr/lib/systemd/system
    )
  endif()
elseif(DEFINED PLATFORM_MACOS)
elseif(DEFINED PLATFORM_WINDOWS)
  set(CPACK_WIX_PRODUCT_ICON "${OSQUERY_SOURCE_DIR}/tools/osquery.ico")
  set(CPACK_WIX_UPGRADE_GUID "ea6c7327-461e-4033-847c-acdf2b85dede")
  set(CPACK_WIX_PATCH_FILE "${CMAKE_SOURCE_DIR}/cmake/wix_patches/osquery_service_install.xml")
  set(CPACK_WIX_SKIP_PROGRAM_FOLDER True)
  set(CPACK_PACKAGE_INSTALL_DIRECTORY "C:/ProgramData/osquery")
elseif(DEFINED PLATFORM_FREEBSD)
else()
  message(FATAL_ERROR "Unsupported platform")
endif()

include(CPack)

if(DEFINED PLATFORM_MACOS)
  cpack_add_component(osquery REQUIRED)
endif()
endfunction()
