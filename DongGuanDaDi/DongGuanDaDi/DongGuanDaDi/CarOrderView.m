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

enum BtnTagTypes
{
    StartDateTag,
    EndDateTag,
    StartTimeTag,
    endTimeTag
};

@interface CarOrderView () <YLDatePickerDelegate>

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
            [self.startTimeBtn setTitle:[YLCommon date2String:date] forState:UIControlStateNormal];
        }
    }
    else if (picker.tag == endTimeTag)
    {
        if (date) {
            [self.endTimeBtn setTitle:[YLCommon date2String:date] forState:UIControlStateNormal];
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
