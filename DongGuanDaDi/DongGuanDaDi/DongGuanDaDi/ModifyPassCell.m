//
//  ModifyPassCell.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/30/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "ModifyPassCell.h"
#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@interface ModifyPassCell ()
@end

@implementation ModifyPassCell

-(void)awakeFromNib
{
    self.nowPassTxtField.delegate = self;
    self.confirmPassTxtField.delegate = self;
    self.oldPassTxtField.delegate = self;
}

- (IBAction)modfiyPassPress:(id)sender {
    
    if (!self.oldPassTxtField.text || !self.nowPassTxtField.text || !self.confirmPassTxtField.text) {
        [YLToast showWithText:@"请填写完整"];
        return;
    }
    
    if (![self.nowPassTxtField.text isEqualToString:self.confirmPassTxtField.text]) {
        [YLToast showWithText:@"确认密码与新的密码不一致"];
        return;
    }
    
    NSInteger length = self.nowPassTxtField.text.length;
    if (length > 12 || length < 6) {
        [YLToast showWithText:@"请输入6~12位的新密码"];
        return;
    }
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self.nowPassTxtField.text,@"password",self.confirmPassTxtField.text,@"confirmedPassword", nil];
    [manager POST:URL_PSW_EDIT parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Modify Pass succ,%@",responseObject);//这里后台可能存在返回值的编码问题
        [YLToast showWithText:@"修改密码成功,下次需用新密码登录"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:@"修改密码失败,请稍候重试"];
        NSLog(@"Modify Pass failed, %@",error);
    }];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
