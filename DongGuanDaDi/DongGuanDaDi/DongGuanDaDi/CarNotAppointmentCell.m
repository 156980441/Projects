//
//  CarNotAppointmentCell.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CarNotAppointmentCell.h"
#import "YLDatePicker.h"
#import "YLCommon.h"
#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@interface CarNotAppointmentCell () <YLDatePickerDelegate>
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@end

@implementation CarNotAppointmentCell

-(void)awakeFromNib
{
    self.brandTxtField.enabled = NO;
    self.seatintTxtField.enabled = NO;
    
    self.startTimeTxtField.delegate = self;
    self.endTimeTxtField.delegate = self;
    self.startDateTxtField.delegate = self;
    self.endDateTxtField.delegate = self;
    self.passengerTxtField.delegate = self;
    self.passengerTxtField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.appointReasonTxtView.layer.borderColor = [UIColor grayColor].CGColor;
    self.appointReasonTxtView.layer.borderWidth = 1.0;
    
    self.picker = [[YLDatePicker alloc] init];
    self.picker.delegate = self;
    self.picker.frame = CGRectMake(0, 0, 300, 250);
}

- (IBAction)appointmentBtnClick:(id)sender {
    
    if ([self.passengerTxtField.text isEqualToString:@""] || [self.appointReasonTxtView.text isEqualToString:@""] || [self.startDateTxtField.text isEqualToString:@""] || [self.endDateTxtField.text isEqualToString:@""]  || [self.startTimeTxtField.text isEqualToString:@""] || [self.endTimeTxtField.text isEqualToString:@""]) {
        [YLToast showWithText:@"输入不能为空"];
        return;
    }
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.passengerTxtField.text,@"peopleNumber",
                         self.appointmentPeopleTxtField.text,@"driver",
                         self.appointReasonTxtView.text,@"reason",
                         self.brandTxtField.text,@"carNumber",
                         @"",@"officeId",
                         [NSString stringWithFormat:@"%@ %@",self.endDateTxtField.text,self.endTimeTxtField.text], @"end",
                         [NSString stringWithFormat:@"%@ %@",self.startDateTxtField.text,self.startTimeTxtField.text], @"start",
                         nil];
    // test
//    NSDictionary* dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                         @"2",@"peopleNumber",
//                         @"何少毅",@"driver",
//                         @"测试",@"reason",
//                         @"粤WQS25",@"carNumber",
//                         @"",@"officeId",
//                         @"2016-09-05", @"end",
//                         @"2016-09-04", @"start",
//                         nil];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL_CAR_APPOINTMENT_SUBMIT_TABLE parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [YLToast showWithText:@"预约成功"];
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
        NSLog(@"%@",error.description);
    }];
}

// 写在这里防止弹出键盘
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.appointReasonTxtView resignFirstResponder];
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
    
    if (self.passengerTxtField == textField) {
        if (self.passengerTxtField.text.integerValue > self.seatintTxtField.text.integerValue) {
            [YLToast showWithText:@"随车人数不能大于座位数"];
        }
    }
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
@end
