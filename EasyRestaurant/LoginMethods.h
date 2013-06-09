//
//  LoginMethods.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestPackage.h"
#import "CommunicateDataDelegate.h"

@interface LoginMethods : NSObject

-(void)getServiceResponse:(RequestPackage*) request addDelegate:(id<CommunicateDataDelegate>)delegate;

@end
