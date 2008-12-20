#import "NSMutableArray+X.h"
#import "XCore.h"

/*
#import "XCore.h"

@interface NSMutableArray (X)
@end
*/

@implementation NSMutableArray (X)

+ (id) with: (id)firstItem vaList: (va_list)argList {
  return [[[self alloc] initWith:firstItem vaList:argList] autorelease];
}

- (id) initWith: (id)firstItem vaList: (va_list)argList {
  if (self = [self init]) {
    id item;
    if (firstItem) {
      [self addObject:firstItem];
      while (item = va_arg(argList, id)) {
        [self addObject:item];
      }
    }
  }
  return self;
}

- (id) initWithVargs: (id)firstItem, ... {
  va_list argList; 
  va_start(argList, firstItem);
  id array = [self initWith:firstItem vaList:argList];
  va_end(argList); 
  return array;
}

// public instance methods

- (id) add: (id)item {
  [self addObject:item];
  return self;
}

- (id) append: (id)item {
  return [self add:item];
}

- (id) appendArray: (id)array {
  [self addObjectsFromArray:array];
  return self;
}

- (id) clear {
  [self removeAllObjects];
  return self;
}

- (id) delete: (id)object {
  [self removeObject:object];
  return self;
}

- (id) remove: (id)object {
  if ([self contains:object]) {
    [self removeObject:object];
    return object;
  }
  return nil;
}

- (id) reverse {
  id temp = [[NSMutableArray class] empty];
  for (id object in [self reverseObjectEnumerator]) {
    [temp add:object];
  }
  [self clear];
  for (id object in temp) {
    [self add:object];
  }
  return self;
}

@end
