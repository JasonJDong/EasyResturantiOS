//
//  RequestPackage.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MethodSchema.h"
#import "AttachSchema.h"
#import "JsonSerializeDelegate.h"

@interface RequestPackage : NSObject<JsonSerializeDelegate>

@property (nonatomic,strong) MethodSchema* Method;
@property (nonatomic,strong) AttachSchema* Attachment;

@end
