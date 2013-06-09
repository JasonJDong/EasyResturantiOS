//
//  TeamEntity.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-15.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityEnumDefined.h"
#import "JsonSerializeDelegate.h"

@interface TeamEntity : NSObject<NSCopying,JsonSerializeDelegate>


@property (nonatomic,copy) NSString         *TeamName;
@property (nonatomic,copy) NSString         *TeamID;
@property (nonatomic,copy) NSString         *TeamRestaurantID;
@property (nonatomic)      NSInteger        TeamJoinPeopleNumber;
@property (nonatomic)      AffordStyle      TeamAffordStyle;
@property (nonatomic,copy) NSString         *TeamCreaterID;
@property (nonatomic,strong) NSDate         *TeamcurrentAssignTime;
@property (nonatomic)      TeamLifeStatus   TeamLifeStatus;
@end
