//
//  CarDepartOfMyOrderTableViewCell.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/12/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDepartOfMyOrderTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *carImage;

@property (strong, nonatomic) IBOutlet UITextField *carNumberTxtField;

@property (strong, nonatomic) IBOutlet UITextField *startDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *endDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTxtField;
@property (strong, nonatomic) IBOutlet UITextField *realStartDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *realStartTimeTxtField;

@property (strong, nonatomic) IBOutlet UITextField *realEndDateTxtField;
@property (strong, nonatomic) IBOutlet UITextField *realEndTimeTxtField;

@property (strong, nonatomic) IBOutlet UITextField *passengersTxtField;
@property (strong, nonatomic) IBOutlet UITextField *carOrderId;
@property (strong, nonatomic) IBOutlet UITextField *reasonTxtField;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

@end
