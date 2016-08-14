//
//  LoginViewController.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/20/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nameTxt;
@property (strong, nonatomic) IBOutlet UITextField *passTxt;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)login:(id)sender;

@end
