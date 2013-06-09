//
//  DJFirstViewController.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-10-29.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "TeamViewController.h"
#import "CreateTeamDetailViewController.h"
#import "TeamOperationsViewController.h"
#import "TeamEntity.h"
#import "MethodSchema.h"
#import "ParameterPair.h"
#import "AttachSchema.h"
#import "RequestPackage.h"
#import "MainMethod.h"
#import "UserEntity.h"
#import "JsonProvider.h"
#import "DJAppDelegate.h"
#import "CommunicateUtility.h"
#import "FunctionAccessor.h"

@interface TeamViewController ()

@end

@implementation TeamViewController

@synthesize buttonBookCook;
@synthesize buttonCheckPeople;
@synthesize buttonCreateTeam;
@synthesize buttonInviteTeam;
@synthesize buttonJoinTeam;
@synthesize buttonMyTeam;
@synthesize buttonMyFriends;

@synthesize loginUser;
@synthesize userCreateTeams;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"队伍", @"Team");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(ButtonPressed:)];
    DJAppDelegate *shareBoundle = (DJAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    loginUser = shareBoundle.loginUser;
    userCreateTeams = [NSMutableArray arrayWithCapacity:8];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)createTeamButtonPressed:(id)sender
{
    CreateTeamDetailViewController *controller = [[CreateTeamDetailViewController alloc] initWithNibName:@"CreateTeamDetailViewController" bundle:nil];
    controller.dataReceiver = self;
    controller.createTeam = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


-(IBAction)joinTeamButtonPressed:(id)sender
{
    TeamOperationsViewController *teamOperate = [[TeamOperationsViewController alloc] initWithNibName:@"JoinTeamViewController" bundle:nil];
    teamOperate.dataReceiver = self;
    teamOperate.teamOperation = TeamOperationsJoinTeam;
    [self.navigationController pushViewController:teamOperate animated:YES];
}

-(void)receiveClassData:(id)sendData
{
    if ([sendData isKindOfClass:[TeamEntity class]]) {
        TeamEntity *receiveData = (TeamEntity*)sendData;
        [userCreateTeams addObject:receiveData];
               
        MainMethod *mainMethod = [[MainMethod alloc] init];
        RequestPackage *request = [FunctionAccessor OperationTeam:[receiveData toJsonString] operationType:CommunicationOperationTypeInsert];
        [mainMethod getServiceResponse:request addDelegate:self];
    }
    if ([sendData isKindOfClass:[NSDictionary class]]) {
        
    }
}
@end
