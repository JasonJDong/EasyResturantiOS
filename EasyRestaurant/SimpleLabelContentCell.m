//
//  SimpleLabelContentCell.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-11.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "SimpleLabelContentCell.h"

@implementation SimpleLabelContentCell

@synthesize lbDisplayTitle;
@synthesize lbDisplayDescription;
@synthesize txtDisplayInput;

@synthesize title;
@synthesize description;
@synthesize input;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitle:(NSString *)displayTitle
{
    if (![displayTitle isEqualToString:title]) {
        title = [displayTitle copy];
        [self.lbDisplayTitle setText:title];
    }
}

-(void)setInput:(NSString *)displayInput
{
    if (![displayInput isEqualToString:input]) {
        input = [displayInput copy];
        [self.txtDisplayInput setText:input];
    }
}

-(void)setDescription:(NSString *)displayDescription
{
    if (![displayDescription isEqualToString:description]) {
        description = [displayDescription copy];
        [self.lbDisplayDescription setText:description];
    }
}

-(void)openAccessory:(UITableViewCellAccessoryType)accessoryType open:(BOOL)openAccessory
{
    if (openAccessory) {
        self.accessoryType = accessoryType;
    }
    else
    {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

//目前cell最适高度为60，待以后版本自适应
-(void)showOrHideDescription:(BOOL)show
{
    self.lbDisplayDescription.hidden = !show;
    if (show) {
        //[self.lbDisplayTitle setFrame:CGRectMake(19, 20,self.lbDisplayTitle.bounds.size.width, self.lbDisplayTitle.bounds.size.height)];
        [self.lbDisplayTitle removeFromSuperview];
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(19, 14, 42, 20)];
        label.text = title;
        label.backgroundColor = [UIColor clearColor];
        lbDisplayTitle = label;
        
        [self addSubview:lbDisplayTitle];
    }
    else
    {
        //[self.lbDisplayTitle setFrame:CGRectMake(19, 28,self.lbDisplayTitle.bounds.size.width, self.lbDisplayTitle.bounds.size.height)];
        [self.lbDisplayTitle removeFromSuperview];
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(19, 22, 42, 20)];
        label.text = title;
        label.backgroundColor = [UIColor clearColor];
        lbDisplayTitle = label;
        
        [self addSubview:lbDisplayTitle];
    }
}
@end
