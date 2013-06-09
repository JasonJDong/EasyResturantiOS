//
//  UserEntity.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-15.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "UserEntity.h"
#import "JsonProvider.h"

@implementation UserEntity

@synthesize userID;
@synthesize userName;
@synthesize userPassword;
@synthesize userSession;
@synthesize userActivePoints;

-(NSString*)toJsonString
{
    NSDictionary *forJsonDic = [self toDictionary];
    return [JsonProvider toJsonStringWithDictionary:forJsonDic];
}

-(NSDictionary *)toDictionary
{

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                         userID,@"UserID",
                         userPassword,@"Password",
                         userSession,@"Session",
                         userName,@"AliasName",nil];
    [dic setValue:[NSNumber numberWithInt:userActivePoints] forKey:@"ActivePoints"];
    return dic;
   
}
-(void)objectFromJsonDictionary:(NSDictionary *)jsonDic
{
    if (jsonDic == nil) {
        return;
    }
    userID = (NSString*)[jsonDic objectForKey:@"UserID"];
    userPassword = (NSString*)[jsonDic objectForKey:@"Password"];
    userSession = (NSString*)[jsonDic objectForKey:@"Session"];
    userActivePoints = [(NSString*)[jsonDic objectForKey:@"ActivePoints"] integerValue];
    userName = (NSString*)[jsonDic objectForKey:@"AliasName"];
}
@end
