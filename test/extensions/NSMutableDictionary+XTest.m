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

- (void) test_cloning_still_gives_mutable_dictionary {
  id original = [NSMutableDictionary withVargs:
    @"anInt", [NSNumber int:5], 
    @"aString", @"bird",     
    @"aDouble", [NSNumber double:1.45],         
    @"aDate", [NSDate now],             
  nil];
  
  id clone = [original clone];
  assert_equal(original, clone);
  
  [original add:@"newKey" value:@"newValue"];
  assert_not_equal(original, clone);
  assert_true([original containsKey:@"newKey"]);
}

- (void) test_delete {
 NSMutableDictionary* dict = [NSMutableDictionary empty];
 assert_equal(dict, [dict delete:@"key"]);
 [dict add:@"key" value:@"value"];
 assert_equal(dict, [dict delete:@"key"]);
 assert_true([dict isEmpty]);
}

- (void) test_dup {
  id original = [NSMutableDictionary withVargs:@"key", @"value", nil];

  id dup = [original dup];
  assert_equal(original, dup);
}

- (void) test_empty {
  id dict = [[NSMutableDictionary alloc] init];
  [dict add:@"key" value:@"value"];
  [dict empty];
  assert_true([dict isEmpty]);
}

- (void) test_isEmpty {
  id dict = [NSMutableDictionary empty];
  assert_true([dict isEmpty]);
  [dict add:@"key" value:@"value"];
  assert_false([dict isEmpty]);
  [dict delete:@"key"];
  assert_true([dict isEmpty]);
}

- (void) test_isEqual {
  id first = [NSMutableDictionary empty];
  id second = [NSMutableDictionary empty];
  assert_equal(first, second);
  [first add:@"key1" value:@"value1"];
  assert_not_equal(first, second);
  [second add:@"key1" value:@"value1"];
  assert_equal(first, second);  
  [first add:@"key3" value:@"value2"];
  [first add:@"key2" value:@"value2"];
  [second add:@"key2" value:@"value2"];
  [second add:@"key3" value:@"value2"];
  assert_equal(first, second);    
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
 id value = [NSObject new];
 [dict add:@"key" value:value];
 assert_equal(value, [dict remove:@"key"]);
 assert_true([dict isEmpty]);
}

- (void) test_remove_returns_unreleased_object {
 NSMutableDictionary* dict = [NSMutableDictionary empty];
 id value = [NSObject new];
 [dict add:@"key" value:value];
 [value release];
 id result = [dict remove:@"key"];
 [result retainCount];
 assert_true(value == result);
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

- (void) test_withVargs_with_variable_args {
  id hash = [NSMutableDictionary withVargs:@"key1", @"value1", @"key2", @"value2", nil];
  assert_equal(@"value1", [hash objectForKey:@"key1"]);
  assert_equal(@"value2", [hash objectForKey:@"key2"]);
}


@end
