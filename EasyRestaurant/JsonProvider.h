//
//  JsonProvider.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonProvider : NSObject

+(NSString*)toJsonStringWithDictionary:(NSDictionary*) dic;
+(NSString*)toJsonStringWithArray:(NSArray*) array;
+(NSString*)toJsonStringWithDictionary:(NSDictionary*) dic encoder:(NSStringEncoding) encoding;
+(NSString*)toJsonStringWithArray:(NSArray*) array encoder:(NSStringEncoding) encoding;
+(NSDictionary*)toDictionaryFromJsonString:(NSString*) json;
+(NSArray*)toArrayFromJsonString:(NSString*) json;
+(id)toObjectFromJsonString:(NSString *)json;
+(id)toObjectFromJsonData:(NSData *)jsonData;
@end
