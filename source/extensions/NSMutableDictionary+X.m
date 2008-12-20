#import "NSMutableDictionary+X.h"
#import "XCore.h"

/*
@interface NSMutableDictionary (X)
@end
*/

@implementation NSMutableDictionary (X)

// instance methods

- (id) add: (id)key value:(id)value {
  [self setObject:value forKey:key];
  return self;
} 

- (id) addKey: (id)key withValue:(id)value {
  [self setObject:value forKey:key];
  return self;
} 

- (BOOL) containsKey: (id)key {
  return [self hasKey:key];
}

- (id) clear {
  [self removeAllObjects];
  return self;
}

- (id) delete: (id)key {
  [self removeObjectForKey:key];
  return self;
}

- (id) empty {
  return [self clear];
}

- (BOOL) hasKey: (id)key {
  return [self objectForKey:key] != nil;
}

- (id) merge: (id)hash {
  [self addEntriesFromDictionary:hash];
  return self;
}

- (id) remove: (id)key {
  id value = [self get:key];
  [self removeObjectForKey:key];
  return value;
}

- (id) set: (id)key to:(id)value {
	return [self add:key value:value];
}

@end
