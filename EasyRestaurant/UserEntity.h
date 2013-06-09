//
//  UserEntity.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-15.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonSerializeDelegate.h"

@interface UserEntity : NSObject<JsonSerializeDelegate>

@property (nonatomic,copy) NSString  *userID;
@property (nonatomic,copy) NSString  *userName;
@property (nonatomic,copy) NSString  *userPassword;
@property (nonatomic,copy) NSString  *userSession;
@property (nonatomic)      NSInteger userActivePoints;

@end
