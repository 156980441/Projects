//
//  CarDepartTableViewCell.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDepartTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *carImageView;
@property (strong, nonatomic) IBOutlet UITextField *startDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *endDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *realStartDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *realStartTimeTxtField;

@property (strong, nonatomic) IBOutlet UITextField *passengersTxtField;
@property (strong, nonatomic) IBOutlet UITextField *seatingTxtField;
@property (strong, nonatomic) IBOutlet UITextField *driverTxtField;
@property (strong, nonatomic) IBOutlet UITextField *reasonTxtField;
@property (strong, nonatomic) IBOutlet UITextField *orderConditionTxtField;
@property (strong, nonatomic) IBOutlet UITextField *orderStartTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *orderEndTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextView *orderReasonTxtView;




@end
