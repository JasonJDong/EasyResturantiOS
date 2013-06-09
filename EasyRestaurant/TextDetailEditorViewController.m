//
//  TextDetailEditorViewController.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-8.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "TextDetailEditorViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TextDetailEditorViewController ()

@end

@implementation TextDetailEditorViewController

@synthesize textViewInput;
@synthesize sendDataDelegate;
@synthesize removeStyle;
@synthesize textShowCharactorCount;
@synthesize inputType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        removeStyle = TextDetailViewRemoveStyleNavigateController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textViewInput.layer.borderColor = [[UIColor grayColor] CGColor];
    self.textViewInput.layer.borderWidth = 5;
    
    UIBarButtonItem *commitButton =
        [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(commitButtonPressed)];
    self.navigationItem.rightBarButtonItem = commitButton;
    
    self.textViewInput.delegate = self;
    self.textShowCharactorCount.text = @"0";
    if (inputType == TextFieldInputTypeNumber) {
        textViewInput.keyboardType = UIKeyboardTypeNumberPad;
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSInteger charLength =  [self.textViewInput.text length];
    self.textShowCharactorCount.text = [NSString stringWithFormat:@"%d",charLength];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (inputType == TextFieldInputTypeNumber)
    {
        if (textView.text.length > 2) {
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    textViewInput = nil;
    sendDataDelegate = nil;
}

-(void)commitButtonPressed
{
    [self commitTextChanges];
}

-(void)saveData
{
    if (sendDataDelegate != nil) {
        NSString *sendToData = [self.textViewInput.text copy];
        [sendDataDelegate receiveStringData:sendToData];
    }
}
-(void)commitTextChanges
{
    [self saveData];
    switch (removeStyle) {
        case TextDetailViewRemoveStyleNavigateController:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case TextDetailViewRemoveStyleNormalRemove:
            [self.view removeFromSuperview];
            break;
        default:
            break;
    }
}
@end
