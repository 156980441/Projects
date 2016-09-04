//
//  AddressListTableViewController.m
//  DongGuanDaDi
//
//  Created by fanyl on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "AddressListTableViewController.h"
#import "Staff.h"
#import "PersonDetailTableViewController.h"
#import "DepartmentTableViewController.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@interface AddressListTableViewController ()

@end

@implementation AddressListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.filteredStaffArray = [NSMutableArray array];
    self.orginDataSource = [NSMutableArray array];
    self.staffDataSources = [NSMutableDictionary dictionary];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    [manager GET:URL_CONTACT parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray* staffs = (NSArray*)responseObject;
        NSMutableArray* indexes = [NSMutableArray array];
        NSMutableArray* values = [NSMutableArray array];
        
        for (NSDictionary* dic in staffs) {
            Staff* staff = [[Staff alloc] init];
            staff.staffId = [dic objectForKey:@"id"];
            staff.phone = ((NSNumber*)[dic objectForKey:@"phone"]).longLongValue;
            staff.qq = ((NSNumber*)[dic objectForKey:@"qq"]).longLongValue;
            staff.sex = [dic objectForKey:@"sex"];
            NSDictionary* dic_user = [dic objectForKey:@"user"];
            staff.name = [dic_user objectForKey:@"name"];
            NSDictionary* office_staff = [dic_user objectForKey:@"office"];
            staff.officeName = [office_staff objectForKey:@"officeName"];
            staff.wechat = [dic_user objectForKey:@"wechatId"];
            [self.orginDataSource addObject:staff];
            [values addObject:staff];
            
            NSString* temp = [staff.name substringToIndex:1];
            if (![indexes containsObject:temp]) {
                [indexes addObject:temp];
            }
            
        }
        
        for (NSString* s in indexes) {
            NSMutableArray* values2 = [NSMutableArray array];
            for (Staff* user in values) {
                if ([[user.name substringToIndex:1] isEqualToString:s]) {
                    [values2 addObject:user];
                }
            }
            CFMutableStringRef pinyin_string = CFStringCreateMutableCopy(NULL, 0, (__bridge CFStringRef)s);
            CFRange range = CFRangeMake(0, 1);
            CFStringTransform(pinyin_string, &range, kCFStringTransformMandarinLatin, NO);
            CFStringTransform(pinyin_string, &range,kCFStringTransformStripDiacritics, NO);
            NSMutableString* pinyin_oc_string = (__bridge NSMutableString*)pinyin_string;
            NSString* pinyin = [pinyin_oc_string substringToIndex:1];
            [self.staffDataSources setObject:values2 forKey:pinyin];
        }
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Login failed, %@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.staffDataSources.allKeys;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.staffDataSources.allKeys.count != 0 && tableView != self.searchDisplayController.searchResultsTableView) {
        return [self.staffDataSources.allKeys objectAtIndex:section];
    }
    else {
        return @"搜索结果";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView != self.searchDisplayController.searchResultsTableView)
    {
        NSInteger count = self.staffDataSources.allKeys.count;
        if (count != 0) {
            return count;
        }
    }
    
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 检查现在显示的是哪个列表视图，然后返回相应的数组长度
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return self.filteredStaffArray.count;
    }
    else
    {
        NSInteger count = self.staffDataSources.allKeys.count;
        if (count != 0) {
            NSString* pinyin_key = [self.staffDataSources.allKeys objectAtIndex:section];
            NSArray* values = [self.staffDataSources objectForKey:pinyin_key];
            return values.count;
        }
        else {
            return 0;
        }
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 这里要用 self.tableView 来解决 Assertion failure when using UISearchDisplayController in UITableViewController
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"staff" forIndexPath:indexPath];
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"staff"];
    Staff* staff = nil;
    // 检查现在应该显示普通列表还是过滤后的列表
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        staff = [self.filteredStaffArray objectAtIndex:indexPath.row];
    }
    else
    {
        NSString* pinyin_key = [self.staffDataSources.allKeys objectAtIndex:indexPath.section];
        NSArray* values = [self.staffDataSources objectForKey:pinyin_key];
        staff = [values objectAtIndex:indexPath.row];
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
    self.filteredStaffArray = [NSMutableArray arrayWithArray:[self.orginDataSource filteredArrayUsingPredicate:predicate]];
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

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        PersonDetailTableViewController *detail = [segue destinationViewController];
        Staff *staff = nil;
        // 我们需要知道哪个是现在正显示的列表视图，这样才能从相应的数组中提取正确的信息，显示在详细视图中。
        if(sender == self.searchDisplayController.searchResultsTableView)
        {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            staff = [self.filteredStaffArray objectAtIndex:[indexPath row]];
        }
        else
        {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSString* pinyin_key = [self.staffDataSources.allKeys objectAtIndex:indexPath.section];
            NSArray* values = [self.staffDataSources objectForKey:pinyin_key];
            staff = [values objectAtIndex:[indexPath row]];
        }
        detail.staff = staff;
    }
    UIViewController* vc = [segue destinationViewController];
    if ([vc isKindOfClass:[DepartmentTableViewController class]]) {
        DepartmentTableViewController* departmentVc = (DepartmentTableViewController*)vc;
        departmentVc.orginDataSource = [self.orginDataSource copy];
    }
}
@end
