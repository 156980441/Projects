//
//  PersonalTableViewController.m
//  DongGuanDaDi
//
//  Created by fanyl on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "PersonalTableViewController.h"
#import "Staff.h"
#import "ModifyPerInfoTableViewController.h"

#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@interface PersonalTableViewController ()

@end

@implementation PersonalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.staff = [[Staff alloc] init];
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"/DongGuan/",@"referer", nil];
    [[AFHTTPSessionManager manager] GET:URL_PERSONAL_INFO parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dic = (NSDictionary*)responseObject;
            self.staff.staffId = (NSString*)[dic objectForKey:@"id"];
            self.staff.phone = ((NSNumber*)[dic objectForKey:@"phone"]).longLongValue;
            self.staff.qq = ((NSNumber*)[dic objectForKey:@"qq"]).longLongValue;
            self.staff.sex = (NSString*)[dic objectForKey:@"sex"];
            self.staff.wechat = (NSString*)[dic objectForKey:@"wechatId"];
            NSDictionary* dic_user = (NSDictionary*)[dic objectForKey:@"user"];
            self.staff.name = (NSString*)[dic_user objectForKey:@"name"];
            self.staff.pass = (NSString*)[dic_user objectForKey:@"password"];
            NSDictionary* dic_office = (NSDictionary*)[dic_user objectForKey:@"office"];
            self.staff.officeName = (NSString*)[dic_office objectForKey:@"officeName"];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
    }];
    
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personal" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (0 == indexPath.row) {
        cell.textLabel.text = self.staff.name;
        cell.detailTextLabel.text = self.staff.officeName;
        cell.detailTextLabel.backgroundColor = [UIColor blueColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    } else if (1 == indexPath.row) {
        cell.textLabel.text = [NSString stringWithFormat:@"电话：%lld",self.staff.phone];
    } else if (2 == indexPath.row) {
        cell.textLabel.text = [NSString stringWithFormat:@"微信：%@",self.staff.wechat];
    } else if (3 == indexPath.row) {
        cell.textLabel.text = [NSString stringWithFormat:@"QQ：%lld",self.staff.qq];
    } else if (4 == indexPath.row) {
        cell.textLabel.text = @"信息编辑";
        cell.textLabel.textColor = [UIColor blueColor];
        CGFloat width = cell.textLabel.frame.size.width / 2;
        cell.separatorInset = UIEdgeInsetsMake(0, cell.center.x - width, 0, cell.center.x - width);// 字缩进到中间
    } else if (5 == indexPath.row) {
        cell.textLabel.text = @"修改密码";
        cell.textLabel.textColor = [UIColor blueColor];
        CGFloat width = cell.textLabel.frame.size.width / 2;
        cell.separatorInset = UIEdgeInsetsMake(0, cell.center.x - width, 0, cell.center.x - width);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (4 == indexPath.row) {
        [self performSegueWithIdentifier:@"modifyInfo" sender:self];
    } else if (5 == indexPath.row) {
        [self performSegueWithIdentifier:@"modifyPass" sender:self];
    }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController* vc = [segue destinationViewController];
    if ([vc isKindOfClass:[ModifyPerInfoTableViewController class]]) {
        ModifyPerInfoTableViewController* modifyPerInfo = (ModifyPerInfoTableViewController*)vc;
        modifyPerInfo.staff = self.staff;
    }
    
}


@end
