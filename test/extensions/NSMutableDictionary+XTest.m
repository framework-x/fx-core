#import "TestHelper.h"


@interface NSMutableDictionaryXTest : XTestCase {}
@end


@implementation NSMutableDictionaryXTest


- (void) test_addValue {
  id dict = [NSMutableDictionary empty];
  [dict add:@"key" value:@"value"];
  assert_equal(@"value", [dict get:@"key"]);
}

- (void) test_addValue_returns_self {
  id dict = [NSMutableDictionary empty];
  assert_equal(dict, [dict add:@"key" value:@"value"]);
}

- (void) test_clear {
  id dict = [NSMutableDictionary empty];
  [dict add:@"key" value:@"value"];
  [dict clear];
  assert_true([dict isEmpty]);
}

- (void) test_delete {
 NSMutableDictionary* dict = [NSMutableDictionary empty];
 assert_equal(dict, [dict delete:@"key"]);
 [dict add:@"key" value:@"value"];
 assert_equal(dict, [dict delete:@"key"]);
 assert_true([dict isEmpty]);
}

- (void) test_empty {
  id dict = [[NSMutableDictionary alloc] init];
  [dict add:@"key" value:@"value"];
  [dict empty];
  assert_true([dict isEmpty]);
}

- (void) test_merge {
  id dict = [NSMutableDictionary empty];
  [dict add:@"key1" value:@"foo"];
  id other = [NSMutableDictionary empty];
  [other add:@"key1" value:@"bar"];
  [other add:@"key2" value:@"baz"];
  assert_equal(@"bar", [[dict merge:other] get:@"key1"]);
  assert_equal(@"baz", [dict get:@"key2"]);
}

- (void) test_remove {
 NSMutableDictionary* dict = [NSMutableDictionary empty];
 [dict add:@"key" value:@"value"];
 assert_equal(@"value", [dict remove:@"key"]);
 assert_true([dict isEmpty]);
}

- (void) test_remove_returns_nil_if_key_not_present {
 NSMutableDictionary* dict = [NSMutableDictionary empty];
 assert_equal(nil, [dict remove:@"key"]);
}

- (void) test_setValue {
  id dict = [NSMutableDictionary empty];
  [dict set:@"key" to:@"value"];
  assert_equal(@"value", [dict get:@"key"]);
}

@end
