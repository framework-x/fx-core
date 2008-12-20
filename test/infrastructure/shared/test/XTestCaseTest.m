#import "TestHelper.h"

@interface XTestCaseTest : XTestCase {}

- (id) bar;

- (id) foo;

@end

@implementation XTestCaseTest

- (void) test_teardown_reverts_stubbed_method_1 {
  id memento = [StubbedMethodMemento named:@"foo" withPreviousImp:[[self getMethod:@"foo"] imp] for:self];
  [self stubMethod:@"foo" with: [self getMethod:@"bar"]];
  assert_equal(@"bar", [self foo]);
  assert_equal(memento, [[StubbedMethodMementoCollection _mementos] first]);
}

- (void) test_teardown_reverts_stubbed_method_2 {
  assert_equal(@"foo", [self foo]); // z: if tearDown isn't working this assert or the one in test_stubMethod_class_method_1 should fail
  
  id memento = [StubbedMethodMemento named:@"foo" withPreviousImp:[[self getMethod:@"foo"] imp] for:self];
  [self stubMethod:@"foo" with: [self getMethod:@"bar"]];
  assert_equal(@"bar", [self foo]);
  assert_equal(memento, [[StubbedMethodMementoCollection _mementos] first]);
}

- (id) bar {
  return @"bar";
}

- (id) foo {
  return @"foo";
}


@end
