//
//  CommunicateDataDelegate.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-8.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommunicateDataDelegate <NSObject>

@optional

-(void)receiveValueData:(NSValue*)sentData;

-(void)receiveStringData:(NSString*)sendData;
-(void)receiveNumberData:(NSNumber*)sendData;
-(void)receiveBooleanData:(Boolean)sendData;
-(void)receiveClassData:(id)sendData;

-(void)receiveValueData:(NSValue *)sentData withTag:(NSInteger)tag;
-(void)receiveStringData:(NSString*)sendData  withTag:(NSInteger)tag;
-(void)receiveNumberData:(NSNumber*)sendData withTag:(NSInteger)tag;
-(void)receiveBooleanData:(Boolean)sendData withTag:(NSInteger)tag;
-(void)receiveClassData:(id)sendData withTag:(NSInteger)tag;
@end
