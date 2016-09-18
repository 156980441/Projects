//
//  CarDepartOfMyOrderTableViewCell.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/12/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CarOfMyOrderTableViewCell.h"

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
    self.carOrderId.delegate = self;
    self.reasonTxtField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}
@end
