#import "XFile.h"
#import "TestHelper.h"

#define test_file @"test/test_file.txt"

@interface XStringTest : XTestCase {}
@end

@implementation XStringTest

- (void) test_append {
  id string = [XString empty];
  assert_equal(@"foo", [string append:@"foo"]);
}

- (void) test_append_changes_string {
  id string = [XString empty];
  [string append:@"foo"];
  assert_equal(@"foo", string);
}

- (void) test_append_after_append {
  id string = [XString empty];
  assert_equal(@"hello", [string append:@"hello"]);  
  assert_equal(@"hello", string);  
  assert_equal(@"hello ", [string append:@" "]);  
  assert_equal(@"hello ", string);  
  assert_equal(@"hello world", [string append:@"world"]);  
  assert_equal(@"hello world", string);  
}

- (void) test_initWithContentsOfFile {
  assert_equal(@"hello world", [[XString alloc] initWithContentsOfFile:test_file]);
}

- (void) test_initWithContentsOfFile2 {
  assert_equal(@"hello world", [[XString alloc] initWithContentsOfFile:test_file encoding:NSUTF8StringEncoding error:NULL]);
}

- (void) test_inspect {
	id string = [XString with:@"foo", nil];
	id result = [string inspect];
	assert_equal(@"\"foo\"", result);
	assert_true([XString isEqualTo:[result class]]);
}

- (void) test_new {
	assert_equal(@"hello world", [XString from:@"hello world"]);
}
- (void) test_fromPath {                          
  assert_equal(@"hello world", [XString fromContentsAtPath:test_file]);
}

- (void) test_fromCString {
  id string = [XString fromCString:"some c string"];
  assert_equal(@"some c string", string);
}

- (void) test_initWithFormat {
  id actual = [[XString alloc] initWithFormat:@"1 = %@, 2 = %@, 3 = %@", @"one", @"two", @"three"];  
  assert_equal(@"1 = one, 2 = two, 3 = three", actual);
}

- (void) test_asCString {
  const char* string = [[XString with:@"hello world", nil] asCString]; 
  id actual = [NSString stringWithCString:string encoding:NSUTF8StringEncoding];
  assert_equal(@"hello world", actual);
  STAssertEquals(0, strcmp("hello world", string), nil);  
}

- (void) test_with {
  id string = [XString with:@"foo", @" ", @"bar", @" ", @"baz", nil];
  
  assert_equal(@"foo bar baz", string); 
}

- (void) test_withFormat {
  id string = [XString withFormat:@"create table %@(%@, %@)", @"book",  @"pk", @"title"];
  assert_equal(@"create table book(pk, title)", string);
}


@end
