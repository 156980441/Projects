//
//  YLDatePicker.h
//  YLUI
//
//  Created by 我叫不紧张 on 16/8/6.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YLDatePickerDelegate <NSObject>

@optional

- (void)picker:(UIDatePicker *)picker valueChanged:(NSDate *)date;

@end

@interface YLDatePicker : UIView

- (instancetype)initWithMode:(UIDatePickerMode)mode;

@property (weak, nonatomic) id<YLDatePickerDelegate> delegate;

@property (strong, nonatomic) UIDatePicker *picker;
@property (assign, nonatomic) UIDatePickerMode mode;
@property (strong, nonatomic) UIButton *submit;
@property (strong, nonatomic) UIButton *cancel;

- (void)show;

- (void)showInView:(UIView*)view;

- (void)showInView:(UIView *)view withFrame:(CGRect)frame andDatePickerMode:(UIDatePickerMode)mode;

- (void)dismiss;
- (void)dismissWithAnamition;

- (void)valueChanged:(UIDatePicker *)picker;

@end
