#import "TestHelper.h"

@interface ValueTestClass : XObject {
  int _value;
} 
+ (id) one;
- (int) addObjectToValue: (id)foo;
- (int) addObjectsToValue: (id)foo bar: (id)bar;
- (int) addIntsToValue: (int)foo bar: (int)bar baz: (int)baz;
- (id) description;
- (int) double;
- (BOOL) isEqual: (id)other;
- (int) value;
@end


@interface NSArrayXTestClass1 : XObject {
  id _foo;
} @end
@implementation NSArrayXTestClass1 

+ (void) initialize {
  [self attrAccessors:@"foo", nil];
}

@end

@interface NSArrayXTest : XTestCase {}
@end

@implementation NSArrayXTest

- (void) test_as2D_with_col_length_1_and_1_elem {
  id array, expected, actual;

  array = [NSArray withVargs:@"foo", nil]; 
  expected = [NSArray withVargs:array, nil]; 
  actual = [array as2D:1];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_1_and_2_elems {
  id array, expected, actual, elem1, elem2;
  
  array = [NSArray withVargs:@"foo", @"bar", nil]; 
  elem1 = [NSArray withVargs:@"foo", nil]; 
  elem2 = [NSArray withVargs:@"bar", nil]; 
  expected = [NSArray withVargs:elem1, elem2, nil]; 
  actual = [array as2D:1];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_1_and_3_elems {
  id array, expected, actual, elem1, elem2, elem3;

  array = [NSArray withVargs:@"foo", @"bar", @"baz", nil]; 
  elem1 = [NSArray withVargs:@"foo", nil]; 
  elem2 = [NSArray withVargs:@"bar", nil]; 
  elem3 = [NSArray withVargs:@"baz", nil]; 
  expected = [NSArray withVargs:elem1, elem2, elem3, nil]; 
  actual = [array as2D:1];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_2_and_1_elem {
  id array, expected, actual;
     
  array = [NSArray withVargs:@"foo", nil]; 
  expected = [NSArray withVargs:array, nil]; 
  actual = [array as2D:2];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_2_and_2_elems {
  id array, expected, actual;

  array = [NSArray withVargs:@"foo", @"bar", nil]; 
  expected = [NSArray withVargs:array, nil]; 
  actual = [array as2D:2];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_2_and_3_elems {
  id array, expected, actual, elem1, elem2;
  
  array = [NSArray withVargs:@"foo", @"bar", @"baz", nil]; 
  elem1 = [NSArray withVargs:@"foo", @"bar", nil]; 
  elem2 = [NSArray withVargs:@"baz", nil]; 
  expected = [NSArray withVargs:elem1, elem2, nil]; 
  actual = [array as2D:2];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_3_and_1_elem {
  id array, expected, actual;
  
  array = [NSArray withVargs:@"foo", nil]; 
  expected = [NSArray withVargs:array, nil];
  actual = [array as2D:3];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_3_and_2_elems {
  id array, expected, actual;
  
  array = [NSArray withVargs:@"foo", @"bar", nil]; 
  expected = [NSArray withVargs:array, nil]; 
  actual = [array as2D:3];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_3_and_3_elems {
  id array, expected, actual;
  
  array = [NSArray withVargs:@"foo", @"bar", @"baz", nil]; 
  expected = [NSArray withVargs:array, nil]; 
  actual = [array as2D:3];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_3_and_4_elems {
  id array, expected, actual, elem1, elem2;
  
  array = [NSArray withVargs:@"foo", @"bar", @"baz", @"foobar", nil]; 
  elem1 = [NSArray withVargs:@"foo", @"bar", @"baz", nil]; 
  elem2 = [NSArray withVargs:@"foobar", nil]; 
  expected = [NSArray withVargs:elem1, elem2, nil];
  actual = [array as2D:3];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_3_and_5_elems {
  id array, expected, actual, elem1, elem2;
  
  array = [NSArray withVargs:@"foo", @"bar", @"baz", @"foobar", @"foobaz", nil]; 
  elem1 = [NSArray withVargs:@"foo", @"bar", @"baz", nil]; 
  elem2 = [NSArray withVargs:@"foobar",@"foobaz", nil]; 
  expected = [NSArray withVargs:elem1, elem2, nil];
  actual = [array as2D:3];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_3_and_6_elems {
  id array, expected, actual, elem1, elem2;
  
  array = [NSArray withVargs:@"foo", @"bar", @"baz", @"foobar", @"foobaz", @"barfoo", nil]; 
  elem1 = [NSArray withVargs:@"foo", @"bar", @"baz", nil]; 
  elem2 = [NSArray withVargs:@"foobar",@"foobaz", @"barfoo", nil]; 
  expected = [NSArray withVargs:elem1, elem2, nil];
  actual = [array as2D:3];
  assert_equal(expected, actual);
}

- (void) test_as2D_with_col_length_3_and_7_elems {
  id array, expected, actual, elem1, elem2, elem3;
  
  array = [NSArray withVargs:@"foo", @"bar", @"baz", @"foobar", @"foobaz", @"barfoo", @"bazbaz", nil]; 
  elem1 = [NSArray withVargs:@"foo", @"bar", @"baz", nil]; 
  elem2 = [NSArray withVargs:@"foobar",@"foobaz", @"barfoo", nil]; 
  elem3 = [NSArray withVargs:@"bazbaz", nil]; 
  expected = [NSArray withVargs:elem1, elem2, elem3, nil];
  actual = [array as2D:3];
  assert_equal(expected, actual);  
}

- (void) test_as2D_returns_empty_array_if_array_is_empty {
  id array = [NSArray empty]; 
  id actual = [array as2D:1];
  assert_equal([NSArray empty], actual);
}

- (void) test_at_returns_nil_if_array_is_empty {
  assert_equal(nil, [[XArray empty] at:0]);
  assert_equal(nil, [[XArray empty] at:1]);  
}

- (void) test_asHash {
	id array = [NSArray withVargs:@"key1", @"a", @"key2", @"b", nil];   
  id expected = [XHash withVargs:@"key1", @"a", @"key2", @"b", nil];
  id hash = [array asHash];
  assert_equal(expected, hash);
}

- (void) test_asHash_with_empty_array {
  id array = [NSArray empty];   
  id expected = [XHash empty];
  id hash = [array asHash];
  assert_equal(expected, hash);
}

- (void) test_collect {
  id array = [NSArray withVargs:@"Hello_World", @"Goodbye_Cruel_World", nil]; 
	id expected = [NSArray withVargs:@"hello_world", @"goodbye_cruel_world", nil]; 	
  id actual = [[array collect] downcase];
	assert_equal(expected, actual);
}

- (void) test_collect_with_empty_array {
  id array = [NSArray empty]; 
  id actual = [[array collect] downcase];
	assert_equal([NSArray empty], actual);  
}

- (void) test_collect_when_method_being_called_returns_nil {
  id object1 = [[NSArrayXTestClass1 alloc] init];
  [object1 setFoo:@"foo"];
  id object2 = [[NSArrayXTestClass1 alloc] init];
  [object2 setFoo:nil];
  
  id array = [NSArray withVargs:object1, object2, nil]; 
	id expected = [NSArray withVargs:@"foo", nullObject, nil]; 	
  id actual = [[array collect] foo];
	assert_equal(expected, actual);
}

- (void) test_compact {
  id array = [NSArray withVargs:@"a", nullObject, @"b", nil]; 
  id expected = [NSArray withVargs:@"a", @"b", nil]; 
  assert_equal(expected, [(NSArray*)array compact]);      
}

- (void) test_compact_with_empty_array {
	assert_equal([NSArray empty], [(NSArray*)[NSArray empty] compact]);    
}

- (void) test_contains {
  id array = [NSArray empty];
  assert_false([array contains:@"foo"]);
  array = [NSArray withVargs:@"foo", nil];
  assert_true([array contains:@"foo"]);
}

//Enumerable.public_instance_methods.sort
// detect
// select
// see NSPredicate
// inject 
// eachWithIndex
// reject
// sortBy

- (void) test_eachDo {
  id array = [NSArray withVargs:[ValueTestClass one], [ValueTestClass one], nil];
  [[array eachDo] double];
  assert_equal_ints(2, [[array first] value]);
  assert_equal_ints(2, [[array last] value]);
  [[array eachDo] addObjectToValue:intObject(1)];
  assert_equal_ints(3, [[array first] value]);
  assert_equal_ints(3, [[array last] value]);  
  [[array eachDo] addObjectsToValue:intObject(4) bar:intObject(6)];
  assert_equal_ints(13, [[array first] value]);
  assert_equal_ints(13, [[array last] value]);  
  [[array eachDo] addIntsToValue:1 bar:2 baz:3];  
  assert_equal_ints(19, [[array first] value]);
  assert_equal_ints(19, [[array last] value]);  
}

- (void) test_eachDo_with_empty_array {
  id array = [NSArray empty]; 
  id actual = [[array eachDo] downcase];
	assert_equal([NSArray empty], actual);  
}

- (void) test_empty_is_equal_to_other_empty {
  assert_equal([NSArray empty], [NSArray empty]);
}

- (void) test_empty_returns_array_with_count_zero {
  assert_equal_ints(0, [[NSArray empty] count]);
}

- (void) test_first {
  id array = [NSArray withVargs:@"foo", @"bar", nil];
  assert_equal(@"foo", [array first]);
}

- (void) test_first_returns_nil_if_array_is_empty {
  id array = [NSArray empty];
  assert_nil([array first]);
}

- (void) test_fromTo {
  id array = [NSArray withVargs:@"foo", @"bar", @"baz", nil]; 
  id expected, actual;

  expected = [NSArray withVargs:@"foo", nil]; 
  actual = [array from:0 to:0];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"foo", @"bar", nil]; 
  actual = [array from:0 to:1];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"bar", nil]; 
  actual = [array from:1 to:1];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"bar", @"baz", nil]; 
  actual = [array from:1 to:2];
  assert_equal(expected, actual);
}

- (void) test_fromWithLength {
  id array = [NSArray withVargs:@"foo", @"bar", @"baz", nil]; 
  id expected, actual;

  expected = [NSArray withVargs:nil]; 
  actual = [array from:0 withLength:0];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"foo", nil]; 
  actual = [array from:0 withLength:1];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"foo", @"bar", nil]; 
  actual = [array from:0 withLength:2];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"bar", nil]; 
  actual = [array from:1 withLength:1];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"bar", @"baz", nil]; 
  actual = [array from:1 withLength:2];
  assert_equal(expected, actual);
}

- (void) test_initWithVargs {
  id array = [[NSArray alloc] _initWithVargs:@"foo", @"bar", nil]; 
	assert_equal(2, [array count]);
  assert_equal(@"foo", [array at:0]);
  assert_equal(@"bar", [array at:1]);
}

- (void) test_isEmpty {
  id array = [NSArray empty];
  assert_true([array isEmpty]);
}

- (void) test_isNotEmpty {
  id array = [NSArray empty];
  assert_false([array isNotEmpty]);
  array = [NSArray withVargs:@"foo", nil]; 
  assert_true([array isNotEmpty]);
}

- (void) test_join {
	id array = [NSArray withVargs:@"a", @"b", nil]; 
	assert_equal(@"a, b", [array join:@", "]);
}

- (void) test_join_returnsan_empty_string_if_array_is_empty {
	id array = [NSArray empty]; 
	assert_equal(@"", [array join:@", "]);
}

- (void) test_last {
  id array = [NSArray withVargs:@"foo", @"bar", nil];
  assert_equal(@"bar", [array last]);
}

- (void) test_last_returns_nil_if_array_is_empty {
  id array = [NSArray empty];
  assert_nil([array last]);
}

- (void) test_map {
	id string1 = [XString with:@"a", nil];
	id string2 = [XString with:@"b", nil];	

	id array = [NSArray withVargs:string1, string2, nil]; 
	id expected = [NSArray withVargs:@"\"a\"", @"\"b\"", nil]; 	
  id newArray = [[array map] inspect];
	assert_equal(expected, newArray); 
}

- (void) test_map_with_a_method_that_is_dynamically_added {
  id obj = [NSArrayXTestClass1 new];
  [obj setFoo:@"hello"];
	id array = [NSArray withVargs:obj, nil]; 
	id expected = [NSArray withVargs:@"hello", nil]; 	
  id newArray = [[array map] foo];
	assert_equal(expected, newArray); 
}

- (void) test_map_when_not_returning_a_string {
	id array = [NSArray withVargs:[NSNumber int:1], [NSNumber int:2], nil]; 
	id expected = [NSArray withVargs:[NSNumber int:1], [NSNumber int:2], nil]; 	
  id newArray = [[array map] inspect];
	assert_equal(expected, newArray); 
}

- (void) test_peek {
	id array = [NSArray withVargs:@"foo", @"bar", nil]; 
  assert_equal(@"foo", [array peek]);
  assert_equal(@"foo", [array peek]);
  array = [NSMutableArray withVargs:@"foo", @"bar", nil]; 
  assert_equal(@"foo", [array peek]);
  [array pop];
  assert_equal(@"bar", [array peek]);
}

- (void) test_range {
  id array = [NSArray withVargs:@"foo", @"bar", @"baz", nil]; 
  id expected, actual;

  expected = [NSArray withVargs:nil]; 
  actual = [array range:NSMakeRange(0, 0)];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"foo", nil]; 
  actual = [array range:NSMakeRange(0, 1)];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"foo", @"bar", nil]; 
  actual = [array range:NSMakeRange(0, 2)];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"bar", nil]; 
  actual = [array range:NSMakeRange(1, 1)];
  assert_equal(expected, actual);

  expected = [NSArray withVargs:@"bar", @"baz", nil]; 
  actual = [array range:NSMakeRange(1, 2)];
  assert_equal(expected, actual);
}

// todo: z: one more reason to only return ids. should we eliminate BOOL return values in fx?
// - (void) test_reject {
//   id array = [NSArray withVargs:@"", @"foo", @"bar", @"", @"baz", @"", nil]; 
//   id expected = [NSArray withVargs:@"foo", @"bar", @"baz", nil];  
//   id actual = [[array reject] testsIsEmptyButReturnsAnObject]; // this method must return an id; BOOLs are a problem
//   assert_equal(expected, actual);
// }

- (void) test_reject_when_array_is_empty {
  id array = [NSArray new];
  id expected = [NSArray new];
  id actual = [[array reject] isEmpty];
  assert_equal(expected, actual);
}

- (void) test_sortBy_with_strings {
  id one = [[ValueTestClass alloc] initWith:1];  
  id twentyOne = [[ValueTestClass alloc] initWith:21];
  id twentyTwo = [[ValueTestClass alloc] initWith:22];
  id three = [[ValueTestClass alloc] initWith:3];
  
	id array = [NSArray withVargs:twentyTwo, twentyOne, three, one, nil];   
	id expected = [NSArray withVargs:one, twentyOne, twentyTwo, three, nil];   
  assert_equal(expected, [array sortBy:@"description"]);
}

- (void) test_sortBy_with_ints {
  id one = [[ValueTestClass alloc] initWith:1];  
  id twentyOne = [[ValueTestClass alloc] initWith:21];
  id twentyTwo = [[ValueTestClass alloc] initWith:22];
  id three = [[ValueTestClass alloc] initWith:3];
  
	id array = [NSArray withVargs:twentyTwo, twentyOne, three, one, nil];   
	id expected = [NSArray withVargs:one, three, twentyOne, twentyTwo, nil];   
  assert_equal(expected, [array sortBy:@"value"]);
}

- (void) test_sortBy_with_an_empty_array {
  assert_equal([[NSArray alloc] init], [[[NSArray alloc] init] sortBy:@"count"]);
}

- (void) test_top {
  id array = [NSArray withVargs:@"foo", @"bar", nil]; 
  assert_equal(@"foo", [array peek]);
  assert_equal(@"foo", [array peek]);
  array = [NSMutableArray withVargs:@"foo", @"bar", nil]; 
  assert_equal(@"foo", [array peek]);
  [array pop];
  assert_equal(@"bar", [array peek]);
}

- (void) test_withVargs_constructs_reference_to_NSArray_object {
	id array = [NSArray withVargs:@"a", @"b", nil]; 
	assert_true([array isKindOf:[NSArray class]]);
}

- (void) test_withVargs_with_0_items {
  id array = [NSArray withVargs:nil];
  assert_equal_ints(0, [array count]);
}

- (void) test_withVargs_with_nil_equals_other_with_nil {
  id first = [NSArray withVargs:nil];
  id second = [NSArray withVargs:nil];
  assert_equal(first, second);
}

- (void) test_withVargs_with_1_item {
  id array = [NSArray withVargs:@"foo", nil];
  assert_equal_ints(1, [array count]);
  assert_equal(@"foo", [array at:0]);
}

- (void) test_withVargs_with_2_items {
  id array = [NSArray withVargs:@"foo", @"bar", nil];
  assert_equal_ints(2, [array count]);
  assert_equal(@"foo", [array at:0]);
  assert_equal(@"bar", [array at:1]);
}

@implementation ValueTestClass 

+ (id) one {
  return [[[self alloc] initWith:1] autorelease];
}

- (id) initWith: (int)value {
  if (self = [super init]) {
    _value = value;
  }
  return self;
}

- (int) addObjectToValue: (id)foo {
  return _value += intValue(foo);
}

- (int) addObjectsToValue: (id)foo bar: (id)bar {
  return _value = _value + intValue(foo) + intValue(bar);
}

- (int) addIntsToValue: (int)foo bar: (int)bar baz: (int)baz {
  return _value = _value + foo + bar + baz;
}

- (id) description {
  return [XString withFormat:@"%d", _value];
}

- (int) double {
  _value = _value * 2;
  return _value;
}

- (BOOL) isEqual: (id)other {
  return _value == [other value];
}

- (int) value {
  return _value;
}

@end
