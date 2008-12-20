#import "NSDictionary+X.h"

#import "XCore.h"

/*
@interface NSDictionary (X)
@end
*/

@implementation NSDictionary (X)

// public class methods

- (id) asQueryString {
	id queryStringComponents = [XArray empty];
	for (id key in self) {
    if ([[self get:key] isa:[NSArray class]]) {
      if ([[self get:key] isEmpty]) {
        [queryStringComponents add:[XString withFormat:@"%@=", key]];
      }
	    for(id value in [self get:key]) {
	      [queryStringComponents add:[XString withFormat:@"%@=%@", key, value]];
	    }        
	  }
	  else {
	    [queryStringComponents add:[XString withFormat:@"%@=%@", key, [self get:key]]];	
	  }
	}
  return [[queryStringComponents join:@"&"] urlEncoded];  
}

+ (id) empty {
  return [[[XHash alloc] init] autorelease];
}

+ (id) withPath: (id)path {
  return [[[self alloc] initWithContentsOfFile:path] autorelease];
}

// public instance methods

- (BOOL) containsKey: (id)key {
  return [self hasKey:key];
}

- (id) get: (id)key {
  return [self objectForKey:key];
}

- (BOOL) hasKey: (id)key {
  return [self objectForKey:key] != nil;
}

- (BOOL) isEmpty {
  return [self count] == 0;
}

- (id) without: (id)firstKey, ... {
  va_list argList; 
  va_start(argList, firstKey);
  id keysToExclude = [XArray with:firstKey vaList:argList];
  va_end(argList); 
  return [self withoutKeys:keysToExclude];
}

- (id) withoutKey: (id)key {
  return [[XHash dictionaryWithDictionary:self] delete:key];
}

- (id) withoutKeys: (id)keysToExclude {
  id result = [XHash empty];
  for (id key in self) {
    if (![keysToExclude contains:key]) {
      [result add:key value:[self get:key]];
    }
  }
  return result;
}

@end
