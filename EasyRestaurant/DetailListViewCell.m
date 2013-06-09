//
//  DetailListViewCell.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-18.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "DetailListViewCell.h"

@class DetailListViewCell;

@implementation DetailListViewCell

@synthesize lbDescriptionField;
@synthesize lbImportantInfoField;
@synthesize lbNameField;
@synthesize lbRightInfoField;
@synthesize imgField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showHiddenControl:(UIView*)control show:(BOOL)toShow
{
    control.hidden = toShow;
}

+(NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}
@end
