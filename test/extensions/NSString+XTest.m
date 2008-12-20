#import "TestHelper.h"

#import "RegexKitLite.h"

#define test_file @"test/test_file.txt"

@interface NSStringXTest : XTestCase {}
@end

@implementation NSStringXTest

- (void) test_asCString {
  assert_true(0 == strcmp("hello world", [@"hello world" asCString]));
}

- (void) test_asCamelCase_with_underscore_at_the_start_of_the_string {
  assert_equal(@"camelC", [@"_camel_c" asCamelCase]);
}

- (void) test_asCamelCase_with_underscore_at_the_end_of_the_string {
  assert_equal(@"camelC", [@"camel_c_" asCamelCase]);
}

- (void) test_asCamelCase_with_hyphen_at_the_end_of_the_string {
  assert_equal(@"camelC", [@"camel-c-" asCamelCase]);
}

- (void) test_asCamelCase_with_one_hump_without_anything_after_the_hump {
  assert_equal(@"camelC", [@"camel_c" asCamelCase]);
}

- (void) test_asCamelCase_with_hyphens {
  assert_equal(@"camelC", [@"camel-c" asCamelCase]);
}

- (void) test_asCamelCase_with_one_hump {
  assert_equal(@"camelCase", [@"camel_case" asCamelCase]);
}

- (void) test_asCamelCase_with_multiple_humps {
  assert_equal(@"camelCaseIsNotPascalCase", [@"camel_case_is_not_pascal_case" asCamelCase]);
}

- (void) test_asCamelCase_with_pascal_case {
  assert_equal(@"pascalCaseFoo", [@"PascalCaseFoo" asCamelCase]);
}

- (void) test_asCamelCase_with_empty_string {
  assert_equal(@"", [@"" asCamelCase]);
}

- (void) test_asDoubleObject {
  assert_equal([NSNumber double:5.2], [@"5.2" asDoubleObject]);
}

- (void) test_asIntObject {
  assert_equal([NSNumber int:5], [@"5" asIntObject]);
}

- (void) test_asPascalCase_withUnderscoreAtTheStartOfTheString {
  assert_equal(@"PascalC", [@"_pascal_c" asPascalCase]);
}

- (void) test_asPascalCase_with_one_hump_without_anything_after_the_hump {
  assert_equal(@"PascalC", [@"pascal_c" asPascalCase]);
}

- (void) test_asPascalCase_with_one_hump {
  assert_equal(@"PascalCase", [@"pascal_case" asPascalCase]);
}

- (void) test_asPascalCase_with_multiple_humps {
  assert_equal(@"PascalCaseIsNotCamelCase", [@"pascal_case_is_not_camel_case" asPascalCase]);
}

- (void) test_asPascalCase_with_pascal_case {
  assert_equal(@"PascalCaseFoo", [@"PascalCaseFoo" asPascalCase]);
}

- (void) test_asPascalCase_with_camel_case {
  assert_equal(@"PascalCaseFoo", [@"pascalCaseFoo" asPascalCase]);
}

- (void) test_asPascalCase_with_empty_string {
  assert_equal(@"", [@"" asPascalCase]);
}

- (void) test_asPascalCase_with_hyphen {
  assert_equal(@"AbcDef", [@"abc-def" asPascalCase]);
}

- (void) test_asRubyCase_with_one_hump_without_anything_after_the_hump {
  assert_equal(@"camel_c", [@"camelC" asRubyCase]);
}

- (void) test_asRubyCase_with_elephant_case_section {
  assert_equal(@"camel_case", [@"camelCASE" asRubyCase]);
}

- (void) test_asRubyCase_with_one_hump {
  assert_equal(@"camel_case", [@"camelCase" asRubyCase]);
}

- (void) test_asRubyCase_with_multiple_humps {
  assert_equal(@"camel_case_is_not_pascal_case", [@"camelCaseIsNotPascalCase" asRubyCase]);
}

- (void) test_asRubyCase_with_pascal_case {
  assert_equal(@"camel_case_is_not_pascal_case", [@"CamelCaseIsNotPascalCase" asRubyCase]);
}

- (void) test_asRubyCase_with_hyphens {
  assert_equal(@"some_hyphenated_word", [@"some-hyphenated-word" asRubyCase]);
}

- (void) test_asSelector {
  id string = @"foo";
  assert_equal(NSSelectorFromString(string), [string asSelector]);
}

- (void) test_asXmlCase_with_camel_case {
  assert_equal(@"camel-case-is-not-pascal-case", [@"camelCaseIsNotPascalCase" asXmlCase]);
}

- (void) test_asXmlCase_with_pascal_case {
  assert_equal(@"camel-case-is-not-pascal-case", [@"CamelCaseIsNotPascalCase" asXmlCase]);
}

- (void) test_asXmlCase_with_no_humps {
  assert_equal(@"camel", [@"camel" asXmlCase]);
}

- (void) test_asXmlCase_with_underscores {
  assert_equal(@"i-have-underscores", [@"i_have_underscores" asXmlCase]);
}

- (void) test_asXmlCase_with_xml_case {
  assert_equal(@"i-am-already-done", [@"i-am-already-done" asXmlCase]);
}

- (void) test_asXmlCase_with_empty_string {
  assert_equal(@"", [@"" asXmlCase]);
}

- (void) test_contains {
  assert_true([@"foobar" contains:@"oob"]);
}

- (void) test_contains_when_string_is_not_present {
  assert_false([@"foobar" contains:@"baz"]);
}

- (void) test_contains_when_string_is_empty {
  assert_false([@"" contains:@"baz"]);
}

- (void) test_downcase {
  assert_equal(@"shh", [@"SHH" downcase]);
}

- (void) test_encrypt {
  id secret = @"z's not wearing pants";
  id encrypted = [secret encrypt];
  id decrypted = [encrypted decrypt];
  assert_equal(@"z's not wearing pants", decrypted);
}

- (void) test_endsWith {
  id string = @"the mind's i";
  assert_true([string endsWith:@"d's i"]);
  assert_false([string endsWith:@"the"]);  
}

- (void) test_endsWith_when_string_does_not_exist {
  id string = @"the mind's i";  
  assert_false([string endsWith:@"this_string_does_not_exist"]);      
}

- (void) test_endsWith_when_passing_entire_string {
  id string = @"the mind's i";  
  assert_true([string endsWith:string]);      
}

- (void) test_inspect {
  id string = @"foo";
	id result = [string inspect];
	assert_equal(@"\"foo\"", result);
}

- (void) test_from {
  assert_equal(@"hello world", [NSString from:@"hello world"]);
}

- (void) test_fromData {
  id data = [NSData fromString:@"MorningYearning"];
  id expected = [NSString withBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding]; 
  assert_equal(expected, [NSString fromData:data]) 
}

- (void) test_fromCString {
  assert_equal(@"hello world", [NSString fromCString:"hello world"]);
}

- (void) test_fromPath {
  assert_equal(@"hello world", [NSString fromContentsAtPath:test_file]);
}

- (void) test_fromSelector {
  assert_equal(@"test_fromSelector", [NSString fromSelector:_cmd]);
}

- (void) test_gsub_no_match {
  assert_equal(@"abc", [@"abc" gsub:@"d" with:@"x"]);
}

- (void) test_gsub_with_empty_string {
  assert_equal(@"", [@"" gsub:@"d" with:@"x"]);
}

- (void) test_gsub_with_static_replacement {
  assert_equal(@"a_b_c_", [@"a1b2c3" gsub:@"[0-9]" with:@"_"]);
  assert_equal(@"a_b_c_", [@"a123b456c789" gsub:@"[0-9]+" with:@"_"]);
}

- (void) test_gsub_statically_replacing_whitespace {
  assert_equal(@"_a_b_c_", [@" a b c " gsub:@"\\s" with:@"_"]);
  assert_equal(@"__a__b__c__", [@"  a  b  c  " gsub:@"\\s" with:@"_"]);
}

- (void) test_gsub_with_one_back_reference {
  assert_equal(@"ABC", [@"Alpha Beta Charlie" gsub:@"([A-Z])[a-z ]+" with:@"\\1"]);
}

- (void) test_gsub_with_two_back_references {
  assert_equal(@"a1 b2 c3", [@"aa11 bb22 cc33" gsub:@"([a-z])[a-z]([0-9])[0-9]" with:@"\\1\\2"]);
}

- (void) test_gsub_for_underscore {
  assert_equal(@"foo_Bar",  [@"fooBar" gsub:@"([a-z]+)([A-Z]+)" with:@"\\1_\\2"]);
}

- (void) test_matches_with_string {
  id regex;
  
  regex = @"(([A-Z]+)[a-z]+)";
  assert_true([@"Az" matches:regex]);
  
  regex = @"[0-9]";
  assert_true([@"3" matches:regex]);
  
  regex = @"/Users/\\w+/Documents";
  assert_true([@"/Users/foo/Documents" matches:regex]);   
  
  regex = @"fo.*ar";
  assert_true([@"foobar" matches:regex]);
  assert_true([@"fo ar" matches:regex]);  
  assert_true([@"fo\"ar" matches:regex]);  
  assert_true([@"fo<>ar" matches:regex]);    
  assert_true([@"fo/ar" matches:regex]);      
}

- (void) test_isEmpty_when_empty {
  assert_true([@"" isEmpty]);
}

- (void) test_isEmpty_when_only_whitespace {
  assert_true([@" " isEmpty]);
}

- (void) test_isEmpty_when_not_empty {
  assert_false([@"a" isEmpty]);
}

- (void) test_hyphensAtHumps_with_empty_string {
  assert_equal(@"", [@"" hyphensAtHumps]);
}

- (void) test_hyphensAtHumps_without_humps {
  assert_equal(@"camel", [@"camel" hyphensAtHumps]);
}

- (void) test_hyphensAtHumps_with_camel_case {
  assert_equal(@"camel-Case", [@"camelCase" hyphensAtHumps]);
}

- (void) test_hyphensAtHumps_with_pascal_case {
  assert_equal(@"Pascal-Case", [@"PascalCase" hyphensAtHumps]);
}

- (void) test_pluralize {
  assert_equal(@"somethings", [@"something" pluralize]);
}

- (void) test_pluralize_with_plural_word {
  assert_equal(@"somethings", [@"somethings" pluralize]);
}

- (void) test_replace_with_with_no_occurances {
  assert_equal_ints(0, [@"" countOccurrences:':'])
}

- (void) test_replace_with_with_one_occurance {
  assert_equal(@"ab_ghi_f", [@"ab_cde_f" copyReplacing:@"cde" with:@"ghi"])
}

- (void) test_replace_with_with_one_occurance_at_the_start {
  assert_equal(@"ghi_cdef", [@"ab_cdef" copyReplacing:@"ab" with:@"ghi"])
}

- (void) test_replace_with_with_one_occurance_at_the_end {
  assert_equal(@"abc_ghi", [@"abc_def" copyReplacing:@"def" with:@"ghi"])
}

- (void) test_replace_with_with_multiple_occurances {
  id value = @"-abc-def-ghi-";
  assert_equal(@"_abc_def_ghi_", [value copyReplacing:@"-" with:@"_"]);
}

- (void) test_singularize {
  assert_equal(@"something", [@"somethings" singularize]);
}

- (void) test_singularize_with_non_plural_word {
  assert_equal(@"something", [@"something" singularize]);
}

- (void) test_split {
  id expected = [XArray withVargs:@"some", @"string", @"with", @"commas", nil];
  id actual = [@"some,string,with,commas" split:@","];
  assert_equal(expected, actual);
}

- (void) test_stringValue {
  id string = @"a string";
  assert_equal(string, [string stringValue]);
}

- (void) test_splitIntoLinesNoLongerThan {
  id string = @"a string that should be split";
  id expected = [XArray withVargs:@"a string", @"that", @"should be", @"split", nil];
  assert_equal(expected, [string splitIntoLinesNoLongerThan:10]);
}

- (void) test_splitIntoLinesNoLongerThan_with_exact_number_of_characters_on_second_word {
  id string = @"a 12346789";
  id expected = [XArray withVargs:@"a", @"12346789", nil];
  assert_equal(expected, [string splitIntoLinesNoLongerThan:9]);
}

- (void) test_splitIntoLinesNoLongerThan_when_string_is_shorter_than_length {
  id string = @"abc";
  id expected = [XArray withVargs:@"abc", nil];
  assert_equal(expected, [string splitIntoLinesNoLongerThan:4]);
}

- (void) test_splitIntoLinesNoLongerThan_when_string_is_longer_than_length {
  id string = @"abc";
  id expected = [XArray withVargs:@"abc", nil];
  assert_equal(expected, [string splitIntoLinesNoLongerThan:2]);
}

- (void) test_splitIntoLinesNoLongerThan_when_second_string_is_longer_than_length {
  id string = @"abc defg";
  id expected = [XArray withVargs:@"abc", @"defg", nil];
  assert_equal(expected, [string splitIntoLinesNoLongerThan:3]);
}

- (void) test_substring {
  assert_equal(@"bc", [@"abcd" substring:1 length:2]);
}

- (void) test_substring_with_length_that_matches_length_of_string {
  assert_equal(@"bcd", [@"abcd" substring:1 length:3]);
}

- (void) test_substring_specifying_full_length {
  assert_equal(@"abc", [@"abc" substring:0 length:3]);
}

- (void) test_substring_with_empty_string {
  assert_equal(@"", [@"" substring:1 length:3]);
}

- (void) test_substring_specifying_length_too_large_for_string {
  assert_equal(@"b", [@"ab" substring:1 length:3]);
}

- (void) test_substring_specifying_start_index_too_large_for_string {
  assert_equal(@"", [@"ab" substring:2 length:1]);
}

- (void) test_trim_with_empty_string {
  assert_equal(@"", [@"" trimmed]);
}

- (void) test_trim_removes_whitespace_from_front_and_back {
  assert_equal(@"abc", [@" abc " trimmed]);
}

- (void) test_trim_removes_tabs {
  assert_equal(@"abc", [@"\tabc\t" trimmed]);
}

- (void) test_trim_does_not_remove_non_whitespace_chars {
  assert_equal(@"abc", [@"abc" trimmed]);
}

- (void) test_underscoresAtHumps_with_empty_string {
  assert_equal(@"", [@"" withUnderscoresAtHumps]);
}

- (void) test_underscoresAtHumps_without_humps {
  assert_equal(@"camel", [@"camel" withUnderscoresAtHumps]);
}

- (void) test_underscoresAtHumps_with_camel_case {
  assert_equal(@"camel_Case", [@"camelCase" withUnderscoresAtHumps]);
}

- (void) test_underscoresAtHumps_with_pascal_case {
  assert_equal(@"Pascal_Case", [@"PascalCase" withUnderscoresAtHumps]);
}

- (void) test_underscoresAtHyphens_with_empty_string {
  assert_equal(@"", [@"" withUnderscoresAtHyphens]);
}

- (void) test_underscoresAtHyphens_with_camel_case {
  assert_equal(@"camelCaseString", [@"camelCaseString" withUnderscoresAtHyphens]);
}

- (void) test_underscoresAtHyphens_starting_with_a_hyphen {
  assert_equal(@"_starting_with_hyphen", [@"-starting-with-hyphen" withUnderscoresAtHyphens]);
}

- (void) test_underscoresAtHyphens_starting_with_hyphens {
  assert_equal(@"a_hyphenated_word", [@"a-hyphenated-word" withUnderscoresAtHyphens]);
}

- (void) test_underscoresAtHyphens_starting_with_underscores {
  assert_equal(@"already_done_so", [@"already_done_so" withUnderscoresAtHyphens]);
}

- (void) test_urlEncode {
  assert_equal(@"hello%20world", [@"hello world" urlEncoded]);
}

- (void) test_with {
  id string = [NSString with:@"foo", @" ", @"bar", @" ", @"baz", nil];
  
  assert_equal(@"foo bar baz", string); 
}

- (void) test_withoutWhitespace {
  assert_equal(@"abc", [@"a b c" withoutWhitespace]);
  assert_equal(@"abc", [@"  a  b  c  " withoutWhitespace]);
  assert_equal(@"abc", [@"\ta   b  c  " withoutWhitespace]);
  assert_equal(@"abc", [@"\rab\nc\r\n" withoutWhitespace]);
}

@end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
