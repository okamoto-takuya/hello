#include <gmock/gmock.h>
#include <gtest/gtest.h>

int main(int argc, char** argv)
{
  // run all tests.
  ::testing::InitGoogleMock(&argc, argv);
  auto rc = RUN_ALL_TESTS();

  return rc;
}
