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
#import "CarAppointmentTableViewController.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"

@interface CarsTableViewController ()
@property (nonatomic, strong) NSMutableArray *carsNotAppointed;
@property (nonatomic, strong) NSMutableArray *carsAppointed;
@property (nonatomic, strong) NSMutableArray *carsDepart;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) Car* selectedCar;
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
    self.dataSource = [NSMutableArray array];
    
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
            [self.dataSource addObject:car];
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
            [self.dataSource addObject:car];
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
            [self.dataSource addObject:car];
        }
        [self.tableView reloadData];
        NSLog(@"responseObject, %@",responseObject);
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
    [self performSegueWithIdentifier:@"carAppointment" sender:self];
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
    CarAppointmentTableViewController* carAppointVc = (CarAppointmentTableViewController*)[segue destinationViewController];
    carAppointVc.car = self.selectedCar;
}


@end
