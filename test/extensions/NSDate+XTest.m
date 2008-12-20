#import "TestHelper.h"

#import </usr/include/objc/objc-class.h>

@interface NSDateXTest : XTestCase {}
@end

@implementation NSDateXTest

+ (id) stubDate {
  return nil;
}

- (void) test_isEarlierThan {
  id now = [NSDate now];
  id later = [NSDate dateWithTimeIntervalSinceNow:4];
  
  assert_true([now isEarlierThan:later]);
  assert_false([later isEarlierThan:now]);  
}

- (void) test_isLaterThan {
  id now = [NSDate now];
  id later = [NSDate dateWithTimeIntervalSinceNow:4];
  
  assert_true([later isLaterThan:now]);
  assert_false([now isLaterThan:later]);  
}

- (void) test_dateWithString_calendarFormat {
  id actual = [NSDate from:@"2008-05-10T01:11:30Z" format:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
  id formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
  assert_equal([formatter dateFromString:@"2008-05-10T01:11:30Z"], actual);
}
@end