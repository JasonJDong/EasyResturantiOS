//
//  SimpleLabelContentCell.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-11.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleLabelContentCell : UITableViewCell


@property (nonatomic,retain) IBOutlet UILabel* lbDisplayTitle;
@property (nonatomic,retain) IBOutlet UILabel* lbDisplayDescription;
@property (nonatomic,retain) IBOutlet UITextField* txtDisplayInput;

@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* description;
@property (nonatomic,copy) NSString* input;


-(void)openAccessory:(UITableViewCellAccessoryType)accessoryType open:(BOOL)openAccessory;
-(void)showOrHideDescription:(BOOL)show;
@end
