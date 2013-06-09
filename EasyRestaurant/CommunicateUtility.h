//
//  CommunicateUtility.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-20.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestPackage.h"
#import "CommunicateDataDelegate.h"

@interface CommunicateUtility : NSObject

@property (nonatomic,assign) id<CommunicateDataDelegate> responseReceiver;

-(void)startAsyncRequestServer:(NSURL*)url;
+(RequestPackage*)makeRequestPackage:(NSString*)methodName params:(NSDictionary*)parameters;
@end
