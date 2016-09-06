//
//  CarDepartTableViewCell.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CarDepartTableViewCell.h"
#import "YLToast.h"
#import "YLDatePicker.h"
#import "YLCommon.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@interface CarDepartTableViewCell () <UITextFieldDelegate,YLDatePickerDelegate>
@property (nonatomic, strong) YLDatePicker *picker;
@end

@implementation CarDepartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.orderEndDateTxtField.delegate = self;
    self.orderEndTimeTxtField.delegate = self;
    self.orderStartDateTxtField.delegate = self;
    self.orderStartTimeTxtField.delegate = self;
    
    // UITextView 添加边框
    self.orderReasonTxtView.layer.borderColor = [UIColor grayColor].CGColor;
    self.orderReasonTxtView.layer.borderWidth =1.0;
    
    self.picker = [[YLDatePicker alloc] init];
    self.picker.frame = CGRectMake(0, 0, 300, 250);
    self.picker.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)submitClick:(id)sender {
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.passengersTxtField.text,@"peopleNumber",
                         self.driverTxtField.text,@"driver",
                         self.reasonTxtField.text,@"reason",
                         self.carNumberTxtField.text,@"carNumber",
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
    self.picker.backgroundColor = [UIColor whiteColor];
    [self.picker show];
    self.picker.mode = UIDatePickerModeDate;
    if (self.startDateTxtField == textField) {
        self.picker.picker.tag = 0;
    } else if (self.endDateTxtField == textField) {
        self.picker.picker.tag = 1;
    } else if (self.startTimeTxtField == textField) {
        self.picker.mode = UIDatePickerModeTime;
        self.picker.picker.tag = 2;
    } else if (self.endTimeTxtField == textField) {
        self.picker.mode = UIDatePickerModeTime;
        self.picker.picker.tag = 3;
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
