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

#import "Unittest.pb.h"

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

@interface UnittestOptimizeForRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface TestOptimizedForSize : PBExtendableMessage {
@private
  BOOL hasI_:1;
  BOOL hasMsg_:1;
  int32_t i;
  ForeignMessage* msg;
}
- (BOOL) hasI;
- (BOOL) hasMsg;
@property (readonly) int32_t i;
@property (readonly, retain) ForeignMessage* msg;

+ (TestOptimizedForSize*) defaultInstance;
- (TestOptimizedForSize*) defaultInstance;

+ (id<PBExtensionField>) testExtension;
+ (id<PBExtensionField>) testExtension2;
- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (TestOptimizedForSize_Builder*) builder;
+ (TestOptimizedForSize_Builder*) builder;
+ (TestOptimizedForSize_Builder*) builderWithPrototype:(TestOptimizedForSize*) prototype;

+ (TestOptimizedForSize*) parseFromData:(NSData*) data;
+ (TestOptimizedForSize*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (TestOptimizedForSize*) parseFromInputStream:(NSInputStream*) input;
+ (TestOptimizedForSize*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (TestOptimizedForSize*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (TestOptimizedForSize*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface TestOptimizedForSize_Builder : PBExtendableMessage_Builder {
@private
  TestOptimizedForSize* result;
}

- (TestOptimizedForSize*) defaultInstance;

- (TestOptimizedForSize_Builder*) clear;
- (TestOptimizedForSize_Builder*) clone;

- (TestOptimizedForSize*) build;
- (TestOptimizedForSize*) buildPartial;

- (TestOptimizedForSize_Builder*) mergeFrom:(TestOptimizedForSize*) other;
- (TestOptimizedForSize_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (TestOptimizedForSize_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasI;
- (int32_t) i;
- (TestOptimizedForSize_Builder*) setI:(int32_t) value;
- (TestOptimizedForSize_Builder*) clearI;

- (BOOL) hasMsg;
- (ForeignMessage*) msg;
- (TestOptimizedForSize_Builder*) setMsg:(ForeignMessage*) value;
- (TestOptimizedForSize_Builder*) setMsgBuilder:(ForeignMessage_Builder*) builderForValue;
- (TestOptimizedForSize_Builder*) mergeMsg:(ForeignMessage*) value;
- (TestOptimizedForSize_Builder*) clearMsg;
@end

@interface TestRequiredOptimizedForSize : PBGeneratedMessage {
@private
  BOOL hasX_:1;
  int32_t x;
}
- (BOOL) hasX;
@property (readonly) int32_t x;

+ (TestRequiredOptimizedForSize*) defaultInstance;
- (TestRequiredOptimizedForSize*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (TestRequiredOptimizedForSize_Builder*) builder;
+ (TestRequiredOptimizedForSize_Builder*) builder;
+ (TestRequiredOptimizedForSize_Builder*) builderWithPrototype:(TestRequiredOptimizedForSize*) prototype;

+ (TestRequiredOptimizedForSize*) parseFromData:(NSData*) data;
+ (TestRequiredOptimizedForSize*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (TestRequiredOptimizedForSize*) parseFromInputStream:(NSInputStream*) input;
+ (TestRequiredOptimizedForSize*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (TestRequiredOptimizedForSize*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (TestRequiredOptimizedForSize*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface TestRequiredOptimizedForSize_Builder : PBGeneratedMessage_Builder {
@private
  TestRequiredOptimizedForSize* result;
}

- (TestRequiredOptimizedForSize*) defaultInstance;

- (TestRequiredOptimizedForSize_Builder*) clear;
- (TestRequiredOptimizedForSize_Builder*) clone;

- (TestRequiredOptimizedForSize*) build;
- (TestRequiredOptimizedForSize*) buildPartial;

- (TestRequiredOptimizedForSize_Builder*) mergeFrom:(TestRequiredOptimizedForSize*) other;
- (TestRequiredOptimizedForSize_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (TestRequiredOptimizedForSize_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasX;
- (int32_t) x;
- (TestRequiredOptimizedForSize_Builder*) setX:(int32_t) value;
- (TestRequiredOptimizedForSize_Builder*) clearX;
@end

@interface TestOptionalOptimizedForSize : PBGeneratedMessage {
@private
  BOOL hasO_:1;
  TestRequiredOptimizedForSize* o;
}
- (BOOL) hasO;
@property (readonly, retain) TestRequiredOptimizedForSize* o;

+ (TestOptionalOptimizedForSize*) defaultInstance;
- (TestOptionalOptimizedForSize*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (TestOptionalOptimizedForSize_Builder*) builder;
+ (TestOptionalOptimizedForSize_Builder*) builder;
+ (TestOptionalOptimizedForSize_Builder*) builderWithPrototype:(TestOptionalOptimizedForSize*) prototype;

+ (TestOptionalOptimizedForSize*) parseFromData:(NSData*) data;
+ (TestOptionalOptimizedForSize*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (TestOptionalOptimizedForSize*) parseFromInputStream:(NSInputStream*) input;
+ (TestOptionalOptimizedForSize*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (TestOptionalOptimizedForSize*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (TestOptionalOptimizedForSize*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface TestOptionalOptimizedForSize_Builder : PBGeneratedMessage_Builder {
@private
  TestOptionalOptimizedForSize* result;
}

- (TestOptionalOptimizedForSize*) defaultInstance;

- (TestOptionalOptimizedForSize_Builder*) clear;
- (TestOptionalOptimizedForSize_Builder*) clone;

- (TestOptionalOptimizedForSize*) build;
- (TestOptionalOptimizedForSize*) buildPartial;

- (TestOptionalOptimizedForSize_Builder*) mergeFrom:(TestOptionalOptimizedForSize*) other;
- (TestOptionalOptimizedForSize_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (TestOptionalOptimizedForSize_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasO;
- (TestRequiredOptimizedForSize*) o;
- (TestOptionalOptimizedForSize_Builder*) setO:(TestRequiredOptimizedForSize*) value;
- (TestOptionalOptimizedForSize_Builder*) setOBuilder:(TestRequiredOptimizedForSize_Builder*) builderForValue;
- (TestOptionalOptimizedForSize_Builder*) mergeO:(TestRequiredOptimizedForSize*) value;
- (TestOptionalOptimizedForSize_Builder*) clearO;
@end
