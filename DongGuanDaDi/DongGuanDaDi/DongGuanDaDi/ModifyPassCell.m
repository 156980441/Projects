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

- (IBAction)modfiyPassPress:(id)sender {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self.nowPassTxtField.text,@"password",self.confirmPassTxtField.text,@"confirmedPassword", nil];
    [manager POST:URL_PSW_EDIT parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Modify Pass succ,%@",responseObject);//这里后台可能存在返回值的编码问题
        [YLToast showWithText:@"修改成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:@"修改失败"];
        NSLog(@"Modify Pass failed, %@",error);
    }];
}
@end
