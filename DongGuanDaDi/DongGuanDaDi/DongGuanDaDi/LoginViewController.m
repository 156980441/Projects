//
//  LoginViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/20/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "LoginViewController.h"
#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPSessionManager.h"

@implementation LoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 应用启动就打开网络监控
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    self.navigationController.navigationBar.hidden = YES;
    self.staff = [[Staff alloc] init];
    self.passTxt.secureTextEntry = YES;
    
    // test
    self.passTxt.text= @"123";
    self.nameTxt.text=@"何少毅";
}

- (IBAction)login:(id)sender {
    if ([self.passTxt.text isEqualToString:@""]|| [self.nameTxt.text isEqualToString:@""]) {
        [YLToast showWithText:@"账号或者密码为空"];
    }
    else if (![AFNetworkReachabilityManager sharedManager].isReachable) {
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
    }
    else {
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self.nameTxt.text,@"username",self.passTxt.text,@"password", nil];
        [[AFHTTPSessionManager manager] POST:URL_USER_LOGIN parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            if([responseObject isKindOfClass:[NSDictionary class]]) {
                NSString* result = [(NSDictionary*)responseObject objectForKey:@"result"];
                if ([result isEqualToString:@"success"]) {
                    self.staff.name = self.nameTxt.text;
                    self.staff.pass = self.passTxt.text;
                    NSArray* authList = [(NSDictionary*)responseObject objectForKey:@"authList"];
                    self.staff.authList = authList;
                    
                    [self performSegueWithIdentifier:@"login" sender:self];
                    
                }
                else {
                    [YLToast showWithText:result];
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Login failed, %@",error);
        }];
    }
}
@end
