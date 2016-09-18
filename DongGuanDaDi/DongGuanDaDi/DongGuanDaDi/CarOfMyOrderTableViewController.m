//
//  CarOfMyOrderTableViewController.m
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/9/18.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "CarOfMyOrderTableViewController.h"
#import "CarOfMyOrderTableViewCell.h"
#import "Car.h"

#import "stdafx_DongGuanDaDi.h"
#import "UIImageView+AFNetworking.h"

@interface CarOfMyOrderTableViewController ()

@end

@implementation CarOfMyOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
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

// need optimized
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 730;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CarOfMyOrderTableViewCell *cell;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CarOfMyOrderTableViewCell" owner:self options:nil];
    if ([nib count]>0)
    {
        cell = [nib objectAtIndex:0];
    }
    // Configure the cell...
    
    NSArray * array = [self.car.startTime componentsSeparatedByString:@" "];
    cell.startDateTxtField.text = [array objectAtIndex:0];
    cell.startTimeTxtField.text = [array objectAtIndex:1];
    array = [self.car.endtime componentsSeparatedByString:@" "];
    cell.endDateTxtField.text = [array objectAtIndex:0];
    cell.endTimeTxtField.text = [array objectAtIndex:1];
    if ([self.car.realStartTime isEqualToString:@""]) {
        cell.realStartDateTxtField.text = @"暂未发车";
        cell.realStartDateTxtField.text = nil;
    }
    else
    {
        array = [self.car.realStartTime componentsSeparatedByString:@" "];
        cell.realStartDateTxtField.text = [array objectAtIndex:0];
        cell.realStartTimeTxtField.text = [array objectAtIndex:1];
    }
    if ([self.car.realEndTime isEqualToString:@""]) {
        cell.realEndDateTxtField.text = @"暂未还车";
        cell.realEndTimeTxtField.text = nil;
    }
    else
    {
        array = [self.car.realEndTime componentsSeparatedByString:@" "];
        cell.realEndDateTxtField.text = [array objectAtIndex:0];
        cell.realEndTimeTxtField.text = [array objectAtIndex:1];
    }
    cell.carOrderId.text = [NSString stringWithFormat:@"%ld",self.car.infoId];
    cell.passengersTxtField.text = [NSString stringWithFormat:@"%zd", self.car.peopleNum];
    cell.reasonTxtField.text = self.car.reason;
    NSString* url = [NSString stringWithFormat:@"%@%@",HOST,self.car.url];
    [cell.carImage setImageWithURL:[NSURL URLWithString:url]];
    cell.carImage.contentMode = UIViewContentModeScaleToFill;
    cell.carNumberTxtField.text = self.car.number;
    
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
