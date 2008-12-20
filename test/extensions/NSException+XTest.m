#import "TestHelper.h"

@interface NSExceptionXTest : XTestCase {}
@end

@implementation NSExceptionXTest

- (void) test_with {
  id exception = [NSException with:@"an exception"];
  assert_equal(@"an exception", [exception reason]);
}

@end
