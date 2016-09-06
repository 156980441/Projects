//
//  CarsTableViewController.m
//  DongGuanDaDi
//
//  Created by fanyl on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "CarsTableViewController.h"
#import "Car.h"
#import "CarDetailCell.h"
#import "CarNotAppointmentTableViewController.h"
#import "CarDepartTableViewController.h"
#import "CarAppointmentTableViewController.h"
#import "ShowCarsTypesView.h"
#import "CarOrderView.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"

@interface CarsTableViewController ()
@property (nonatomic, strong) NSMutableArray *carsNotAppointed;
@property (nonatomic, strong) NSMutableArray *carsAppointed;
@property (nonatomic, strong) NSMutableArray *carsDepart;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *orderDataSource;
@property (nonatomic, strong) NSMutableArray *myOrderDataSource;
@property (nonatomic, strong) Car* selectedCar;
@property (nonatomic, strong) UIButton* sectionHeaderView;
@end

@implementation CarsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.carsDepart = [NSMutableArray array];
    self.carsAppointed = [NSMutableArray array];
    self.carsNotAppointed = [NSMutableArray array];
    self.orderDataSource = [NSMutableArray array];
    self.myOrderDataSource = [NSMutableArray array];
    self.dataSource = self.orderDataSource;
    
    self.sectionHeaderView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.sectionHeaderView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 30);
    [self.sectionHeaderView setTitle:@"未出行车辆" forState:UIControlStateNormal];
    [self.sectionHeaderView addTarget:self action:@selector(selecteShowCarTypes) forControlEvents:UIControlEventTouchDown];
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"/DongGuan/",@"referer", nil];
    [[AFHTTPSessionManager manager] GET:URL_CAR_STATTE parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary* jsonData = (NSDictionary*)responseObject;
        
        NSArray* carsDepart = [jsonData objectForKey:@"carsDepart"];
        for (NSDictionary* temp in carsDepart) {
            NSDictionary* dic = [temp objectForKey:@"car"];
            Car* car = [[Car alloc] init];
            car.brand = [dic objectForKey:@"brand"];
            car.number = [dic objectForKey:@"carNumber"];
            car.color = [dic objectForKey:@"color"];
            car.carId = ((NSNumber*)[dic objectForKey:@"id"]).integerValue;
            car.purpose = [dic objectForKey:@"purpose"];
            car.seating = ((NSNumber*)[dic objectForKey:@"seating"]).integerValue;
            car.type = [dic objectForKey:@"type"];
            car.url = [dic objectForKey:@"url"];
            car.weight = ((NSNumber*)[dic objectForKey:@"loading"]).integerValue;
            car.type = [dic objectForKey:@"type"];
            
            car.driver = [temp objectForKey:@"driver"];
            car.endtime = [temp objectForKey:@"endTime"];
            car.infoId = ((NSNumber*)[temp objectForKey:@"id"]).integerValue;
            car.lat = [temp objectForKey:@"lat"];
            car.lng = [temp objectForKey:@"lng"];
            car.peopleNum = ((NSNumber*)[temp objectForKey:@"peopleNumber"]).integerValue;
            car.realStartTime = [temp objectForKey:@"realStartTime"];
            car.reason = [temp objectForKey:@"reason"];
            car.startTime = [temp objectForKey:@"startTime"];
            
            NSDictionary* dic_car_user = [temp objectForKey:@"user"];
            car.userId = ((NSNumber*)[dic_car_user objectForKey:@"id"]).integerValue;
            car.userName = [temp objectForKey:@"name"];
            
            car.state = DGCarDepart;
            [self.carsDepart addObject:car];
            [self.orderDataSource addObject:car];
        }
        
        NSArray* carsNotAppointed = [jsonData objectForKey:@"carsNotAppointed"];
        for (NSDictionary* dic in carsNotAppointed) {
            Car* car = [[Car alloc] init];
            car.brand = [dic objectForKey:@"brand"];
            car.number = [dic objectForKey:@"carNumber"];
            car.color = [dic objectForKey:@"color"];
            car.carId = ((NSNumber*)[dic objectForKey:@"id"]).integerValue;
            car.purpose = [dic objectForKey:@"purpose"];
            car.seating = ((NSNumber*)[dic objectForKey:@"seating"]).integerValue;
            car.type = [dic objectForKey:@"type"];
            car.url = [dic objectForKey:@"url"];
            car.weight = ((NSNumber*)[dic objectForKey:@"loading"]).integerValue;
            
            car.state = DGCarNotAppointment;
            
            [self.carsNotAppointed addObject:car];
            [self.orderDataSource addObject:car];
        }
        
        NSArray* carsAppointed = [jsonData objectForKey:@"carsAppointed"];
        for (NSDictionary* dic in carsAppointed) {
            Car* car = [[Car alloc] init];
            car.brand = [dic objectForKey:@"brand"];
            car.number = [dic objectForKey:@"carNumber"];
            car.color = [dic objectForKey:@"color"];
            car.carId = ((NSNumber*)[dic objectForKey:@"id"]).integerValue;
            car.purpose = [dic objectForKey:@"purpose"];
            car.seating = ((NSNumber*)[dic objectForKey:@"seating"]).integerValue;
            car.type = [dic objectForKey:@"type"];
            car.url = [dic objectForKey:@"url"];
            car.weight = ((NSNumber*)[dic objectForKey:@"loading"]).integerValue;
            
            car.state = DGCarAppointment;
            
            [self.carsAppointed addObject:car];
            [self.orderDataSource addObject:car];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCar = (Car*)[self.dataSource objectAtIndex:indexPath.row];
    DGCarState state = self.selectedCar.state;
    if (state == DGCarNotAppointment)
    {
        [self performSegueWithIdentifier:@"carNotAppointment" sender:self];
    }
    else if (state == DGCarDepart)
    {
        [self performSegueWithIdentifier:@"carDepart" sender:self];
    }
    else if (state == DGCarAppointment)
    {
        [self performSegueWithIdentifier:@"carAppointment" sender:self];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carDetail" forIndexPath:indexPath];
    
    // Configure the cell...
    Car* car = (Car*)[self.dataSource objectAtIndex:indexPath.row];
    cell.brand.text = [NSString stringWithFormat:@"车辆品牌：%@",car.brand];
    cell.number.text = [NSString stringWithFormat:@"车牌号：%@",car.number];
    cell.seats.text = [NSString stringWithFormat:@"座位数：%ld",car.seating];
    cell.weight.text = [NSString stringWithFormat:@"车辆载重：%ld",car.weight];
    NSString* url = [NSString stringWithFormat:@"%@%@",HOST,car.url];
    [cell.thumbnail setImageWithURL:[NSURL URLWithString:url]];
    if (car.state == DGCarDepart) {
        cell.state.text = @"已出行车辆";
        cell.state.backgroundColor = [UIColor redColor];
    }
    else if (car.state == DGCarNotAppointment)
    {
        cell.state.text = @"未预约车辆";
        cell.state.backgroundColor = [UIColor greenColor];
    }
    else if (car.state == DGCarAppointment)
    {
        cell.state.text = @"已预约车辆";
        cell.state.backgroundColor = [UIColor yellowColor];
    }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController* vc = [segue destinationViewController];
    if ([vc isKindOfClass:[CarNotAppointmentTableViewController class]]) {
        CarNotAppointmentTableViewController* carNotAppointVc = (CarNotAppointmentTableViewController*)vc;
        carNotAppointVc.car = self.selectedCar;
    }
    if ([vc isKindOfClass:[CarDepartTableViewController class]]) {
        CarDepartTableViewController* carDepartVc = (CarDepartTableViewController*)vc;
        carDepartVc.car = self.selectedCar;
    }
    if ([vc isKindOfClass:[CarAppointmentTableViewController class]]) {
        CarAppointmentTableViewController* carAppointVc = (CarAppointmentTableViewController*)vc;
        carAppointVc.car = self.selectedCar;
    }
}


- (IBAction)selectedChange:(id)sender {
    if (self.orderAndMyOrderSeg.selectedSegmentIndex == 1) {
        self.dataSource = nil;
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"/DongGuan/",@"referer", nil];
        [[AFHTTPSessionManager manager] GET:URL_CAR_MY_APPOINTMENT parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary* jsonData = (NSDictionary*)responseObject;
            
            NSArray* carsDepart = [jsonData objectForKey:@"carManages"];
            for (NSDictionary* temp in carsDepart) {
                NSDictionary* dic = [temp objectForKey:@"car"];
                Car* car = [[Car alloc] init];
                car.number = [dic objectForKey:@"carNumber"];
                car.carId = ((NSNumber*)[dic objectForKey:@"id"]).integerValue;
                car.url = [dic objectForKey:@"url"];
                car.driver = [temp objectForKey:@"driver"];
                car.endtime = [temp objectForKey:@"endTime"];
                car.infoId = ((NSNumber*)[temp objectForKey:@"id"]).integerValue;
                car.peopleNum = ((NSNumber*)[temp objectForKey:@"peopleNumber"]).integerValue;
                car.realStartTime = [temp objectForKey:@"realStartTime"];
                car.realEndTime = [temp objectForKey:@"realEndTime"];
                car.reason = [temp objectForKey:@"reason"];
                car.startTime = [temp objectForKey:@"startTime"];
                
                [self.myOrderDataSource addObject:car];
            }
            self.dataSource = self.myOrderDataSource;
            [self.tableView reloadData];
            //        NSLog(@"responseObject, %@",responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Login failed, %@",error);
        }];
        
    }
    if (self.orderAndMyOrderSeg.selectedSegmentIndex == 0) {
        self.dataSource = self.orderDataSource;
    }
    [self.tableView reloadData];
    
}

- (IBAction)showCarOrderView:(id)sender {
    CarOrderView* orderView = nil;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CarOrderView" owner:self options:nil];
    if ([nib count]>0)
    {
        orderView = [nib objectAtIndex:0];
    }
    
    orderView.center = self.tableView.window.center;
    [self.tableView.window addSubview:orderView];
    self.tableView.alpha = 0.7;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.orderAndMyOrderSeg.selectedSegmentIndex == 1) {
        return self.sectionHeaderView;
    }
    return nil;
}
-(void)selecteShowCarTypes
{
    ShowCarsTypesView* view;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShowCarsTypesView" owner:self options:nil];
    if ([nib count]>0)
    {
        view = [nib objectAtIndex:0];
    }
    view.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 90);
    __weak ShowCarsTypesView* weak_view = view;
    view.showCarsTypeBlock = ^(NSInteger index){
        if (0 == index) {
            [self.sectionHeaderView setTitle:weak_view.notAppointmentBtn.titleLabel.text forState:UIControlStateNormal];
            [weak_view removeFromSuperview];
            [self.tableView reloadData];
        }
        else if (1 == index)
        {
            [self.sectionHeaderView setTitle:weak_view.departBtn.titleLabel.text forState:UIControlStateNormal];
            [weak_view removeFromSuperview];
            [self.tableView reloadData];
        }
        else if (2 == index)
        {
            [self.sectionHeaderView setTitle:weak_view.hasBackBtn.titleLabel.text forState:UIControlStateNormal];
            [weak_view removeFromSuperview];
            [self.tableView reloadData];
        }
    };
    [self.tableView addSubview:view];
}
@end
