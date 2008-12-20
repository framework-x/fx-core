#import "TestHelper.h"

#include <stdlib.h>
#include <sys/time.h>


@interface Delegate1 : XObject {} @end
@implementation Delegate1 @end

@interface XObjectTestClass : XObject {} @end

@implementation XObjectTestClass 
+ (void) initialize {
  [self attrAccessors:@"accessor1", @"accessor2", nil];
  [self attrReaders:@"reader1", @"reader2", nil];
  [self attrWriters:@"writer1", @"writer2", nil];
}
@end

@interface XObjectTest : XTestCase {} @end

@implementation XObjectTest


- (void) test_hasDelegations_returns_1 {
  id obj = [[XObject alloc] init];
  assert_equal_ints(1, [obj _hasDelegations]);
}

- (void) test_attrAccessors {
  id object = [XObjectTestClass new];
  assert_equal(nil, [object accessor1]);
  assert_equal(nil, [object accessor2]);
  [object setAccessor1:@"foo"];
  [object setAccessor2:@"bar"];
  assert_equal(@"foo", [object accessor1]);
  assert_equal(@"bar", [object accessor2]);
}

- (void) test_attrAccessors_setting_to_nil_works {
  id object = [XObjectTestClass new];
  [object setAccessor1:nil];
  [object setAccessor2:nil];
  assert_equal(nil, [object accessor1]);
  assert_equal(nil, [object accessor2]);
}

- (void) test_attrReaders {
  id object = [XObjectTestClass new];
  assert_equal(nil, [object reader1]);
  assert_equal(nil, [object reader2]);
  id underlyingHash = [object _attributes];
  [underlyingHash set:@"reader1" to:@"foo"];
  [underlyingHash set:@"reader2" to:@"bar"];
  assert_equal(@"foo", [object reader1]);
  assert_equal(@"bar", [object reader2]);
  assert_throws(NSException, [object setReader1:@"baz"]);
  assert_throws(NSException, [object setReader2:@"baz"]);
}

- (void) test_attrWriters {
  id object = [XObjectTestClass new];
  id underlyingHash = [object _attributes];  
  [object setWriter1:@"foo"];
  [object setWriter2:@"bar"];
  assert_equal(@"foo", [underlyingHash get:@"writer1"]);
  assert_equal(@"bar", [underlyingHash get:@"writer2"]);
  assert_throws(NSException, [object writer1]);
  assert_throws(NSException, [object writer2]);
}

- (void) test_init_initializes_delegates_to_an_empty_array {
  id obj = [[XObject alloc] init];
  assert_equal([XArray empty], [obj _delegates]);
}

- (void) test_init_initializes_specific_delegations_to_an_empty_hash {
  id obj = [[XObject alloc] init];
  assert_equal_ints(0, [[obj _delegations] count]);
}

@end



