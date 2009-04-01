#import "TestHelper.h"

@interface NSDictionaryXTest : XTestCase {}
@end


@implementation NSDictionaryXTest

- (void) test_asQueryString {
  id hash = [NSDictionary withVargs:@"key1", @"value1", @"key2[]", [XArray withVargs:@"value2", @"value3", nil], nil];
  id expected = @"key1=value1&key2%5B%5D=value2&key2%5B%5D=value3";
  id actual = [hash asQueryString];
  assert_equal(expected, actual);  
}

- (void) test_asQueryString_with_empty_array {
  id hash = [NSDictionary withVargs:@"key[]", [XArray empty], nil];
  id expected = @"key%5B%5D=";
  id actual = [hash asQueryString];
  assert_equal(expected, actual);  
}

- (void) test_clone {
  id original = [NSDictionary withVargs:
    @"anInt", [NSNumber int:5], 
    @"aString", @"bird",     
    @"aDouble", [NSNumber double:1.45],         
    @"aDate", [NSDate now],             
  nil];
  
  id clone = [original clone];
  assert_equal(original, clone);
}

- (void) test_empty {
	id dictionary = [NSDictionary empty];
	assert_equal_ints(0, [dictionary count]);
}

- (void) test_from {    
	id hash = [NSDictionary atPath: @"test/extensions/TestFile.plist"];    
	assert_equal_ints(10, [[hash get:@"radius"] intValue]);
	assert_equal_ints(36000, [[hash get:@"timeIntervalInSeconds"] intValue]);    
}
 
- (void) test_containsKey {
  id hash = [NSDictionary withVargs:@"key", @"value", nil];
  assert_true([hash containsKey:@"key"]);
  assert_false([hash containsKey:@"key_not_in_hash"]);
}

- (void) test_get {
  id hash = [NSDictionary withVargs:@"key", @"value", nil];
  assert_equal(@"value", [hash get:@"key"]);
}

- (void) test_get_returns_nil_if_key_doesnt_exist {
  id hash = [NSDictionary empty];
  assert_equal(nil, [hash get:@"key"]);
}

- (void) test_hasKey {
  id hash = [NSDictionary withVargs:@"key", @"value", nil];
  assert_true([hash hasKey:@"key"]);
  assert_false([hash hasKey:@"key_not_in_hash"]);
}

- (void) test_isEmpty {
  id dict = [NSDictionary empty];
  assert_true([dict isEmpty]);
  dict = [NSDictionary withVargs:@"key", @"value", nil];
  assert_false([dict isEmpty]);
}

- (void) test_isEqual {
  id first = [NSDictionary empty];
  id second = [NSDictionary empty];
  assert_equal(first, second);
  first = [NSDictionary withVargs:@"key1", @"value1", nil];
  assert_not_equal(first, second);
  second = [NSDictionary withVargs:@"key1", @"value1", nil];
  assert_equal(first, second);  
  first = [NSDictionary withVargs:@"key1", @"value1", @"key2", @"value2", nil];
  second = [NSDictionary withVargs:@"key1", @"value1", @"key2", @"value2", nil];
  assert_equal(first, second);    
}

- (void) test_keys {
  id dict = [NSDictionary withVargs:@"key1", @"value1", @"key2", @"value2", nil];
  assert_equal(XArrayWith(@"key1", @"key2", nil), [dict keys]);
}

- (void) test_withVargs_with_variable_args {
  id hash = [NSDictionary withVargs:@"key1", @"value1", @"key2", @"value2", nil];
  assert_equal(@"value1", [hash objectForKey:@"key1"]);
  assert_equal(@"value2", [hash objectForKey:@"key2"]);
}

- (void) test_withoutKey {
  id hash = [NSDictionary withVargs:@"key1", @"value1", @"key2", @"value2", nil];
  id result = [hash withoutKey:@"key1"];
  id expected = [XHash withVargs:@"key2", @"value2", nil];
  assert_equal(expected, result);
}

- (void) test_withoutKey_whenHashDoesNotHaveKey {
  id hash = [NSDictionary withVargs:@"key1", @"value1", nil];
  id result = [hash withoutKey:@"key3"];
  id expected = [XHash withVargs:@"key1", @"value1", nil];
  assert_equal(expected, result);
}

- (void) test_withoutKey_whenHashIsEmpty {
  id hash = [NSDictionary empty];
  id result = [hash withoutKey:@"key3"];
  id expected = [XHash empty];
  assert_equal(expected, result);
}

- (void) test_without {
  id hash = [NSDictionary withVargs:@"key1", @"value1", @"key2", @"value2", @"key3", @"value3", nil];
  id result = [hash without:@"key1", @"key2", nil];
  id expected = [XHash withVargs:@"key3", @"value3", nil];
  assert_equal(expected, result);
}

- (void) test_without_whenHashDoesNotHaveKey {
  id hash = [NSDictionary withVargs:@"key1", @"value1", nil];
  id result = [hash without:@"key3", nil];
  id expected = [XHash withVargs:@"key1", @"value1", nil];
  assert_equal(expected, result);
}

- (void) test_without_whenHashIsEmpty {
  id hash = [NSDictionary empty];
  id result = [hash without:@"key3", nil];
  id expected = [XHash empty];
  assert_equal(expected, result);
}

@end
