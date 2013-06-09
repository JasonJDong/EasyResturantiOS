//
//  JoinTeamEntity.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-23.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "TeamEntity.h"

@interface JoinTeamEntity : TeamEntity

@property (nonatomic,strong) NSMutableArray *currentJoinedPeopleID;
@property (nonatomic,strong) NSMutableArray *currentApplyForPeopleIDs;

@end
