//
//  LoginViewController.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/20/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Staff.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameTxt;
@property (strong, nonatomic) IBOutlet UITextField *passTxt;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)login:(id)sender;

@property (nonatomic, strong) Staff *staff;

@end
