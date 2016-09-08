//
//  CarOrderView.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/6/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLDatePicker;

@interface CarOrderView : UIView

@property (nonatomic, strong) YLDatePicker *datePiker;

@property (strong, nonatomic) IBOutlet UIButton *endDateBtn;
@property (strong, nonatomic) IBOutlet UIButton *startDateBtn;
@property (strong, nonatomic) IBOutlet UIButton *startTimeBtn;
@property (strong, nonatomic) IBOutlet UIButton *endTimeBtn;
@property (strong, nonatomic) IBOutlet UITextField *passenagersNunTxtField;

@property (copy, nonatomic) void (^cancelBtnClickBlock)(void);
@property (copy, nonatomic) void (^submitBtnClickBlock)(void);

@end
