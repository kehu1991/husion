// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class SmartPhoneDataMessage;
@class SmartPhoneDataMessage_Builder;
@class SmartPhoneNodeMessage;
@class SmartPhoneNodeMessage_Builder;
@class SmartPhoneNodeMessage_Point;
@class SmartPhoneNodeMessage_Point_Builder;

@interface SmartPhoneMessagesRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface SmartPhoneNodeMessage : PBGeneratedMessage {
@private
  BOOL hasId_:1;
  BOOL hasConfidence_:1;
  BOOL hasSubject_:1;
  BOOL hasPreposition_:1;
  BOOL hasObject_:1;
  int32_t id;
  int32_t confidence;
  NSString* subject;
  NSString* preposition;
  NSString* object;
  NSMutableArray* mutableCoordinatesList;
}
- (BOOL) hasId;
- (BOOL) hasSubject;
- (BOOL) hasPreposition;
- (BOOL) hasObject;
- (BOOL) hasConfidence;
@property (readonly) int32_t id;
@property (readonly, retain) NSString* subject;
@property (readonly, retain) NSString* preposition;
@property (readonly, retain) NSString* object;
@property (readonly) int32_t confidence;
- (NSArray*) coordinatesList;
- (SmartPhoneNodeMessage_Point*) coordinatesAtIndex:(int32_t) index;

+ (SmartPhoneNodeMessage*) defaultInstance;
- (SmartPhoneNodeMessage*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (SmartPhoneNodeMessage_Builder*) builder;
+ (SmartPhoneNodeMessage_Builder*) builder;
+ (SmartPhoneNodeMessage_Builder*) builderWithPrototype:(SmartPhoneNodeMessage*) prototype;

+ (SmartPhoneNodeMessage*) parseFromData:(NSData*) data;
+ (SmartPhoneNodeMessage*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SmartPhoneNodeMessage*) parseFromInputStream:(NSInputStream*) input;
+ (SmartPhoneNodeMessage*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SmartPhoneNodeMessage*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (SmartPhoneNodeMessage*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface SmartPhoneNodeMessage_Point : PBGeneratedMessage {
@private
  BOOL hasX_:1;
  BOOL hasY_:1;
  BOOL hasZ_:1;
  Float64 x;
  Float64 y;
  Float64 z;
}
- (BOOL) hasX;
- (BOOL) hasY;
- (BOOL) hasZ;
@property (readonly) Float64 x;
@property (readonly) Float64 y;
@property (readonly) Float64 z;

+ (SmartPhoneNodeMessage_Point*) defaultInstance;
- (SmartPhoneNodeMessage_Point*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (SmartPhoneNodeMessage_Point_Builder*) builder;
+ (SmartPhoneNodeMessage_Point_Builder*) builder;
+ (SmartPhoneNodeMessage_Point_Builder*) builderWithPrototype:(SmartPhoneNodeMessage_Point*) prototype;

+ (SmartPhoneNodeMessage_Point*) parseFromData:(NSData*) data;
+ (SmartPhoneNodeMessage_Point*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SmartPhoneNodeMessage_Point*) parseFromInputStream:(NSInputStream*) input;
+ (SmartPhoneNodeMessage_Point*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SmartPhoneNodeMessage_Point*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (SmartPhoneNodeMessage_Point*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface SmartPhoneNodeMessage_Point_Builder : PBGeneratedMessage_Builder {
@private
  SmartPhoneNodeMessage_Point* result;
}

- (SmartPhoneNodeMessage_Point*) defaultInstance;

- (SmartPhoneNodeMessage_Point_Builder*) clear;
- (SmartPhoneNodeMessage_Point_Builder*) clone;

- (SmartPhoneNodeMessage_Point*) build;
- (SmartPhoneNodeMessage_Point*) buildPartial;

- (SmartPhoneNodeMessage_Point_Builder*) mergeFrom:(SmartPhoneNodeMessage_Point*) other;
- (SmartPhoneNodeMessage_Point_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (SmartPhoneNodeMessage_Point_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasX;
- (Float64) x;
- (SmartPhoneNodeMessage_Point_Builder*) setX:(Float64) value;
- (SmartPhoneNodeMessage_Point_Builder*) clearX;

- (BOOL) hasY;
- (Float64) y;
- (SmartPhoneNodeMessage_Point_Builder*) setY:(Float64) value;
- (SmartPhoneNodeMessage_Point_Builder*) clearY;

- (BOOL) hasZ;
- (Float64) z;
- (SmartPhoneNodeMessage_Point_Builder*) setZ:(Float64) value;
- (SmartPhoneNodeMessage_Point_Builder*) clearZ;
@end

@interface SmartPhoneNodeMessage_Builder : PBGeneratedMessage_Builder {
@private
  SmartPhoneNodeMessage* result;
}

- (SmartPhoneNodeMessage*) defaultInstance;

- (SmartPhoneNodeMessage_Builder*) clear;
- (SmartPhoneNodeMessage_Builder*) clone;

- (SmartPhoneNodeMessage*) build;
- (SmartPhoneNodeMessage*) buildPartial;

- (SmartPhoneNodeMessage_Builder*) mergeFrom:(SmartPhoneNodeMessage*) other;
- (SmartPhoneNodeMessage_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (SmartPhoneNodeMessage_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (int32_t) id;
- (SmartPhoneNodeMessage_Builder*) setId:(int32_t) value;
- (SmartPhoneNodeMessage_Builder*) clearId;

- (NSArray*) coordinatesList;
- (SmartPhoneNodeMessage_Point*) coordinatesAtIndex:(int32_t) index;
- (SmartPhoneNodeMessage_Builder*) replaceCoordinatesAtIndex:(int32_t) index with:(SmartPhoneNodeMessage_Point*) value;
- (SmartPhoneNodeMessage_Builder*) addCoordinates:(SmartPhoneNodeMessage_Point*) value;
- (SmartPhoneNodeMessage_Builder*) addAllCoordinates:(NSArray*) values;
- (SmartPhoneNodeMessage_Builder*) clearCoordinatesList;

- (BOOL) hasSubject;
- (NSString*) subject;
- (SmartPhoneNodeMessage_Builder*) setSubject:(NSString*) value;
- (SmartPhoneNodeMessage_Builder*) clearSubject;

- (BOOL) hasPreposition;
- (NSString*) preposition;
- (SmartPhoneNodeMessage_Builder*) setPreposition:(NSString*) value;
- (SmartPhoneNodeMessage_Builder*) clearPreposition;

- (BOOL) hasObject;
- (NSString*) object;
- (SmartPhoneNodeMessage_Builder*) setObject:(NSString*) value;
- (SmartPhoneNodeMessage_Builder*) clearObject;

- (BOOL) hasConfidence;
- (int32_t) confidence;
- (SmartPhoneNodeMessage_Builder*) setConfidence:(int32_t) value;
- (SmartPhoneNodeMessage_Builder*) clearConfidence;
@end

@interface SmartPhoneDataMessage : PBGeneratedMessage {
@private
  BOOL hasCenterX_:1;
  BOOL hasCenterY_:1;
  BOOL hasId_:1;
  BOOL hasWidth_:1;
  BOOL hasHeight_:1;
  BOOL hasMapData_:1;
  Float64 centerX;
  Float64 centerY;
  int32_t id;
  int32_t width;
  int32_t height;
  NSData* mapData;
}
- (BOOL) hasId;
- (BOOL) hasWidth;
- (BOOL) hasHeight;
- (BOOL) hasMapData;
- (BOOL) hasCenterX;
- (BOOL) hasCenterY;
@property (readonly) int32_t id;
@property (readonly) int32_t width;
@property (readonly) int32_t height;
@property (readonly, retain) NSData* mapData;
@property (readonly) Float64 centerX;
@property (readonly) Float64 centerY;

+ (SmartPhoneDataMessage*) defaultInstance;
- (SmartPhoneDataMessage*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (SmartPhoneDataMessage_Builder*) builder;
+ (SmartPhoneDataMessage_Builder*) builder;
+ (SmartPhoneDataMessage_Builder*) builderWithPrototype:(SmartPhoneDataMessage*) prototype;

+ (SmartPhoneDataMessage*) parseFromData:(NSData*) data;
+ (SmartPhoneDataMessage*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SmartPhoneDataMessage*) parseFromInputStream:(NSInputStream*) input;
+ (SmartPhoneDataMessage*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SmartPhoneDataMessage*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (SmartPhoneDataMessage*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface SmartPhoneDataMessage_Builder : PBGeneratedMessage_Builder {
@private
  SmartPhoneDataMessage* result;
}

- (SmartPhoneDataMessage*) defaultInstance;

- (SmartPhoneDataMessage_Builder*) clear;
- (SmartPhoneDataMessage_Builder*) clone;

- (SmartPhoneDataMessage*) build;
- (SmartPhoneDataMessage*) buildPartial;

- (SmartPhoneDataMessage_Builder*) mergeFrom:(SmartPhoneDataMessage*) other;
- (SmartPhoneDataMessage_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (SmartPhoneDataMessage_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (int32_t) id;
- (SmartPhoneDataMessage_Builder*) setId:(int32_t) value;
- (SmartPhoneDataMessage_Builder*) clearId;

- (BOOL) hasWidth;
- (int32_t) width;
- (SmartPhoneDataMessage_Builder*) setWidth:(int32_t) value;
- (SmartPhoneDataMessage_Builder*) clearWidth;

- (BOOL) hasHeight;
- (int32_t) height;
- (SmartPhoneDataMessage_Builder*) setHeight:(int32_t) value;
- (SmartPhoneDataMessage_Builder*) clearHeight;

- (BOOL) hasMapData;
- (NSData*) mapData;
- (SmartPhoneDataMessage_Builder*) setMapData:(NSData*) value;
- (SmartPhoneDataMessage_Builder*) clearMapData;

- (BOOL) hasCenterX;
- (Float64) centerX;
- (SmartPhoneDataMessage_Builder*) setCenterX:(Float64) value;
- (SmartPhoneDataMessage_Builder*) clearCenterX;

- (BOOL) hasCenterY;
- (Float64) centerY;
- (SmartPhoneDataMessage_Builder*) setCenterY:(Float64) value;
- (SmartPhoneDataMessage_Builder*) clearCenterY;
@end

