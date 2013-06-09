//
//  JsonSerializeDelegate.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JsonSerializeDelegate <NSObject>

@optional
-(NSString*)toJsonString;
-(NSDictionary*)toDictionary;
-(void)objectFromJsonDictionary:(NSDictionary*)jsonDic;
-(void)objectFromJsonArray:(NSArray*)jsonArray;
@end
