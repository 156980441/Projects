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

#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"

@interface CarDepartTableViewController ()
@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation CarDepartTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = [NSString stringWithFormat:@"%@ 出车详情",self.car.number];
    self.tableView.allowsSelection = NO; // 是否可以点击一行
    
    self.cellHeight = 1050;
    self.appointCars = [NSMutableArray array];
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSString stringWithFormat:@"%ld", self.car.carId],@"id",
                         nil];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    // 这里的返回值是一个标准 json
    [manager POST:URL_CAR_RESERVED parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary* result = (NSDictionary*)responseObject;
        NSArray* carAppoints = [result objectForKey:@"carAppoints"];
        Car* appointCar = [[Car alloc] init];
        
        for (NSDictionary* car in carAppoints) {
            appointCar.driver = [car objectForKey:@"driver"];
            appointCar.endtime = [car objectForKey:@"endTime"];
            appointCar.peopleNum = ((NSNumber*)[car objectForKey:@"followNumber"]).integerValue;
            appointCar.reason = [car objectForKey:@"reason"];
            appointCar.startTime = [car objectForKey:@"startTime"];
            [self.appointCars addObject:appointCar];
        }
        
        self.cellHeight = self.cellHeight + self.appointCars.count * 44 * 5;
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:error.localizedDescription];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// need optimized
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
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
    cell.appointCarsDataSource = self.appointCars;
    CGRect frame = cell.orderConditionTableView.frame;
    cell.orderConditionTableView.frame = CGRectMake(frame.origin.x, frame.origin.y, CGRectGetWidth(frame), self.cellHeight - 1050);
    
    return cell;
}
@end
