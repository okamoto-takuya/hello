#include <iostream>
#include "hello.h"

namespace hello {

int32_t greet()
{
  std::cout << "Hello, World" << std::endl;
  std::cout << "Bye." << std::endl;
  return 0;
}

}
