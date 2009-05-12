
#import "TestHelper.h"
#import "XIo.h"

@interface XFileTest : XTestCase {}
@end

@implementation XFileTest

- (void) test_copyFrom_to_when_destination_does_not_exist {
  id destination = @"test/io/XFileTest_no_such_file.txt";
  assert_false([XFile exists:destination]);
  
  [XFile copyFrom:@"test/test_file.txt" to:destination];
  assert_true([XFile exists:destination]);

  [XFile delete:destination];
  assert_false([XFile exists:destination]);  
}

- (void) test_copyFrom_to_when_destination_exists {
  id destination = @"test/io/XFileTest_test_file.txt";
  id source = @"test/io/XFileTest_source.txt";  

  id file = [XFile open:destination];
  [file write:@"hello world"];

  file = [XFile open:source];
  [file write:@"goodbye cruel world"];
  
  [XFile copyFrom:source to:destination];

  id contents = [XFile read:destination];
  assert_equal(@"goodbye cruel world", contents);

  [XFile delete:destination];
  [XFile delete:source];
}

- (void) test_create {
  id fileName = @"test/io/XFileTest_create.txt";
  if ([XFile exists:fileName]) {
    [XFile delete:fileName];
  }
  assert_false([XFile exists:fileName]);
  [XFile create:fileName];
  assert_true([XFile exists:fileName]);
  assert_equal(@"", [XFile read:fileName]);
  [XFile delete:fileName];
}

- (void) test_create_when_file_exists {
  id file = [XFile create:@"test/test_file.txt"];
  assert_equal(@"hello world", [file read]);
}

- (void) test_currentPath {
  assert_true([[XFile currentPath] hasSuffix:@"/fx-core"]);
}

- (void) test_delete {
  id path = @"test/io/XFileTest_path.txt";
  
  assert_false([XFile exists:path]);
  
  id file = [XFile open:path];
  assert_not_nil(file);
  assert_equal(path, [file path]);
  assert_true([file exists]);
  
  [XFile delete:path];
  
  assert_false([XFile exists:path]);
}

- (void) test_delete_when_file_does_not_exist {
  id path = @"test/io/XFileTest_path.txt";
  assert_false([XFile exists:path]);  
  assert_nothing_thrown([XFile delete:path]);
}

- (void) test_exists {
  assert_true([XFile exists:@"test/test_file.txt"]);
}

- (void) test_newWith {
  id path = @"test/io/XFileTest_test_file.txt";
  id file = [XFile newWith:path];
  assert_not_nil(file);
  assert_equal(path, [file path]);
}

- (void) test_open {
  id path = @"test/io/XFileTest_test_file.txt";
  id file = [XFile open:path];
  assert_not_nil(file);
  assert_equal(path, [file path]);
  assert_true([file exists]);
}

- (void) test_open_creates_file_if_it_doesnt_exist_and_delete_deletes {
  id no_such_file = @"test/io/XFileTest_no_such_file.txt";
  
  assert_false([XFile exists:no_such_file]);
  
  id file = [XFile open:no_such_file];
  assert_not_nil(file);
  assert_equal(no_such_file, [file path]);
  assert_true([file exists]);
  
  [file delete];
  
  assert_false([XFile exists:no_such_file]);
}

- (void) test_open_for_file_that_does_not_exist_then_read_write {
  id no_such_file = @"test/io/XFileTest_no_such_file.txt";
  
  assert_false([XFile exists:no_such_file]);
  
  id file = [XFile open:no_such_file];
  assert_not_nil(file);
  assert_equal(no_such_file, [file path]);
  assert_true([file exists]);

  id hello = @"hello world";
  id goodbye = @"goodbye cruel world";
  
  [file write:goodbye];
  assert_equal(goodbye, [XFile read:[file path]]); 
  
  [file write:hello];
  assert_equal(hello, [XFile read:[file path]]);   
  
  [file delete];
}

- (void) test_reads {
  id path = @"test/io/XFileTest_test_file.txt";
  id file = [XFile open:path];
  id content = [file read];
  assert_equal(@"hello world", content);
  assert_equal(@"hello world", [XFile read:path]);
}

- (void) test_read_write {
  id path = @"test/io/XFileTest_test_file.txt";
  id file = [XFile open:path];
  id hello = @"hello world";
  id goodbye = @"goodbye cruel world";
  
  [file write:goodbye];
  assert_equal(goodbye, [XFile read:path]); 
  
  [file write:hello];
  assert_equal(hello, [XFile read:path]); 
}

- (void) test_write_and_readData_with_binary_content {
  id data = [NSData dataWithContentsOfFile:@"test/integration/framework_x/net/kenny_g.png"];
  id copyFileName = @"test/framework_x/io/binary.png";
  assert_false([XFile exists:copyFileName]);
  id file = [XFile open:copyFileName];
  [file write:data];
  file = [XFile open:copyFileName];
  assert_equal(data, [file readData]);  
  [XFile delete:copyFileName];
}

- (void) test_resourcesDirectory_does_not_blow_up {
  [XFile resourcesDirectory];
}

@end
