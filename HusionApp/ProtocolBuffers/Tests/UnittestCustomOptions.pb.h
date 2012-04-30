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

#import "Descriptor.pb.h"

@class ComplexOpt6;
@class ComplexOpt6_Builder;
@class ComplexOptionType1;
@class ComplexOptionType1_Builder;
@class ComplexOptionType2;
@class ComplexOptionType2_Builder;
@class ComplexOptionType2_ComplexOptionType4;
@class ComplexOptionType2_ComplexOptionType4_Builder;
@class ComplexOptionType3;
@class ComplexOptionType3_Builder;
@class ComplexOptionType3_ComplexOptionType5;
@class ComplexOptionType3_ComplexOptionType5_Builder;
@class CustomOptionFooRequest;
@class CustomOptionFooRequest_Builder;
@class CustomOptionFooResponse;
@class CustomOptionFooResponse_Builder;
@class CustomOptionMaxIntegerValues;
@class CustomOptionMaxIntegerValues_Builder;
@class CustomOptionMinIntegerValues;
@class CustomOptionMinIntegerValues_Builder;
@class CustomOptionOtherValues;
@class CustomOptionOtherValues_Builder;
@class DummyMessageContainingEnum;
@class DummyMessageContainingEnum_Builder;
@class DummyMessageInvalidAsOptionType;
@class DummyMessageInvalidAsOptionType_Builder;
@class PBDescriptorProto;
@class PBDescriptorProto_Builder;
@class PBDescriptorProto_ExtensionRange;
@class PBDescriptorProto_ExtensionRange_Builder;
@class PBEnumDescriptorProto;
@class PBEnumDescriptorProto_Builder;
@class PBEnumOptions;
@class PBEnumOptions_Builder;
@class PBEnumValueDescriptorProto;
@class PBEnumValueDescriptorProto_Builder;
@class PBEnumValueOptions;
@class PBEnumValueOptions_Builder;
@class PBFieldDescriptorProto;
@class PBFieldDescriptorProto_Builder;
@class PBFieldOptions;
@class PBFieldOptions_Builder;
@class PBFileDescriptorProto;
@class PBFileDescriptorProto_Builder;
@class PBFileDescriptorSet;
@class PBFileDescriptorSet_Builder;
@class PBFileOptions;
@class PBFileOptions_Builder;
@class PBMessageOptions;
@class PBMessageOptions_Builder;
@class PBMethodDescriptorProto;
@class PBMethodDescriptorProto_Builder;
@class PBMethodOptions;
@class PBMethodOptions_Builder;
@class PBServiceDescriptorProto;
@class PBServiceDescriptorProto_Builder;
@class PBServiceOptions;
@class PBServiceOptions_Builder;
@class PBUninterpretedOption;
@class PBUninterpretedOption_Builder;
@class PBUninterpretedOption_NamePart;
@class PBUninterpretedOption_NamePart_Builder;
@class SettingRealsFromNegativeInts;
@class SettingRealsFromNegativeInts_Builder;
@class SettingRealsFromPositiveInts;
@class SettingRealsFromPositiveInts_Builder;
@class TestMessageWithCustomOptions;
@class TestMessageWithCustomOptions_Builder;
@class VariousComplexOptions;
@class VariousComplexOptions_Builder;
typedef enum {
  MethodOpt1Methodopt1Val1 = 1,
  MethodOpt1Methodopt1Val2 = 2,
} MethodOpt1;

BOOL MethodOpt1IsValidValue(MethodOpt1 value);

typedef enum {
  TestMessageWithCustomOptions_AnEnumAnenumVal1 = 1,
  TestMessageWithCustomOptions_AnEnumAnenumVal2 = 2,
} TestMessageWithCustomOptions_AnEnum;

BOOL TestMessageWithCustomOptions_AnEnumIsValidValue(TestMessageWithCustomOptions_AnEnum value);

typedef enum {
  DummyMessageContainingEnum_TestEnumTypeTestOptionEnumType1 = 22,
  DummyMessageContainingEnum_TestEnumTypeTestOptionEnumType2 = -23,
} DummyMessageContainingEnum_TestEnumType;

BOOL DummyMessageContainingEnum_TestEnumTypeIsValidValue(DummyMessageContainingEnum_TestEnumType value);


@interface UnittestCustomOptionsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
+ (id<PBExtensionField>) fileOpt1;
+ (id<PBExtensionField>) messageOpt1;
+ (id<PBExtensionField>) fieldOpt1;
+ (id<PBExtensionField>) fieldOpt2;
+ (id<PBExtensionField>) enumOpt1;
+ (id<PBExtensionField>) enumValueOpt1;
+ (id<PBExtensionField>) serviceOpt1;
+ (id<PBExtensionField>) methodOpt1;
+ (id<PBExtensionField>) boolOpt;
+ (id<PBExtensionField>) int32Opt;
+ (id<PBExtensionField>) int64Opt;
+ (id<PBExtensionField>) uint32Opt;
+ (id<PBExtensionField>) uint64Opt;
+ (id<PBExtensionField>) sint32Opt;
+ (id<PBExtensionField>) sint64Opt;
+ (id<PBExtensionField>) fixed32Opt;
+ (id<PBExtensionField>) fixed64Opt;
+ (id<PBExtensionField>) sfixed32Opt;
+ (id<PBExtensionField>) sfixed64Opt;
+ (id<PBExtensionField>) floatOpt;
+ (id<PBExtensionField>) doubleOpt;
+ (id<PBExtensionField>) stringOpt;
+ (id<PBExtensionField>) bytesOpt;
+ (id<PBExtensionField>) enumOpt;
+ (id<PBExtensionField>) messageTypeOpt;
+ (id<PBExtensionField>) quux;
+ (id<PBExtensionField>) corge;
+ (id<PBExtensionField>) grault;
+ (id<PBExtensionField>) garply;
+ (id<PBExtensionField>) complexOpt1;
+ (id<PBExtensionField>) complexOpt2;
+ (id<PBExtensionField>) complexOpt3;
+ (id<PBExtensionField>) complexOpt6;
@end

@interface TestMessageWithCustomOptions : PBGeneratedMessage {
@private
  BOOL hasField1_:1;
  NSString* field1;
}
- (BOOL) hasField1;
@property (readonly, retain) NSString* field1;

+ (TestMessageWithCustomOptions*) defaultInstance;
- (TestMessageWithCustomOptions*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (TestMessageWithCustomOptions_Builder*) builder;
+ (TestMessageWithCustomOptions_Builder*) builder;
+ (TestMessageWithCustomOptions_Builder*) builderWithPrototype:(TestMessageWithCustomOptions*) prototype;

+ (TestMessageWithCustomOptions*) parseFromData:(NSData*) data;
+ (TestMessageWithCustomOptions*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (TestMessageWithCustomOptions*) parseFromInputStream:(NSInputStream*) input;
+ (TestMessageWithCustomOptions*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (TestMessageWithCustomOptions*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (TestMessageWithCustomOptions*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface TestMessageWithCustomOptions_Builder : PBGeneratedMessage_Builder {
@private
  TestMessageWithCustomOptions* result;
}

- (TestMessageWithCustomOptions*) defaultInstance;

- (TestMessageWithCustomOptions_Builder*) clear;
- (TestMessageWithCustomOptions_Builder*) clone;

- (TestMessageWithCustomOptions*) build;
- (TestMessageWithCustomOptions*) buildPartial;

- (TestMessageWithCustomOptions_Builder*) mergeFrom:(TestMessageWithCustomOptions*) other;
- (TestMessageWithCustomOptions_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (TestMessageWithCustomOptions_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasField1;
- (NSString*) field1;
- (TestMessageWithCustomOptions_Builder*) setField1:(NSString*) value;
- (TestMessageWithCustomOptions_Builder*) clearField1;
@end

@interface CustomOptionFooRequest : PBGeneratedMessage {
@private
}

+ (CustomOptionFooRequest*) defaultInstance;
- (CustomOptionFooRequest*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (CustomOptionFooRequest_Builder*) builder;
+ (CustomOptionFooRequest_Builder*) builder;
+ (CustomOptionFooRequest_Builder*) builderWithPrototype:(CustomOptionFooRequest*) prototype;

+ (CustomOptionFooRequest*) parseFromData:(NSData*) data;
+ (CustomOptionFooRequest*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CustomOptionFooRequest*) parseFromInputStream:(NSInputStream*) input;
+ (CustomOptionFooRequest*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CustomOptionFooRequest*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (CustomOptionFooRequest*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface CustomOptionFooRequest_Builder : PBGeneratedMessage_Builder {
@private
  CustomOptionFooRequest* result;
}

- (CustomOptionFooRequest*) defaultInstance;

- (CustomOptionFooRequest_Builder*) clear;
- (CustomOptionFooRequest_Builder*) clone;

- (CustomOptionFooRequest*) build;
- (CustomOptionFooRequest*) buildPartial;

- (CustomOptionFooRequest_Builder*) mergeFrom:(CustomOptionFooRequest*) other;
- (CustomOptionFooRequest_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (CustomOptionFooRequest_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface CustomOptionFooResponse : PBGeneratedMessage {
@private
}

+ (CustomOptionFooResponse*) defaultInstance;
- (CustomOptionFooResponse*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (CustomOptionFooResponse_Builder*) builder;
+ (CustomOptionFooResponse_Builder*) builder;
+ (CustomOptionFooResponse_Builder*) builderWithPrototype:(CustomOptionFooResponse*) prototype;

+ (CustomOptionFooResponse*) parseFromData:(NSData*) data;
+ (CustomOptionFooResponse*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CustomOptionFooResponse*) parseFromInputStream:(NSInputStream*) input;
+ (CustomOptionFooResponse*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CustomOptionFooResponse*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (CustomOptionFooResponse*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface CustomOptionFooResponse_Builder : PBGeneratedMessage_Builder {
@private
  CustomOptionFooResponse* result;
}

- (CustomOptionFooResponse*) defaultInstance;

- (CustomOptionFooResponse_Builder*) clear;
- (CustomOptionFooResponse_Builder*) clone;

- (CustomOptionFooResponse*) build;
- (CustomOptionFooResponse*) buildPartial;

- (CustomOptionFooResponse_Builder*) mergeFrom:(CustomOptionFooResponse*) other;
- (CustomOptionFooResponse_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (CustomOptionFooResponse_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface DummyMessageContainingEnum : PBGeneratedMessage {
@private
}

+ (DummyMessageContainingEnum*) defaultInstance;
- (DummyMessageContainingEnum*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (DummyMessageContainingEnum_Builder*) builder;
+ (DummyMessageContainingEnum_Builder*) builder;
+ (DummyMessageContainingEnum_Builder*) builderWithPrototype:(DummyMessageContainingEnum*) prototype;

+ (DummyMessageContainingEnum*) parseFromData:(NSData*) data;
+ (DummyMessageContainingEnum*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (DummyMessageContainingEnum*) parseFromInputStream:(NSInputStream*) input;
+ (DummyMessageContainingEnum*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (DummyMessageContainingEnum*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (DummyMessageContainingEnum*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface DummyMessageContainingEnum_Builder : PBGeneratedMessage_Builder {
@private
  DummyMessageContainingEnum* result;
}

- (DummyMessageContainingEnum*) defaultInstance;

- (DummyMessageContainingEnum_Builder*) clear;
- (DummyMessageContainingEnum_Builder*) clone;

- (DummyMessageContainingEnum*) build;
- (DummyMessageContainingEnum*) buildPartial;

- (DummyMessageContainingEnum_Builder*) mergeFrom:(DummyMessageContainingEnum*) other;
- (DummyMessageContainingEnum_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (DummyMessageContainingEnum_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface DummyMessageInvalidAsOptionType : PBGeneratedMessage {
@private
}

+ (DummyMessageInvalidAsOptionType*) defaultInstance;
- (DummyMessageInvalidAsOptionType*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (DummyMessageInvalidAsOptionType_Builder*) builder;
+ (DummyMessageInvalidAsOptionType_Builder*) builder;
+ (DummyMessageInvalidAsOptionType_Builder*) builderWithPrototype:(DummyMessageInvalidAsOptionType*) prototype;

+ (DummyMessageInvalidAsOptionType*) parseFromData:(NSData*) data;
+ (DummyMessageInvalidAsOptionType*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (DummyMessageInvalidAsOptionType*) parseFromInputStream:(NSInputStream*) input;
+ (DummyMessageInvalidAsOptionType*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (DummyMessageInvalidAsOptionType*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (DummyMessageInvalidAsOptionType*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface DummyMessageInvalidAsOptionType_Builder : PBGeneratedMessage_Builder {
@private
  DummyMessageInvalidAsOptionType* result;
}

- (DummyMessageInvalidAsOptionType*) defaultInstance;

- (DummyMessageInvalidAsOptionType_Builder*) clear;
- (DummyMessageInvalidAsOptionType_Builder*) clone;

- (DummyMessageInvalidAsOptionType*) build;
- (DummyMessageInvalidAsOptionType*) buildPartial;

- (DummyMessageInvalidAsOptionType_Builder*) mergeFrom:(DummyMessageInvalidAsOptionType*) other;
- (DummyMessageInvalidAsOptionType_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (DummyMessageInvalidAsOptionType_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface CustomOptionMinIntegerValues : PBGeneratedMessage {
@private
}

+ (CustomOptionMinIntegerValues*) defaultInstance;
- (CustomOptionMinIntegerValues*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (CustomOptionMinIntegerValues_Builder*) builder;
+ (CustomOptionMinIntegerValues_Builder*) builder;
+ (CustomOptionMinIntegerValues_Builder*) builderWithPrototype:(CustomOptionMinIntegerValues*) prototype;

+ (CustomOptionMinIntegerValues*) parseFromData:(NSData*) data;
+ (CustomOptionMinIntegerValues*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CustomOptionMinIntegerValues*) parseFromInputStream:(NSInputStream*) input;
+ (CustomOptionMinIntegerValues*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CustomOptionMinIntegerValues*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (CustomOptionMinIntegerValues*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface CustomOptionMinIntegerValues_Builder : PBGeneratedMessage_Builder {
@private
  CustomOptionMinIntegerValues* result;
}

- (CustomOptionMinIntegerValues*) defaultInstance;

- (CustomOptionMinIntegerValues_Builder*) clear;
- (CustomOptionMinIntegerValues_Builder*) clone;

- (CustomOptionMinIntegerValues*) build;
- (CustomOptionMinIntegerValues*) buildPartial;

- (CustomOptionMinIntegerValues_Builder*) mergeFrom:(CustomOptionMinIntegerValues*) other;
- (CustomOptionMinIntegerValues_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (CustomOptionMinIntegerValues_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface CustomOptionMaxIntegerValues : PBGeneratedMessage {
@private
}

+ (CustomOptionMaxIntegerValues*) defaultInstance;
- (CustomOptionMaxIntegerValues*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (CustomOptionMaxIntegerValues_Builder*) builder;
+ (CustomOptionMaxIntegerValues_Builder*) builder;
+ (CustomOptionMaxIntegerValues_Builder*) builderWithPrototype:(CustomOptionMaxIntegerValues*) prototype;

+ (CustomOptionMaxIntegerValues*) parseFromData:(NSData*) data;
+ (CustomOptionMaxIntegerValues*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CustomOptionMaxIntegerValues*) parseFromInputStream:(NSInputStream*) input;
+ (CustomOptionMaxIntegerValues*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CustomOptionMaxIntegerValues*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (CustomOptionMaxIntegerValues*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface CustomOptionMaxIntegerValues_Builder : PBGeneratedMessage_Builder {
@private
  CustomOptionMaxIntegerValues* result;
}

- (CustomOptionMaxIntegerValues*) defaultInstance;

- (CustomOptionMaxIntegerValues_Builder*) clear;
- (CustomOptionMaxIntegerValues_Builder*) clone;

- (CustomOptionMaxIntegerValues*) build;
- (CustomOptionMaxIntegerValues*) buildPartial;

- (CustomOptionMaxIntegerValues_Builder*) mergeFrom:(CustomOptionMaxIntegerValues*) other;
- (CustomOptionMaxIntegerValues_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (CustomOptionMaxIntegerValues_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface CustomOptionOtherValues : PBGeneratedMessage {
@private
}

+ (CustomOptionOtherValues*) defaultInstance;
- (CustomOptionOtherValues*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (CustomOptionOtherValues_Builder*) builder;
+ (CustomOptionOtherValues_Builder*) builder;
+ (CustomOptionOtherValues_Builder*) builderWithPrototype:(CustomOptionOtherValues*) prototype;

+ (CustomOptionOtherValues*) parseFromData:(NSData*) data;
+ (CustomOptionOtherValues*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CustomOptionOtherValues*) parseFromInputStream:(NSInputStream*) input;
+ (CustomOptionOtherValues*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CustomOptionOtherValues*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (CustomOptionOtherValues*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface CustomOptionOtherValues_Builder : PBGeneratedMessage_Builder {
@private
  CustomOptionOtherValues* result;
}

- (CustomOptionOtherValues*) defaultInstance;

- (CustomOptionOtherValues_Builder*) clear;
- (CustomOptionOtherValues_Builder*) clone;

- (CustomOptionOtherValues*) build;
- (CustomOptionOtherValues*) buildPartial;

- (CustomOptionOtherValues_Builder*) mergeFrom:(CustomOptionOtherValues*) other;
- (CustomOptionOtherValues_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (CustomOptionOtherValues_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface SettingRealsFromPositiveInts : PBGeneratedMessage {
@private
}

+ (SettingRealsFromPositiveInts*) defaultInstance;
- (SettingRealsFromPositiveInts*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (SettingRealsFromPositiveInts_Builder*) builder;
+ (SettingRealsFromPositiveInts_Builder*) builder;
+ (SettingRealsFromPositiveInts_Builder*) builderWithPrototype:(SettingRealsFromPositiveInts*) prototype;

+ (SettingRealsFromPositiveInts*) parseFromData:(NSData*) data;
+ (SettingRealsFromPositiveInts*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SettingRealsFromPositiveInts*) parseFromInputStream:(NSInputStream*) input;
+ (SettingRealsFromPositiveInts*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SettingRealsFromPositiveInts*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (SettingRealsFromPositiveInts*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface SettingRealsFromPositiveInts_Builder : PBGeneratedMessage_Builder {
@private
  SettingRealsFromPositiveInts* result;
}

- (SettingRealsFromPositiveInts*) defaultInstance;

- (SettingRealsFromPositiveInts_Builder*) clear;
- (SettingRealsFromPositiveInts_Builder*) clone;

- (SettingRealsFromPositiveInts*) build;
- (SettingRealsFromPositiveInts*) buildPartial;

- (SettingRealsFromPositiveInts_Builder*) mergeFrom:(SettingRealsFromPositiveInts*) other;
- (SettingRealsFromPositiveInts_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (SettingRealsFromPositiveInts_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface SettingRealsFromNegativeInts : PBGeneratedMessage {
@private
}

+ (SettingRealsFromNegativeInts*) defaultInstance;
- (SettingRealsFromNegativeInts*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (SettingRealsFromNegativeInts_Builder*) builder;
+ (SettingRealsFromNegativeInts_Builder*) builder;
+ (SettingRealsFromNegativeInts_Builder*) builderWithPrototype:(SettingRealsFromNegativeInts*) prototype;

+ (SettingRealsFromNegativeInts*) parseFromData:(NSData*) data;
+ (SettingRealsFromNegativeInts*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SettingRealsFromNegativeInts*) parseFromInputStream:(NSInputStream*) input;
+ (SettingRealsFromNegativeInts*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SettingRealsFromNegativeInts*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (SettingRealsFromNegativeInts*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface SettingRealsFromNegativeInts_Builder : PBGeneratedMessage_Builder {
@private
  SettingRealsFromNegativeInts* result;
}

- (SettingRealsFromNegativeInts*) defaultInstance;

- (SettingRealsFromNegativeInts_Builder*) clear;
- (SettingRealsFromNegativeInts_Builder*) clone;

- (SettingRealsFromNegativeInts*) build;
- (SettingRealsFromNegativeInts*) buildPartial;

- (SettingRealsFromNegativeInts_Builder*) mergeFrom:(SettingRealsFromNegativeInts*) other;
- (SettingRealsFromNegativeInts_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (SettingRealsFromNegativeInts_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ComplexOptionType1 : PBExtendableMessage {
@private
  BOOL hasFoo_:1;
  int32_t foo;
}
- (BOOL) hasFoo;
@property (readonly) int32_t foo;

+ (ComplexOptionType1*) defaultInstance;
- (ComplexOptionType1*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ComplexOptionType1_Builder*) builder;
+ (ComplexOptionType1_Builder*) builder;
+ (ComplexOptionType1_Builder*) builderWithPrototype:(ComplexOptionType1*) prototype;

+ (ComplexOptionType1*) parseFromData:(NSData*) data;
+ (ComplexOptionType1*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOptionType1*) parseFromInputStream:(NSInputStream*) input;
+ (ComplexOptionType1*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOptionType1*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ComplexOptionType1*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ComplexOptionType1_Builder : PBExtendableMessage_Builder {
@private
  ComplexOptionType1* result;
}

- (ComplexOptionType1*) defaultInstance;

- (ComplexOptionType1_Builder*) clear;
- (ComplexOptionType1_Builder*) clone;

- (ComplexOptionType1*) build;
- (ComplexOptionType1*) buildPartial;

- (ComplexOptionType1_Builder*) mergeFrom:(ComplexOptionType1*) other;
- (ComplexOptionType1_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ComplexOptionType1_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasFoo;
- (int32_t) foo;
- (ComplexOptionType1_Builder*) setFoo:(int32_t) value;
- (ComplexOptionType1_Builder*) clearFoo;
@end

@interface ComplexOptionType2 : PBExtendableMessage {
@private
  BOOL hasBaz_:1;
  BOOL hasBar_:1;
  BOOL hasFred_:1;
  int32_t baz;
  ComplexOptionType1* bar;
  ComplexOptionType2_ComplexOptionType4* fred;
}
- (BOOL) hasBar;
- (BOOL) hasBaz;
- (BOOL) hasFred;
@property (readonly, retain) ComplexOptionType1* bar;
@property (readonly) int32_t baz;
@property (readonly, retain) ComplexOptionType2_ComplexOptionType4* fred;

+ (ComplexOptionType2*) defaultInstance;
- (ComplexOptionType2*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ComplexOptionType2_Builder*) builder;
+ (ComplexOptionType2_Builder*) builder;
+ (ComplexOptionType2_Builder*) builderWithPrototype:(ComplexOptionType2*) prototype;

+ (ComplexOptionType2*) parseFromData:(NSData*) data;
+ (ComplexOptionType2*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOptionType2*) parseFromInputStream:(NSInputStream*) input;
+ (ComplexOptionType2*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOptionType2*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ComplexOptionType2*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ComplexOptionType2_ComplexOptionType4 : PBGeneratedMessage {
@private
  BOOL hasWaldo_:1;
  int32_t waldo;
}
- (BOOL) hasWaldo;
@property (readonly) int32_t waldo;

+ (ComplexOptionType2_ComplexOptionType4*) defaultInstance;
- (ComplexOptionType2_ComplexOptionType4*) defaultInstance;

+ (id<PBExtensionField>) complexOpt4;
- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ComplexOptionType2_ComplexOptionType4_Builder*) builder;
+ (ComplexOptionType2_ComplexOptionType4_Builder*) builder;
+ (ComplexOptionType2_ComplexOptionType4_Builder*) builderWithPrototype:(ComplexOptionType2_ComplexOptionType4*) prototype;

+ (ComplexOptionType2_ComplexOptionType4*) parseFromData:(NSData*) data;
+ (ComplexOptionType2_ComplexOptionType4*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOptionType2_ComplexOptionType4*) parseFromInputStream:(NSInputStream*) input;
+ (ComplexOptionType2_ComplexOptionType4*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOptionType2_ComplexOptionType4*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ComplexOptionType2_ComplexOptionType4*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ComplexOptionType2_ComplexOptionType4_Builder : PBGeneratedMessage_Builder {
@private
  ComplexOptionType2_ComplexOptionType4* result;
}

- (ComplexOptionType2_ComplexOptionType4*) defaultInstance;

- (ComplexOptionType2_ComplexOptionType4_Builder*) clear;
- (ComplexOptionType2_ComplexOptionType4_Builder*) clone;

- (ComplexOptionType2_ComplexOptionType4*) build;
- (ComplexOptionType2_ComplexOptionType4*) buildPartial;

- (ComplexOptionType2_ComplexOptionType4_Builder*) mergeFrom:(ComplexOptionType2_ComplexOptionType4*) other;
- (ComplexOptionType2_ComplexOptionType4_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ComplexOptionType2_ComplexOptionType4_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasWaldo;
- (int32_t) waldo;
- (ComplexOptionType2_ComplexOptionType4_Builder*) setWaldo:(int32_t) value;
- (ComplexOptionType2_ComplexOptionType4_Builder*) clearWaldo;
@end

@interface ComplexOptionType2_Builder : PBExtendableMessage_Builder {
@private
  ComplexOptionType2* result;
}

- (ComplexOptionType2*) defaultInstance;

- (ComplexOptionType2_Builder*) clear;
- (ComplexOptionType2_Builder*) clone;

- (ComplexOptionType2*) build;
- (ComplexOptionType2*) buildPartial;

- (ComplexOptionType2_Builder*) mergeFrom:(ComplexOptionType2*) other;
- (ComplexOptionType2_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ComplexOptionType2_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasBar;
- (ComplexOptionType1*) bar;
- (ComplexOptionType2_Builder*) setBar:(ComplexOptionType1*) value;
- (ComplexOptionType2_Builder*) setBarBuilder:(ComplexOptionType1_Builder*) builderForValue;
- (ComplexOptionType2_Builder*) mergeBar:(ComplexOptionType1*) value;
- (ComplexOptionType2_Builder*) clearBar;

- (BOOL) hasBaz;
- (int32_t) baz;
- (ComplexOptionType2_Builder*) setBaz:(int32_t) value;
- (ComplexOptionType2_Builder*) clearBaz;

- (BOOL) hasFred;
- (ComplexOptionType2_ComplexOptionType4*) fred;
- (ComplexOptionType2_Builder*) setFred:(ComplexOptionType2_ComplexOptionType4*) value;
- (ComplexOptionType2_Builder*) setFredBuilder:(ComplexOptionType2_ComplexOptionType4_Builder*) builderForValue;
- (ComplexOptionType2_Builder*) mergeFred:(ComplexOptionType2_ComplexOptionType4*) value;
- (ComplexOptionType2_Builder*) clearFred;
@end

@interface ComplexOptionType3 : PBGeneratedMessage {
@private
  BOOL hasQux_:1;
  BOOL hasComplexOptionType5_:1;
  int32_t qux;
  ComplexOptionType3_ComplexOptionType5* complexOptionType5;
}
- (BOOL) hasQux;
- (BOOL) hasComplexOptionType5;
@property (readonly) int32_t qux;
@property (readonly, retain) ComplexOptionType3_ComplexOptionType5* complexOptionType5;

+ (ComplexOptionType3*) defaultInstance;
- (ComplexOptionType3*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ComplexOptionType3_Builder*) builder;
+ (ComplexOptionType3_Builder*) builder;
+ (ComplexOptionType3_Builder*) builderWithPrototype:(ComplexOptionType3*) prototype;

+ (ComplexOptionType3*) parseFromData:(NSData*) data;
+ (ComplexOptionType3*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOptionType3*) parseFromInputStream:(NSInputStream*) input;
+ (ComplexOptionType3*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOptionType3*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ComplexOptionType3*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ComplexOptionType3_ComplexOptionType5 : PBGeneratedMessage {
@private
  BOOL hasPlugh_:1;
  int32_t plugh;
}
- (BOOL) hasPlugh;
@property (readonly) int32_t plugh;

+ (ComplexOptionType3_ComplexOptionType5*) defaultInstance;
- (ComplexOptionType3_ComplexOptionType5*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ComplexOptionType3_ComplexOptionType5_Builder*) builder;
+ (ComplexOptionType3_ComplexOptionType5_Builder*) builder;
+ (ComplexOptionType3_ComplexOptionType5_Builder*) builderWithPrototype:(ComplexOptionType3_ComplexOptionType5*) prototype;

+ (ComplexOptionType3_ComplexOptionType5*) parseFromData:(NSData*) data;
+ (ComplexOptionType3_ComplexOptionType5*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOptionType3_ComplexOptionType5*) parseFromInputStream:(NSInputStream*) input;
+ (ComplexOptionType3_ComplexOptionType5*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOptionType3_ComplexOptionType5*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ComplexOptionType3_ComplexOptionType5*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ComplexOptionType3_ComplexOptionType5_Builder : PBGeneratedMessage_Builder {
@private
  ComplexOptionType3_ComplexOptionType5* result;
}

- (ComplexOptionType3_ComplexOptionType5*) defaultInstance;

- (ComplexOptionType3_ComplexOptionType5_Builder*) clear;
- (ComplexOptionType3_ComplexOptionType5_Builder*) clone;

- (ComplexOptionType3_ComplexOptionType5*) build;
- (ComplexOptionType3_ComplexOptionType5*) buildPartial;

- (ComplexOptionType3_ComplexOptionType5_Builder*) mergeFrom:(ComplexOptionType3_ComplexOptionType5*) other;
- (ComplexOptionType3_ComplexOptionType5_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ComplexOptionType3_ComplexOptionType5_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasPlugh;
- (int32_t) plugh;
- (ComplexOptionType3_ComplexOptionType5_Builder*) setPlugh:(int32_t) value;
- (ComplexOptionType3_ComplexOptionType5_Builder*) clearPlugh;
@end

@interface ComplexOptionType3_Builder : PBGeneratedMessage_Builder {
@private
  ComplexOptionType3* result;
}

- (ComplexOptionType3*) defaultInstance;

- (ComplexOptionType3_Builder*) clear;
- (ComplexOptionType3_Builder*) clone;

- (ComplexOptionType3*) build;
- (ComplexOptionType3*) buildPartial;

- (ComplexOptionType3_Builder*) mergeFrom:(ComplexOptionType3*) other;
- (ComplexOptionType3_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ComplexOptionType3_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasQux;
- (int32_t) qux;
- (ComplexOptionType3_Builder*) setQux:(int32_t) value;
- (ComplexOptionType3_Builder*) clearQux;

- (BOOL) hasComplexOptionType5;
- (ComplexOptionType3_ComplexOptionType5*) complexOptionType5;
- (ComplexOptionType3_Builder*) setComplexOptionType5:(ComplexOptionType3_ComplexOptionType5*) value;
- (ComplexOptionType3_Builder*) setComplexOptionType5Builder:(ComplexOptionType3_ComplexOptionType5_Builder*) builderForValue;
- (ComplexOptionType3_Builder*) mergeComplexOptionType5:(ComplexOptionType3_ComplexOptionType5*) value;
- (ComplexOptionType3_Builder*) clearComplexOptionType5;
@end

@interface ComplexOpt6 : PBGeneratedMessage {
@private
  BOOL hasXyzzy_:1;
  int32_t xyzzy;
}
- (BOOL) hasXyzzy;
@property (readonly) int32_t xyzzy;

+ (ComplexOpt6*) defaultInstance;
- (ComplexOpt6*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ComplexOpt6_Builder*) builder;
+ (ComplexOpt6_Builder*) builder;
+ (ComplexOpt6_Builder*) builderWithPrototype:(ComplexOpt6*) prototype;

+ (ComplexOpt6*) parseFromData:(NSData*) data;
+ (ComplexOpt6*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOpt6*) parseFromInputStream:(NSInputStream*) input;
+ (ComplexOpt6*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ComplexOpt6*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ComplexOpt6*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ComplexOpt6_Builder : PBGeneratedMessage_Builder {
@private
  ComplexOpt6* result;
}

- (ComplexOpt6*) defaultInstance;

- (ComplexOpt6_Builder*) clear;
- (ComplexOpt6_Builder*) clone;

- (ComplexOpt6*) build;
- (ComplexOpt6*) buildPartial;

- (ComplexOpt6_Builder*) mergeFrom:(ComplexOpt6*) other;
- (ComplexOpt6_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ComplexOpt6_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasXyzzy;
- (int32_t) xyzzy;
- (ComplexOpt6_Builder*) setXyzzy:(int32_t) value;
- (ComplexOpt6_Builder*) clearXyzzy;
@end

@interface VariousComplexOptions : PBGeneratedMessage {
@private
}

+ (VariousComplexOptions*) defaultInstance;
- (VariousComplexOptions*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (VariousComplexOptions_Builder*) builder;
+ (VariousComplexOptions_Builder*) builder;
+ (VariousComplexOptions_Builder*) builderWithPrototype:(VariousComplexOptions*) prototype;

+ (VariousComplexOptions*) parseFromData:(NSData*) data;
+ (VariousComplexOptions*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (VariousComplexOptions*) parseFromInputStream:(NSInputStream*) input;
+ (VariousComplexOptions*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (VariousComplexOptions*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (VariousComplexOptions*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface VariousComplexOptions_Builder : PBGeneratedMessage_Builder {
@private
  VariousComplexOptions* result;
}

- (VariousComplexOptions*) defaultInstance;

- (VariousComplexOptions_Builder*) clear;
- (VariousComplexOptions_Builder*) clone;

- (VariousComplexOptions*) build;
- (VariousComplexOptions*) buildPartial;

- (VariousComplexOptions_Builder*) mergeFrom:(VariousComplexOptions*) other;
- (VariousComplexOptions_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (VariousComplexOptions_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end
