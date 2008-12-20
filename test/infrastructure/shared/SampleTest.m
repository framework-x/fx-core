#import "TestHelper.h"

#import "FrameworkX.h"

@interface SampleTest : XTestCase {}

- (id) methodThatThrowsException;

@end


@implementation SampleTest

- (void) setUp {
}

- (void) testAssertions {
  STAssertEquals(YES, YES, @"%@ should equal %@", @"YES", @"YES");
  STAssertEquals(YES, YES, @"YES should equal YES");
  
  STAssertNil(nil, nil);
  STAssertNotNil([[NSObject alloc] init], nil);
  
  STAssertTrue(YES, nil);
  STAssertFalse(NO, nil);

	STAssertEqualsWithAccuracy(-115.678, -115.6785, 0.001, @"longitudes should be equal", nil);	
  
  STAssertThrows([self methodThatThrowsException], nil);
  
  STAssertThrowsSpecific([self methodThatThrowsException],
                         NSException,
                         @"Should specifically throw TestFooExceptionName.");
  
}

- (id) methodThatThrowsException {
  @throw ([NSException exceptionWithName:@"Chuck" reason:@"test" userInfo:nil]);
}

- (void) test_archiving {
  id hash = [XHash withVargs:@"someKey", @"someValue", nil];
  NSMutableData *data = [NSMutableData data];
  NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  [archiver encodeObject:hash forKey:@"theHash"];
  [archiver finishEncoding];
  NSString *b64 = [data encodeBase64];
  NSData *decodedData = [b64 decodeBase64];
  NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:decodedData];
  id hash2 = [unarchiver decodeObjectForKey:@"theHash"];
  [unarchiver finishDecoding];
  assert_equal(@"someValue", [hash2 get:@"someKey"]);
}

@end
