//
//  DetailListViewCell.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-18.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailListViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UITableViewCell *cell;

@property (nonatomic,strong) IBOutlet UILabel *lbNameField;
@property (nonatomic,strong) IBOutlet UILabel *lbDescriptionField;
@property (nonatomic,strong) IBOutlet UILabel *lbImportantInfoField;
@property (nonatomic,strong) IBOutlet UILabel *lbRightInfoField;
@property (nonatomic,strong) IBOutlet UIImageView *imgField;


+(NSString*)cellReuseIdentifier;
@end
