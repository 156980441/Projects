//
//  AddressListTableViewController.m
//  DongGuanDaDi
//
//  Created by 赵雪莹 on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "AddressListTableViewController.h"
#import "Staff.h"

@interface AddressListTableViewController ()

@end

@implementation AddressListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.filteredStaffArray = [NSMutableArray arrayWithCapacity:self.staffDataSources.count];
    self.staffDataSources = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 3; i++) {
        Staff* temp = [[Staff alloc] init];
        temp.name = [NSString stringWithFormat:@"张%d",i];
        temp.phone = @"123456";
        temp.wechat =  @"88888";
        [self.staffDataSources addObject:temp];
    }
    for (int i = 0; i < 5; i++) {
        Staff* temp = [[Staff alloc] init];
        temp.name = [NSString stringWithFormat:@"王%d",i];
        temp.phone = @"123456";
        temp.wechat =  @"88888";
        [self.staffDataSources addObject:temp];
    }
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
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return self.filteredStaffArray.count;
    }
    else
    {
        return self.staffDataSources.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"staff" forIndexPath:indexPath];
    Staff* staff = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        staff = [self.filteredStaffArray objectAtIndex:indexPath.row];
    }
    else
    {
        staff = [self.staffDataSources objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = staff.name;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    // 根据搜索栏的内容和范围更新过滤后的数组。
    // 先将过滤后的数组清空。
    [self.filteredStaffArray removeAllObjects];
    
    // 用NSPredicate来过滤数组。
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.filteredStaffArray = [NSMutableArray arrayWithArray:[self.staffDataSources filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // 当用户改变搜索字符串时，让列表的数据来源重新加载数据
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // 返回YES，让table view重新加载。
    return YES;
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // 当用户改变搜索范围时，让列表的数据来源重新加载数据
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // 返回YES，让table view重新加载。
    return YES;
}

@end
