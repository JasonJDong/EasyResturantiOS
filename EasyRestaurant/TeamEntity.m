//
//  TeamEntity.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-15.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "TeamEntity.h"
#import "JsonProvider.h"
#import "CommonUitility.h"

@implementation TeamEntity

@synthesize TeamAffordStyle;
@synthesize TeamID;
@synthesize TeamJoinPeopleNumber;
@synthesize TeamName;
@synthesize TeamRestaurantID;
@synthesize TeamCreaterID;
@synthesize TeamcurrentAssignTime;
@synthesize TeamLifeStatus;

-(id)initWithName:(NSString*)name
{
    if(self = [super init])
    {
        self.TeamName = name;
        self.TeamLifeStatus = TeamLifeStatusActived;
    }
   return self;
}
-(id)copyWithZone:(NSZone *)zone
{
    TeamEntity *entity = [[self class] allocWithZone:zone];
    entity.TeamAffordStyle = TeamAffordStyle;
    entity.TeamID = [TeamID copy];
    entity.TeamJoinPeopleNumber = TeamJoinPeopleNumber;
    entity.TeamName = [TeamName copy];
    entity.TeamRestaurantID = [TeamRestaurantID copy];
    entity.TeamCreaterID = [TeamCreaterID copy];
    entity.TeamcurrentAssignTime = TeamcurrentAssignTime;
    entity.TeamLifeStatus = TeamLifeStatus;
    
    return entity;
}

-(NSString *)toJsonString
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         TeamName,@"TeamName",
                         TeamID,@"TeamID",
                         TeamCreaterID,@"HolderID",
                         TeamRestaurantID,@"TeamUseRestaurantID",
                         [NSString stringWithFormat:@"%d",TeamAffordStyle],@"TeamAffordStyle",
                         [CommonUitility dateTimeToJsonString:TeamcurrentAssignTime],@"MealTime",
                         [NSString stringWithFormat:@"%d",TeamJoinPeopleNumber],@"MaxPeopleNumber",
                         [NSString stringWithFormat:@"%d",TeamLifeStatus],@"AliveStatus",nil];
    return [JsonProvider toJsonStringWithDictionary:dic];
}
@end
