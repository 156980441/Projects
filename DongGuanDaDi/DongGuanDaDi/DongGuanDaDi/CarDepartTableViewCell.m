//
//  CarDepartTableViewCell.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CarDepartTableViewCell.h"
#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@implementation CarDepartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSLog(@"awake from nib");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)submitClick:(id)sender {
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.passengersTxtField.text,@"peopleNumber",
                         self.driverTxtField.text,@"driver",
                         self.reasonTxtField.text,@"reason",
                         self.carNumberTxtField.text,@"carNumber",
                         @"",@"officeId",
                         [NSString stringWithFormat:@"%@ %@",self.endDateTxtField.text,self.endTimeTxtField.text], @"end",
                         [NSString stringWithFormat:@"%@ %@",self.startDateTxtField.text,self.startTimeTxtField.text], @"start",
                         nil];
    NSDictionary* dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"2",@"peopleNumber",
                          @"何少毅",@"driver",
                          @"测试",@"reason",
                          @"粤WQS25",@"carNumber",
                          @"",@"officeId",
                          @"2016-09-05", @"end",
                          @"2016-09-04", @"start",
                          nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL_CAR_APPOINTMENT_SUBMIT_TABLE parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
        [YLToast showWithText:@"预约成功"];
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:@"预约失败"];
        NSLog(@"%@",error.description);
    }];
}
@end
