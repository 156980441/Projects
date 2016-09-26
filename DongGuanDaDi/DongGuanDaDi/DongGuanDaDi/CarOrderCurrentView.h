//
//  CarOrderCurrentView.h
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/9/8.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLDatePicker;

@interface CarOrderCurrentView : UIView <UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *startDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *endDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *passengerTxtField;
@property (strong, nonatomic) IBOutlet UITextView *reasonTxtView;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) YLDatePicker* picker;
- (IBAction)submitBtnClick:(id)sender;

@end
