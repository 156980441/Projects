//
//  DinnerCommentTableViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/6/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "DinnerCommentTableViewController.h"
#import "DinnerInfo.h"
#import "DinnerCommentInfo.h"
#import "DinnerCommentTableViewCell.h"
#import "DinnerCommentTableViewHeaderView.h"
#import "YLToast.h"
#import "YLCommon.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"

@interface DinnerCommentTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation DinnerCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dataSource = [NSMutableArray array];
    
    DinnerCommentTableViewHeaderView* headerView = [[[NSBundle mainBundle] loadNibNamed:@"DinnerCommentTableViewHeaderView" owner:nil options:nil] lastObject];
    NSString* imageURL = [NSString stringWithFormat:@"%@%@",HOST,self.dinnerInfo.url];
    headerView.dinnerNameLabel.text = self.dinnerInfo.name;
    [headerView.imageView setImageWithURL:[NSURL URLWithString:imageURL]];
    headerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 215);//为什么必须设置？
    headerView.commentBtnClick = ^(NSInteger stars, NSString* contents)
    {
        NSInteger menuId = 0;
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:contents,STR_CONTENT,[NSNumber numberWithInteger:stars],STR_SCORE,[NSNumber numberWithInteger:self.dinnerInfo.foodId],STR_DISH_ID,[NSNumber numberWithInteger:menuId], STR_MENU_ID, nil];
        
        AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
        [manager POST:URL_NEW_COMMENT
           parameters:dic
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  NSDictionary* result = (NSDictionary*)responseObject;
                  if ([[result objectForKey:@"result"] isEqualToString:@"success"])
                  {
                      [YLToast showWithText:@"评论成功"];
                  }
                  else
                  {
                      [YLToast showWithText:@"评论失败"];
                  }
                  
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  [YLToast showWithText:@"网络连接失败，请检查网络配置"];
                  NSLog(@"%@",error.description);
              }];
    };
    headerView.dateBtnClick = ^(NSDate* date){
        [self getCommentFromInternetByDate:[YLCommon date2String:date]];
    };
    self.tableView.tableHeaderView = headerView;
    
    [self getCommentFromInternetByDate:self.dinnerInfo.date];
    
}

- (void)getCommentFromInternetByDate:(NSString*)date
{
    NSInteger pageNum = 1;
    NSInteger pageSize = 10;
    
    NSString* url = [NSString stringWithFormat:@"%@%@=%@&%@=%@&%@=%@&%@=%@",URL_GET_DISH_COMMENT,
                     STR_DISH_ID,[NSString stringWithFormat:@"%ld", self.dinnerInfo.foodId],
                     STR_DATESTRING,date,
                     STR_PAGENUMBER,[NSString stringWithFormat:@"%ld", pageNum],
                     STR_PAGESIZE,[NSString stringWithFormat:@"%ld", pageSize]];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.dataSource removeAllObjects];
        NSArray* comments = (NSArray*)responseObject;
        for (NSDictionary* dic in comments) {
            DinnerCommentInfo* info = [[DinnerCommentInfo alloc] init];
            info.commentId = ((NSNumber*)[dic objectForKey:@"id"]).integerValue;
            info.content = [dic objectForKey:@"content"];
            info.date = [dic objectForKey:@"createdTime"];
            NSDictionary* dic_auth = [dic objectForKey:@"author"];
            info.authName = [dic_auth objectForKey:@"name"];
            info.score = ((NSNumber*)[dic objectForKey:@"score"]).integerValue;
            [self.dataSource addObject:info];
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

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return nil;
    }
    else if (1 == section)
    {
        return @"全部评论";
    }
    else
    {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 1;
    }
    else if (1 == section)
    {
        return self.dataSource.count;
    }
    else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DinnerCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dinner_comment" forIndexPath:indexPath];
    if (0 == indexPath.section) {
        for (UIView* view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        CGSize labelSize = [self.dinnerInfo.desc sizeWithFont:[UIFont systemFontOfSize:14]
                         constrainedToSize:CGSizeMake(cell.frame.size.width, 800)//cell.frame.size.width为UILabel的宽度，500是预设的一个高度，表示在这个范围内
                             lineBreakMode:UILineBreakModeWordWrap];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
        label.numberOfLines = 0;
        label.text = self.dinnerInfo.desc;
        [label sizeToFit];
        [cell.contentView addSubview:label];
    }
    else if (1 == indexPath.section) {
        DinnerCommentInfo* info = [self.dataSource objectAtIndex:indexPath.row];
        cell.autherNameLabel.text = info.authName;
        cell.commentDateLabel.text = info.date;
        
        cell.contentLabel.numberOfLines = 0;
        cell.contentLabel.text = info.content;
        [cell.contentLabel sizeToFit];
        
    }
    // Configure the cell...
    
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

@end
