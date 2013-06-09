//
//  DJFirstViewController.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-10-29.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicateDataDelegate.h"
#import "UserEntity.h"

@interface TeamViewController : UIViewController<CommunicateDataDelegate>


@property (nonatomic,strong) IBOutlet UIButton *buttonCreateTeam;
@property (nonatomic,strong) IBOutlet UIButton *buttonJoinTeam;
@property (nonatomic,strong) IBOutlet UIButton *buttonMyTeam;
@property (nonatomic,strong) IBOutlet UIButton *buttonInviteTeam;
@property (nonatomic,strong) IBOutlet UIButton *buttonBookCook;
@property (nonatomic,strong) IBOutlet UIButton *buttonCheckPeople;
@property (nonatomic,strong) IBOutlet UIButton *buttonMyFriends;

@property (nonatomic,strong) UserEntity *loginUser;
@property (nonatomic,copy)   NSMutableArray *userCreateTeams;
@end
