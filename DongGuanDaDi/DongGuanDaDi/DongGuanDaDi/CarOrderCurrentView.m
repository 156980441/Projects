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

@interface CarOrderCurrentView () <UITextFieldDelegate,YLDatePickerDelegate>
@property (strong, nonatomic) YLDatePicker* picker;
@end

@implementation CarOrderCurrentView

-(void)awakeFromNib
{
    self.startDateTxtField.delegate = self;
    self.startTimeTxtField.delegate = self;
    self.endDateTxtField.delegate = self;
    self.endTimeTxtField.delegate = self;
    
    self.reasonTxtView.layer.borderColor = [UIColor grayColor].CGColor;
    self.reasonTxtView.layer.borderWidth =1.0;
    
    self.picker = [[YLDatePicker alloc] init];
    self.picker.delegate = self;
    self.picker.frame = CGRectMake(0, 0, 300, 250);
}

- (IBAction)submitBtnClick:(id)sender {
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.passengerTxtField.text,@"peopleNumber",
                         self.reasonTxtView.text,@"reason",
                         [NSString stringWithFormat:@"%@ %@",self.endDateTxtField.text,self.endTimeTxtField.text], @"end",
                         [NSString stringWithFormat:@"%@ %@",self.startDateTxtField.text,self.startTimeTxtField.text], @"start",
                         nil];
    NSDictionary* dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"2",@"peopleNumber",
                          @"何少毅",@"driver",
                          @"测试",@"reason",
                          @"粤WQS25",@"carNumber",
                          @"",@"officeId",
                          @"2016-09-05", @"end",
                          @"2016-09-04", @"start",
                          nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL_CAR_APPOINTMENT_SUBMIT_TABLE parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
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
        self.startDateTxtField.text = [YLCommon date2String:date];
    } else if (1 == picker.tag) {
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
