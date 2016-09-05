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

@end

@implementation CarNotAppointmentCell

-(void)awakeFromNib
{
    self.startTimeTxtField.delegate = self;
    self.endTimeTxtField.delegate = self;
    self.startDateTxtField.delegate = self;
    self.endDateTxtField.delegate = self;
    self.passengerTxtField.delegate = self;
}

- (IBAction)appointmentBtnClick:(id)sender {
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.passengerTxtField.text,@"peopleNumber",
                         self.appointmentPeopleTxtField.text,@"driver",
                         self.appointReasonTxtView.text,@"reason",
                         self.brandTxtField.text,@"carNumber",
                         @"",@"officeId",
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
        [YLToast showWithText:@"预约失败"];
        NSLog(@"%@",error.description);
    }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.picker = [[YLDatePicker alloc] init];
    self.picker.delegate = self;
    CGRect date_rect = CGRectMake(0, 0, 300, 250);
    CGPoint date_origin = CGPointMake(self.superview.center.x - date_rect.size.width / 2, self.superview.center.y - date_rect.size.height / 2);
    if (self.startDateTxtField == textField) {
        [self.picker showInView:self.superview
                    withFrame:CGRectMake(date_origin.x, date_origin.y, date_rect.size.width, date_rect.size.height)
            andDatePickerMode:UIDatePickerModeDate];
        self.picker.picker.tag = 0;
    } else if (self.endDateTxtField == textField) {
        
        [self.picker showInView:self.superview
                    withFrame:CGRectMake(date_origin.x, date_origin.y, date_rect.size.width, date_rect.size.height)
            andDatePickerMode:UIDatePickerModeDate];
        self.picker.picker.tag = 1;
    } else if (self.startTimeTxtField == textField) {
        
        [self.picker showInView:self.superview
                    withFrame:CGRectMake(date_origin.x, date_origin.y, date_rect.size.width, date_rect.size.height)
            andDatePickerMode:UIDatePickerModeTime];
        self.picker.picker.tag = 2;
    } else if (self.endTimeTxtField == textField) {
        
        [self.picker showInView:self.superview
                    withFrame:CGRectMake(date_origin.x, date_origin.y, date_rect.size.width, date_rect.size.height)
            andDatePickerMode:UIDatePickerModeTime];
        self.picker.picker.tag = 3;//这里封装的不好。需要show之后才能设置tag
    }
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
@end
