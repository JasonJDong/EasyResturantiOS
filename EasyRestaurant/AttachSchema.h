//
//  AttachEntity.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonSerializeDelegate.h"

@interface AttachSchema : NSObject<JsonSerializeDelegate>

@property (nonatomic,copy) NSString* DeviceMac;
@property (nonatomic,copy) NSString* DeviceHost;
@property (nonatomic,copy) NSString* Note;

@end
