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
        self.datePiker = [[YLDatePicker alloc] init];
        self.datePiker.delegate = self;
        CGRect rect = CGRectMake(0, 0, 300, 250);
        CGPoint origin = CGPointMake(self.view.center.x - rect.size.width / 2, self.view.center.y - rect.size.height / 2);
        [self.datePiker showInView:self.view
                         withFrame:CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height)
                 andDatePickerMode:UIDatePickerModeDate];
    }
}

- (IBAction)queryRecord:(id)sender {
}

- (void)picker:(UIDatePicker *)picker valueChanged:(NSDate *)date
{
    [self.startBtn setTitle:[Common date2String:date] forState:UIControlStateNormal];
}

@end
