//
//  LoginViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/20/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "LoginViewController.h"
#import "YLToast.h"
#import "AFNetworkReachabilityManager.h"

@implementation LoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)login:(id)sender {
    if ([self.passTxt.text isEqualToString:@""]|| [self.nameTxt.text isEqualToString:@""]) {
        [YLToast showWithText:@"账号或者密码为空"];
    }
    if (![AFNetworkReachabilityManager sharedManager].isReachable) {
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
    }
}
@end
