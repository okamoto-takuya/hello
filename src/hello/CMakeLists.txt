add_library(hello STATIC
  hello.cc
  )
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
target_include_directories(hello PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

