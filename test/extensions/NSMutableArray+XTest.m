#import "TestHelper.h"
#import "NSArray+X.h"

@interface NSMutableArrayXTest : XTestCase {}
@end

@implementation NSMutableArrayXTest


//- (void) test_add {
//  id array = [NSMutableArray empty];
//  
//  array = [array add:@"foo"];
//  assert_equal_ints(1, [array count]);
//  assert_equal(@"foo", [array at:0]);
//  
//  [[array add:@"bar"] add:@"baz"];
//  assert_equal_ints(3, [array count]);
//  assert_equal(@"foo", [array at:0]);  
//  assert_equal(@"bar", [array at:1]);  
//  assert_equal(@"baz", [array at:2]);  
//}

- (void) test_append {
  id array = [NSMutableArray empty];
  array = [array append:@"foo"];
  assert_equal_ints(1, [array count]);
  assert_equal(@"foo", [array at:0]);  
}

- (void) test_appendArray {
  id array = [NSMutableArray empty];
  id arrayToAppend = [NSMutableArray empty];
  [arrayToAppend append:@"foo"];
  [arrayToAppend append:@"bar"];
  [array appendArray:arrayToAppend];
  assert_equal_arrays(arrayToAppend, array);
}

- (void) test_appendArray_with_empty_arrays {
  id array = [NSMutableArray empty];
  id arrayToAppend = [NSMutableArray empty];
  [array appendArray:arrayToAppend];
  assert_equal_arrays([NSMutableArray empty], array);
}

- (void) test_clear {
  id array = [NSMutableArray empty];
  [array addObject:@"a"];
  [array clear];
  assert_equal_ints(0, [array count]);
}

- (void) test_delete {
 NSMutableArray* array = [NSMutableArray empty];
 assert_equal(array, [array delete:@"item"]);
 [array add:@"item"];
 assert_equal(array, [array delete:@"item"]);
 assert_true([array isEmpty]);
}

- (void) test_empty_array_can_be_added_to {
 NSMutableArray* array = [NSMutableArray empty];
 array = [array add:@"foo"];
 assert_equal_ints(1, [array count]);
 assert_equal(@"foo", [array at:0]);
}

- (void) test_initWithVargs {
  id array = [[NSMutableArray alloc] initWithVargs:@"foo", @"bar", nil]; 
	assert_equal(2, [array count]);
  assert_equal(@"foo", [array at:0]);
  assert_equal(@"bar", [array at:1]);
}

- (void) test_isEmpty {
  id array = [NSMutableArray empty];
  assert_true([array isEmpty]);
  [array add:@"item"];
  assert_false([array isEmpty]);
}

- (void) test_remove {
 NSMutableArray* array = [NSMutableArray empty];
 [array add:@"item"];
 assert_equal(@"item", [array remove:@"item"]);
 assert_true([array isEmpty]);
}

- (void) test_reverse_with_one_item {
  id expected = [[NSMutableArray alloc] initWithVargs:@"foo", nil]; 
  id array = [[NSMutableArray alloc] initWithVargs:@"foo", nil]; 
  [array reverse];
  assert_equal(expected, array);  
}

- (void) test_reverse_with_two_items {
  id expected = [[NSMutableArray alloc] initWithVargs:@"bar", @"foo", nil]; 
  id array = [[NSMutableArray alloc] initWithVargs:@"foo", @"bar", nil]; 
  [array reverse];
  assert_equal(expected, array);  
}

- (void) test_reverse_with_three_items {
  id expected = [[NSMutableArray alloc] initWithVargs:@"baz", @"bar", @"foo", nil]; 
  id array = [[NSMutableArray alloc] initWithVargs:@"foo", @"bar", @"baz", nil]; 
  [array reverse];
  assert_equal(expected, array);  
}

- (void) test_reverse_empty_array {
  id array = [NSMutableArray empty];
  [array reverse];
  assert_true([array isEmpty]);  
  assert_equal([NSMutableArray empty], array);
}

- (void) test_reverse_returns_self {
  id array = [NSMutableArray empty];
  assert_true(array == [array reverse]);
}

- (void) test_remove_returns_nil_if_key_not_present {
 NSMutableArray* array = [NSMutableArray empty];
 assert_equal(nil, [array remove:@"item"]);
}

- (void) test_with {
  id array = [NSMutableArray withVargs:@"foo", @"bar", nil]; 
	assert_equal(2, [array count]);
  assert_equal(@"foo", [array at:0]);
  assert_equal(@"bar", [array at:1]);
}

@end
