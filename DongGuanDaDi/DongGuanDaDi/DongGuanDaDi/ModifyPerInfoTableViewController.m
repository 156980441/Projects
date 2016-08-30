//
//  ModifyPerInfoTableViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/30/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "ModifyPerInfoTableViewController.h"
#import "ModifyPerInfoCell.h"
#import "Staff.h"

@implementation ModifyPerInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModifyPerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"modifyPersonal" forIndexPath:indexPath];
    cell.nameLabel.text = self.staff.name;
    cell.jobTitle.text = self.staff.officeName;
    cell.phoneTxtField.text = [NSString stringWithFormat:@"%lld", self.staff.phone];
    cell.weChatTxtField.text = self.staff.wechat;
    cell.qqTxtField.text = [NSString stringWithFormat:@"%lld", self.staff.qq];
    // Configure the cell...
    
    return cell;
}
@end
