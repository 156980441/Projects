//
//  CarNotAppointmentCell.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLDatePicker;
@interface CarNotAppointmentCell : UITableViewCell <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *brandTxtField;
@property (strong, nonatomic) IBOutlet UITextField *startDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *endDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *passengerTxtField;
@property (strong, nonatomic) IBOutlet UITextField *seatintTxtField;
@property (strong, nonatomic) IBOutlet UITextField *appointmentPeopleTxtField;
@property (strong, nonatomic) IBOutlet UITextView *appointReasonTxtView;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
@property (strong, nonatomic) YLDatePicker* picker;
- (IBAction)appointmentBtnClick:(id)sender;

@end
