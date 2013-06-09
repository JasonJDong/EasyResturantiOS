//
//  RequestPackage.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "RequestPackage.h"
#import "JsonProvider.h"

@implementation RequestPackage

NSString* const KEY_KEY = @"Key";
NSString* const VALUE_KEY = @"Value";
NSString* const METHOD_NAME_VALUE = @"METHOD";
NSString* const ATTACHMENT_VALUE = @"ATTACHMENT";

@synthesize Method;
@synthesize Attachment;

-(NSString *)toJsonString
{
    NSArray *forJsonArray = [self toArray];
    if (forJsonArray == nil) {
        return @"";
    }
    
    return [JsonProvider toJsonStringWithArray:forJsonArray];
}

-(NSArray *)toArray
{
    NSDictionary *dicMethod     = [NSDictionary dictionaryWithObjectsAndKeys:
                                   METHOD_NAME_VALUE,
                                   KEY_KEY,
                                   [Method toJsonString],
                                   VALUE_KEY, nil];
    NSDictionary *dicAttachment = [NSDictionary dictionaryWithObjectsAndKeys:
                                   ATTACHMENT_VALUE,
                                   KEY_KEY,
                                   [Attachment toJsonString],
                                   VALUE_KEY, nil];
    NSArray *array = [NSArray arrayWithObjects:dicMethod,dicAttachment, nil];
    return array;
}
@end
