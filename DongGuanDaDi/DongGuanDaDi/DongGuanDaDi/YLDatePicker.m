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

- (instancetype)initWithMode:(UIDatePickerMode)mode
{
    YLDatePicker* pick = [self init];
    pick.picker.datePickerMode = mode;
    return pick;
}

- (instancetype) init
{
    self = [super init];
    
    if (self) {
        self.picker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        
        self.submit = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self.submit setTitle:@"确认" forState:UIControlStateNormal];
        [self.submit addTarget:self action:@selector(confirmDone) forControlEvents:UIControlEventTouchUpInside];
        
        self.cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.cancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancel addTarget:self action:@selector(cancelDone) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.cancel];
        [self addSubview:self.submit];
        [self addSubview:self.picker];
    }
    
    return self;
}

- (void) layoutSubviews
{
    CGRect frame = self.frame;
    self.picker.frame = CGRectMake(0,
                                   0,
                                   CGRectGetWidth(frame),
                                   CGRectGetHeight(frame) - CommonHeght);
    
    CGRect picker_frame = self.picker.frame;
    self.submit.frame = CGRectMake(picker_frame.origin.x,
                                   CGRectGetHeight(picker_frame),
                                   CGRectGetWidth(picker_frame) / 2,
                                   CommonHeght);
    
    CGRect submit_frame = self.submit.frame;
    self.cancel.frame = CGRectMake(submit_frame.origin.x + CGRectGetWidth(submit_frame),
                                   submit_frame.origin.y,
                                   CGRectGetWidth(submit_frame),
                                   CommonHeght);
    
    [super layoutSubviews];
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.center = window.center;
    [window addSubview:self];
}

- (void)showInView:(UIView*)view
{
    [view addSubview:self];
    
    CGRect frame = self.frame;
    
    // pop from bottom
    self.frame = CGRectMake(self.window.center.x - self.frame.size.width / 2, self.window.center.y, frame.size.width, frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = self.window.center;
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

-(void)setMode:(UIDatePickerMode)mode
{
    self.picker.datePickerMode = mode;
}

- (void)showInView:(UIView *)view withFrame:(CGRect)frame andDatePickerMode:(UIDatePickerMode)mode{
    self.picker.datePickerMode = mode;
    [self showInView:view];
    
    /**
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
    **/
}

- (void)dismiss
{
    [self removeFromSuperview];
    NSLog(@"%zd",self.picker.tag);
}

- (void)dismissWithAnamition{
    
    CGRect frame = self.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(self.superview.center.x - self.frame.size.width / 2, SCREENHEIGHT, frame.size.width, frame.size.height);
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
