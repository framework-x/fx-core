#import "TestHelper.h"

@interface XMethodTest : XTestCase {}
@end

@implementation XMethodTest

- (void) test_initWith {
  SEL selector = @selector(test_initWith);
  Method underlyingMethod = class_getInstanceMethod([self class], selector);
  assert_true(underlyingMethod != NULL);
  id method = [XMethod with:underlyingMethod from:self];
  assert_equal(underlyingMethod, [method method]);
  assert_equal(self, [method owningObject]);
}

- (void) test_imp {
  SEL selector = @selector(test_imp);
  Method underlyingMethod = class_getInstanceMethod([self class], selector);
  assert_true(underlyingMethod != NULL);
  id method = [XMethod with:underlyingMethod from:self];
  assert_equal(method_getImplementation(underlyingMethod), [method imp]);  
}

- (void) test_imp_when_method_is_null {
  id method = [XMethod with:NULL from:self];
  assert_true([method imp] == NULL);  
}

- (void) test_isEqual {
  SEL selector = @selector(test_initWith);
  Method underlyingMethod = class_getInstanceMethod([self class], selector);
  assert_true(underlyingMethod != NULL);

  id first = [XMethod with:NULL from:nil];
  id second = [XMethod with:NULL from:nil];

  assert_equal(first, second);
    
  first = [XMethod with:underlyingMethod from:nil];
  assert_not_equal(first, second);
  
  second = [XMethod with:underlyingMethod from:nil];
  assert_equal(first, second);
  
  first = [XMethod with:underlyingMethod from:self];
  assert_not_equal(first, second);
  
  second = [XMethod with:underlyingMethod from:self];
  assert_equal(first, second);
}

- (void) test_methodTypes {
  SEL selector = @selector(test_methodTypes);
  Method underlyingMethod = class_getInstanceMethod([self class], selector);
  const char* methodTypes = method_getTypeEncoding(underlyingMethod);
  id xmethod = [XMethod with:underlyingMethod from:self];
  assert_equal(methodTypes, [xmethod methodTypes]);
}

- (void) test_owningObject {
  SEL selector = @selector(test_owningObject);
  Method underlyingMethod = class_getInstanceMethod([self class], selector);
  id xmethod = [XMethod with:underlyingMethod from:self];
  assert_equal(self, [xmethod owningObject]);  
}

- (void) test_returnType_when_id {
  id xmethod = [XMethod withName:@"hello" from:self];
  assert_equal(@"@", [xmethod returnType]);    
}

- (void) test_returnType_when_void {
  id xmethod = [XMethod withName:@"test_returnType_when_void" from:self];
  assert_equal(@"v", [xmethod returnType]);    
}

- (void) test_selector {
  SEL selector = @selector(test_methodTypes);
  Method underlyingMethod = class_getInstanceMethod([self class], selector);
  id xmethod = [XMethod with:underlyingMethod from:self];
  assert_equal(selector, [xmethod selector]);  
}

- (void) test_withName {
  SEL selector = @selector(test_withName);
  Method underlyingMethod = class_getInstanceMethod([self class], selector);
  assert_true(underlyingMethod != NULL);
  id method = [XMethod withName:@"test_withName" from:self];
  assert_equal(underlyingMethod, [method method]);
  assert_equal(self, [method owningObject]);
}

- (id) hello {
  return @"hello";
}

@end
