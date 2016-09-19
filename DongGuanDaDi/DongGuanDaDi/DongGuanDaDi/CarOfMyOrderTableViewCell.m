//
//  CarDepartOfMyOrderTableViewCell.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/12/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CarOfMyOrderTableViewCell.h"
#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@implementation CarOfMyOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // 这里的 UITextField 不可编辑，这里通过代码控制，区别 Xib 控制方式。
    self.carNumberTxtField.delegate = self;
    self.startDateTxtField.delegate = self;
    self.startTimeTxtField.delegate = self;
    self.endDateTxtField.delegate = self;
    self.endTimeTxtField.delegate = self;
    self.realStartDateTxtField.delegate = self;
    self.realStartTimeTxtField.delegate = self;
    self.realEndDateTxtField.delegate = self;
    self.realEndTimeTxtField.delegate = self;
    self.passengersTxtField.delegate = self;
    self.passengersTxtField.keyboardType = UIKeyboardTypeNumberPad;
    self.carOrderId.delegate = self;
    self.reasonTxtField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)submitBtnClick:(id)sender {
    if ([[self.submitBtn titleForState:UIControlStateNormal] isEqualToString:@"取消预约"]) {
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             self.carOrderId.text,@"id",
                             nil];
        
        AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:URL_CAR_APPOINTMENT_CANCLE parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            [YLToast showWithText:@"取消成功"];
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [YLToast showWithText:@"网络连接失败，请检查网络配置"];
            NSLog(@"%@",error.description);
        }];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}
@end
