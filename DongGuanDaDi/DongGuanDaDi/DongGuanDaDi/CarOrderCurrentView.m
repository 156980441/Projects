//
//  CarOrderCurrentView.m
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/9/8.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "CarOrderCurrentView.h"
#import "YLCommon.h"
#import "YLToast.h"
#import "YLDatePicker.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@interface CarOrderCurrentView () <YLDatePickerDelegate>

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end

@implementation CarOrderCurrentView

// 为了 xib 的嵌套
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"CarOrderCurrentView" owner:self options:nil] lastObject];
        [self addSubview:view];
    }
    return self;
}

-(void)awakeFromNib
{
    // CarAppointmentTableViewController 不调用，不经过storyboard就不调用。
    self.startDateTxtField.delegate = self;
    self.startTimeTxtField.delegate = self;
    self.endDateTxtField.delegate = self;
    self.endTimeTxtField.delegate = self;
    
    self.reasonTxtView.layer.borderColor = [UIColor grayColor].CGColor;
    self.reasonTxtView.layer.borderWidth =1.0;
    self.reasonTxtView.delegate = self;
    
    self.picker = [[YLDatePicker alloc] init];
    self.picker.delegate = self;
    self.picker.frame = CGRectMake(0, 0, 300, 250);
    
    self.passengerTxtField.keyboardType = UIKeyboardTypeNumberPad;
}

- (IBAction)submitBtnClick:(id)sender {
    
    if (self.submitBtnClickBlock) {
        self.submitBtnClickBlock(self.startDate,self.endDate);
    }
}

// 写在这里防止弹出键盘
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.reasonTxtView resignFirstResponder];
    if (self.passengerTxtField != textField) {
        [self.passengerTxtField resignFirstResponder];
    }
    
    self.picker.backgroundColor = [UIColor whiteColor];
    self.picker.mode = UIDatePickerModeDate;
    if (self.startDateTxtField == textField) {
        self.picker.picker.tag = 0;
        [self.picker show];
    } else if (self.endDateTxtField == textField) {
        self.picker.picker.tag = 1;
        [self.picker show];
    } else if (self.startTimeTxtField == textField) {
        self.picker.mode = UIDatePickerModeTime;
        self.picker.picker.tag = 2;
        [self.picker show];
    } else if (self.endTimeTxtField == textField) {
        self.picker.mode = UIDatePickerModeTime;
        self.picker.picker.tag = 3;
        [self.picker show];
    } else
    {
        return YES;
    }
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.picker dismiss];
}
- (void)picker:(UIDatePicker *)picker valueChanged:(NSDate *)date
{
    if (0 == picker.tag) {
        
        if ([[date dateByAddingTimeInterval:60] compare:[NSDate date]] == NSOrderedAscending) {
            [YLToast showWithText:@"出车时间不能小于当前时间"];
            return;
        }
        self.startDate = date;
        
        self.startDateTxtField.text = [YLCommon date2String:date];
    } else if (1 == picker.tag) {
        
        if ([date compare:self.startDate] == NSOrderedAscending) {
            [YLToast showWithText:@"还车时间应大于出车时间"];
            return;
        }
        self.endDate = date;
        
        self.endDateTxtField.text = [YLCommon date2String:date];
    } else if (2 == picker.tag) {
        self.startTimeTxtField.text = [YLCommon time2String:date];
    } else if (3 == picker.tag) {
        self.endTimeTxtField.text = [YLCommon time2String:date];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // 调整键盘和视图高度
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    
    self.center = CGPointMake(self.center.x, self.center.y - 216 / 2);// 键盘高度216
    
    [UIView commitAnimations];
    
}

@end
