//
//  CarDepartTableViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CarDepartTableViewController.h"
#import "CarDepartTableViewCell.h"
#import "CarOfMyOrderTableViewCell.h"
#import "Car.h"

#import "stdafx_DongGuanDaDi.h"
#import "UIImageView+AFNetworking.h"

@implementation CarDepartTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = [NSString stringWithFormat:@"%@ 出车详情",self.car.number];
    self.tableView.allowsSelection = NO; // 是否可以点击一行
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// need optimized
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isMyOrder) {
        return 1050;
    }
    else {
        return 725;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.isMyOrder) {
        CarDepartTableViewCell *cell;
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CarDepartTableViewCell" owner:self options:nil];
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
        array = [self.car.realStartTime componentsSeparatedByString:@" "];
        cell.realStartDateTxtField.text = [array objectAtIndex:0];
        cell.realStartTimeTxtField.text = [array objectAtIndex:1];
        
        cell.passengersTxtField.text = [NSString stringWithFormat:@"%zd", self.car.peopleNum];
        cell.seatingTxtField.text = [NSString stringWithFormat:@"%zd", self.car.seating];
        cell.driverTxtField.text = self.car.driver;
        cell.reasonTxtField.text = self.car.reason;
        NSString* url = [NSString stringWithFormat:@"%@%@",HOST,self.car.url];
        [cell.carImageView setImageWithURL:[NSURL URLWithString:url]];
        cell.carImageView.contentMode = UIViewContentModeScaleToFill;
        //    cell.carNumberTxtField.text = self.car.number;
        
        return cell;
    }
    else
    {
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
        array = [self.car.realStartTime componentsSeparatedByString:@" "];
        cell.realStartDateTxtField.text = [array objectAtIndex:0];
        cell.realStartTimeTxtField.text = [array objectAtIndex:1];
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
}
@end
