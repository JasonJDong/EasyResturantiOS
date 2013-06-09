//
//  JoinTeamViewController.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-15.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "TeamOperationsViewController.h"
#import "DetailListViewCell.h"
#import "CreateTeamDetailViewController.h"

@class DetailListViewCell;

@interface TeamOperationsViewController ()

@end

@implementation TeamOperationsViewController


@synthesize tableViewTeam;
@synthesize teamsSearchDataSource;
@synthesize teamsDataSource;
@synthesize teamsOriginalDataSource;
@synthesize currentWantJoinTeam;

@synthesize loginUser;

@synthesize teamSearchBar;

@synthesize nibRegistered;

@synthesize dataReceiver;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        teamsDataSource = [[NSMutableArray alloc] initWithCapacity:10];
        for (int i=0; i<10; i++) {
            JoinTeamEntity *entity = [[JoinTeamEntity alloc]  init];
            NSString *main = [NSString stringWithFormat:@"%d",i];
            NSString *name = [main stringByAppendingString:@"董健"];
            entity.TeamName = name;
            entity.TeamID = [NSString stringWithFormat:@"FFF-3DDF%d",i];
            entity.TeamJoinPeopleNumber = 5;
            entity.TeamAffordStyle = AffordStyleSomeOnePayForAll;
            [teamsDataSource addObject:entity];
        }
        teamsOriginalDataSource = [[NSArray alloc] initWithArray:teamsDataSource];
        teamsSearchDataSource = [[NSMutableArray alloc] initWithCapacity:[teamsOriginalDataSource count]];
        loginUser = [[UserEntity alloc] init];
        loginUser.userID = @"FE3-DDRR5";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *advancedBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    self.navigationItem.rightBarButtonItem = advancedBarItem;
    [self.tableViewTeam setDataSource:self];
    [self.tableViewTeam setDelegate:self];
    [self.teamSearchBar setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.teamSearchBar = nil;
    self.teamsDataSource = nil;
    self.teamsSearchDataSource = nil;
    self.loginUser = nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailListViewCell";
    nibRegistered = NO;
    
    if (!nibRegistered) {
        UINib *nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibRegistered = YES;
    }
    DetailListViewCell *detailListCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == detailListCell) {
        detailListCell = [[DetailListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    JoinTeamEntity *entity = [teamsDataSource objectAtIndex:row];
    [self prepareEachTableViewCell:detailListCell teamData:entity];
    
    return detailListCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [teamsDataSource count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    TeamEntity *currentTeam = [teamsDataSource objectAtIndex:row];
    CreateTeamDetailViewController *joinTeam =
    [[CreateTeamDetailViewController alloc] initWithNibName:[CreateTeamDetailViewController getNibName] bundle:nil];
    joinTeam.createTeam = NO;
    joinTeam.currentTitle = currentTeam.TeamName;
    joinTeam.currentStyle = currentTeam.TeamAffordStyle;
    joinTeam.dataReceiver = self;
    joinTeam.currentTeam = currentTeam;
    [self.navigationController pushViewController:joinTeam animated:YES];
}

-(DetailListViewCell*)prepareEachTableViewCell:(DetailListViewCell*)refCell teamData:(JoinTeamEntity*)team
{
    NSDateFormatter *datefmt = [[NSDateFormatter alloc] init];
    [datefmt setDateFormat:@"yyyy-MM-dd"];
    refCell.lbNameField.text = team.TeamName;
    refCell.lbImportantInfoField.text = [datefmt stringFromDate:team.TeamcurrentAssignTime];
    refCell.lbRightInfoField.text = [NSString stringWithFormat:@"%u",team.TeamAffordStyle];
    
    NSMutableString *actived = team.TeamLifeStatus == TeamLifeStatusActived?
                            [NSMutableString stringWithString:@"已激活"]:
                            [NSMutableString stringWithString:@"已关闭"];
    
    NSMutableString *joinedPersons = [NSMutableString stringWithFormat:@" 已加入%d 申请%d 剩余%d ",
                                       [team.currentJoinedPeopleID count],[team.currentApplyForPeopleIDs count],
                                      team.TeamJoinPeopleNumber - [team.currentApplyForPeopleIDs count] - [team.currentJoinedPeopleID count]];
    
    refCell.lbDescriptionField.text = [actived stringByAppendingString:joinedPersons];
    switch (self.teamOperation) {
        case TeamOperationsJoinTeam:
            if ([team.currentApplyForPeopleIDs containsObject:loginUser.userID]) {
                refCell.lbDescriptionField.text = [refCell.lbDescriptionField.text stringByAppendingString:@"申请中..."];
            }
            break;
        default:
            break;
    }
    refCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return refCell;
}

#pragma - Mark
#pragma Searchbar delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (![searchText isEqual:@""]) {
        
        for (TeamEntity *team in teamsOriginalDataSource) {
            if ([team.TeamName rangeOfString:searchText].location != NSNotFound) {
                [teamsSearchDataSource addObject:team];
            }
        }
        [teamsDataSource removeAllObjects];
        [teamsDataSource addObjectsFromArray:teamsSearchDataSource];
    }
    else
    {
        [self resetTableView];
    }
    [tableViewTeam reloadData];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self resetTableView];
}

-(void)resetTableView
{
    [teamsSearchDataSource removeAllObjects];
    [teamsDataSource removeAllObjects];
    [teamsDataSource addObjectsFromArray:teamsOriginalDataSource];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)receiveClassData:(id)sendData
{
    if ([sendData isKindOfClass:[JoinTeamEntity class]]) {
        
        JoinTeamEntity *joinTeam = (JoinTeamEntity*)sendData;
        for (int i = 0; i < [teamsDataSource count]; i++) {
            JoinTeamEntity *team = (JoinTeamEntity*)[teamsDataSource objectAtIndex:i];
            if ([team.TeamID isEqual:joinTeam.TeamID]) {
                //team = joinTeam;
                //TEST
                [team.currentApplyForPeopleIDs addObject:loginUser.userID];
                JoinTeamEntity *orgTeam =(JoinTeamEntity*)[teamsOriginalDataSource objectAtIndex:i];
                [orgTeam.currentApplyForPeopleIDs addObject:loginUser.userID];
                break;
            }
        }
        
        [tableViewTeam reloadData];
        //此处发送队伍信息给创建队伍的用户
    }
}
@end
