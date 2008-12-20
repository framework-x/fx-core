#import "TestHelper.h"

@interface NSNumberXTest : XTestCase {}
@end

@implementation NSNumberXTest

- (void) test_asBool_returns_true {
  assert_true([trueObject asBool]);
}

- (void) test_asBool_returns_false {
  assert_false([falseObject asBool]);
}

- (void) test_asString {
  assert_equal(@"456", [[NSNumber int:456] asString]);
}

- (void) test_int {
	id integer = [NSNumber int:2];
	assert_equal_ints(2, [integer intValue]);
}

- (void) test_double {
	id theDouble = [NSNumber double:2.6];
  assert_equal(theDouble, [NSNumber numberWithDouble:2.6]);
}

- (void) test_doubleFromString {
  id theDouble = [NSNumber double:2.6];
  assert_equal(theDouble, [NSNumber doubleFromString:@"2.6"]);  
}

- (void) test_doubleFromString_with_empty_string {
  id theDouble = [NSNumber double:0];
  assert_equal(theDouble, [NSNumber doubleFromString:@""]);  
}

- (void) test_intFromString {
  id theDouble = [NSNumber int:2];
  assert_equal(theDouble, [NSNumber doubleFromString:@"2"]);  
}

- (void) test_intFromString_with_empty_string {
  id theDouble = [NSNumber int:0];
  assert_equal(theDouble, [NSNumber doubleFromString:@""]);  
}

- (void) test_plusInt {
  id expected = [NSNumber int:2];
  assert_equal(expected, [[NSNumber int:1] plusInt:1]);    
}

- (void) test_plus {
  id expected = [NSNumber int:3];
  assert_equal(expected, [[NSNumber int:1] plus:[NSNumber int:2]]);    
}

- (void) test_trueObject {
  id expected = [NSNumber int:1];
  assert_equal(expected, [NSNumber trueObj]);  
}

- (void) test_trueObject_macro {
  id expected = [NSNumber int:1];
  assert_equal(expected, trueObject);  
}

- (void) test_falseObject {
  id expected = [NSNumber int:0];
  assert_equal(expected, [NSNumber falseObj]);  
}

- (void) test_falseObject_macro {
  id expected = [NSNumber int:0];
  assert_equal(expected, falseObject);  
}

- (void) test_isGreaterThan {
  id number1 = [NSNumber int:2];
  id number2 = [NSNumber int:3];  
  assert_true([number2 isGreaterThan:number1]);
  assert_false([number1 isGreaterThan:number2]);  
}

- (void) test_isGreaterThan_with_doubles {
  id number1 = [NSNumber double:3.1];
  id number2 = [NSNumber double:3.2];  
  assert_true([number2 isGreaterThan:number1]);  
  assert_false([number1 isGreaterThan:number2]);    
}

- (void) test_isLessThan {
  id number1 = [NSNumber int:2];
  id number2 = [NSNumber int:3];  
  assert_true([number1 isLessThan:number2]);    
  assert_false([number2 isLessThan:number1]);
}

- (void) test_isLessThan_with_doubles {
  id number1 = [NSNumber double:3.1];
  id number2 = [NSNumber double:3.2];  
  assert_true([number1 isLessThan:number2]);    
  assert_false([number2 isLessThan:number1]);  
}

- (void) test_isGreaterThanOrEqualTo {
  id number1 = [NSNumber int:2];
  id number2 = [NSNumber int:3];
  id number3 = [NSNumber int:3];    
  assert_true([number2 isGreaterThanOrEqualTo:number1]);
  assert_false([number1 isGreaterThanOrEqualTo:number2]);    
  assert_true([number2 isGreaterThanOrEqualTo:number3]);
  assert_true([number3 isGreaterThanOrEqualTo:number2]);    
}

- (void) test_isGreaterThanOrEqualTo_with_doubles {
  id number1 = [NSNumber double:3.1];
  id number2 = [NSNumber double:3.2];
  id number3 = [NSNumber double:3.2];    
  assert_true([number2 isGreaterThanOrEqualTo:number1]);
  assert_false([number1 isGreaterThanOrEqualTo:number2]);    
  assert_true([number2 isGreaterThanOrEqualTo:number3]);
  assert_true([number3 isGreaterThanOrEqualTo:number2]);      
}

- (void) test_isLessThanOrEqualTo {
  id number1 = [NSNumber int:2];
  id number2 = [NSNumber int:3];
  id number3 = [NSNumber int:3];    
  assert_true([number1 isLessThanOrEqualTo:number2]);
  assert_false([number2 isLessThanOrEqualTo:number1]);    
  assert_true([number2 isLessThanOrEqualTo:number3]);
  assert_true([number3 isLessThanOrEqualTo:number2]);      
}

- (void) test_isLessThanOrEqualTo_with_doubles {
  id number1 = [NSNumber double:3.1];
  id number2 = [NSNumber double:3.2];
  id number3 = [NSNumber double:3.2];    
  assert_true([number1 isLessThanOrEqualTo:number2]);
  assert_false([number2 isLessThanOrEqualTo:number1]);    
  assert_true([number2 isLessThanOrEqualTo:number3]);
  assert_true([number3 isLessThanOrEqualTo:number2]);        
}

- (void) test_isTrue_returns_true {
  assert_true([trueObject isTrue]);
}

- (void) test_isTrue_returns_false {
  assert_false([falseObject isTrue]);
}

- (void) test_isFalse_returns_true {
  assert_true([falseObject isFalse]);
}

- (void) test_isFalse_returns_false {
  assert_false([trueObject isFalse]);
}

@end
