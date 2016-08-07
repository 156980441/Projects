//
//  DinerRecordViewController.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLDatePicker.h"

@interface DinerRecordViewController : UITableViewController <YLDatePickerDelegate>
@property (strong, nonatomic) IBOutlet UIView *TableViewHeader;
@property (nonatomic, strong) YLDatePicker* datePiker;
- (IBAction)selectDate:(id)sender;
- (IBAction)queryRecord:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;

@end
