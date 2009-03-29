#import "TestHelper.h"

#import "_XParameterSet.h"

@interface NSObjectXTest : XTestCase {
  id _asyncHelper;
  int _callbackValue;
  int _counter;
}

+ (id) replacingMethod;

- (id) echo: (id)firstItem, ...;

- (id) goodBye;

- (id) replacingMethod: (id)value;

@end

@interface NSObjectXTestClass : NSObject {
	id _foo;
	id _bar;
  BOOL _bool1;
  BOOL _bool2;
} 
static id classLevelVariable;

+ (id) replaceableMethod;

- (id) bar;
- (void) bar: (id)value;
- (id) foo;
- (void) foo: (id)value;
- (id) replaceableMethod: (id)value;

@end

// todo: z: rename and consolidate with NSObjectXTestClass too
@interface NSObjectXTestClass1 : NSObject {
  id _foo;
  id _bar;
} @end

@interface NSObjectXTestClass2 : XObject {
  id foo;
  id _bar;
} @end

@interface NSObjectXTestClass3 : XObject {
  id foo;
  id _bar;
} @end


@implementation NSObjectXTest

- (void) test_addInstanceMethod {
  id object = [NSObjectXTestClass new];
  assert_throws(NSException, [object hello]);
  assert_true([NSObjectXTestClass addInstanceMethod:[self getMethod:@"hello"]]);
  assert_equal(@"hello", [object hello]);
}

- (void) test_addMethod_on_class {
  assert_throws(NSException, [NSObjectXTestClass goodBye]);
  assert_true([NSObjectXTestClass addMethod:[self getMethod:@"goodBye"]]);
  assert_equal(@"good bye", [NSObjectXTestClass goodBye]);
}

- (void) test_addMethod {
  id object = [NSObjectXTestClass new];
  assert_throws(NSException, [object goodbye]);
  assert_true([object addMethod:[self getMethod:@"goodBye"]]);
  assert_equal(@"good bye", [object goodBye]);
}

- (void) test_addMethod_imp_methodTypes {
  id object = [NSObjectXTestClass new];
  assert_throws(NSException, [object adios]);
  id method = [self getMethod:@"goodBye"];
  IMP imp = [method imp];
  const char* methodTypes = [method methodTypes];
  assert_true([object addMethod:@"adios" imp:imp methodTypes:methodTypes]);
  assert_equal(@"good bye", [object adios]);  
}

- (void) test_addMethod_imp_methodTypes_with_1_variable_arg {
  id object = [NSObjectXTestClass new];
  assert_throws(NSException, [object echo1:nil]);
  id method = [self getMethod:@"echo:"];
  IMP imp = [method imp];
  const char* methodTypes = [method methodTypes];
  assert_true([object addMethod:@"echo1:" imp:imp methodTypes:methodTypes]);
  id actual = [object echo1:@"hello", nil];
  assert_equal(@"hello", actual);  
}

- (void) test_addMethod_imp_methodTypes_with_2_variable_args {
  id object = [NSObjectXTestClass new];
  assert_throws(NSException, [object echo2:nil]);
  id method = [self getMethod:@"echo:"];
  IMP imp = [method imp];
  const char* methodTypes = [method methodTypes];
  assert_true([object addMethod:@"echo2:" imp:imp methodTypes:methodTypes]);
  id actual = [object echo2:@"hello", @"world", nil];
  assert_equal(@"hello world", actual);  
}

- (void) test_addMethod_imp_methodTypes_with_3_args {
  id object = [NSObjectXTestClass new];
  assert_throws(NSException, [object one:nil two:nil three:nil]);
  id method = [self getMethod:@"echo:"];
  IMP imp = [method imp];
  const char* methodTypes = [method methodTypes];
  assert_true([object addMethod:@"one:two:three:" imp:imp methodTypes:methodTypes]);
  assert_equal(@"hey world", [object one:@"hey" two:@"world" three:nil]);
}

- (void) test_addMethod_imp_methodTypes_with_1_arg {
  id object = [NSObjectXTestClass new];
  assert_throws(NSException, [object parroting:nil]);
  id method = [self getMethod:@"echo:"];
  IMP imp = [method imp];
  const char* methodTypes = [method methodTypes];
  assert_true([object addMethod:@"parroting:" imp:imp methodTypes:methodTypes]);
  assert_equal(@"", [object parroting:nil]);  
}

- (void) test_addMethod_imp_methodTypes_with_2_args {
  id object = [NSObjectXTestClass new];
  assert_throws(NSException, [object one:nil two:nil]);
  id method = [self getMethod:@"echo:"];
  IMP imp = [method imp];
  const char* methodTypes = [method methodTypes];
  assert_true([object addMethod:@"one:two:" imp:imp methodTypes:methodTypes]);
  assert_equal(@"hello", [object one:@"hello" two:nil]);
}

- (void) test_aliasAs_on_a_class {
  [NSObjectXTestClass alias:@"replaceableMethod" as:@"aliasedMethod"];
  assert_equal(@"a classy hello", [NSObjectXTestClass aliasedMethod]);
}

- (void) test_aliasAs_on_an_instance {
  id object = [NSObjectXTestClass new];
  [object alias:@"replaceableMethod:" as:@"aliasedMethod:"];
  assert_equal(@"hello world", [object aliasedMethod:@"world"]);
}

- (void) test_aliasAs_replaces_method_even_if_it_already_exists {
  id object = [NSObjectXTestClass new];
  [object bar:@"bar"];
  [object foo:@"foo"];
  assert_equal(@"bar", [object bar]);
  assert_equal(@"foo", [object foo]);
  
  // z: so we can clean up after ourselves
  [object alias:@"bar" as:@"temp"];
  assert_equal(@"bar", [object temp]);
  [object alias:@"foo" as:@"bar"];
  assert_equal(@"foo", [object bar]);
  
  // z: clean up after ourselves
  [object alias:@"temp" as:@"bar"];
  assert_equal(@"bar", [object bar]);  
}

- (void) test_aliasInstanceMethodAs {
  id object = [NSObjectXTestClass new];
  [NSObjectXTestClass aliasInstanceMethod:@"replaceableMethod:" as:@"aliasedInstanceMethod:"];
  assert_equal(@"hello friend", [object aliasedInstanceMethod:@"friend"]);
}

- (void) test_ivarAccessors {
	id obj = [NSObjectXTestClass1 new];
  assert_equal(nil, [obj foo]);  
  assert_equal(nil, [obj bar]);  
  [obj setFoo:@"hello"];
  assert_equal(@"hello", [obj foo]);
  [obj setBar:@"world"];
  assert_equal(@"world", [obj bar]);
}

- (void) test_ivarAccessor_set_to_nil_returns_nil {
  id obj =[NSObjectXTestClass1 new];
  [obj setFoo:nil];
  [obj setBar:nil];
  assert_nil([obj foo]);  
  assert_nil([obj bar]);  
}

- (void) test_ivarReaders {
  id obj = [NSObjectXTestClass2 new];
  assert_equal(nil, [obj foo]);  
  assert_equal(nil, [obj bar]);  

  [obj _foo:@"hello"];
  [obj _bar:@"world"];
  
  assert_equal(@"hello", [obj foo]);
  assert_equal(@"world", [obj bar]);
  assert_throws(NSException, [obj setFoo:@"foo"]);
  assert_throws(NSException, [obj setBar:@"bar"]);
}

- (void) test_ivarWriters {
  id obj = [NSObjectXTestClass3 new];

  [obj setFoo:@"hello"];
  [obj setBar:@"world"];

  assert_equal(@"hello", [obj _getFoo]);
  assert_equal(@"world", [obj _getBar]);
  
  assert_throws(NSException, [obj foo]);
  assert_throws(NSException, [obj bar]);  
}

- (void) test_ivarWriter_set_to_nil_returns_nil {
  id obj =[NSObjectXTestClass3 new];
  [obj setFoo:nil];
  [obj setBar:nil];
  assert_nil([obj _getFoo]);  
  assert_nil([obj _getBar]);  
}

- (void) test_ivarWriter_set_to_nil_can_be_set_again {
  id obj =[NSObjectXTestClass3 new];
  [obj setBar:nil];
  assert_nil([obj _getBar]);  
  [obj setBar:@"hello"];
  assert_equal(@"hello", [obj _getBar]); 
}

- (void) test_exception_is_thrown_when_method_does_not_exist {
	id obj = [[XObject alloc] init];
  assert_throws(NSException, [obj some_method_that_does_not_exist]);
}

- (void) test_forwardTo_on_instance_forwards_to_the_designated_object {
	id object = [[XObject alloc] init];
	id delegate = @"Hello World";
	[object forwardTo:delegate];
	id result = [object downcase];
  assert_equal(@"hello world", result);	
}

// todo: z: this test is broken and it's unclear if we really want its functionality
// - (void) test_forwardTo_on_class_forwards_to_the_designated_object {
//  id object = [[XObject alloc] init];
//  id delegate = @"Hello World";
//   [XObject forwardTo:delegate];
//  id result = [object downcase];
//   assert_equal(@"hello world", result);  
// }

- (void) test_forwardTo_on_instance_can_delegate_to_multiple_objects {
	id obj = [[XObject alloc] init];
	id delegate = @"Hello World";
	id anotherDelegate = XArrayWith(@"foo", nil);	
	[obj forwardTo:delegate];
	[obj forwardTo:anotherDelegate];	
	id first_result = [obj downcase];
  assert_equal(@"hello world", first_result);	
	id second_result = [obj first];
  assert_equal(@"foo", second_result);
}

- (void) test_forwardTo_on_instance_forwards_to_first_delegate_if_multiple_delegates_respond_to_same_method {
	id object = [[XObject alloc] init];
	id delegate = @" Hello World ";
	id anotherDelegate = @"Goodbye Cruel World";	
	[object forwardTo:delegate];
	[object forwardTo:anotherDelegate];	
	id first_result = [object downcase];
  assert_equal(@" hello world ", first_result);	
	id second_result = [object trimmed];
  assert_equal(@"Hello World", second_result);  
}

- (void) test_forward_forwards_to_the_designated_object_and_method {
  id object = [[XObject alloc] init];
  id delegate = @"Hello World";
  [object forward:@"downcase" to:delegate];
  id result = [object downcase];
  assert_equal(@"hello world", result);
}

- (void) test_forwardAll_forwards_to_the_designated_object_and_methods {
  id object = [[XObject alloc] init];
  id delegate = @"Hello World";
  [object forwardTo:delegate methods:@"downcase", @"asCamelCase", nil ];
  assert_equal(@"hello World", [object asCamelCase]);
  assert_equal(@"hello world", [object downcase]);
}

- (void) test_forward_forwards_a_method_with_a_parameter {
	id obj = [[XObject alloc] init];
	id delegate = @"hello";
	[obj forward:@"append:" to:delegate];
	id result = [obj append:@" world"];
  assert_equal(@"hello world", result);
}

- (void) test_forward_forwards_a_method_with_two_parameters {
	id object = [[XObject alloc] init];
	id delegate = @"hello world";
	[object forward:@"substring:length:" to:delegate];
	id result = [object substring:3 length:5];
  assert_equal(@"lo wo", result);
}

- (void) test_forward_can_forward_to_different_methods_on_different_objects {
	id object = [[XObject alloc] init];
  id delegate = @"Hello World";
	id anotherDelegate = @"pant";	
	[object forward:@"downcase" to:delegate];
	[object forward:@"pluralize" to:anotherDelegate];	
	id first_result = [object downcase];
  assert_equal(@"hello world", first_result);
	id second_result = [object pluralize];
  assert_equal(@"pants", second_result);	
}

- (void) test_getInstanceVariable {
  id object = [NSObjectXTestClass new];
  [object foo:@"hello world"];
  assert_equal(@"hello world", [object getInstanceVariable:@"_foo"]);
}

- (void) test_getInstanceVariable_returns_nil_if_variable_doesnt_exist {
  id object = [NSObjectXTestClass new];
  assert_equal(nil, [object getInstanceVariable:@"garbage_variable_that_doesnt_exist"]);
}

- (void) test_getInstanceMethod {
  SEL selector = NSSelectorFromString(@"foo");
  Method underlyingMethod = class_getInstanceMethod([NSObjectXTestClass class], selector);
  assert_true(underlyingMethod != NULL);
    
  id method = [NSObjectXTestClass getInstanceMethod:@"foo"];

  assert_equal(underlyingMethod, [method method]);  
}

- (void) test_getMethod_on_a_class {
  SEL selector = NSSelectorFromString(@"replaceableMethod");
  Method underlyingMethod = class_getClassMethod([NSObjectXTestClass class], selector);
  assert_true(underlyingMethod != NULL);
    
  id method = [NSObjectXTestClass getMethod:@"replaceableMethod"];

  assert_equal(underlyingMethod, [method method]);
}

- (void) test_getMethod_on_an_instance {
  id object = [NSObjectXTestClass new];
  SEL selector = NSSelectorFromString(@"foo:");
  Method underlyingMethod = class_getInstanceMethod([object class], selector);
  assert_true(underlyingMethod != NULL);
  
  id method = [object getMethod:@"foo:"];

  assert_equal(underlyingMethod, [method method]);
}

- (void) test_initWithHash {
	id object = [[NSObjectXTestClass alloc] initWithHash:[XHash withVargs:@"foo", @"dinner", @"bar", @"ready", nil]];
	assert_equal(@"dinner", [object foo]);
	assert_equal(@"ready", [object bar]);    
}

- (void) test_initWithHash_with_nil_value {
	id object = [[NSObjectXTestClass alloc] initWithHash:[XHash withVargs:@"foo", nullObject, @"bar", @"world", nil]];
	assert_nil([object foo]);
	assert_equal(@"world", [object bar]);    
}

- (void) test_initWithHash_with_bool_values {
	id object = [[NSObjectXTestClass alloc] initWithHash:[XHash withVargs:@"foo", @"hello", @"bool1", trueObject, @"bool2", falseObject, nil]];
	assert_equal(@"hello", [object foo]);
	assert_true([object bool1]);
	assert_false([object bool2]);
}

- (void) test_instanceOf {
  id object = [XObject new];
  assert_true([object instanceOf:[XObject class]]);
  assert_true([object instanceOf:[NSObject class]]);
}

- (void) test_isa {
  assert_true([[XArray empty] isa:[XArray class]]);
  assert_true([[XArray empty] isa:[NSArray class]]);  
  assert_false([[XArray empty] isa:[NSString class]]);      
}

- (void) test_performMethodOnNewThread {
  _asyncHelper = [[XAsyncTestHelper new] retain];
  [_asyncHelper setResponseReceived:NO];
  [self performMethodOnNewThread:@"setCounterTo2"];
  [_asyncHelper waitForCallback];
  assert_equal_ints(2, _counter);
}

- (void) test_performMethodOnNewThread_callbackMethod {
  _asyncHelper = [[XAsyncTestHelper new] retain];
  [_asyncHelper setResponseReceived:NO];
  [self performMethodOnNewThread:@"setCounterTo3AndReturn4" withCallbackNamed:@"aCallbackMethod:"];
  [_asyncHelper waitForCallback];
  assert_equal_ints(3, _counter);
  assert_equal_ints(4, [_callbackValue intValue]);
}
 
- (void) test_performMethodOnNewThread_callbackMethod_doesnt_crash_if_method_doesnt_have_a_return_value {
  _asyncHelper = [[XAsyncTestHelper new] retain];
  [_asyncHelper setResponseReceived:NO];
  [self performMethodOnNewThread:@"setCounterTo5AndReturnNothing" withCallbackNamed:@"aCallbackMethod:"];
  [_asyncHelper waitForCallback];
  assert_equal_ints(5, _counter);
  assert_nil(_callbackValue);
}

- (void) test_performMethodOnNewThread_withObject {
  _asyncHelper = [[XAsyncTestHelper new] retain];
  [_asyncHelper setResponseReceived:NO];
  [self performMethodOnNewThread:@"setCounterThenResponseReceived:" withObject:intObject(32)];
  [_asyncHelper waitForCallback];
  assert_equal_ints(32, _counter);
}

- (void) test_performMethodOnNewThread_withObject_thats_nil {
  _asyncHelper = [[XAsyncTestHelper new] retain];
  [_asyncHelper setResponseReceived:NO];
  [self performMethodOnNewThread:@"setCounterThenResponseReceived:" withObject:nil];
  [_asyncHelper waitForCallback];
  assert_equal_ints(-1, _counter);
}

- (void) test_performMethodOnNewThread_withObject_withCallbackNamed {
  _asyncHelper = [[XAsyncTestHelper new] retain];
  [_asyncHelper setResponseReceived:NO];
  [self performMethodOnNewThread:@"setCounterTo:" withObject:intObject(23) withCallbackNamed:@"aCallbackMethod:"];
  [_asyncHelper waitForCallback];
  assert_equal_ints(23, _counter);
  assert_equal_ints(9, [_callbackValue intValue]);
}

- (void) test_replaceMethodImplementation_called_on_a_class {
  id object = [[NSObjectXTestClass new] class];
  id replaceableMethod = @"replaceableMethod";
  // z : make sure other tests haven't messed us up
  assert_equal(@"a classy hello", [object replaceableMethod]);
  
  // z: hold onto replaceableMethod so we can clean up after ourselves
  [NSObjectXTestClass alias:replaceableMethod as:@"tempMethod"];
  
  [NSObjectXTestClass replaceMethodImplementation:replaceableMethod with:[[self class] getMethod:@"replacingMethod"]];
  assert_equal(@"a classy goodbye", [NSObjectXTestClass replaceableMethod]);
  
  // z: clean up after ourselves
  [NSObjectXTestClass replaceMethodImplementation:replaceableMethod with:[NSObjectXTestClass getMethod:@"tempMethod"]];
  assert_equal(@"a classy hello", [NSObjectXTestClass replaceableMethod]);
}

- (void) test_replaceMethod_called_on_an_instance {
  id object = [NSObjectXTestClass new];
  // z: hold onto replaceableMethod so we can clean up after ourselves
  id replaceableMethod = @"replaceableMethod:";

  // z : make sure other tests haven't messed us up
  assert_equal(@"hello and hi", [object replaceableMethod:@"and hi"]);
  [object alias:replaceableMethod as:@"tempMethod:"];
    
  [object replaceMethodImplementation:replaceableMethod with:[self getMethod:@"replacingMethod:"]];
  assert_equal(@"goodbye now", [object replaceableMethod:@"now"]);
  
  // z: clean up after ourselves
  [object replaceMethodImplementation:replaceableMethod with:[object getMethod:@"tempMethod:"]];
  assert_equal(@"hello hello", [object replaceableMethod:@"hello"]);
}

- (void) test_setAttributes {
  id object = [NSObjectXTestClass new];
  id actual = [object _setAttributes:[XHash withVargs:@"foo", @"hello", @"bar", @"world", nil]];
  assert_equal(object, actual);
  assert_equal(@"hello", [object foo]);
  assert_equal(@"world", [object bar]);
}

- (void) test_setInstanceVariable {
  id object = [NSObjectXTestClass new];
  [object setInstanceVariable:@"_foo" to:@"hello world"];
  assert_equal(@"hello world", [object foo]);
}

- (void) test_setInstanceVariable_adjust_retain_counts_correctly {
  id object = [NSObjectXTestClass new];
  id oldValue = [[NSObjectXTestClass alloc] init];
  int oldValueRetainCount = [oldValue retainCount];
  id newValue = [[NSObjectXTestClass alloc] init];
  int newValueRetainCount = [newValue retainCount];
  [object foo:oldValue];
  [object setInstanceVariable:@"_foo" to:newValue];
  assert_equal_ints(oldValueRetainCount, [oldValue retainCount]);
  assert_equal_ints(newValueRetainCount + 1, [newValue retainCount]);
}


+ (id) replacingMethod {
  return @"a classy goodbye";
}

- (id) aCallbackMethod: (id)value {
  _callbackValue = [value retain];
  [_asyncHelper setResponseReceived:YES];
  return self;
}

- (id) echo: (id)firstItem, ... {
  va_list argList; 
  va_start(argList, firstItem);
  id array = [XArray with:firstItem vaList:argList];
  va_end(argList); 
  return [array join:@" "];
}

- (id) goodBye {
  return @"good bye";
}

- (id) hello {
  return @"hello";
}

- (id) replacingMethod: (id)value {
  return [XString withFormat:@"goodbye %@", value];
}

// todo: z: should clean up these helper methods and try to reuse some

- (id) setCounterTo: (id)value {
  _counter = [value intValue];
  return intObject(9);
}

- (id) setCounterThenResponseReceived: (id)value {
  if (value) {
    _counter = [value intValue];
  }
  else {
    _counter = -1;
  }
  [_asyncHelper setResponseReceived:YES];
  return _counter;  
}

- (id) setCounterTo2 {
  _counter = 2;
  [_asyncHelper setResponseReceived:YES];
  return _counter;
}

- (id) setCounterTo3AndReturn4 {
  _counter = 3;
  return intObject(4);
}

- (void) setCounterTo5AndReturnNothing {
  _counter = 5;
}

@end

@implementation NSObjectXTestClass 

+ (void) initialize {
  classLevelVariable = [@"helloWorld" retain];
}

+ (id) new {
  return [[[self alloc] init] autorelease];
}

+ (id) replaceableMethod {
  return @"a classy hello";
}

- (id) bar: (id)value {
	_bar = [value retain];
  return self;
}

- (id) bar {
	return _bar;
}

- (void) foo: (id)value {
	_foo = [value retain];
}

- (id) foo {
	return _foo;
}

- (id) replaceableMethod: (id)value {
  return [XString withFormat:@"hello %@", value];
}

- (id) bool1 {
  return _bool1;
}

- (id) bool2 {
  return _bool2;
}

@end

@implementation NSObjectXTestClass1 

+ (void) initialize {
  [self ivarAccessors:@"foo", @"bar", @"baz", nil];
}

@end

@implementation NSObjectXTestClass2 

+ (void) initialize {
  [self ivarReaders:@"foo", @"bar", @"baz", nil];
}

- (void) _bar: value {
  _bar = [value retain];
}

- (void) _baz: value {
  [_attributes set:@"baz" to:value];
}

- (void) _foo: value {
  foo = [value retain];
}

@end

@implementation NSObjectXTestClass3 

+ (void) initialize {
  [self ivarWriters:@"foo", @"bar", @"baz", nil];
}

- (id) _getBar {
  return _bar;
}

- (id) _getBaz {
  return [_attributes get:@"baz"];
}

- (id) _getFoo {
  return foo;
}

@end
















