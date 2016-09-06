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
    self.alpha = 1.0;
    self.datePiker = [[YLDatePicker alloc] init];
    self.datePiker.delegate = self;
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
    self.superview.alpha = 1.0;
    [self removeFromSuperview];
}

- (IBAction)submitBtnClick:(id)sender {
}

- (IBAction)startDateBtnClick:(id)sender {
    
    if (self.datePiker.superview) {
        [self.datePiker dismiss];
    }
    else {
        CGRect rect = CGRectMake(0, 0, 300, 300);
        CGPoint origin = CGPointMake(self.window.center.x - rect.size.width / 2, self.window.center.y - rect.size.height / 2);
        [self.datePiker showInView:self.window
                         withFrame:CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height)
                 andDatePickerMode:UIDatePickerModeDate];
        self.datePiker.tag = StartDateTag;
    }
    
}

- (IBAction)endDateBtnClick:(id)sender {
    if (self.datePiker.superview) {
        [self.datePiker dismiss];
    }
    else {
        CGRect rect = CGRectMake(0, 0, 300, 250);
        CGPoint origin = CGPointMake(self.window.center.x - rect.size.width / 2, self.window.center.y - rect.size.height / 2);
        [self.datePiker showInView:self.window
                         withFrame:CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height)
                 andDatePickerMode:UIDatePickerModeDate];
        self.datePiker.tag = EndDateTag;
    }

}

- (IBAction)startTimeBtnClick:(id)sender {
    if (self.datePiker.superview) {
        [self.datePiker dismiss];
    }
    else {
        CGRect rect = CGRectMake(0, 0, 300, 250);
        CGPoint origin = CGPointMake(self.window.center.x - rect.size.width / 2, self.window.center.y - rect.size.height / 2);
        [self.datePiker showInView:self.window
                         withFrame:CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height)
                 andDatePickerMode:UIDatePickerModeTime];
        self.datePiker.tag = StartTimeTag;
    }
}

- (IBAction)endTimeBtnClick:(id)sender {
    if (self.datePiker.superview) {
        [self.datePiker dismiss];
    }
    else {
        CGRect rect = CGRectMake(0, 0, 300, 250);
        CGPoint origin = CGPointMake(self.window.center.x - rect.size.width / 2, self.window.center.y - rect.size.height / 2);
        [self.datePiker showInView:self.window
                         withFrame:CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height)
                 andDatePickerMode:UIDatePickerModeTime];
        self.datePiker.tag = endTimeTag;
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
