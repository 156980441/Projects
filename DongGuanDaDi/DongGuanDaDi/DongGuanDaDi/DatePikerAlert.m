//
//  DatePikerAlert.m
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/8/6.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "DatePikerAlert.h"

@implementation DatePikerAlert

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 450)];
    self.bounds = self.datePicker.frame;
    [self addSubview:self.datePicker];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
