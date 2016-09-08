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

@interface CarOrderView () <YLDatePickerDelegate>
@property (nonatomic, strong) NSMutableArray *carArray;
@end

@implementation CarOrderView

-(void)awakeFromNib
{
    self.datePiker = [[YLDatePicker alloc] init];
    self.datePiker.delegate = self;
    self.datePiker.frame = CGRectMake(0, 0, 300, 300);
    self.datePiker.mode = UIDatePickerModeDate;
    self.datePiker.backgroundColor = [UIColor whiteColor];
    [self.passenagersNunTxtField.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.passenagersNunTxtField.layer setBorderWidth:1.0];
    
    self.carArray = [NSMutableArray array];
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
    self.datePiker.delegate = nil;
    [self removeFromSuperview];
}

- (IBAction)submitBtnClick:(id)sender {
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.passenagersNunTxtField.text,@"peopleNumber",
                         [NSString stringWithFormat:@"%@ %@",self.endDateBtn.titleLabel.text,self.endTimeBtn.titleLabel.text], @"end",
                         [NSString stringWithFormat:@"%@ %@",self.startDateBtn.titleLabel.text,self.startTimeBtn.titleLabel.text], @"start",
                         nil];
    NSDictionary* dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"2",@"peopleNumber",
                          @"2016-09-08 12:10", @"end",
                          @"2016-09-07 12:10", @"start",
                          nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    [manager POST:URL_CAR_APPOINTMENT_SUBMIT parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary* dic = (NSDictionary*)responseObject;
        NSLog(@"succ %@",dic);
        NSArray* carManage_dic = [dic objectForKey:@"carManage"];
        NSArray* cars_arr = [dic objectForKey:@"cars"];
        for (NSDictionary* car_dic in cars_arr) {
            Car* car = [[Car alloc] init];
            car.brand = [car_dic objectForKey:@"brand"];
            car.number = [car_dic objectForKey:@"carNumber"];
            car.color = [car_dic objectForKey:@"color"];
            car.carId = ((NSNumber*)[car_dic objectForKey:@"id"]).integerValue;
            car.purpose = [car_dic objectForKey:@"purpose"];
            car.seating = ((NSNumber*)[car_dic objectForKey:@"seating"]).integerValue;
            car.type = [car_dic objectForKey:@"type"];
            car.url = [car_dic objectForKey:@"url"];
            car.weight = ((NSNumber*)[car_dic objectForKey:@"loading"]).integerValue;
            car.state = DGCarNotAppointment;
            [self.carArray addObject:car];
        }
        NSArray* departCarManage_dic = [dic objectForKey:@"departCarManage"];
        if (self.orderQuerySuccBlock) {
            self.orderQuerySuccBlock(self.carArray);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
    }];
    
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
@end
