#import "NSObject+Test.h"
#import "TestHelper.h"

@implementation NSObject (Test) 

- (id) stubMethod: (id)methodName with: (id)xMethod {
  IMP imp = [[self getMethod:methodName] imp];
  id memento = [StubbedMethodMemento named:methodName withPreviousImp:imp for:self];
  [StubbedMethodMementoCollection add:memento];
  [self replaceMethodImplementation:methodName with:xMethod];
  return self;
}


@end
