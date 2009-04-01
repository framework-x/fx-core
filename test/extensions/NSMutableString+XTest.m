#import "TestHelper.h"


@interface NSMutableStringXTest : XTestCase {}
@end

@implementation NSMutableStringXTest

- (void) test_delete {
  id string = [NSMutableString stringWithCapacity:20];
  [string appendString:@"fooboo"];
  [string delete:@"o"];
  assert_equal(@"fb", string);
}

- (void) test_delete_when_string_does_not_exist {
  id string = [NSMutableString stringWithCapacity:20];
  [string appendString:@"foo"];
  [string delete:@"z"];
  assert_equal(@"foo", string);
}

- (void) test_insertAt {
  id str = [NSMutableString empty];
  assert_equal(@"", str);
  assert_equal(@"foo", [str insert:@"foo" at:0]);
  assert_equal(@"foobaz", [str insert:@"baz" at:3]);
  assert_equal(@"foobarbaz", [str insert:@"bar" at:3]);
}

- (void) test_prepend {
  id str = [NSMutableString empty];
  assert_equal(@"baz", [str prepend:@"baz"]);
  assert_equal(@"baz", str);
  assert_equal(@"barbaz", [str prepend:@"bar"]);
  assert_equal(@"barbaz", str);
  assert_equal(@"foobarbaz", [str prepend:@"foo"]);
  assert_equal(@"foobarbaz", str);
}

- (void) test_removeWhitespace {
  id str = [NSMutableString empty];
  [str removeWhitespace];
  assert_equal(@"", str);
  
  str = [NSMutableString from:@" "];
  [str removeWhitespace];
  assert_equal(@"", str);

  str = [NSMutableString from:@" a "];
  [str removeWhitespace];
  assert_equal(@"a", str);

  str = [NSMutableString from:@" a b c"];
  [str removeWhitespace];
  assert_equal(@"abc", str);
  
  str = [NSMutableString from:@"  a  b  c  "];
  [str removeWhitespace];
  assert_equal(@"abc", str);
  
  str = [NSMutableString from:@"\ta b\rc\r\n"];
  [str removeWhitespace];
  assert_equal(@"abc", str);  
}

- (void) test_replaceWith {
  id string = [NSMutableString stringWithCapacity:20];
  [string appendString:@"foobar"];
  [string replace:@"bar" with:@"baz"];
  assert_equal(@"foobaz", string);
}

- (void) test_replaceWith_when_empty {
  id string = [NSMutableString string];
  [string replace:@"foo" with:@"bar"];
  assert_equal(@"", string);
}

- (void) test_replaceWith_when_string_not_found {
  id string = [NSMutableString string];
  [string appendString:@"foo"];
  [string replace:@"bar" with:@"baz"];
  assert_equal(@"foo", string);
}

@end
