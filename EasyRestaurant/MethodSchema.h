//
//  MethodEntity.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonSerializeDelegate.h"

@interface MethodSchema : NSObject<JsonSerializeDelegate>

@property (nonatomic,copy) NSString* MethodName;
@property (nonatomic,copy) NSDictionary* Parameters;

@end
