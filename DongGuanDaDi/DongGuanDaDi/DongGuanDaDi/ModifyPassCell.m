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

@implementation ModifyPassCell

- (IBAction)modfiyPassPress:(id)sender {
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"/DongGuan/",@"referer",self.nowPassTxtField.text,@"password",self.confirmPassTxtField.text,@"confirmedPassword", nil];
    [[AFHTTPSessionManager manager] POST:URL_PSW_EDIT parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Modify Pass succ,%@",responseObject);
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result = [(NSDictionary*)responseObject objectForKey:@"result"];
            [YLToast showWithText:result];
            if ([result isEqualToString:@"success"]) {
                
            }
            else {
                [YLToast showWithText:result];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Modify Pass failed, %@",error);
    }];
}
@end
