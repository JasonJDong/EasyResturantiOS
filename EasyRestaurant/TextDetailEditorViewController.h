//
//  TextDetailEditorViewController.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-8.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicateDataDelegate.h"
#import "EntityEnumDefined.h"

@interface TextDetailEditorViewController : UIViewController<UITextViewDelegate>

@property (nonatomic,strong) IBOutlet UITextView *textViewInput;
@property (nonatomic,strong) IBOutlet UITextField *textShowCharactorCount;

@property (nonatomic,assign) TextDetailViewRemoveStyle   removeStyle;
@property (nonatomic,assign) id<CommunicateDataDelegate> sendDataDelegate;

@property (nonatomic) TextFieldInputType inputType;
@end
