//
//  MemuDetailViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "MemuDetailViewController.h"
#import "DinnerInfo.h"

@interface MemuDetailViewController ()

@end

@implementation MemuDetailViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section    // fixed font style. use custom view (UILabel) if you want something different
{
    NSDictionary* dic = [self.dataSource objectAtIndex:section];
    return [dic.allKeys objectAtIndex:0];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary* dic = [self.dataSource objectAtIndex:section];
    NSArray* arr = [dic.allValues objectAtIndex:0];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MenuDetail"];
    NSDictionary* dic = [self.dataSource objectAtIndex:indexPath.section];
    NSArray* dinners = [dic.allValues objectAtIndex:0];
    DinnerInfo* dinner = [dinners objectAtIndex:indexPath.row];
    cell.textLabel.text = dinner.name;
    cell.detailTextLabel.text = dinner.desc;
    return cell;
}
@end
