//
//  LoginViewController.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-17.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "LoginViewController.h"
#import "TeamViewController.h"
#import "NearRestaurantViewController.h"
#import "MoreViewController.h"
#import "FavoriteViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginMethods.h"
#import "CommunicateUtility.h"
#import "FunctionAccessor.h"
#import "DataEncryptProvider.h"

#define MAIN_QUEUE dispatch_get_main_queue()

@interface LoginViewController ()

@end

@implementation LoginViewController(private)

LoginMethods *loginMethods;

@end

@implementation LoginViewController

@synthesize btnforgetPassword;
@synthesize btnRegister;
@synthesize btnLoginStatus;
@synthesize btnSubmit;
@synthesize txtPassword;
@synthesize txtUserName;
@synthesize lblErrorMsg;
@synthesize lblLoginDisplay;
@synthesize progressLogin;

@synthesize loginUser;

@synthesize isRegister;

@synthesize mainBounld;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initLoginIndicator];
    [btnSubmit addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    [btnRegister addTarget:self action:@selector(registerStatus:) forControlEvents:UIControlEventTouchDown];
    [btnLoginStatus addTarget:self action:@selector(loginStatus:) forControlEvents:UIControlEventTouchDown];
    loginMethods = [[LoginMethods alloc] init];
    loginUser = [[UserEntity alloc] init];
    txtUserName.delegate = self;
    txtPassword.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initLoginIndicator
{
    [lblErrorMsg setHidden:YES];
    [lblLoginDisplay setHidden:YES];
    if ([progressLogin isAnimating]) {
        [progressLogin stopAnimating];
    }
    [progressLogin setHidden:YES];
    [btnSubmit setEnabled:YES];
}

-(void)resetUnloginStatus
{
    [lblLoginDisplay setHidden:YES];
    if ([progressLogin isAnimating]) {
        [progressLogin stopAnimating];
    }
    [progressLogin setHidden:YES];
    [btnSubmit setEnabled:YES];
    [btnRegister setEnabled:YES];
    [btnforgetPassword setEnabled:YES];
    [txtUserName setEnabled:YES];
    [txtPassword setEnabled:YES];
    [progressLogin setHidden:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)loginStatus:(id)sender
{
    btnSubmit.titleLabel.text = @"登         录";
    [btnLoginStatus setHidden:YES];
    [btnRegister setHidden:NO];
    isRegister = NO;
    
    [btnSubmit removeTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchDown];
    [btnSubmit addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
  
}

-(IBAction)login:(id)sender
{
    //动画设置
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:@"ViewTrans" context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view.superview cache:YES];
    //View改变代码
    //提交动画
//    [UIView commitAnimations];
    if ([self checkInputData] == NO) {
        return;
    }
    [self workingUIControl];
    
    RequestPackage *request = [FunctionAccessor LoginForSession:txtUserName.text pwd:txtPassword.text];
    
    //使用服务器数据时激活
    [loginMethods getServiceResponse:request addDelegate:self];
    
}

-(IBAction)registerStatus:(id)sender
{
    btnSubmit.titleLabel.text = @"注         册";
    [btnLoginStatus setHidden:NO];
    [btnRegister setHidden:YES];
    isRegister = YES;
    [btnSubmit removeTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    
    [btnSubmit addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchDown];
}

-(IBAction)registerUser:(id)sender
{
    if ([self checkInputData] == NO) {
        return;
    }
    [loginUser setUserID:txtUserName.text];
    [loginUser setUserPassword:txtPassword.text];
    [self workingUIControl];
    
    RequestPackage *request = [FunctionAccessor CreateUser:txtUserName.text password:txtPassword.text];
    [loginMethods getServiceResponse:request addDelegate:self];
}

-(void)receiveClassData:(id)sendData
{
    if (isRegister) {
        if ([sendData isKindOfClass:[NSString class]]) {
            NSString* decryptSession = [DataEncryptProvider decryptFromString:(NSString*)sendData];
            if ([decryptSession length] > 0) {
                [loginUser setUserSession:decryptSession];
                [self enterMainScreen:NO];
            }
            else
            {
                [self showErrorMsg:@"创建用户失败，请重试"];
            }
        }
    }
    else
    {
        if ([sendData isKindOfClass:[NSDictionary class]]) {
            [loginUser objectFromJsonDictionary:sendData];
            if ([loginUser.userSession isEqual:[NSNull null]]) {
                dispatch_sync(MAIN_QUEUE, ^{
                    [lblErrorMsg setHidden:NO];
                    [lblErrorMsg setText: @"用户名或者密码错误"];
                    [self resetUnloginStatus];
                    return;
                });
            }
            else
            {
                [self enterMainScreen:NO];
                return;
            }
        }
        else if ([sendData isKindOfClass:[NSError class]])
        {
            dispatch_sync(MAIN_QUEUE, ^{
                [lblErrorMsg setHidden:NO];
                [lblErrorMsg setText: @"服务器不可用"];
                [self resetUnloginStatus];
            });
        }
    }
}

-(void)workingUIControl
{
    [lblErrorMsg setHidden:YES];
    [btnRegister setEnabled:NO];
    [btnforgetPassword setEnabled:NO];
    [txtUserName setEnabled:NO];
    [txtPassword setEnabled:NO];
    [progressLogin setHidden:NO];
    if (![progressLogin isAnimating]) {
        [progressLogin startAnimating];
    }
    [lblLoginDisplay setHidden:NO];
    [btnSubmit setEnabled:NO];
}

-(Boolean)checkInputData
{
    if (txtUserName.text == @"") {
        [self showErrorMsg:@"用户名不能为空"];
        return NO;
    }
    
    if (txtPassword.text == @"") {
        [self showErrorMsg:@"密码不能为空"];
        return NO;
    }
    return YES;
}

-(void)showErrorMsg:(NSString*) errorMsg
{
    lblErrorMsg.text = errorMsg;
    if (lblErrorMsg.hidden) {
        [lblErrorMsg setHidden:NO];
    }
}

-(void)enterMainScreen:(Boolean)mainThread
{
    __block DJAppDelegate* mBould = mainBounld;
    
    void(^enterMainScreen)(void)=^(void){
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 1.25f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.fillMode = kCAFillModeForwards;
        animation.type = kCATransitionMoveIn;
        animation.subtype = kCATransitionFromRight;
        [[self.view.superview layer] addAnimation:animation forKey:@"animation"];
        
        //UIView 改变代码
        [self.view removeFromSuperview];
        
        TeamViewController *viewControllerTeam = [[TeamViewController alloc] initWithNibName:@"TeamViewController" bundle:nil];
        FavoriteViewController *viewControllerFavorite = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController" bundle:nil];
        NearRestaurantViewController *viewControllerNearRestaurant = [[NearRestaurantViewController alloc]
                                                                      initWithNibName:@"NearRestaurantViewController" bundle:nil];
        MoreViewController *viewControllerMore = [[MoreViewController alloc]
                                                  initWithNibName:@"MoreViewController" bundle:nil];
        
        DJAppDelegate *shareBoundle = (DJAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        shareBoundle.loginUser = loginUser;
        
        UINavigationController *teamMainController = [[UINavigationController alloc] initWithRootViewController:viewControllerTeam];
        
        mBould.rootTabBarController = [[UITabBarController alloc] init];
        mBould.rootTabBarController.viewControllers = @[teamMainController, viewControllerFavorite,viewControllerNearRestaurant,viewControllerMore];
        mBould.window.rootViewController = mainBounld.rootTabBarController;
    };
    if (mainThread) {
        enterMainScreen();
    }
    else{
        dispatch_sync(MAIN_QUEUE, enterMainScreen);
    }
}

@end
