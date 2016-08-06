//
//  DinerRecordViewController.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePikerAlert.h"

@interface DinerRecordViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIView *TableViewHeader;
@property (nonatomic, strong) DatePikerAlert* datePikerAlert;
- (IBAction)selectDate:(id)sender;
- (IBAction)queryRecord:(id)sender;

@end
