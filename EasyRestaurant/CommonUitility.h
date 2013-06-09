//
//  CommonUitility.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUitility : NSObject

+(NSString*)dateTimeToString:(NSDate*)date;
+(NSString*)dateTimeToJsonString:(NSDate*)date;
+(NSData*)dataWithBase64EncodedString:(NSString *)string;
+(NSString*)base64EncodedStringFrom:(NSData *)data;
+(Boolean)isNullOrEmptyWhiteSpace:(NSString*)string;
@end
