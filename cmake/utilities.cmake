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

# Generates an include namespace; this is sadly required by the Buck-based project and can't be removed
function(generateIncludeNamespace target_name namespace_path mode)
  # Make sure we actually have parameters
  if(${ARGC} EQUAL 0)
    message(SEND_ERROR "No library specified")
    return()
  endif()

  # Validate the mode
  if(NOT "${mode}" STREQUAL "FILE_ONLY" AND NOT "${mode}" STREQUAL "FULL_PATH")
    message(SEND_ERROR "Invalid namespace generation mode")
    return()
  endif()

  # Generate a root target that we'll attach to the user target
  set(index 1)

  while(true)
    set(root_target_name "${target_name}_namespace_generator_${index}")
    if(NOT TARGET "${root_target_name}")
      break()
    endif()

    MATH(EXPR index "${index}+1")
  endwhile()

  add_custom_target("${root_target_name}"
    COMMENT "Generating namespace '${namespace_path}' for target '${target_name}'"
  )

  add_dependencies("${target_name}" "${root_target_name}")

  foreach(relative_source_file_path ${ARGN})
    get_filename_component(source_name "${relative_source_file_path}" NAME)

    set(target_namespace_root_directory "${CMAKE_BINARY_DIR}/ns_${target_name}")

    if("${mode}" STREQUAL "FILE_ONLY")
      set(output_source_file_path "${target_namespace_root_directory}/${namespace_path}/${source_name}")
    else()
      set(output_source_file_path "${target_namespace_root_directory}/${namespace_path}/${relative_source_file_path}")
    endif()

    get_filename_component(parent_folder_path "${output_source_file_path}" DIRECTORY)
    set(source_base_path "${CMAKE_CURRENT_SOURCE_DIR}")
    string(REPLACE "${CMAKE_SOURCE_DIR}" "${OSQUERY_SOURCE_DIR}" source_base_path "${source_base_path}")
    set(absolute_source_file_path "${source_base_path}/${relative_source_file_path}")

    add_custom_command(
      OUTPUT "${output_source_file_path}"
      COMMAND "${CMAKE_COMMAND}" -E make_directory "${parent_folder_path}"
      COMMAND "${CMAKE_COMMAND}" -E create_symlink "${absolute_source_file_path}" "${output_source_file_path}"
      VERBATIM
    )

    string(REPLACE "/" "_" file_generator_name "${target_name}_namespaced_${relative_source_file_path}")
    add_custom_target("${file_generator_name}" DEPENDS "${output_source_file_path}")
    add_dependencies("${root_target_name}" "${file_generator_name}")
  endforeach()

  get_target_property(target_type "${target_name}" TYPE)
  if("${target_type}" STREQUAL "INTERFACE_LIBRARY")
    set(mode "INTERFACE")
  else()
    set(mode "PUBLIC")
  endif()

  # So that the IDE finds all the necessary headers
  add_dependencies("prepare_for_ide" "${root_target_name}")

  target_include_directories("${target_name}" ${mode} "${target_namespace_root_directory}")
endfunction()

# Generates the global_c_settings, global_cxx_settings targets and the respective thirdparty variant
function(generateGlobalSettingsTargets)

  if (NOT DEFINED PLATFORM_WINDOWS)
    if("${CMAKE_BUILD_TYPE}" STREQUAL "")
      message(SEND_ERROR "The CMAKE_BUILD_TYPE variabile is empty! Make sure to include globals.cmake before utilities.cmake!")
      return()
    endif()
  endif()

  # Common settings
  add_library(global_settings INTERFACE)

  if (DEFINED PLATFORM_WINDOWS)
    target_compile_options(global_settings INTERFACE
      "$<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:/Z7;/Gs;/GS>"
    )

    target_compile_options(global_settings INTERFACE
      "$<$<CONFIG:Debug>:/Od;/UNDEBUG>$<$<NOT:$<CONFIG:Debug>>:/Ot>"
    )
    target_compile_definitions(global_settings INTERFACE "$<$<NOT:$<CONFIG:Debug>>:NDEBUG>")

    target_link_options(global_settings INTERFACE
      /SUBSYSTEM:CONSOLE
      /LTCG
      ntdll.lib
      ws2_32.lib
      iphlpapi.lib
      netapi32.lib
      rpcrt4.lib
      shlwapi.lib
      version.lib
      wtsapi32.lib
      wbemuuid.lib
      secur32.lib
      taskschd.lib
      dbghelp.lib
      dbgeng.lib
      bcrypt.lib
      crypt32.lib
      wintrust.lib
      setupapi.lib
      advapi32.lib
      userenv.lib
      wevtapi.lib
      shell32.lib
      gdi32.lib
    )
  else()
    if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug" OR "${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
      target_compile_options(global_settings INTERFACE -gdwarf-2 -g3)
    endif()

    if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
      target_compile_options(global_settings INTERFACE -O0)
    else()
      target_compile_options(global_settings INTERFACE -Oz)
      target_compile_definitions(global_settings INTERFACE "NDEBUG")
    endif()
  endif()

  set_target_properties(global_settings PROPERTIES
    INTERFACE_POSITION_INDEPENDENT_CODE ON
  )

  if(DEFINED PLATFORM_LINUX)
    target_link_options(global_settings INTERFACE --no-undefined)
  endif()

  # Settings only for osquery binaries, not third party
  add_library(osquery_settings INTERFACE)
  target_compile_definitions(osquery_settings INTERFACE
    OSQUERY_VERSION=${OSQUERY_VERSION}
    OSQUERY_BUILD_VERSION=${OSQUERY_BUILD_VERSION}
    OSQUERY_BUILD_SDK_VERSION=${OSQUERY_BUILD_SDK_VERSION}
  )

  if(DEFINED PLATFORM_LINUX)
    target_compile_definitions(global_settings INTERFACE
      LINUX=1
      POSIX=1
      OSQUERY_LINUX=1
      OSQUERY_POSIX=1
      OSQUERY_BUILD_PLATFORM=linux
      OSQUERY_BUILD_DISTRO=centos7
    )

  elseif(DEFINED PLATFORM_MACOS)
    target_compile_definitions(global_settings INTERFACE
      APPLE=1
      DARWIN=1
      BSD=1
      POSIX=1
      OSQUERY_POSIX=1
      OSQUERY_BUILD_PLATFORM=darwin
      OSQUERY_BUILD_DISTRO=10.12
    )
  elseif(DEFINED PLATFORM_WINDOWS)
    target_compile_definitions(global_settings INTERFACE
      WIN32=1
      WINDOWS=1
      OSQUERY_WINDOWS=1
      OSQUERY_BUILD_PLATFORM=windows
      OSQUERY_BUILD_DISTRO=10
      BOOST_ALL_NO_LIB
      _WIN32_WINNT=_WIN32_WINNT_WIN7
      NTDDI_VERSION=NTDDI_WIN7
    )
  else()
    message(FATAL_ERROR "This platform is not yet supported")
  endif()

  add_library(c_settings INTERFACE)
  add_library(cxx_settings INTERFACE)

  # C++ settings
  if (DEFINED PLATFORM_WINDOWS)
    target_compile_options(cxx_settings INTERFACE
      /MT
      /EHs
      /W3
      /guard:cf
      /bigobj
      /Zc:inline-
    )
  else()
    target_compile_options(cxx_settings INTERFACE
      -Qunused-arguments
      -Wno-shadow-field
      -Wall
      -Wextra
      -Wno-unused-local-typedef
      -Wno-deprecated-register
      -Wno-unknown-warning-option
      -Wstrict-aliasing
      -Wno-missing-field-initializers
      -Wnon-virtual-dtor
      -Wchar-subscripts
      -Wpointer-arith
      -Woverloaded-virtual
      -Wformat
      -Wformat-security
      -Werror=format-security
      -Wuseless-cast
      -Wno-c++11-extensions
      -Wno-zero-length-array
      -Wno-unused-parameter
      -Wno-gnu-case-range
      -Weffc++
      -fpermissive
      -fstack-protector-all
      -fdata-sections
      -ffunction-sections
      -fvisibility=hidden
      -fvisibility-inlines-hidden
      -fno-limit-debug-info
      -pipe
      -pedantic
      -stdlib=libc++
    )

    if(DEFINED PLATFORM_MACOS)
      target_compile_options(cxx_settings INTERFACE
        -x objective-c++
        -fobjc-arc
        -Wabi-tag
      )

      target_link_options(cxx_settings INTERFACE
        "SHELL:-framework AppKit"
        "SHELL:-framework Foundation"
        "SHELL:-framework CoreServices"
        "SHELL:-framework CoreFoundation"
        "SHELL:-framework CoreWLAN"
        "SHELL:-framework CoreGraphics"
        "SHELL:-framework DiskArbitration"
        "SHELL:-framework IOKit"
        "SHELL:-framework OpenDirectory"
        "SHELL:-framework Security"
        "SHELL:-framework ServiceManagement"
        "SHELL:-framework SystemConfiguration"
      )

      target_link_libraries(cxx_settings INTERFACE
        iconv
        cups
        bsm
        xar
      )
    endif()

    target_link_libraries(cxx_settings INTERFACE c++ c++abi)
  endif()

  target_compile_features(cxx_settings INTERFACE cxx_std_14)

  # C settings
  if (DEFINED PLATFORM_WINDOWS)
    target_compile_options(c_settings INTERFACE
      /std:c11
      /MT
      /EHs
      /W3
      /guard:cf
      /bigobj
    )
  else()
    target_compile_options(c_settings INTERFACE
      -std=gnu11
      -Qunused-arguments
      -Wno-shadow-field
      -Wall
      -Wextra
      -Wno-unused-local-typedef
      -Wno-deprecated-register
      -Wno-unknown-warning-option
      -Wstrict-aliasing
      -Wno-missing-field-initializers
      -Wnon-virtual-dtor
      -Wchar-subscripts
      -Wpointer-arith
      -Woverloaded-virtual
      -Wformat
      -Wformat-security
      -Werror=format-security
      -Wuseless-cast
      -Wno-c99-extensions
      -Wno-zero-length-array
      -Wno-unused-parameter
      -Wno-gnu-case-range
      -Weffc++
      -fpermissive
      -fstack-protector-all
      -fdata-sections
      -ffunction-sections
      -fvisibility=hidden
      -fvisibility-inlines-hidden
      -fno-limit-debug-info
      -pipe
      -pedantic
    )
  endif()

  add_library(global_c_settings INTERFACE)
  target_link_libraries(global_c_settings INTERFACE c_settings global_settings osquery_settings)

  add_library(global_cxx_settings INTERFACE)
  target_link_libraries(global_cxx_settings INTERFACE cxx_settings global_settings osquery_settings)

  add_library(thirdparty_global_c_settings INTERFACE)
  target_link_libraries(thirdparty_global_c_settings INTERFACE c_settings global_settings)

  add_library(thirdparty_global_cxx_settings INTERFACE)
  target_link_libraries(thirdparty_global_cxx_settings INTERFACE cxx_settings global_settings)

endfunction()

# Marks the specified target to enable link whole archive
function(enableLinkWholeArchive target_name)
  if(NOT TARGET "${target_name}")
    message(SEND_ERROR "The specified target does not exists")
    return()
  endif()

  set_property(GLOBAL APPEND PROPERTY "LinkWholeArchive_targetList" "${target_name}")
endfunction()

# Returns a list containing all the targets that have been created
function(getTargetList)
  set(new_directory_queue "${CMAKE_SOURCE_DIR}")

  while(true)
    set(directory_queue ${new_directory_queue})
    unset(new_directory_queue)

    foreach(directory ${directory_queue})
      get_property(child_directories DIRECTORY "${directory}" PROPERTY "SUBDIRECTORIES")
      list(APPEND visited_directories "${directory}")

      list(APPEND new_directory_queue ${child_directories})
    endforeach()

    list(LENGTH new_directory_queue new_directory_queue_size)
    if(${new_directory_queue_size} EQUAL 0)
      break()
    endif()
  endwhile()

  foreach(directory ${visited_directories})
    get_property(directory_target_list DIRECTORY "${directory}" PROPERTY "BUILDSYSTEM_TARGETS")
    list(APPEND target_list ${directory_target_list})
  endforeach()

  set(getTargetList_output ${target_list} PARENT_SCOPE)
endfunction()

# Copies the interface include directories from one target to the other
function(inheritIncludeDirectoriesFromSingleTarget destination_target source_target)
  if(NOT TARGET "${destination_target}" OR NOT TARGET "${source_target}")
    message(SEND_ERROR "Invalid argument(s) specified")
    return()
  endif()

  get_target_property(destination_target_type "${destination_target}" TYPE)
  if("${destination_target_type}" STREQUAL "INTERFACE_LIBRARY")
    set(mode "INTERFACE")
  else()
    set(mode "PUBLIC")
  endif()

  get_target_property(src_interface_include_dirs "${source_target}" "INTERFACE_INCLUDE_DIRECTORIES")
  if(NOT "${src_interface_include_dirs}" STREQUAL "src_interface_include_dirs-NOTFOUND")
    target_include_directories("${destination_target}" ${mode} ${src_interface_include_dirs})
  endif()
endfunction()

# Copies the interface compile definitions from one target to the other
function(inheritCompileDefinitionsFromSingleTarget destination_target source_target)
  if(NOT TARGET "${destination_target}" OR NOT TARGET "${source_target}")
    message(SEND_ERROR "Invalid argument(s) specified")
    return()
  endif()

  get_target_property(destination_target_type "${destination_target}" TYPE)
  if("${destination_target_type}" STREQUAL "INTERFACE_LIBRARY")
    set(mode "INTERFACE")
  else()
    set(mode "PUBLIC")
  endif()

  get_target_property(src_interface_compile_defs "${source_target}" "INTERFACE_COMPILE_DEFINITIONS")
  if(NOT "${src_interface_compile_defs}" STREQUAL "src_interface_compile_defs-NOTFOUND")
    target_compile_definitions("${destination_target}" ${mode} ${src_interface_compile_defs})
  endif()
endfunction()

# Returns true if the specified target should be linked with --whole-archive
function(isWholeLinkLibraryTarget target_name)
  get_property(LinkWholeArchive_targetList GLOBAL PROPERTY "LinkWholeArchive_targetList")

  list(FIND LinkWholeArchive_targetList "${target_name}" index)
  if(${index} EQUAL -1)
    set(isWholeLinkLibraryTarget_output false PARENT_SCOPE)
  else()
    set(isWholeLinkLibraryTarget_output true PARENT_SCOPE)
  endif()
endfunction()

# Processes every target created inside the project, applying the link whole archive settings
function(processLinkWholeArchiveSettings)
  # Do not do anything if we building shared libs
  if(${BUILD_SHARED_LIBS})
    message(STATUS "Skipping link_whole handling (building shared libraries)")
    return()
  endif()

  message(STATUS "Processing link_whole settings...")

  # Enumerate all the targets we have in the project and all the targets we need to link with --whole-archive
  getTargetList()

  foreach(project_target ${getTargetList_output})
    get_target_property(project_target_type "${project_target}" TYPE)
    if("${project_target_type}" STREQUAL "UTILITY")
      continue()
    endif()

    list(APPEND project_target_list "${project_target}")
  endforeach()

  # Iterate through each target and its dependencies and do the substitution
  while(true)
    set(substitution_performed false)

    foreach(project_target ${project_target_list})
      get_target_property(project_target_type "${project_target}" TYPE)

      set(link_lib_property_list "INTERFACE_LINK_LIBRARIES")
      if(NOT "${project_target_type}" STREQUAL "INTERFACE_LIBRARY")
        list(APPEND link_lib_property_list "LINK_LIBRARIES")
      endif()

      foreach(link_lib_property ${link_lib_property_list})
        unset(new_project_target_dependency_list)
        unset(dependency_to_migrate_list)
        unset(new_project_target_link_options)

        get_target_property(project_target_dependency_list "${project_target}" "${link_lib_property}")
        if("${project_target_dependency_list}" STREQUAL "project_target_dependency_list-NOTFOUND")
          continue()
        endif()

        list(REMOVE_DUPLICATES project_target_dependency_list)

        foreach(project_target_dependency ${project_target_dependency_list})
          isWholeLinkLibraryTarget("${project_target_dependency}")
          if(NOT ${isWholeLinkLibraryTarget_output})
            list(APPEND new_project_target_dependency_list "${project_target_dependency}")
            continue()
          endif()

          if(DEFINED PLATFORM_LINUX)
            list(APPEND new_project_target_link_options
              "SHELL:-Wl,--whole-archive $<TARGET_FILE:${project_target_dependency}> -Wl,--no-whole-archive"
            )
          elseif(DEFINED PLATFORM_MACOS)
            list(APPEND new_project_target_link_options
              "SHELL:-Wl,-force_load $<TARGET_FILE:${project_target_dependency}>"
            )
          elseif(DEFINED PLATFORM_WINDOWS)
            list(APPEND new_project_target_link_options
              "/WHOLEARCHIVE:$<TARGET_FILE:${project_target_dependency}>")
          endif()

          add_dependencies("${project_target}" "${project_target_dependency}")

          list(APPEND dependency_to_migrate_list "${project_target_dependency}")
          set(substitution_performed true)
        endforeach()

        foreach(dependency_to_migrate ${dependency_to_migrate_list})
          inheritIncludeDirectoriesFromSingleTarget("${project_target}" "${dependency_to_migrate}")
          inheritCompileDefinitionsFromSingleTarget("${project_target}" "${dependency_to_migrate}")

          get_target_property(additional_dependencies "${dependency_to_migrate}" INTERFACE_LINK_LIBRARIES)
          if(NOT "${additional_dependencies}" STREQUAL "additional_dependencies-NOTFOUND")
            list(APPEND new_project_target_dependency_list ${additional_dependencies})
          endif()

          get_target_property(additional_link_options "${dependency_to_migrate}" INTERFACE_LINK_OPTIONS)
          if(NOT "${additional_link_options}" STREQUAL "additional_link_options-NOTFOUND")
            list(APPEND new_project_target_link_options ${additional_link_options})
          endif()
        endforeach()

        list(REMOVE_DUPLICATES new_project_target_dependency_list)
        set_target_properties("${project_target}" PROPERTIES "${link_lib_property}" "${new_project_target_dependency_list}")

        if ("${link_lib_property}" STREQUAL "INTERFACE_LINK_LIBRARIES")
          get_target_property(additional_link_options "${project_target}" INTERFACE_LINK_OPTIONS)
          if(NOT "${additional_link_options}" STREQUAL "additional_link_options-NOTFOUND")
            list(APPEND new_project_target_link_options ${additional_link_options})
          endif()
          set_target_properties("${project_target}" PROPERTIES INTERFACE_LINK_OPTIONS "${new_project_target_link_options}")
        else()
          get_target_property(additional_link_options "${project_target}" LINK_OPTIONS)
          if(NOT "${additional_link_options}" STREQUAL "additional_link_options-NOTFOUND")
            list(APPEND new_project_target_link_options ${additional_link_options})
          endif()
          set_target_properties("${project_target}" PROPERTIES LINK_OPTIONS "${new_project_target_link_options}")
        endif()
      endforeach()
    endforeach()

    if(NOT ${substitution_performed})
      break()
    endif()
  endwhile()

  message(STATUS "Finished processing link_whole settings")
endfunction()

function(findPythonExecutablePath)
  find_package(Python2 COMPONENTS Interpreter REQUIRED)
  find_package(Python3 COMPONENTS Interpreter REQUIRED)

  set(EX_TOOL_PYTHON2_EXECUTABLE_PATH "${Python2_EXECUTABLE}" PARENT_SCOPE)
  set(EX_TOOL_PYTHON3_EXECUTABLE_PATH "${Python3_EXECUTABLE}" PARENT_SCOPE)
endfunction()

function(generateBuildTimeSourceFile file_path content)
  add_custom_command(
    OUTPUT "${file_path}"
    COMMAND "${CMAKE_COMMAND}" -E echo "${content}" > "${file_path}"
    VERBATIM
  )
endfunction()

function(generateUnsupportedPlatformSourceFile)
  set(source_file "${CMAKE_CURRENT_BINARY_DIR}/osquery_unsupported_platform_target_source_file.cpp")
  set(file_content "#error This target does not support this platform")

  generateBuildTimeSourceFile(${source_file} ${file_content})

  set(unsupported_platform_source_file "${source_file}" PARENT_SCOPE)
endfunction()

function(generateCopyFileTarget name type relative_file_paths)

  set(source_base_path "${CMAKE_CURRENT_SOURCE_DIR}")
  string(REPLACE "${CMAKE_SOURCE_DIR}" "${OSQUERY_SOURCE_DIR}" source_base_path "${source_base_path}")

  if (type STREQUAL "REGEX")
    file(GLOB_RECURSE relative_file_paths RELATIVE "${source_base_path}" "${source_base_path}/${relative_file_paths}")
  endif()

  add_library("${name}" INTERFACE)

  foreach(file ${relative_file_paths})
    get_filename_component(intermediate_directory "${file}" DIRECTORY)
    list(APPEND intermediate_directories "${intermediate_directory}")
  endforeach()

  list(REMOVE_DUPLICATES intermediate_directories)

  foreach(directory ${intermediate_directories})
    add_custom_command(
      OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${directory}"
      COMMAND "${CMAKE_COMMAND}" -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/${directory}"
    )
    list(APPEND created_directories "${CMAKE_CURRENT_BINARY_DIR}/${directory}")
  endforeach()

  add_custom_target("${name}_create_dirs" DEPENDS "${created_directories}")

  foreach(file ${relative_file_paths})
    add_custom_command(
      OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${file}"
      COMMAND "${CMAKE_COMMAND}" -E copy "${source_base_path}/${file}" "${CMAKE_CURRENT_BINARY_DIR}/${file}"
    )
    list(APPEND copied_files "${CMAKE_CURRENT_BINARY_DIR}/${file}")
  endforeach()

  add_custom_target("${name}_copy_files" DEPENDS "${name}_create_dirs" "${copied_files}")

  add_dependencies("${name}" "${name}_copy_files")

  set_target_properties("${name}" PROPERTIES INTERFACE_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}")

endfunction()

function(add_osquery_executable)
  set(osquery_exe_options EXCLUDE_FROM_ALL;WIN32;MACOSX_BUNDLE)
  set(osquery_exe_ARGN ${ARGN})

  list(GET osquery_exe_ARGN 0 osquery_exe_name)
  list(REMOVE_AT osquery_exe_ARGN 0)

  foreach(arg ${osquery_exe_ARGN})
    list(FIND osquery_exe_options "${arg}" arg_POS)
    if(${arg_POS} EQUAL -1 AND NOT IS_ABSOLUTE "${arg}")
      set(base_path "${CMAKE_CURRENT_SOURCE_DIR}")
      string(REPLACE "${CMAKE_SOURCE_DIR}" "${OSQUERY_SOURCE_DIR}" base_path "${base_path}")
      list(APPEND osquery_exe_args "${base_path}/${arg}")
    else()
      list(APPEND osquery_exe_args "${arg}")
    endif()
  endforeach()

  #string(REPLACE ";" " " osquery_exe_args "${osquery_exe_args}")

  add_executable(${osquery_exe_name} ${osquery_exe_args})
endfunction()

function(add_osquery_library)
  set(osquery_lib_options STATIC;SHARED;MODULE;OBJECT;UNKNOWN;EXCLUDE_FROM_ALL;IMPORTED;GLOBAL;INTERFACE)
  set(osquery_lib_ARGN ${ARGN})

  list(GET osquery_lib_ARGN 0 osquery_lib_name)
  #foreach(arg ${osquery_lib_ARGN})
    #message("${arg}")
  #endforeach()
  list(REMOVE_AT osquery_lib_ARGN 0)
  #message("LIBNAME ${osquery_lib_name}")

  foreach(arg ${osquery_lib_ARGN})
    list(FIND osquery_lib_options "${arg}" arg_POS)
    if(${arg_POS} EQUAL -1 AND NOT IS_ABSOLUTE "${arg}")
      set(base_path "${CMAKE_CURRENT_SOURCE_DIR}")
      # message("BASEPATH ${base_path}")
      # message("ARG ${arg}")
      # message("${CMAKE_CURRENT_SOURCE_DIR}")
      string(REPLACE "${CMAKE_SOURCE_DIR}" "${OSQUERY_SOURCE_DIR}" base_path "${base_path}")
      list(APPEND osquery_lib_args "${base_path}/${arg}")
    else()
      list(APPEND osquery_lib_args "${arg}")
    endif()
  endforeach()

  #string(REPLACE ";" " " osquery_lib_args "${osquery_lib_args}")

  add_library(${osquery_lib_name} ${osquery_lib_args})
endfunction()
