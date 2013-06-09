//
//  JoinTeamEntity.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-23.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "JoinTeamEntity.h"

@implementation JoinTeamEntity

@synthesize currentJoinedPeopleID;
@synthesize currentApplyForPeopleIDs;

-(id)init
{
    if(self = [super init])
    {
        self.currentJoinedPeopleID = [[NSMutableArray alloc] initWithCapacity:8];
        self.currentApplyForPeopleIDs = [[NSMutableArray alloc] initWithCapacity:8];
    }
    return self;
}
@end
