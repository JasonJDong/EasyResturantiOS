//
//  FunctionAccessor.m
//  EasyRestaurant
//
//  Created by JasonDong on 13-3-27.
//  Copyright (c) 2013年 JasonDong. All rights reserved.
//

#import "FunctionAccessor.h"
#import "CommunicateUtility.h"

@implementation FunctionAccessor

+(RequestPackage*)LoginForSession:(NSString*)UserId pwd:(NSString*)password
{
    static NSString* MethodName = @"LoginForSession";
    static NSString* UserIdKey = @"uid";
    static NSString* UserPasswordKey = @"pwd";
    
    NSDictionary *paramDic = @{UserIdKey : UserId,UserPasswordKey : password};
    return [CommunicateUtility makeRequestPackage:MethodName params:paramDic];
}

+(RequestPackage*)OperationTeam:(NSString*)entity operationType:(NSInteger)type
{
    static NSString *createTeamMethod = @"OperationTeam";
    static NSString *createTeamParamEntity = @"entity";
    static NSString *createTeamParamOperation = @"operationType";

    NSDictionary *paramDic = @{createTeamParamEntity:entity,createTeamParamOperation:[NSNumber numberWithInteger:type]};
    return [CommunicateUtility makeRequestPackage:createTeamMethod params:paramDic];
}

+(RequestPackage*)CreateUser:(NSString*)userID password:(NSString*)pwd
{
    static NSString *createUserMethod = @"CreateUser";
    static NSString *userIDKey = @"uid";
    static NSString *passwordKey = @"pwd";
    
    NSDictionary *paramDic = @{userIDKey : userID,passwordKey:pwd};
    return [CommunicateUtility makeRequestPackage:createUserMethod params:paramDic];
}
@end

