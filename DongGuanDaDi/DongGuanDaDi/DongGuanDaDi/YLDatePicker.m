//
//  YLDatePicker.m
//  YLUI
//
//  Created by 我叫不紧张 on 16/8/6.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "YLDatePicker.h"
#import "YLUI_stdfax.h"

@implementation YLDatePicker

- (void)showInView:(UIView *)view withFrame:(CGRect)frame andDatePickerMode:(UIDatePickerMode)mode{
    
    self.frame = frame;
    
    if(!self.picker){
        self.picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - CommonHeght)];
    }
    
    self.picker.datePickerMode = mode;
    
//    [self.picker addTarget:self
//                    action:@selector(valueChanged:)
//          forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:self.picker];
    
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeSystem];
    confirm.frame = CGRectMake(self.picker.frame.origin.x, self.picker.frame.size.height, self.picker.frame.size.width / 2, CommonHeght);
    [confirm setTitle:@"确认" forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(confirmDone) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirm];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    cancel.frame = CGRectMake(confirm.frame.origin.x + confirm.frame.size.width, confirm.frame.origin.y, confirm.frame.size.width, CommonHeght);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelDone) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    
    [view addSubview:self];
    
    // pop from bottom
    self.frame = CGRectMake(view.center.x - frame.size.width / 2, view.center.y, 0, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
    }];
}

- (void)confirmDone{
    if (![self.picker respondsToSelector:@selector(valueChanged:)]) {
        [self.delegate picker:self.picker valueChanged:self.picker.date];
    }
    [self dismiss];
}

- (void)cancelDone{
    [self dismiss];
}

- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(self.superview.center.x - self.frame.size.width / 2, SCREENHEIGHT, 0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)valueChanged:(UIDatePicker *)picker{
    if([self.delegate respondsToSelector:@selector(picker:valueChanged:)]){
//        [self.delegate picker:picker valueChanged:picker.date];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
