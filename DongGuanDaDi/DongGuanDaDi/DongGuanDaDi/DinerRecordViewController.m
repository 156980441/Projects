//
//  DinerRecordViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "DinerRecordViewController.h"
#import "Common.h"

@implementation DinerRecordViewController

- (IBAction)selectDate:(id)sender {
    if (!self.datePiker) {
        UIButton* btn = (UIButton*)sender;
        self.datePiker = [[YLDatePicker alloc] init];
        self.datePiker.delegate = self;
        CGRect rect = CGRectMake(0, 0, 300, 250);
        CGPoint origin = CGPointMake(self.view.center.x - rect.size.width / 2, self.view.center.y - rect.size.height / 2);
        [self.datePiker showInView:self.view
                         withFrame:CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height)
                 andDatePickerMode:UIDatePickerModeDate];
        self.datePiker.picker.tag = btn.tag;// storyboard set StartBtn tag is 0, EndBtn tag is 1;
    }
    else
    {
        [self.datePiker dismiss];
        self.datePiker = nil;// System automatic release delay
    }
}

- (IBAction)queryRecord:(id)sender {
    // hide some buttons in storyboard. Such as date button. When query come back result appear them.
}

- (void)picker:(UIDatePicker *)picker valueChanged:(NSDate *)date
{
    if (picker.tag == 0) {
        if (date) {
            [self.startBtn setTitle:[Common date2String:date] forState:UIControlStateNormal];
        }
    }
    else if (picker.tag == 1)
    {
        if (date) {
            [self.endBtn setTitle:[Common date2String:date] forState:UIControlStateNormal];
        }
    }
}

@end
