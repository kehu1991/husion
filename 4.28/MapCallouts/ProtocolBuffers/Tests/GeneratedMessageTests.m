// Copyright 2008 Cyrus Najmabadi
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "GeneratedMessageTests.h"

#import "TestUtilities.h"
#import "Unittest.pb.h"

@implementation GeneratedMessageTests

- (void) testDefaultInstance {
  STAssertTrue([TestAllTypes defaultInstance] ==
               [[TestAllTypes defaultInstance] defaultInstance], @"");
  STAssertTrue([TestAllTypes defaultInstance] ==
               [[TestAllTypes builder] defaultInstance], @"");
}


- (void) testAccessors {
  TestAllTypes_Builder* builder = [TestAllTypes builder];
  [TestUtilities setAllFields:builder];
  TestAllTypes* message = [builder build];
  [TestUtilities assertAllFieldsSet:message];
}


- (void) testRepeatedSetters {
  TestAllTypes_Builder* builder = [TestAllTypes builder];
  [TestUtilities setAllFields:builder];

  [TestUtilities modifyRepeatedFields:builder];
  TestAllTypes* message = [builder build];
  [TestUtilities assertRepeatedFieldsModified:message];
}


- (void) testRepeatedAppend {
  TestAllTypes_Builder* builder = [TestAllTypes builder];

  NSArray* array =
  [NSArray arrayWithObjects:
   [NSNumber numberWithInt:1],
   [NSNumber numberWithInt:2],
   [NSNumber numberWithInt:3],
   [NSNumber numberWithInt:4], nil];

  [builder addAllRepeatedInt32:array];
  [builder addAllRepeatedForeignEnum:
   [NSArray arrayWithObject:
    [NSNumber numberWithInt:ForeignEnumForeignBaz]]];

  ForeignMessage* foreignMessage = [[[ForeignMessage builder] setC:12] build];
  [builder addAllRepeatedForeignMessage:[NSArray arrayWithObject:foreignMessage]];

  TestAllTypes* message = [builder build];
  STAssertEqualObjects(message.repeatedInt32List, array, @"");
  STAssertEqualObjects(message.repeatedForeignEnumList,
                       [NSArray arrayWithObject:[NSNumber numberWithInt:ForeignEnumForeignBaz]], @"");
  STAssertTrue(1 == message.repeatedForeignMessageList.count, @"");
  STAssertTrue(12 == [[message repeatedForeignMessageAtIndex:0] c], @"");
}


- (void) testClearExtension {
  // clearExtension() is not actually used in TestUtil, so try it manually.
  PBExtendableMessage_Builder* builder1 =
  [[TestAllExtensions builder]
   setExtension:[UnittestRoot optionalInt32Extension] value:[NSNumber numberWithInt:1]];

  STAssertTrue([builder1 hasExtension:[UnittestRoot optionalInt32Extension]], @"");
  [builder1 clearExtension:[UnittestRoot optionalInt32Extension]];
  STAssertFalse([builder1 hasExtension:[UnittestRoot optionalInt32Extension]], @"");

  PBExtendableMessage_Builder* builder2 =
  [[TestAllExtensions builder]
   addExtension:[UnittestRoot repeatedInt32Extension] value:[NSNumber numberWithInt:1]];

  STAssertTrue(1 == [[builder2 getExtension:[UnittestRoot repeatedInt32Extension]] count], @"");
  [builder2 clearExtension:[UnittestRoot repeatedInt32Extension]];
  STAssertTrue(0 == [[builder2 getExtension:[UnittestRoot repeatedInt32Extension]] count], @"");
}


- (void) testExtensionAccessors {
  TestAllExtensions_Builder* builder = [TestAllExtensions builder];
  [TestUtilities setAllExtensions:builder];
  TestAllExtensions* message = [builder build];
  [TestUtilities assertAllExtensionsSet:message];
}


- (void) testExtensionRepeatedSetters {
  TestAllExtensions_Builder* builder = [TestAllExtensions builder];
  [TestUtilities setAllExtensions:builder];
  [TestUtilities modifyRepeatedExtensions:builder];
  TestAllExtensions* message = [builder build];
  [TestUtilities assertRepeatedExtensionsModified:message];
}


- (void) testExtensionDefaults {
  [TestUtilities assertExtensionsClear:[TestAllExtensions defaultInstance]];
  [TestUtilities assertExtensionsClear:[[TestAllExtensions builder] build]];
}

@end
