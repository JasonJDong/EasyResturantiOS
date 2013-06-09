//
//  CreateTeamDetailViewController.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-6.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "CreateTeamDetailViewController.h"
#import "TextDetailEditorViewController.h"
#import "SimpleLabelContentCell.h"
#import "TeamEntity.h"
#import "JoinTeamEntity.h"
#import "MainMethod.h"
#import "RequestPackage.h"
#import "CommunicateUtility.h"
#import "DJAppDelegate.h"

#define MAIN_QUEUE dispatch_get_main_queue()

@interface CreateTeamDetailViewController ()

@end
@implementation CreateTeamDetailViewController(private)

SimpleLabelContentCell *currentCell;
NSDateFormatter *dateFormatter;
static const NSString *NilIdentifier = @"00000000000000000000000000000000";
@end
@implementation CreateTeamDetailViewController

@synthesize titleList;
@synthesize userAssignData;
@synthesize createTeamTableView;

@synthesize nibRegistered;

@synthesize currentDate;
@synthesize currentRestaurantId;
@synthesize currentPeopleNumber;
@synthesize currentStyle;
@synthesize currentTitle;

@synthesize affordStyle;

@synthesize createTeam;
@synthesize currentEditingField;
@synthesize currentTeam;

@synthesize loginUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"创建队伍", @"CreateTeamDetail");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    currentDate = [NSDate dateWithTimeIntervalSinceNow:2700];
    currentPeopleNumber = 8;
    currentStyle = AffordStyleAverage;
    currentTitle = @"我的队伍";
    currentRestaurantId = [NilIdentifier copy];
    
    DJAppDelegate *shareBoundle = (DJAppDelegate*)[[UIApplication sharedApplication] delegate];
    loginUser = shareBoundle.loginUser;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    dateFormatter = formatter;
    
    NSString *rightItemTitle = createTeam ? @"完成":@"加入";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:rightItemTitle style:UIBarButtonItemStyleDone target:self
                                                                             action:@selector(CreateTeamDetailDone)];
    NSArray *allocArray = [[NSArray alloc] initWithObjects:@"名称",@"地点",@"时间",@"方式",@"人数",@"备注", nil];
    self.titleList = allocArray;
    
    NSArray *styleArray = [[NSArray alloc] initWithObjects:@"AA制",@"仅为自己付费",@"请客", nil];
    self.affordStyle = styleArray;
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [table setDataSource:self];
    [table setDelegate:self];
    createTeamTableView = table;
    [self.view addSubview:table];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.titleList = nil;
    self.userAssignData = nil;
    self.createTeamTableView = nil;
}

-(void)CreateTeamDetailDone
{
    TeamEntity *receiveData = [self getTeamData];
    
    currentTeam = receiveData;
    
    MainMethod *mainMethod = [[MainMethod alloc] init];

    RequestPackage *request = [FunctionAccessor OperationTeam:[receiveData toJsonString] operationType:CommunicationOperationTypeInsert];
    [mainMethod getServiceResponse:request addDelegate:self];
    
    UIActivityIndicatorView *createProgress = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    createProgress.tag = 101;
    
    UIBarButtonItem *doneBarItem = self.navigationItem.rightBarButtonItem;
    doneBarItem.customView = createProgress;
    
    [createProgress startAnimating];
}

#pragma mark -
#pragma mark Table View Source Method

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SimpleLabelContentCell";
    nibRegistered = NO;
    
    if (!nibRegistered) {
        UINib *nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibRegistered = YES;
    }
    
    SimpleLabelContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SimpleLabelContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger realRow = [indexPath section] + [indexPath row];
    
    NSString *rowString = [titleList objectAtIndex:realRow];
    cell.title = rowString;
    
    [self makeSpecialCell:cell cellRow:realRow];
    [cell showOrHideDescription:NO];
    
    return cell;
}

-(UITableViewCell *)makeSpecialCell:(SimpleLabelContentCell *)refCell cellRow:(NSInteger)row
{
    if (createTeam) {
        NSString *inputString = nil;
        UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
        int peopleNumber = 8;
        switch (row) {
            case 0:
                inputString = @"我的队伍";
                break;
            case 2:
                inputString = [dateFormatter stringFromDate:currentDate];
                accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 3:
                inputString = [affordStyle objectAtIndex:0];
                accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 4:
                inputString = [NSString stringWithFormat:@"%d",peopleNumber];
                break;
            default:
                accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
        }
        refCell.input = inputString;
        refCell.accessoryType = accessoryType;
        if (row != 0) {
            refCell.txtDisplayInput.enabled = NO;
        }
    }
    else
    {
        refCell.accessoryType = UITableViewCellAccessoryNone;
        refCell.txtDisplayInput.enabled = NO;
    }
    return refCell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return 4;
    }
}

-(void)didSelectDateTime:(SimpleLabelContentCell*)refCell setDate:(NSDate *)date
{
    refCell.input = [dateFormatter stringFromDate:date];
    currentDate = date;
}

-(void)didSelectPeopleNumber:(SimpleLabelContentCell*)refCell setNumber:(NSNumber*)number
{
    refCell.input = (NSString*)number;
    currentPeopleNumber = (NSInteger)number;
}

-(void)didSelectStyle:(SimpleLabelContentCell*)refCell setStyle:(NSNumber*)style
{
    NSString *display = nil;
    int styleInt = [style intValue];
    display = (NSString*)[self.affordStyle objectAtIndex:styleInt];
    refCell.input = [display copy];
}

-(void)showActionSheetForStyle
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                    initWithTitle:@"请选择方式"
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles:@"AA制",@"仅为自己付费",@"请客", nil];

    [actionSheet showFromTabBar:[self.tabBarController tabBar]];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (createTeamTableView != nil)
    {
        if (actionSheet.tag == 2) {
            if (buttonIndex == 0) {
                UIDatePicker *datePicker = (UIDatePicker*)[actionSheet viewWithTag:101];
                currentDate = datePicker.date;
                [currentCell setInput:[dateFormatter stringFromDate:currentDate]];
            }
        }
        else
        {
            if (buttonIndex < 3)
            {
                [self didSelectStyle:currentCell setStyle:[NSNumber numberWithInteger:buttonIndex]];
            }
        }
    }
}
#pragma mark -
#pragma mark Table View Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!createTeam) {
        return;
    }
    NSInteger row = [indexPath section] + [indexPath row];
    SimpleLabelContentCell *refCell = (SimpleLabelContentCell*)[tableView cellForRowAtIndexPath:indexPath];
    BOOL needDetail = row == 1 || row == 4;
    if (needDetail) {
        NSString *rowString = [titleList objectAtIndex:row];
        UIViewController *controller = [[UIViewController alloc] init];
        [controller setTitle:rowString];
        [controller.view setBackgroundColor:[UIColor whiteColor]];
        
        TextDetailEditorViewController *textDetail = [[TextDetailEditorViewController alloc] initWithNibName:@"TextDetailEditorViewController" bundle:nil];
        textDetail.sendDataDelegate = self;
        if (row == 4) {
            textDetail.inputType = TextFieldInputTypeNumber;
        }
        [self.navigationController pushViewController:textDetail animated:YES];
    }
    
    if (row == 3) {
        [self showActionSheetForStyle];
    }
    if (row == 2) {
        [self popMealTimeSelector];
    }
    
    self.currentEditingField = row;
    currentCell = refCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

#pragma mark -
#pragma mark change data of views

-(void)popMealTimeSelector
{
    static NSString *title = @"\n\n\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet *mealTime = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
    mealTime.tag = 2;
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.tag = 101;
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    datePicker.date = currentDate;
    [mealTime addSubview:datePicker];
    [mealTime showFromTabBar:self.tabBarController.tabBar];
}

-(void)didSaveData
{
    TeamEntity *team = [self getTeamData];
    [self notifyDataReceiver:team];
}

-(TeamEntity*)getTeamData
{
    TeamEntity *team = [[JoinTeamEntity alloc] init];
    team.TeamName = [self getTeamName];
    team.TeamAffordStyle = currentStyle;
    team.TeamJoinPeopleNumber = currentPeopleNumber;
    team.TeamRestaurantID = currentRestaurantId;
    team.TeamID = [NilIdentifier copy];
    team.TeamCreaterID = loginUser.userID;
    team.TeamcurrentAssignTime = currentDate;
    
    return team;
}

-(NSString*)getTeamName
{
    if (createTeamTableView != nil) {
        SimpleLabelContentCell *cell =
            (SimpleLabelContentCell*)[createTeamTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        return cell.input;
    }
    return [NSString string];
}

-(void)notifyDataReceiver:(TeamEntity*)data
{
    if (self.dataReceiver != nil) {
        [self.dataReceiver receiveClassData:(id)data];
    }
}

#pragma mark -
#pragma mark Receive data
-(void)receiveStringData:(NSString *)sendData
{
    switch (currentEditingField) {
        case 0:
            self.currentTitle = sendData;
            break;
        case 1:
            self.currentRestaurantId = sendData;
            break;
        case 4:
            self.currentPeopleNumber = [sendData intValue];
            break;
    }
    [currentCell setInput:sendData];
}

-(void)receiveClassData:(id)sendData
{
    dispatch_async(MAIN_QUEUE, ^{
        UIActivityIndicatorView *createProgress = (UIActivityIndicatorView*)self.navigationItem.rightBarButtonItem.customView;
        if (createProgress != nil) {
            [createProgress stopAnimating];
        }
    });
    
    if ([sendData isKindOfClass:[NSDictionary class]]) {
        
        dispatch_async(MAIN_QUEUE, ^{
            [self notifyDataReceiver:currentTeam];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}

-(void)popCreateTeamFailedMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"创建队伍失败!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+(NSString *)getNibName
{
    return NSStringFromClass([self class]);
}
@end
