#import "TestHelper.h"

@interface NSDictionaryXTest : XTestCase {}
@end


@implementation NSDictionaryXTest

- (void) test_asQueryString {
  id hash = [NSDictionary empty];
  [hash add:@"key1" value:@"value1"];
  [hash add:@"key2[]" value:[XArray withVargs:@"value2", @"value3", nil]];
  id expected = @"key1=value1&key2%5B%5D=value2&key2%5B%5D=value3";
  id actual = [hash asQueryString];
  assert_equal(expected, actual);  
}

- (void) test_asQueryString_with_empty_array {
  id hash = [NSDictionary empty];
  [hash add:@"key1[]" value:[XArray empty]];
  id expected = @"key1%5B%5D=";
  id actual = [hash asQueryString];
  assert_equal(expected, actual);  
}

- (void) test_empty {
	id dictionary = [NSDictionary empty];
	assert_equal_ints(0, [dictionary count]);
  assert_true([dictionary instanceOf: [XHash class]]);
}

- (void) test_from {    
	id hash = [NSDictionary withPath: @"test/extensions/TestFile.plist"];    
	assert_equal_ints(10, [[hash get:@"radius"] intValue]);
	assert_equal_ints(36000, [[hash get:@"timeIntervalInSeconds"] intValue]);    
}

- (void) test_containsKey {
  id hash = [NSDictionary empty];
  [hash add:@"key" value:@"value"];
  assert_true([hash containsKey:@"key"]);
  assert_false([hash containsKey:@"key_not_in_hash"]);
}

- (void) test_get {
  id hash = [NSDictionary empty];
  [hash add:@"key" value:@"value"];
  assert_equal(@"value", [hash get:@"key"]);
}

- (void) test_get_returns_nil_if_key_doesnt_exist {
  id hash = [NSDictionary empty];
  assert_equal(nil, [hash get:@"key"]);
}

- (void) test_hasKey {
  id hash = [NSDictionary empty];
  [hash add:@"key" value:@"value"];
  assert_true([hash hasKey:@"key"]);
  assert_false([hash hasKey:@"key_not_in_hash"]);
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
  id first = [NSDictionary empty];
  id second = [NSDictionary empty];
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

- (void) test_withoutKey {
  id hash = [NSDictionary empty];
  [hash add:@"key1" value:@"value1"];
  [hash add:@"key2" value:@"value2"];      
  id result = [hash withoutKey:@"key1"];
  id expected = [XHash withVargs:@"key2", @"value2", nil];
  assert_equal(expected, result);
}

- (void) test_withoutKey_whenHashDoesNotHaveKey {
  id hash = [NSDictionary empty];
  [hash add:@"key1" value:@"value1"];
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
  id hash = [NSDictionary empty];
  [hash add:@"key1" value:@"value1"];
  [hash add:@"key2" value:@"value2"];  
  [hash add:@"key3" value:@"value3"];    
  id result = [hash without:@"key1", @"key2", nil];
  id expected = [XHash withVargs:@"key3", @"value3", nil];
  assert_equal(expected, result);
}

- (void) test_without_whenHashDoesNotHaveKey {
  id hash = [NSDictionary empty];
  [hash add:@"key1" value:@"value1"];
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
