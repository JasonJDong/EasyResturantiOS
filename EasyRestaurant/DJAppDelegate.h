//
//  DJAppDelegate.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-10-29.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"

@interface DJAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *rootTabBarController;

@property (strong,nonatomic) UserEntity *loginUser;

@end
