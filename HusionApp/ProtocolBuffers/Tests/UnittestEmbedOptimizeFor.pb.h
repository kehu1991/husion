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

#import "ProtocolBuffers.h"

#import "UnittestOptimizeFor.pb.h"

@class BarRequest;
@class BarRequest_Builder;
@class BarResponse;
@class BarResponse_Builder;
@class FooRequest;
@class FooRequest_Builder;
@class FooResponse;
@class FooResponse_Builder;
@class ForeignMessage;
@class ForeignMessage_Builder;
@class ImportMessage;
@class ImportMessage_Builder;
@class OneBytes;
@class OneBytes_Builder;
@class OneString;
@class OneString_Builder;
@class OptionalGroup_extension;
@class OptionalGroup_extension_Builder;
@class RepeatedGroup_extension;
@class RepeatedGroup_extension_Builder;
@class TestAllExtensions;
@class TestAllExtensions_Builder;
@class TestAllTypes;
@class TestAllTypes_Builder;
@class TestAllTypes_NestedMessage;
@class TestAllTypes_NestedMessage_Builder;
@class TestAllTypes_OptionalGroup;
@class TestAllTypes_OptionalGroup_Builder;
@class TestAllTypes_RepeatedGroup;
@class TestAllTypes_RepeatedGroup_Builder;
@class TestCamelCaseFieldNames;
@class TestCamelCaseFieldNames_Builder;
@class TestDupFieldNumber;
@class TestDupFieldNumber_Bar;
@class TestDupFieldNumber_Bar_Builder;
@class TestDupFieldNumber_Builder;
@class TestDupFieldNumber_Foo;
@class TestDupFieldNumber_Foo_Builder;
@class TestEmbedOptimizedForSize;
@class TestEmbedOptimizedForSize_Builder;
@class TestEmptyMessage;
@class TestEmptyMessageWithExtensions;
@class TestEmptyMessageWithExtensions_Builder;
@class TestEmptyMessage_Builder;
@class TestExtremeDefaultValues;
@class TestExtremeDefaultValues_Builder;
@class TestFieldOrderings;
@class TestFieldOrderings_Builder;
@class TestForeignNested;
@class TestForeignNested_Builder;
@class TestMutualRecursionA;
@class TestMutualRecursionA_Builder;
@class TestMutualRecursionB;
@class TestMutualRecursionB_Builder;
@class TestNestedExtension;
@class TestNestedExtension_Builder;
@class TestNestedMessageHasBits;
@class TestNestedMessageHasBits_Builder;
@class TestNestedMessageHasBits_NestedMessage;
@class TestNestedMessageHasBits_NestedMessage_Builder;
@class TestOptimizedForSize;
@class TestOptimizedForSize_Builder;
@class TestOptionalOptimizedForSize;
@class TestOptionalOptimizedForSize_Builder;
@class TestPackedExtensions;
@class TestPackedExtensions_Builder;
@class TestPackedTypes;
@class TestPackedTypes_Builder;
@class TestReallyLargeTagNumber;
@class TestReallyLargeTagNumber_Builder;
@class TestRecursiveMessage;
@class TestRecursiveMessage_Builder;
@class TestRequired;
@class TestRequiredForeign;
@class TestRequiredForeign_Builder;
@class TestRequiredOptimizedForSize;
@class TestRequiredOptimizedForSize_Builder;
@class TestRequired_Builder;

@interface UnittestEmbedOptimizeForRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface TestEmbedOptimizedForSize : PBGeneratedMessage {
@private
  BOOL hasOptionalMessage_:1;
  TestOptimizedForSize* optionalMessage;
  NSMutableArray* mutableRepeatedMessageList;
}
- (BOOL) hasOptionalMessage;
@property (readonly, retain) TestOptimizedForSize* optionalMessage;
- (NSArray*) repeatedMessageList;
- (TestOptimizedForSize*) repeatedMessageAtIndex:(int32_t) index;

+ (TestEmbedOptimizedForSize*) defaultInstance;
- (TestEmbedOptimizedForSize*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (TestEmbedOptimizedForSize_Builder*) builder;
+ (TestEmbedOptimizedForSize_Builder*) builder;
+ (TestEmbedOptimizedForSize_Builder*) builderWithPrototype:(TestEmbedOptimizedForSize*) prototype;

+ (TestEmbedOptimizedForSize*) parseFromData:(NSData*) data;
+ (TestEmbedOptimizedForSize*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (TestEmbedOptimizedForSize*) parseFromInputStream:(NSInputStream*) input;
+ (TestEmbedOptimizedForSize*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (TestEmbedOptimizedForSize*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (TestEmbedOptimizedForSize*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface TestEmbedOptimizedForSize_Builder : PBGeneratedMessage_Builder {
@private
  TestEmbedOptimizedForSize* result;
}

- (TestEmbedOptimizedForSize*) defaultInstance;

- (TestEmbedOptimizedForSize_Builder*) clear;
- (TestEmbedOptimizedForSize_Builder*) clone;

- (TestEmbedOptimizedForSize*) build;
- (TestEmbedOptimizedForSize*) buildPartial;

- (TestEmbedOptimizedForSize_Builder*) mergeFrom:(TestEmbedOptimizedForSize*) other;
- (TestEmbedOptimizedForSize_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (TestEmbedOptimizedForSize_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasOptionalMessage;
- (TestOptimizedForSize*) optionalMessage;
- (TestEmbedOptimizedForSize_Builder*) setOptionalMessage:(TestOptimizedForSize*) value;
- (TestEmbedOptimizedForSize_Builder*) setOptionalMessageBuilder:(TestOptimizedForSize_Builder*) builderForValue;
- (TestEmbedOptimizedForSize_Builder*) mergeOptionalMessage:(TestOptimizedForSize*) value;
- (TestEmbedOptimizedForSize_Builder*) clearOptionalMessage;

- (NSArray*) repeatedMessageList;
- (TestOptimizedForSize*) repeatedMessageAtIndex:(int32_t) index;
- (TestEmbedOptimizedForSize_Builder*) replaceRepeatedMessageAtIndex:(int32_t) index with:(TestOptimizedForSize*) value;
- (TestEmbedOptimizedForSize_Builder*) addRepeatedMessage:(TestOptimizedForSize*) value;
- (TestEmbedOptimizedForSize_Builder*) addAllRepeatedMessage:(NSArray*) values;
- (TestEmbedOptimizedForSize_Builder*) clearRepeatedMessageList;
@end
