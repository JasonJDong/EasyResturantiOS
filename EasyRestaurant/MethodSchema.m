//
//  MethodEntity.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "MethodSchema.h"
#import "JsonProvider.h"
#import "ParameterPair.h"

@implementation MethodSchema

static NSString* METHOD_NAME_KEY = @"MethodName";
static NSString* PARAMETER_KEY = @"Parameters";

@synthesize MethodName;
@synthesize Parameters;

-(NSString *)toJsonString
{
    NSDictionary *forJsonDic = [self toDictionary];
    if (forJsonDic == nil) {
        return @"";
    }
    return [JsonProvider toJsonStringWithDictionary:forJsonDic];
}

-(id)init
{
    if ([super init]) {
        Parameters = [[NSDictionary alloc] init];
    }
    return self;
}

-(NSDictionary *)toDictionary
{
    if (Parameters != nil)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    MethodName,METHOD_NAME_KEY,nil];
        [dic setValue:Parameters forKey:PARAMETER_KEY];
        
        return (NSDictionary*)dic;
    }
    return nil;
}
@end
