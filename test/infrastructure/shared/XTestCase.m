#import "XTestCase.h"
#import "Infrastructure.h"

@implementation XTestCase

- (void) tearDown {
  [StubbedMethodMementoCollection revertAll];
}

@end
