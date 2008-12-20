#import <SenTestingKit/SenTestingKit.h>

#define assert_false(foo)\
  STAssertTrue(foo == NO, @"");

// STAssertEqualObjects uses the isEqual: method e.g. [expected isEqualTo:actual]

#define assert_equal(__expected__, __actual__) \
  STAssertEqualObjects(__actual__, __expected__, nil);
  
#define assert_not_equal(__expected__, __actual__) \
  if (__expected__) { \
    assert_false([__expected__ isEqual:__actual__]); \
  } \
  else { \
    STAssertNotNil(__actual__, @"not expecting both values to be nil"); \
  } \

#define assert_equal_arrays(__expecteds__, __actuals__)\
	if (![XArray isEqualTo:[__expecteds__ class]] || ![XArray isEqualTo:[__actuals__ class]]) {\
  	STAssertTrue([__expecteds__ instanceOf: [NSArray class]], [XString withFormat:@"The expected value was not an XArray. It was a <%@>", [__expecteds__ class]]);\
    STAssertTrue([__actuals__ instanceOf:[NSArray class]], [XString withFormat:@"The actual value was not an XArray. It was a <%@>", [__actuals__ class]]);\
		return;\
	}\
	if ([__expecteds__ count] != [__actuals__ count]) {\
		STAssertEquals((int)[__expecteds__ count], (int)[__actuals__ count], @"arrays were not of the same size");\
		return;\
	}\
	int index = 0;\
	id __expected__;\
	id __actual__;\
	while (index < [__expecteds__ count]) {\
		__expected__ = [__expecteds__ objectAtIndex:index];\
		__actual__ = [__actuals__ objectAtIndex:index];\
		STAssertEqualObjects(__expected__, __actual__, [XString withFormat:@"Arrays differed at index: %d", index]);\
		index = index + 1;\
	}\

#define assert_equal_doubles(expected, actual)\
  STAssertEqualObjects(doubleObject(actual), doubleObject(expected), nil);

#define assert_equal_ints(expected, actual)\
  STAssertEquals((int)actual, (int)expected, nil);

#define assert_equal_values(expected, actual)\
  STAssertEquals(actual, expected, nil);

#define assert_in_delta(__expected__, __actual__, __delta__)\
	STAssertEqualsWithAccuracy(__expected__, __actual__, __delta__, @"");
	
#define assert_nil(foo)\
   STAssertNil(foo, @"");

#define assert_not_nil(foo)\
   STAssertNotNil(foo, @"");

#define assert_not_nil_or_null(foo)\
   assert_not_equal(nullObject, foo);\
   STAssertNotNil(foo, @"");

#define assert_nothing_thrown(method_call)\
   STAssertNoThrow(method_call, @"");
#define assert_throws_something(thing_that_should_throw_an_exception)\
  STAssertThrows(thing_that_should_throw_an_exception, @"expected an exception, but one was not thrown");

#define assert_throws(exception, thing_that_should_throw_an_exception)\
  STAssertThrowsSpecific(thing_that_should_throw_an_exception, exception, @"");

#define assert_true(foo)\
  STAssertTrue(foo == YES, @"");
