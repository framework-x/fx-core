#import "NSMutableString+X.h"

#import "XCore.h"

/*
#import "XCore.h"

@interface NSMutableString (X)
@end
*/

@implementation NSMutableString (X)

// z: unfortunately we can't use NSMutable's appendString method because, inexplicably, non-mutable strings call this method on themselves; I blame NSCFString
- (id) append: (id)string {
  return [XString with:self, string, nil];
}

- (id) delete: (id)string {
  [self replaceOccurrencesOfString:string withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [self length])];
  return self;
}

- (id) insert: (id)str at: (NSUInteger)index {
  [self insertString:str atIndex:index];
  return self;
}

- (id) prepend: (id)str {
  [self insertString:str atIndex:0];
  return self;
}

- (id) removeWhitespace {
  [self replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
  [self replaceOccurrencesOfString:@"\t" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
  [self replaceOccurrencesOfString:@"\r" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
  [self replaceOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
  
  return self;
}

@end
