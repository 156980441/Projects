//
//  DepartmentTableViewController.m
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/8/1.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "DepartmentTableViewController.h"

@interface DepartmentTableViewController ()

@end

@implementation DepartmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dataSource = [[NSMutableArray alloc] initWithCapacity : 2];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity : 2];
    [dict setObject:@"综合科" forKey:@"groupname"];
    
    //利用数组来填充数据
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity : 2];
    [arr addObject: @"张三1"];
    [arr addObject: @"李四"];
    [arr addObject: @"张三0"];
    
    
    [dict setObject:arr forKey:@"users"];
    
    [self.dataSource addObject: dict];
    
    
    dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
    [dict setObject:@"工程科" forKey:@"groupname"];
    
    arr = [[NSMutableArray alloc] initWithCapacity : 2];
    [arr addObject: @"曹操"];
    [arr addObject: @"司马懿"];
    [arr addObject: @"张辽"];
    [dict setObject:arr forKey:@"users"];
    [self.dataSource addObject: dict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// 设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    
    UIView *hView;
    if (UIInterfaceOrientationLandscapeRight == [[UIDevice currentDevice] orientation] ||
        UIInterfaceOrientationLandscapeLeft == [[UIDevice currentDevice] orientation])
    {
        hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 40)];
    }
    else
    {
        hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    }
    
    UIButton* eButton = [[UIButton alloc] init];
    
    //按钮填充整个视图
    eButton.frame = hView.frame;
    [eButton addTarget:self action:@selector(expandButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    eButton.tag = section;//把节号保存到按钮tag，以便传递到expandButtonClicked方法
    
    //根据是否展开，切换按钮显示图片
    if ([self isExpanded:section])
        [eButton setImage: [ UIImage imageNamed: @"btn_down.png" ] forState:UIControlStateNormal];
    else
        [eButton setImage: [ UIImage imageNamed: @"btn_right.png" ] forState:UIControlStateNormal];
    
    
    //由于按钮的标题，
    //4个参数是上边界，左边界，下边界，右边界。
    eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [eButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 0)];
    [eButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    
    
    //设置按钮显示颜色
    eButton.backgroundColor = [UIColor lightGrayColor];
    [eButton setTitle:[[self.dataSource objectAtIndex:section] objectForKey:@"groupname"] forState:UIControlStateNormal];
    [eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [eButton setBackgroundImage: [ UIImage imageNamed: @"btn_listbg.png" ] forState:UIControlStateNormal];//btn_line.png"
    //[eButton setTitleShadowColor:[UIColor colorWithWhite:0.1 alpha:1] forState:UIControlStateNormal];
    //[eButton.titleLabel setShadowOffset:CGSizeMake(1, 1)];
    
    [hView addSubview: eButton];
    return hView;
}

//对指定的节进行“展开/折叠”操作
-(void)collapseOrExpand:(NSInteger)section{
    Boolean expanded = NO;
    //Boolean searched = NO;
    NSMutableDictionary* d=[self.dataSource objectAtIndex:section];
    
    //若本节model中的“expanded”属性不为空，则取出来
    if([d objectForKey:@"expanded"]!=nil)
        expanded=[[d objectForKey:@"expanded"]intValue];
    
    //若原来是折叠的则展开，若原来是展开的则折叠
    [d setObject:[NSNumber numberWithBool:!expanded] forKey:@"expanded"];
}

//返回指定节的“expanded”值
-(Boolean)isExpanded:(NSInteger)section{
    Boolean expanded = NO;
    NSMutableDictionary* d=[self.dataSource objectAtIndex:section];
    
    //若本节model中的“expanded”属性不为空，则取出来
    if([d objectForKey:@"expanded"]!=nil)
        expanded=[[d objectForKey:@"expanded"]intValue];
    
    return expanded;
}

//按钮被点击时触发
-(void)expandButtonClicked:(id)sender{
    
    UIButton* btn= (UIButton*)sender;
    NSInteger section= btn.tag; //取得tag知道点击对应哪个块
    
    // NSLog(@"click %d", section);
    [self collapseOrExpand:section];
    
    //刷新tableview
    [self.tableView reloadData];
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    
    //对指定节进行“展开”判断
    if (![self isExpanded:section]) {
        
        //若本节是“折叠”的，其行数返回为0
        return 0;
    }
    
    NSDictionary* d=[self.dataSource objectAtIndex:section];
    return [[d objectForKey:@"users"] count];
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    NSDictionary* m= (NSDictionary*)[self.dataSource objectAtIndex: indexPath.section];
    NSArray *d = (NSArray*)[m objectForKey:@"users"];
    
    if (d == nil) {
        return cell;
    }
    
    //显示联系人名称
    cell.textLabel.text = [d objectAtIndex: indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    //UIColor *newColor = [[UIColor alloc] initWithRed:(float) green:(float) blue:(float) alpha:(float)];
    cell.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_listbg.png"]];
    cell.imageView.image = [UIImage imageNamed:@"mod_user.png"];
    
    //选中行时灰色
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
