//
//  DataEncryptProvider.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataEncryptProvider : NSObject

+(NSString*)encryptFromString:(NSString*)data;
+(NSString*)decryptFromString:(NSString*)data;
@end
