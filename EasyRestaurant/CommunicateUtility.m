//
//  CommunicateUtility.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-20.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "CommunicateUtility.h"
#import "DataEncryptProvider.h"
#import "JsonProvider.h"
#import "MethodSchema.h"
#import "ParameterPair.h"

@implementation CommunicateUtility

@synthesize responseReceiver;

-(void)startAsyncRequestServer:(NSURL*)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection
     sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
         if ([data length] > 0 && error == nil) {
             id object = [JsonProvider toObjectFromJsonData:data];
             if ([object isKindOfClass:[NSString class]]) {
                 id moreParse = [JsonProvider toObjectFromJsonString:object];
                 [self receiveClassData:moreParse];
             }
             [self receiveClassData:object];
         }
         else
         {
             NSLog(@"%@",error);
             [self receiveClassData:error];
         }
     }];
}


-(void)receiveClassData:(id)sendData
{
    if (responseReceiver == nil) {
        return;
    }
    [responseReceiver receiveClassData:sendData];
}

+(RequestPackage *)makeRequestPackage:(NSString *)methodName params:(NSDictionary *)parameters
{
    RequestPackage *request = [[RequestPackage alloc] init];
    
    MethodSchema *m = [[MethodSchema alloc] init];
    m.MethodName = methodName;
    m.Parameters = parameters;
    
    
    AttachSchema *attach = [[AttachSchema alloc] init];
    
    request.Method = m;
    request.Attachment = attach;
    
    return request;
}
@end
