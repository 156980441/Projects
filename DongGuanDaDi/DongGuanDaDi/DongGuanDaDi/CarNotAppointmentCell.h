//
//  CarNotAppointmentCell.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarNotAppointmentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *brandTxtField;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *passengerTxtField;
@property (strong, nonatomic) IBOutlet UITextField *seatintTxtField;
@property (strong, nonatomic) IBOutlet UITextField *appointmentPeopleTxtField;
@property (strong, nonatomic) IBOutlet UITextView *appointReasonTxtView;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
- (IBAction)appointmentBtnClick:(id)sender;

@end
