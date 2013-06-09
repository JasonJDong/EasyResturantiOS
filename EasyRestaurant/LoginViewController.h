//
//  LoginViewController.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-12-17.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJAppDelegate.h"
#import "UserEntity.h"
#import "CommunicateDataDelegate.h"

@interface LoginViewController : UIViewController<CommunicateDataDelegate,UITextFieldDelegate>

//控件
@property (nonatomic,strong) IBOutlet UIButton      *btnSubmit;
@property (nonatomic,strong) IBOutlet UIButton      *btnRegister;
@property (nonatomic,strong) IBOutlet UIButton      *btnLoginStatus;
@property (nonatomic,strong) IBOutlet UIButton      *btnforgetPassword;
@property (nonatomic,strong) IBOutlet UITextField   *txtUserName;
@property (nonatomic,strong) IBOutlet UITextField   *txtPassword;
@property (nonatomic,strong) IBOutlet UILabel       *lblErrorMsg;
@property (nonatomic,strong) IBOutlet UILabel       *lblLoginDisplay;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView       *progressLogin;

//数据
@property (nonatomic,strong) UserEntity *loginUser;

//本地数据
@property (nonatomic) Boolean isRegister;

//主界面委托
@property (nonatomic,assign) DJAppDelegate *mainBounld;

-(void)enterMainScreen:(Boolean) mainThread;
@end
