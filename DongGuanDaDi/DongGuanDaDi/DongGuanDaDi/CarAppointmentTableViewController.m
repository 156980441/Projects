//
//  CarAppointmentTableViewController.m
//  DongGuanDaDi
//
//  Created by fanyl on 16/9/4.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "CarAppointmentTableViewController.h"
#import "Car.h"
#import "CarOrderCurrentView.h"

#import "stdafx_DongGuanDaDi.h"
#import "UIImageView+AFNetworking.h"

@interface CarAppointmentTableViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation CarAppointmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = [NSString stringWithFormat:@"%@预约情况",self.car.number];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;// 不显示分割线，也可以在 storyboard 中控制。
    
    UIImageView* imageView = [[UIImageView alloc] init];
    NSString* imageURL = [NSString stringWithFormat:@"%@%@",HOST,self.car.url];
    [imageView setImageWithURL:[NSURL URLWithString:imageURL]];
    imageView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 200);//为什么必须设置？
    self.tableView.tableHeaderView = imageView;
    
    NSString* startStr = [NSString stringWithFormat:@"预约出车时间：%@",self.car.startTime];
    NSString* endStr = [NSString stringWithFormat:@"预约出车时间：%@",self.car.endtime];
    NSString* driver = [NSString stringWithFormat:@"预约人：%@",self.car.driver];
    NSString* passengers = [NSString stringWithFormat:@"随车人数：%zd", self.car.peopleNum];
    NSString* reason = [NSString stringWithFormat:@"出车事由：%@",self.car.reason];
    self.dataSource =@[startStr,endStr,driver,passengers,reason];
    
    CarOrderCurrentView* orderCurrCar = [[[NSBundle mainBundle] loadNibNamed:@"CarOrderCurrentView" owner:nil options:nil] lastObject];
    self.tableView.tableFooterView = orderCurrCar;
    
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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"car_appointment_identifier" forIndexPath:indexPath];
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
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
