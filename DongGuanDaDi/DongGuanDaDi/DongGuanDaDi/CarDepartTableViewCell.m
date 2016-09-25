//
//  CarDepartTableViewCell.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CarDepartTableViewCell.h"
#import "CarOrderCurrentView.h"
#import "Car.h"
#import "YLDatePicker.h"
#import "YLCommon.h"
#import "YLToast.h"

@interface CarDepartTableViewCell () <UITextFieldDelegate,YLDatePickerDelegate>
@property (nonatomic, strong) YLDatePicker *picker;
@end

@implementation CarDepartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 在 Xib 中关闭了 TextField enable 属性
    self.picker = [[YLDatePicker alloc] init];
    self.picker.frame = CGRectMake(0, 0, 300, 250);
    self.picker.delegate = self;
    self.passengersTxtField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.orderConditionTableView.delegate = self;
    self.orderConditionTableView.dataSource = self;

    // 这里加载进的 CarOrderCurrentView 的大小是 CarOrderCurrentView.xib 中的大小
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 写在这里防止弹出键盘
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.picker.backgroundColor = [UIColor whiteColor];
    [self.picker show];
    self.picker.mode = UIDatePickerModeDate;
    if (self.startDateTxtField == textField) {
        self.picker.picker.tag = 0;
    } else if (self.endDateTxtField == textField) {
        self.picker.picker.tag = 1;
    } else if (self.startTimeTxtField == textField) {
        self.picker.mode = UIDatePickerModeTime;
        self.picker.picker.tag = 2;
    } else if (self.endTimeTxtField == textField) {
        self.picker.mode = UIDatePickerModeTime;
        self.picker.picker.tag = 3;
    }
    return NO;
}

// 写在这里会弹出键盘，布局就不好看了。
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.picker dismiss];
}
- (void)picker:(UIDatePicker *)picker valueChanged:(NSDate *)date
{
    if (0 == picker.tag) {
        self.startDateTxtField.text = [YLCommon date2String:date];
    } else if (1 == picker.tag) {
        self.endDateTxtField.text = [YLCommon date2String:date];
    } else if (2 == picker.tag) {
        self.startTimeTxtField.text = [YLCommon time2String:date];
    } else if (3 == picker.tag) {
        self.endTimeTxtField.text = [YLCommon time2String:date];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.appointCarsDataSource.count == 0)
    {
        return 1;
    }
    else
    {
        return self.appointCarsDataSource.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.appointCarsDataSource.count == 0)
    {
        return 1;
    }
    else
    {
        return 5;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifer = @"appointCell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifer];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    if (self.appointCarsDataSource.count > 0)
    {
        Car* car = [self.appointCarsDataSource objectAtIndex:indexPath.section];
        if (0 == indexPath.row) {
            cell.textLabel.text = [NSString stringWithFormat:@"预约出车时间：%@",car.startTime];
        }
        else if (1 == indexPath.row) {
            cell.textLabel.text = [NSString stringWithFormat:@"预约还车时间：%@",car.endtime];
        }
        else if (2 == indexPath.row) {
            cell.textLabel.text = [NSString stringWithFormat:@"预约人：%@",car.driver];
        }
        else if (3 == indexPath.row) {
            cell.textLabel.text = [NSString stringWithFormat:@"随车人数：%zd", car.peopleNum];
        }
        else if (4 == indexPath.row) {
            cell.textLabel.text = [NSString stringWithFormat:@"出车事由：%@",car.reason];
        }
    }
    else {
        cell.textLabel.text = @"暂无预约信息";
    }
    return cell;
}
@end
