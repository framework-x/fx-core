#import "XAsynchronousTestCase.h"
#import "Infrastructure.h"

@implementation XAsynchronousTestCase

// public instance methods
#define k_time_interval_between_checks_in_seconds 0.25

- (void) defineCallbackForWait: (id)callbackMethodName {
  _responseReceived = NO;    
  _numArgs = [callbackMethodName countOccurrences:':'];
  id method = [self getMethod:@"_callbackMethod:"];
  IMP imp = [method imp];
  const char* methodTypes = [method methodTypes];
  [self addMethod:callbackMethodName imp:imp methodTypes:methodTypes];  
}

- (id) waitForCallback {
  return [self waitForCallback:5.0 failOnTimeout:YES];
}

- (id) waitForCallback: (double)timeInSeconds failOnTimeout: (BOOL)failOnTimeout{
  int count = 0;
  int numberOfChecks = timeInSeconds / k_time_interval_between_checks_in_seconds;
  while (count++ <= numberOfChecks && !_responseReceived) {
    id timeToStop = [NSDate dateWithTimeIntervalSinceNow:k_time_interval_between_checks_in_seconds];
    [[NSRunLoop currentRunLoop] runUntilDate:timeToStop];    
  }
  if (!_responseReceived) {
    if (failOnTimeout) {      
      STFail(@"Timed out waiting for response");
    }
    _params = nil;
  }
  _responseReceived = NO;    
  return _params;
}

// protected instance methods

- (void) _callbackMethod: (id)firstItem, ... {
  firstItem = firstItem ? firstItem : nullObject;
  _params = [[XArray withVargs:firstItem, nil] retain];
  id item;
  va_list argList; 
  va_start(argList, firstItem);
  for (int i = 1; i < _numArgs; i++) {
    item = va_arg(argList, id);
    item = item ? item : nullObject;
    [_params append:item];
  }
  va_end(argList);
  _responseReceived = YES;
}

@end
