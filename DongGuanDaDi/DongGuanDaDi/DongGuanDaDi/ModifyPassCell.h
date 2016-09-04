//
//  ModifyPassCell.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/30/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPassCell : UITableViewCell <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *oldPassTxtField;
@property (strong, nonatomic) IBOutlet UITextField *nowPassTxtField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassTxtField;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)modfiyPassPress:(id)sender;

@end
