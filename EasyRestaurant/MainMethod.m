//
//  MainMethod.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-20.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "MainMethod.h"
#import "DataEncryptProvider.h"
#import "CommunicateUtility.h"
#import "DJAppDelegate.h"

@implementation MainMethod(private)

NSString* const MainServiceBaseUrl = @"http://192.168.1.223:4477/CommunicationCenter/";

@end

@implementation MainMethod

-(void)getServiceResponse:(RequestPackage*) request addDelegate:(id<CommunicateDataDelegate>)delegate
{
    DJAppDelegate *shareBoundle = (DJAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *jsonString = [request toJsonString];
    
    NSString *encryptData = [DataEncryptProvider encryptFromString:jsonString];
    
    //NSString *urlEncode = [encryptData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* urlEncode = (__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)encryptData, nil, (CFStringRef)@"!*’();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    
    NSString *subUrlString = [NSString stringWithFormat:@"request?sessionid=%@&encryptdata=%@",shareBoundle.loginUser.userSession,urlEncode];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",MainServiceBaseUrl,subUrlString]];
    
    CommunicateUtility *commUtil = [[CommunicateUtility alloc] init];
    
    commUtil.responseReceiver = delegate;
    
    [commUtil startAsyncRequestServer:url];
}

@end
