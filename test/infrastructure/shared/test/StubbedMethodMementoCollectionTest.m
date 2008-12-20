#import "TestHelper.h"

@interface StubbedMethodMementoCollectionTest : XTestCase {}
@end

@implementation StubbedMethodMementoCollectionTest

- (void) test_StubbedMethodMementoCollection_gets_initialized_correctly {
  assert_equal([XArray empty], [StubbedMethodMementoCollection _mementos]);
}

- (void) test_add {
  id first = [StubbedMethodMemento named:@"test_add" withPreviousImp:[[self getMethod:@"test_add"] imp] for:self];
  [StubbedMethodMementoCollection add:first];
  assert_equal(first, [[StubbedMethodMementoCollection _mementos] first]);  
}

@end
