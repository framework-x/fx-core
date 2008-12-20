#import "XCore.h"


@interface StubbedMethodMementoCollection : XObject {}

// public class methods
+ (id) add: (id)memento;

+ (id) revertAll;

// protected class methods

+ (id) _mementos;

@end
