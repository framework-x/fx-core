#import "TestHelper.h"

// todo: z: where is this needed?
// todo: z: let's try to come up with a better name for this and NSObject+Test
@interface NSObjectTestTest : XTestCase {}

+ (id) classMeth1;

+ (id) classMeth1;

- (id) bar;

- (id) foo;

@end

@implementation NSObjectTestTest

+ (id) classMeth1 {
  return @"classy1";
}

+ (id) classMeth2 {
  return @"classy2";
}

- (void) test_stubMethod_with_instance_method {
  assert_equal(@"foo", [self foo]);
  
  id memento = [StubbedMethodMemento named:@"foo" withPreviousImp:[[self getMethod:@"foo"] imp] for:self];
  [self stubMethod:@"foo" with: [self getMethod:@"bar"]];
  assert_equal(@"bar", [self foo]);
  assert_equal(memento, [[StubbedMethodMementoCollection _mementos] first]);
}

- (void) test_stubMethod_with_class_method {
  assert_equal(@"classy1", [[self class] classMeth1]);
  
  id memento = [StubbedMethodMemento named:@"classMeth1" withPreviousImp:[[[self class] getMethod:@"classMeth1"] imp] for:[self class]];
  [[self class] stubMethod:@"classMeth1" with: [[self class]getMethod:@"classMeth2"]];
  assert_equal(@"classy2", [[self class] classMeth1]);
  assert_equal(memento, [[StubbedMethodMementoCollection _mementos] first]);
}

- (id) bar {
  return @"bar";
}

- (id) foo {
  return @"foo";
}

@end
