//
//  MemuDetailViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "MemuDetailViewController.h"
#import "DinnerCommentTableViewController.h"
#import "DinnerInfo.h"

@interface MemuDetailViewController ()
@property (nonatomic, strong) DinnerInfo *selecetedDinner;
@end

@implementation MemuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"菜式详情 (%@)",self.selectedDate];
}

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
    cell.imageView.image = [UIImage imageNamed:@"error_outline"];//临时
    cell.textLabel.text = dinner.name;
    cell.detailTextLabel.text = dinner.desc;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dic = [self.dataSource objectAtIndex:indexPath.section];
    NSArray* dinners = [dic.allValues objectAtIndex:0];
    self.selecetedDinner = [dinners objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"dinnerComment" sender:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DinnerCommentTableViewController* dinnerComment = [segue destinationViewController];
    dinnerComment.dinnerInfo = self.selecetedDinner;
}
@end
