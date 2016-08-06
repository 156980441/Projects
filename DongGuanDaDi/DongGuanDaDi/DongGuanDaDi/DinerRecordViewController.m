//
//  DinerRecordViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "DinerRecordViewController.h"


@implementation DinerRecordViewController

- (IBAction)selectDate:(id)sender {
    self.datePikerAlert = [[DatePikerAlert alloc] initWithTitle:@"设置时间" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [self.datePikerAlert show];
}

- (IBAction)queryRecord:(id)sender {
}
@end
