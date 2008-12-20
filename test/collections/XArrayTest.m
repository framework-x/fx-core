#import "TestHelper.h"
#import "FrameworkX.h"

@interface XArrayTest : XTestCase {}
@end

@implementation XArrayTest

- (void) test_addObject {
	id array = [XArray empty];
	[array addObject:@"a"];
  assert_equal_ints(1, [array count]);
}

- (void) test_empty_returns_an_empty_array {
  assert_equal_ints(0, [[XArray empty] count]);
}

- (void) test_encodeWithCoder_and_initWithCoder {
  id expected = XArrayWith(@"first", @"second", @"third", nil);
  id data = [NSKeyedArchiver archivedDataWithRootObject:expected];
  id unarchivedItem = [NSKeyedUnarchiver unarchiveObjectWithData:data];

  assert_equal(expected, unarchivedItem);
}

- (void) test_from {
  id array = [XArray withVargs:@"foo", @"bar", nil];
  id actual = [XArray from:array];
  assert_equal(array, actual); 
  assert_true([[actual class] isEqual:[XArray class]]);
}

- (void) test_from_with_copyItems_true {
  id original = [XArray withVargs:[NSNumber int:5], @"bird", [NSNumber double:1.45], [NSDate now], nil];
  id result = [XArray from:original copyItems:YES];
  assert_equal(original, result);
  assert_false([original at:3] == [result at:3]);
}

- (void) test_from_with_copyItems_false {
  id original = [XArray withVargs:[NSNumber int:5], @"bird", [NSNumber double:1.45], [NSDate now], nil];
  id result = [XArray from:original copyItems:NO];
  assert_equal(original, result);
  [original add:@"bargh"];
  assert_false([result contains:@"bargh"]);
  assert_true([original contains:@"bargh"]);
  assert_true([original at:0] == [result at:0]);  
}

- (void) test_from_does_not_copy_items {
  id original = [XArray withVargs:[NSNumber int:5], @"bird", [NSNumber double:1.45], [NSDate now], nil];
  id result = [XArray from:original];
  assert_equal(original, result);
  [original add:@"bargh"];
  assert_false([result contains:@"bargh"]);
  assert_true([original contains:@"bargh"]);
}

- (void) test_init_returns_an_empty_array {
  assert_equal_ints(0, [[[XArray alloc] init] count]);
}

- (void) test_initWithVargs {
  id array = [[XArray alloc] initWithVargs:@"foo", @"bar", nil]; 
	assert_equal(2, [array count]);
  assert_equal(@"foo", [array at:0]);
  assert_equal(@"bar", [array at:1]);
}

- (void) test_insertObjectAtIndex {
	id obj = @"c";
	id array = [XArray withVargs:@"a", @"b", nil]; 
	[array insertObject:obj atIndex:1];
	assert_equal(obj, [array objectAtIndex:1]);
}

- (void) test_isEmpty {
  id array = [XArray empty];
  assert_true([array isEmpty]);
  [array add:@"item"];
  assert_false([array isEmpty]);
}

- (void) test_removeObjectAtIndex {	
	id array = [XArray withVargs:@"a", @"b", nil]; 
	[array removeObjectAtIndex:1];
	assert_equal_ints(1, [array count]);
}

- (void) test_removeLastObject {
	id array = [XArray withVargs:@"a", @"b", nil]; 
	[array removeLastObject];
	assert_equal_ints(1, [array count]);	
	assert_equal(@"a", [array objectAtIndex:0]);
}

- (void) test_replaceObjectAtIndexWithObject {
	id array = [XArray withVargs:@"a", @"b", nil]; 
	[array replaceObjectAtIndex:1 withObject:@"c"];
	assert_equal_ints(2, [array count]);	
	assert_equal(@"c", [array objectAtIndex:1]);
}

- (void) test_reverse_returns_self {
  id array = [XArray empty];
  assert_true(array == [array reverse]);
}

- (void) test_with {
  id array = [XArray withVargs:@"foo", @"bar", nil]; 
	assert_equal(2, [array count]);
  assert_equal(@"foo", [array at:0]);
  assert_equal(@"bar", [array at:1]);
}

- (void) test_xarray_function {
  id array = XArrayWith(@"foo", @"bar", nil); 
	assert_equal(2, [array count]);
  assert_equal(@"foo", [array at:0]);
  assert_equal(@"bar", [array at:1]);
}

- (void) test_xarray_function_with_nil {
  id array = XArrayWith(nil); 
	assert_equal(0, [array count]);
}


@end
