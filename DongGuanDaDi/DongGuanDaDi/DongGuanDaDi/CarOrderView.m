//
//  CarOrderView.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/6/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CarOrderView.h"
#import "YLDatePicker.h"
#import "YLCommon.h"
#import "YLToast.h"
#import "Car.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

enum BtnTagTypes
{
    StartDateTag,
    EndDateTag,
    StartTimeTag,
    endTimeTag
};

@interface CarOrderView () <YLDatePickerDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@property (strong, nonatomic) IBOutlet UIButton *submitBtn;


@end

@implementation CarOrderView

-(void)awakeFromNib
{
    self.datePiker = [[YLDatePicker alloc] init];
    self.datePiker.delegate = self;
    self.datePiker.frame = CGRectMake(0, 0, 320, 300);
    self.datePiker.mode = UIDatePickerModeDate;
    self.datePiker.backgroundColor = [UIColor whiteColor];
    [self.passenagersNunTxtField.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.passenagersNunTxtField.layer setBorderWidth:1.0];
    
    self.passenagersNunTxtField.delegate = self;
    self.passenagersNunTxtField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.cancelBtn.layer.borderWidth = self.submitBtn.layer.borderWidth = 0.5;
    self.cancelBtn.layer.borderColor = self.submitBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)cancelBtnClick:(id)sender
{
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock();
    }
    self.datePiker.delegate = nil;
}

- (IBAction)submitBtnClick:(id)sender {

    if (self.submitBtnClickBlock) {
        self.submitBtnClickBlock();
    }
    
}

- (IBAction)startDateBtnClick:(id)sender {
    
    if (self.datePiker.superview) {
        [self.datePiker dismiss];
    }
    else {
        self.datePiker.picker.tag = StartDateTag;
        [self.datePiker show];
    }
    
}

- (IBAction)endDateBtnClick:(id)sender {
    if (self.datePiker.superview) {
        [self.datePiker dismiss];
    }
    else {
        self.datePiker.picker.tag = EndDateTag;
        [self.datePiker show];
    }

}

- (IBAction)startTimeBtnClick:(id)sender {
    if (self.datePiker.superview) {
        [self.datePiker dismiss];
    }
    else {
        self.datePiker.mode = UIDatePickerModeTime;
        self.datePiker.picker.tag = StartTimeTag;
        [self.datePiker show];
    }
}

- (IBAction)endTimeBtnClick:(id)sender {
    if (self.datePiker.superview) {
        [self.datePiker dismiss];
    }
    else {
        self.datePiker.mode = UIDatePickerModeTime;
        self.datePiker.picker.tag = endTimeTag;
        [self.datePiker show];
    }
}
- (void)picker:(UIDatePicker *)picker valueChanged:(NSDate *)date
{
    if (picker.tag == StartTimeTag) {
        if (date) {
            [self.startTimeBtn setTitle:[YLCommon time2String:date] forState:UIControlStateNormal];
        }
    }
    else if (picker.tag == endTimeTag)
    {
        if (date) {
            [self.endTimeBtn setTitle:[YLCommon time2String:date] forState:UIControlStateNormal];
        }
    }
    else if (picker.tag == EndDateTag)
    {
        if (date) {
            [self.endDateBtn setTitle:[YLCommon date2String:date] forState:UIControlStateNormal];
        }
    }
    else if (picker.tag == StartDateTag)
    {
        if (date) {
            [self.startDateBtn setTitle:[YLCommon date2String:date] forState:UIControlStateNormal];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    // 调整键盘和视图高度
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    
    self.center = CGPointMake(self.center.x, self.center.y - 216 / 2);// 键盘高度216
    
    [UIView commitAnimations];
    
}

@end
