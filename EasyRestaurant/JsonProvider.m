//
//  JsonProvider.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "JsonProvider.h"
#import "objc/runtime.h"

@implementation JsonProvider

+(NSString *)toJsonStringWithArray:(NSArray *)array
{
    return [self toJsonStringWithArray:array encoder:NSUTF8StringEncoding];
}

+(NSString *)toJsonStringWithDictionary:(NSDictionary *)dic
{
    return [self toJsonStringWithDictionary:dic encoder:NSUTF8StringEncoding];
}

+(NSString *)toJsonStringWithArray:(NSArray *)array encoder:(NSStringEncoding)encoding
{
    if ([NSJSONSerialization isValidJSONObject:array]) {
        NSError *err;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&err];
        if (jsonData != NULL) {
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:encoding];
            return json;
        }
    }
    return @"";
}

+(NSString *)toJsonStringWithDictionary:(NSDictionary *)dic encoder:(NSStringEncoding)encoding
{
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *err;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&err];
        if (jsonData != NULL) {
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:encoding];
            return json;
        }
    }
    return @"";
}

+(NSDictionary*)toDictionaryFromJsonString:(NSString *)json
{
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (jsonObj != nil && error == nil) {
        if ([jsonObj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *deserializedDictionary = (NSDictionary*)jsonObj;
            return deserializedDictionary;
        }
    }
    return nil;
}

+(NSArray *)toArrayFromJsonString:(NSString *)json
{
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (jsonObj != nil && error == nil) {
        if ([jsonObj isKindOfClass:[NSArray class]]) {
            NSArray *deserializedDictionary = (NSArray*)jsonObj;
            return deserializedDictionary;
        }
    }
    return nil;
}

+(id)toObjectFromJsonString:(NSString *)json
{
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    return jsonObj;
}
+(id)toObjectFromJsonData:(NSData *)jsonData
{
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    return jsonObj;
}

@end
