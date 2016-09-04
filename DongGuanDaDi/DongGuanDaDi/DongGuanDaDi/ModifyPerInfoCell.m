//
//  ModifyPerInfoCell.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/30/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "ModifyPerInfoCell.h"
#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@implementation ModifyPerInfoCell

- (IBAction)modifyPeronalInfo:(id)sender {
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self.qqTxtField.text,@"qq",self.phoneTxtField.text,@"phone",self.weChatTxtField.text,@"wechatId",self.phoneTxtField.text,@"phone",@"男",@"sex", nil];//这里没有性别啊？
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:URL_INFO_EDIT parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Modify PerInfo succ,%@",responseObject);
        [YLToast showWithText:@"修改成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:error.description];
        NSLog(@"Modify PerInfo failed, %@",error);
    }];
}

- (IBAction)cancelModifyPersonalInfo:(id)sender {
}
@end
