//
//  MainMethod.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-20.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestPackage.h"
#import "CommunicateDataDelegate.h"

@interface MainMethod : NSObject

-(void)getServiceResponse:(RequestPackage*) request addDelegate:(id<CommunicateDataDelegate>)delegate;

@end
