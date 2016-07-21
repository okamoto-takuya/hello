#include <gtest/gtest.h>
#include "hello/hello.h"

class Hello_test : public ::testing::Test {
protected:
  virtual void SetUp()
  {
  }

  virtual void TearDown()
  {
  }
};

TEST_F(Hello_test, GreetAlwaysReturnsZero)
{
  EXPECT_EQ(0, hello::greet());
}
