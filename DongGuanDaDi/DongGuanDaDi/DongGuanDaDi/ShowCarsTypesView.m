//
//  ShowCarsTypesView.m
//  DongGuanDaDi
//
//  Created by fanyl on 16/8/31.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "ShowCarsTypesView.h"

@implementation ShowCarsTypesView
-(void)awakeFromNib
{
    self.notAppointmentBtn.tag = 0;
    self.departBtn.tag = 1;
    self.hasBackBtn.tag = 2;
    [self.notAppointmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.departBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.hasBackBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
}
-(void)btnClick:(UIButton*)sender
{
    self.showCarsTypeBlock(sender.tag);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
