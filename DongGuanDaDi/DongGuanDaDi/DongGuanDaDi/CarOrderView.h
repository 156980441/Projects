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

- (IBAction)cancelBtnClick:(id)sender;
- (IBAction)submitBtnClick:(id)sender;

- (IBAction)startDateBtnClick:(id)sender;
- (IBAction)endDateBtnClick:(id)sender;
- (IBAction)startTimeBtnClick:(id)sender;
- (IBAction)endTimeBtnClick:(id)sender;


@end
