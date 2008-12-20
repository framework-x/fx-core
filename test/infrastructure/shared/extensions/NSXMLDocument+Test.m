#import "NSXMLDocument+Test.h"

#import "FrameworkX.h"

// @interface NSXMLDocument (Test)
// @end

@implementation NSXMLDocument (Test)

// public class methods

// creates an XML Document of the form that is returned by rails
+ (id) with: (id)arrayOfStrings {
  id xmlString = [@"\n  " append:[arrayOfStrings join:@"\n    "]];
  [xmlString append:@"\n  "];
  id err = nil;
  id result = [[NSXMLDocument alloc] initWithXMLString:xmlString options: (NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA) error: &err];
  if (err) {
    NSLog(@"Error creating NSXMLDocument: %@", [err localizedDescription]);
  }
  return result;
}

@end
