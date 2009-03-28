#import "TestHelper.h"

@interface NSFileManagerXTest : XTestCase {}
@end

@implementation NSFileManagerXTest

- (void) test_removeItemAtPathAndLogError_when_file_exists {
  id path = @"test/test_file_that_gets_deleted.txt";
  id file = [XFile open:path];
  [file write:@"I wanna go home, yeah yeah"];
  id manager = [NSFileManager defaultManager];
  assert_true([manager removeItemAtPathAndLogError:path]);
}

- (void) test_removeItemAtPathAndLogError_when_file_does_not_exist {
  id path = @"test/NSFileManagerXTest_file_that_does_not_exist.txt"; 
  id manager = [NSFileManager defaultManager];
  NSLog(@"z: ignore the next NSFileManager logging message. it's just a test...");
  assert_false([manager removeItemAtPathAndLogError:path]);  
}

@end