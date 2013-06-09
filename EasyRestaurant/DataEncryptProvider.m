//
//  DataEncryptProvider.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-13.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "DataEncryptProvider.h"
#import "CommonUitility.h"

@implementation DataEncryptProvider

const NSInteger HeaderCount = 20;

const NSString *UpperString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const NSString *LowerString = @"abcdefghijklmnopqrstuvwxyz";
const NSString *NumberString = @"0123456789";


+(NSString *)decryptFromString:(NSString *)data
{
    if ([data length] < HeaderCount) {
        return data;
    }
    
    NSCharacterSet *upperSet = [NSCharacterSet characterSetWithCharactersInString:[UpperString copy]];
    NSCharacterSet *lowerSet = [NSCharacterSet characterSetWithCharactersInString:[LowerString copy]];
    NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:[NumberString copy]];
    
    NSRange headerRange = NSMakeRange(0, HeaderCount);
    
    NSMutableString *encrypt = [[NSMutableString alloc] initWithString:[data substringWithRange:headerRange]];
    NSMutableString *decrypt = [[NSMutableString alloc] initWithCapacity:HeaderCount];
    
    for (int i = 0; i < HeaderCount; i++) {
        
        unichar theChar = [encrypt characterAtIndex:i];
        
        NSString *c =  [NSString stringWithUTF8String:(char*)&theChar];
        
        NSRange includeRange = [c rangeOfCharacterFromSet:upperSet];
        if (includeRange.location != NSNotFound) {
            unichar newChar = theChar + 32;
            NSString *decryptChar =  [NSString stringWithUTF8String:(char*)&newChar];
            [decrypt appendString:decryptChar];
            continue;
        }
        
        includeRange = [c rangeOfCharacterFromSet:lowerSet];
        if (includeRange.location != NSNotFound) {
            unichar newChar = theChar - 32;
            NSString *decryptChar =  [NSString stringWithUTF8String:(char*)&newChar];
            [decrypt appendString:decryptChar];
            continue;
        }
        
        includeRange = [c rangeOfCharacterFromSet:numberSet];
        if (includeRange.location != NSNotFound) {
            unichar newChar = 105 - (unsigned short)theChar;
            NSString *decryptChar =  [NSString stringWithUTF8String:(char*)&newChar];
            [decrypt appendString:decryptChar];
        }

    }
    
    headerRange = NSMakeRange(HeaderCount, [data length] - HeaderCount);
    
    NSMutableString *leftEncrypt = [[NSMutableString alloc] initWithString:[data substringWithRange:headerRange]];
    [leftEncrypt insertString:decrypt atIndex:0];
    
    NSData *base64Data = [CommonUitility dataWithBase64EncodedString:leftEncrypt];
    
    return [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
}

+(NSString *)encryptFromString:(NSString *)data
{
    NSData *dataOriginal = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [CommonUitility base64EncodedStringFrom:dataOriginal];
    
    if ([base64String length] < HeaderCount) {
        return data;
    }
    
    NSCharacterSet *upperSet = [NSCharacterSet characterSetWithCharactersInString:[UpperString copy]];
    NSCharacterSet *lowerSet = [NSCharacterSet characterSetWithCharactersInString:[LowerString copy]];
    NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:[NumberString copy]];
    
    NSRange headerRange = NSMakeRange(0, HeaderCount);
    NSMutableString *forEncrypt = [[NSMutableString alloc] initWithString:[base64String substringWithRange:headerRange]];
    NSMutableString *encryptResult = [[NSMutableString alloc] initWithCapacity:HeaderCount];
    
    for (int i = 0; i < HeaderCount; i++) {
        
        unichar theChar = [forEncrypt characterAtIndex:i];
        
        NSString *c =  [NSString stringWithUTF8String:(char*)&theChar];
        
        NSRange includeRange = [c rangeOfCharacterFromSet:upperSet];
        if (includeRange.location != NSNotFound) {
            unichar newChar = theChar + 32;
            NSString *decryptChar =  [NSString stringWithUTF8String:(char*)&newChar];
            [encryptResult appendString:decryptChar];
            continue;
        }
        
        includeRange = [c rangeOfCharacterFromSet:lowerSet];
        if (includeRange.location != NSNotFound) {
            unichar newChar = theChar - 32;
            NSString *decryptChar =  [NSString stringWithUTF8String:(char*)&newChar];
            [encryptResult appendString:decryptChar];
            continue;
        }
        
        includeRange = [c rangeOfCharacterFromSet:numberSet];
        if (includeRange.location != NSNotFound) {
            unichar newChar = 105 - (unsigned short)theChar;
            NSString *decryptChar =  [NSString stringWithUTF8String:(char*)&newChar];
            [encryptResult appendString:decryptChar];
        }
    }
    
    headerRange = NSMakeRange(HeaderCount, [base64String length] - HeaderCount);
    
    NSMutableString *leftEncrypt = [[NSMutableString alloc] initWithString:[base64String substringWithRange:headerRange]];
    [leftEncrypt insertString:encryptResult atIndex:0];
    
    return leftEncrypt;
}
@end
