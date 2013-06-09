//
//  NearRestaurantViewController.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-10-29.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "NearRestaurantViewController.h"

@interface NearRestaurantViewController ()

@end

@implementation NearRestaurantViewController

@synthesize loginUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"附近餐厅", @"NearRestaurant");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
