add_executable(helloapp
  main.cc
  )

target_link_libraries(helloapp
  hello
  gcov
  ${CMAKE_THREAD_LIBS_INIT}
  )

add_subdirectory(hello)

# FIXME: Add uninstall to stress that cmake doesn't provide it.

# List of libraries to install in --bindir.
install(TARGETS helloapp RUNTIME DESTINATION bin)
