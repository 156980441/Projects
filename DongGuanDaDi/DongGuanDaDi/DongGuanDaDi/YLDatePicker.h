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

@property (weak, nonatomic) id<YLDatePickerDelegate> delegate;

@property (strong, nonatomic) UIDatePicker *picker;

- (void)showInView:(UIView *)view withFrame:(CGRect)frame andDatePickerMode:(UIDatePickerMode)mode;

- (void)dismiss;

- (void)valueChanged:(UIDatePicker *)picker;

@end
