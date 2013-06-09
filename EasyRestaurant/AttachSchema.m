//
//  AttachEntity.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "AttachSchema.h"
#import "JsonProvider.h"

@implementation AttachSchema

@synthesize DeviceHost;
@synthesize DeviceMac;
@synthesize Note;

-(NSString *)toJsonString
{
    NSDictionary *forJsonDic = [self toDictionary];
    if (forJsonDic == nil) {
        return @"";
    }
    return [JsonProvider toJsonStringWithDictionary:forJsonDic];
}
-(NSDictionary *)toDictionary
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         DeviceHost,@"Host",
                         DeviceMac,@"MacAddress",
                         Note,@"Note",nil];
    return dic;
}
@end
