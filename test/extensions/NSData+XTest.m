#import "TestHelper.h"

@interface NSDataXTest : XTestCase {}
@end

@implementation NSDataXTest

- (void) test_fromString {
  id string = @"fooBar";
  id expected = [NSData dataWithBytes:[string asCString] length:strlen([string asCString])];
  assert_equal(expected, [NSData fromString:string]);
}

@end