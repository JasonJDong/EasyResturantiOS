//
//  CreateTeamDetailViewController.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-6.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicateDataDelegate.h"
#import "TeamEntity.h"
#import "UserEntity.h"
#import "FunctionAccessor.h"

@interface CreateTeamDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CommunicateDataDelegate,UIActionSheetDelegate>

@property (strong,nonatomic) NSArray *titleList;
@property (strong,nonatomic) NSMutableArray *userAssignData;
@property (strong,nonatomic) UITableView *createTeamTableView;

@property (nonatomic) BOOL nibRegistered;

@property (nonatomic,copy) NSString *currentTitle;
@property (nonatomic,copy) NSString *currentRestaurantId;
@property (nonatomic,strong) NSDate *currentDate;
@property (nonatomic) NSInteger currentStyle;
@property (nonatomic) NSInteger currentPeopleNumber;

@property (nonatomic,strong) TeamEntity *currentTeam;

@property (nonatomic,strong) NSArray *affordStyle;

@property (nonatomic,assign) id<CommunicateDataDelegate> dataReceiver;

@property (nonatomic) BOOL createTeam;
@property (nonatomic) NSInteger currentEditingField;

@property (nonatomic,strong) UserEntity *loginUser;

+(NSString*)getNibName;
@end
