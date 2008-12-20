#import "TestHelper.h"
#import "NSXMLDocument+Test.h"

@interface NSXMLDocumentTestTest : XTestCase {}
@end

@implementation NSXMLDocumentTestTest

- (void) test_with {
  id xmlArray = [XArray withVargs:  
    @"<artist-resource>",
      @"<name>Chuck Berry</name>",
    @"</artist-resource>",
    nil
  ];
  id xmlString = [@"\n  " append:[xmlArray join:@"\n    "]];
  [xmlString append:@"\n  "];

  id err = nil;
  id expected = [[NSXMLDocument alloc] initWithXMLString: xmlString options: (NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA) error: &err];
  
  assert_equal(expected, [NSXMLDocument with:xmlArray]);
}

@end
