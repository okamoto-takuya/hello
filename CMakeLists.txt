cmake_minimum_required (VERSION 3.0)
project(hello C CXX)

find_package(Threads REQUIRED)

# enable C++11
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
if(COMPILER_SUPPORTS_CXX11)
  add_compile_options(
    -std=c++11
    -Wall
    -Wnon-virtual-dtor
    -Woverloaded-virtual
    -Wswitch-default
    -Wunused-variable
    -Wunused-but-set-variable
    -Werror
    -Wno-error=unused-variable
    -Wno-error=unused-but-set-variable
    -Wno-error=sign-compare
    )
else()
  message(FATAL_ERROR "C++11 complient compiler needed for this project.")
endif()

# Enabling valgrind will cause all unit tests to be ran with valgrind
# to detect memory leaks.  --error-exitcode will cause unit test to
# fail when leaks are detected.
option(valgrind "-Dvalgrind=ON enables use of valgrind when running tests." OFF)
if(valgrind)
    find_program(VALGRIND valgrind)
    if(VALGRIND)
	set(TESTS_ENVIRONMENT "valgrind --quiet --leak-check=full --error-exitcode=1")
	separate_arguments(TESTS_ENVIRONMENT)
    endif(VALGRIND)
endif(valgrind)

option(gcov "-Dvalgrind=ON enables gcov code coverage support." ON)
if(gcov)
    if(NOT CMAKE_COMPILER_IS_GNUCC)
      message(FATAL_ERROR "gcov enabled but no GNU compiler detected")
    endif(NOT CMAKE_COMPILER_IS_GNUCC)
    add_compile_options(-O0 -fprofile-arcs -ftest-coverage)
endif(gcov)

# Add project-level include path and library path(es)
include_directories(
  ${PROJECT_SOURCE_DIR}/external/include
  ${PROJECT_SOURCE_DIR}/src
  )
link_directories(${PROJECT_SOURCE_DIR}/external/lib)

# Inform cmake of subdirectories that contain source code
add_subdirectory(src)
add_subdirectory(test EXCLUDE_FROM_ALL)

add_custom_target(lcov
  COMMAND echo "Doing lcov..."
  COMMAND ${PROJECT_SOURCE_DIR}/run_lcov.sh
)
add_dependencies(lcov
  check
  )

# Generate Quality Analysis
add_custom_target(cpplint-xml
  COMMAND cpplint_mod.py --root=src `find ${PROJECT_SOURCE_DIR}/src -name "*.cc" -o -name "*.h"` 2> cpplint.txt
  COMMAND cpplintReport2checkstyleReport.perl cpplint.txt cpplint.xml
  COMMENT "Now, cpplint!!!"
)
