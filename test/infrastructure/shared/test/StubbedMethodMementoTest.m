#import "TestHelper.h"

@interface StubbedMethodMementoTest : XTestCase {}

- (id) bar;

- (id) foo;

@end

@implementation StubbedMethodMementoTest

 - (void) test_isEqual {
   id first = nil;
   id second = nil;
   
   assert_equal(first, second);
   assert_equal(second, first);
   first = [StubbedMethodMemento named:nil withPreviousImp:NULL for:nil]; 
   assert_not_equal(first, second);
   second = [StubbedMethodMemento named:nil withPreviousImp:NULL for:nil];
   assert_equal(first, second);
   assert_equal(second, first);
   first = [StubbedMethodMemento named:@"foo" withPreviousImp:[[self getMethod:@"foo"] imp] for:self]; 
   assert_not_equal(first, second);
   second = [StubbedMethodMemento named:@"foo" withPreviousImp:[[self getMethod:@"foo"] imp] for:self];  
   assert_equal(first, second);
   assert_equal(second, first);   
 }

- (void) test_revert {
  id memento = [StubbedMethodMemento named:@"foo" withPreviousImp:[[self getMethod:@"foo"] imp] for:self]; 
  assert_equal(@"foo", [self foo]);
  [self stubMethod:@"foo" with: [self getMethod:@"bar"]];
  assert_equal(@"bar", [self foo]);
  
  IMP currentImp = [[self getMethod:@"foo"] imp];
  assert_equal(currentImp, [memento revert]);
  assert_equal(@"foo", [self foo]);
}

- (id) bar {
 return @"bar";
}

- (id) foo {
 return @"foo";
}

@end
