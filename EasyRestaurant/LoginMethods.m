//
//  LoginMethods.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "LoginMethods.h"
#import "CommunicateUtility.h"
#import "DataEncryptProvider.h"

@implementation LoginMethods(private)

NSString* const LoginServiceBaseUrl = @"http://192.168.1.223:9070/LoginService/";
NSString* const LoginServicePostBaseUrl = @"http://192.168.1.223:9070/LoginService/post/{dataLength}";

@end

@implementation LoginMethods

-(void)getServiceResponse:(RequestPackage*) request addDelegate:(id<CommunicateDataDelegate>)delegate
{
    NSString *jsonString = [request toJsonString];
    
    NSString *encryptData = [DataEncryptProvider encryptFromString:jsonString];
    
    NSString *subUrlString = [NSString stringWithFormat:@"request?data=%@",encryptData];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LoginServiceBaseUrl,subUrlString]];
    
    CommunicateUtility *commUtil = [[CommunicateUtility alloc] init];
    
    commUtil.responseReceiver = delegate;
    
    [commUtil startAsyncRequestServer:url];
}


@end
