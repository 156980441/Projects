//
//  LoginViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/20/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "YLToast.h"
#import "YLCommon.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPSessionManager.h"

@implementation LoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 应用启动就打开网络监控
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    self.passTxt.delegate = self;
    self.nameTxt.delegate = self;
    self.navigationController.navigationBar.hidden = YES;
    self.passTxt.secureTextEntry = YES;
    
    self.staff = [[Staff alloc] init];
    Staff* staff = [self loadFromArchiver];
    if (staff) {
        [self checkStaff:staff.name withPass:staff.pass];
    }
    
    
    // test
    self.passTxt.text= @"123";
    self.nameTxt.text=@"何少毅";
}

- (BOOL)saveToArchiver:(Staff*)staff {
    NSString* fileName = [YLCommon docPath:@"staff.archiver"];
    NSMutableData* data = [NSMutableData data];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:staff forKey:@"login_staff"];
    [archiver finishEncoding];
    return [data writeToFile:fileName atomically:YES];
}

- (Staff*)loadFromArchiver {
    NSString* fileName = [YLCommon docPath:@"staff.archiver"];
    NSData* data = [NSData dataWithContentsOfFile:fileName];
    if ([data length] > 0) {
        NSKeyedUnarchiver* unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        Staff* staff = [unArchiver decodeObjectForKey:@"login_staff"];
        [unArchiver finishDecoding];
        return staff;
    }
    else {
        return nil;
    }
}

-(void)checkStaff:(NSString*)name withPass:(NSString*)pass
{
//    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:name,@"username",pass,@"password", nil];
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"范志辉",@"username",@"123",@"password", nil];
    [[AFHTTPSessionManager manager] POST:URL_USER_LOGIN parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result = [(NSDictionary*)responseObject objectForKey:@"result"];
            if ([result isEqualToString:@"success"]) {
                self.staff.name = name;
                self.staff.pass = pass;
                NSArray* authList = [(NSDictionary*)responseObject objectForKey:@"authList"];
                self.staff.authList = authList;
                [self saveToArchiver:self.staff];
                
                [self performSegueWithIdentifier:@"login" sender:self];
                
            }
            else {
                [YLToast showWithText:result];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
    }];
}

- (IBAction)login:(id)sender {
    if ([self.passTxt.text isEqualToString:@""]|| [self.nameTxt.text isEqualToString:@""]) {
        [YLToast showWithText:@"账号或者密码为空"];
    }
    else if (![AFNetworkReachabilityManager sharedManager].isReachable) {
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
    }
    else {
        [self checkStaff:self.nameTxt.text withPass:self.passTxt.text];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MainViewController* mainVc = (MainViewController*)[segue destinationViewController];
    mainVc.staff = self.staff;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    NSLog(@"textFieldDidBeginEditing");
    
    CGRect frame = textField.frame;
    
    CGFloat heights = self.view.frame.size.height;
    
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    
    int offset = frame.origin.y + 42- ( heights - 216.0-35.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.view.frame.size.width;
    
    float height = self.view.frame.size.height;
    
    if(offset > 0)
        
    {
        
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        
        self.view.frame = rect;
        
    }
    
    [UIView commitAnimations];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    NSLog(@"touchesBegan");
    
    [self.view endEditing:YES];
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
}
@end
