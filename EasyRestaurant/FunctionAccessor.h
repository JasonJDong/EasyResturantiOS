//
//  FunctionAccessor.h
//  EasyRestaurant
//
//  Created by JasonDong on 13-3-27.
//  Copyright (c) 2013年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestPackage.h"
#import "UserEntity.h"

@interface FunctionAccessor : NSObject

+(RequestPackage*)LoginForSession:(NSString*)UserId pwd:(NSString*)password;

+(RequestPackage*)OperationTeam:(NSString*)entity operationType:(NSInteger)type;
+(RequestPackage*)CreateUser:(NSString*)userID password:(NSString*)pwd;

@end
