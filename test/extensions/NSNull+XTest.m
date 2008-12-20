#import "TestHelper.h"

@interface NSNullXTest : XTestCase {}
@end

@implementation NSNullXTest

- (void) test_isNilOrNull_when_arg_is_nil {
  assert_equal_ints(1, isNilOrNull(nil));
}

- (void) test_isNilOrNull_when_arg_is_null {
  assert_equal_ints(1, isNilOrNull(nullObject));
}

- (void) test_isNilOrNull_when_arg_is_nil_and_using_not_operator {
  assert_equal_ints(0, !isNilOrNull(nil));
}

- (void) test_isNilOrNull_when_arg_is_null_and_using_not_operator {
  assert_equal_ints(0, !isNilOrNull(nullObject));
}

- (void) test_isNilOrNull_when_arg_is_not_nil_nor_null_and_using_not_operator {
  assert_equal_ints(1, !isNilOrNull([[XObject alloc] init]));
}

- (void) test_isNilOrNull_when_arg_is_not_nil_nor_null {
  assert_equal_ints(0, isNilOrNull([[XObject alloc] init]));
}

@end