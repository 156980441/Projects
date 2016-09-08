//
//  CarOrderCurrentView.m
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/9/8.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "CarOrderCurrentView.h"

@implementation CarOrderCurrentView
-(void)awakeFromNib
{
    self.reasonTxtView.layer.borderColor = [UIColor grayColor].CGColor;
    self.reasonTxtView.layer.borderWidth =1.0;
}
@end
