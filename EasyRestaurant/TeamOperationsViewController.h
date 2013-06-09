//
//  JoinTeamViewController.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-15.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicateDataDelegate.h"
#import "JoinTeamEntity.h"
#import "UserEntity.h"
#import "EntityEnumDefined.h"

@interface TeamOperationsViewController : UIViewController<CommunicateDataDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) IBOutlet UISearchBar *teamSearchBar;

@property (nonatomic,strong) IBOutlet UITableView *tableViewTeam;


@property (nonatomic,strong) NSArray        *teamsOriginalDataSource;
@property (nonatomic,strong) NSMutableArray *teamsDataSource;
@property (nonatomic,strong) NSMutableArray *teamsSearchDataSource;

@property (nonatomic,assign) JoinTeamEntity *currentWantJoinTeam;

@property (nonatomic,strong) UserEntity     *loginUser;
@property (nonatomic)        BOOL           nibRegistered;

@property (nonatomic)        TeamOperations teamOperation;

@property (nonatomic,assign) id<CommunicateDataDelegate> dataReceiver;
@end
