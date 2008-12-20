#import "TestHelper.h"
#import "XFile.h"

@interface XHashTest : XTestCase {}
@end

@implementation XHashTest

- (void) test_description_with_empty_hash {
  assert_equal(@"{\n}", [[XHash empty] description]);
}

- (void) test_empty_returnsAnEmptyHash {
	assert_equal_ints(0, [[XHash empty] count]);
}

- (void) test_from_with_copyItems_true {
  id original = [XHash withVargs:
    @"anInt", [NSNumber int:5], 
    @"aString", @"bird",     
    @"aDouble", [NSNumber double:1.45],         
    @"aDate", [NSDate now],             
  nil];
  id result = [XHash from:original copyItems:YES];
  assert_equal(original, result);
  [original set:@"baz" to:@"bargh"];
  assert_nil([result get:@"baz"]);
  assert_false([original get:@"aDate"] == [result get:@"aDate"]);
}

- (void) test_from_with_copyItems_false {
  id original = [XHash withVargs:
    @"anInt", [NSNumber int:5], 
    @"aString", @"bird",     
    @"aDouble", [NSNumber double:1.45],         
    @"aDate", [NSDate now],             
  nil];
  id result = [XHash from:original copyItems:NO];
  assert_equal(original, result);
  [original set:@"baz" to:@"bargh"];
  assert_nil([result get:@"baz"]);
  assert_true([original get:@"aDate"] == [result get:@"aDate"]);
}

- (void) test_from_does_not_copy_items {
  id original = [XHash withVargs:
    @"anInt", [NSNumber int:5], 
    @"aString", @"bird",     
    @"aDouble", [NSNumber double:1.45],         
    @"aDate", [NSDate now],             
  nil];
  id result = [XHash from:original copyItems:NO];
  assert_equal(original, result);
  [original set:@"baz" to:@"bargh"];
  assert_nil([result get:@"baz"]);
  assert_true([original get:@"aDate"] == [result get:@"aDate"]);
}

- (void) test_init_returns_an_empty_hash {
	assert_equal_ints(0, [[[XHash alloc] init] count]);
}

- (void) test_initWithCapacity {
  assert_equal_ints(0, [[[XHash alloc] initWithCapacity:0] count]);
}

- (void) test_withVargs_with_variable_args {
  id hash = [XHash withVargs:@"key1", @"foo", @"key2", @"bar", nil];
  assert_equal(@"foo", [hash get:@"key1"]);
  assert_equal(@"bar", [hash get:@"key2"]);
}

- (void) test_with_withEmptyList {
  id hash = [XHash withVargs:nil];
  assert_equal([XHash empty], hash);
}

- (void) test_xhash_function_with_arguments {
  id hash = XHashWith(@"key1", @"foo", @"key2", @"bar", nil);
  assert_equal(@"foo", [hash get:@"key1"]);
  assert_equal(@"bar", [hash get:@"key2"]);
}

- (void) test_xhash_function_with_nil {
  id foo = XHashWith(nil);
  assert_equal(foo, [XHash empty]);
}

@end
