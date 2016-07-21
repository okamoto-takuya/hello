enable_testing()

find_package(Threads REQUIRED)
include(ExternalProject)

add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND})

set(GTEST_TEST_TARGET_NAME gtest_app)
set(GTEST_TEST_OUTPUT_OPT --gtest_output=xml:gtest-app-result.xml)

## googlemock (includes googletest)
ExternalProject_Add(
    googlemock
    URL http://googlemock.googlecode.com/files/gmock-1.7.0.zip
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/googlemock
    # Disable install step
    INSTALL_COMMAND ""
)

add_library(gmock IMPORTED STATIC GLOBAL)
add_dependencies(gmock googlemock)
add_library(gmock_main IMPORTED STATIC GLOBAL)
add_dependencies(gmock_main googlemock)
add_library(gtest IMPORTED STATIC GLOBAL)
add_dependencies(gtest googlemock)
add_library(gtest_main IMPORTED STATIC GLOBAL)
add_dependencies(gtest_main googlemock)

ExternalProject_Get_Property(googlemock source_dir binary_dir)
set_target_properties(gmock PROPERTIES
  "IMPORTED_LOCATION" "${binary_dir}/libgmock.a"
  "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
  )

set_target_properties(gmock_main PROPERTIES
  "IMPORTED_LOCATION" "${binary_dir}/libgmock_main.a"
  "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
  )
set_target_properties(gtest PROPERTIES
  "IMPORTED_LOCATION" "${binary_dir}/gtest/libgtest.a"
  "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
  )
set_target_properties(gtest_main PROPERTIES
  "IMPORTED_LOCATION" "${binary_dir}/gtest/libgtest_main.a"
  "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
  )
include_directories("${source_dir}/include")
include_directories("${source_dir}/gtest/include")

include_directories(
  ${PROJECT_SOURCE_DIR}/src
  ${CMAKE_CURRENT_SOURCE_DIR}
  )

add_executable(${GTEST_TEST_TARGET_NAME}
  gtest_app_main.cc
  hello_test.cc
  )

target_link_libraries(${GTEST_TEST_TARGET_NAME}
  -Wl,--whole-archive
  hello
  -Wl,--no-whole-archive
  gtest
  gmock
  gcov
  ${CMAKE_THREAD_LIBS_INIT}
  )

add_test(test_gtest_app ${GTEST_TEST_TARGET_NAME} ${GTEST_TEST_OUTPUT_OPT})
add_dependencies(check
  ${GTEST_TEST_TARGET_NAME}
  )
