//
//  LoginViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/20/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"

@implementation LoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)login:(id)sender {
    
    MainViewController* main = [[MainViewController alloc] init];
    
    [self.navigationController pushViewController:main animated:YES];
    
}

@end
