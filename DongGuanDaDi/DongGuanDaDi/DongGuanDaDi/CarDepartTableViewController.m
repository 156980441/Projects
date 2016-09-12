//
//  CarDepartTableViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CarDepartTableViewController.h"
#import "CarDepartTableViewCell.h"
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
@end
