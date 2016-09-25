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
#import "CarDetailOfMyOrderTableViewCell.h"

#import "CarNotAppointmentTableViewController.h"
#import "CarDepartTableViewController.h"
#import "CarAppointmentTableViewController.h"
#import "CarOfMyOrderTableViewController.h"

#import "ShowCarsTypesView.h"
#import "CarOrderView.h"
#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"

@interface CarsTableViewController ()

@property (nonatomic, strong) NSMutableArray *carsNotAppointed;
@property (nonatomic, strong) NSMutableArray *carsAppointed;
@property (nonatomic, strong) NSMutableArray *carsDepart;
@property (nonatomic, strong) NSMutableArray *orderDataSource;// 车辆预约的数据

@property (nonatomic, strong) NSMutableArray *myCarsNotDepart;
@property (nonatomic, strong) NSMutableArray *myCarsBack;
@property (nonatomic, strong) NSMutableArray *myCarsDepart;
@property (nonatomic, strong) NSMutableArray *myOrderDataSource;// 我的预约的数据

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) Car* selectedCar;
@property (nonatomic, strong) UIButton* sectionHeaderView;// 我的预约界面下的选择按钮，
@property (nonatomic, strong) ShowCarsTypesView* typesView;
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
    
    self.myCarsDepart = [NSMutableArray array];
    self.myCarsNotDepart = [NSMutableArray array];
    self.myCarsBack = [NSMutableArray array];
    self.myOrderDataSource = [NSMutableArray array];
    
    // 首次默认显示车辆预约的数据
    self.dataSource = self.orderDataSource;
    
    self.sectionHeaderView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.sectionHeaderView.frame = CGRectMake(0, 10, self.tableView.frame.size.width, 50);
    self.sectionHeaderView.titleLabel.font = [UIFont systemFontOfSize: 20.0];
    self.sectionHeaderView.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.sectionHeaderView setTitle:@"未出行车辆" forState:UIControlStateNormal];
    [self.sectionHeaderView addTarget:self action:@selector(selecteShowCarTypes) forControlEvents:UIControlEventTouchDown];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    [manager GET:URL_CAR_STATTE parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
        
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
//        NSLog(@"Login failed, %@",error);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.orderAndMyOrderSeg.selectedSegmentIndex == 1) {
        return 50;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.orderAndMyOrderSeg.selectedSegmentIndex == 1) {
        return self.sectionHeaderView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCar = (Car*)[self.dataSource objectAtIndex:indexPath.row];
    DGCarState state = self.selectedCar.state;
    if (self.orderAndMyOrderSeg.selectedSegmentIndex == 0) {
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
    else if (self.orderAndMyOrderSeg.selectedSegmentIndex == 1) {
        [self performSegueWithIdentifier:@"carOfMyOrder" sender:self];
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
    
    UITableViewCell* returnCell = nil;
    
    if (self.orderAndMyOrderSeg.selectedSegmentIndex == 0) {
        CarDetailCell *cell = (CarDetailCell*)[tableView dequeueReusableCellWithIdentifier:@"carDetail" forIndexPath:indexPath];
        
        // Configure the cell...
        Car* car = (Car*)[self.dataSource objectAtIndex:indexPath.row];
        cell.brand.text = [NSString stringWithFormat:@"车辆品牌：%@",car.brand];
        cell.number.text = [NSString stringWithFormat:@"车牌号：%@",car.number];
        cell.seats.text = [NSString stringWithFormat:@"座位数：%ld",car.seating];
        cell.weight.text = [NSString stringWithFormat:@"车辆载重：%ld",car.weight];
        NSString* url = [NSString stringWithFormat:@"%@%@",HOST,car.url];
        [cell.thumbnail setImageWithURL:[NSURL URLWithString:url]];
        cell.thumbnail.contentMode = UIViewContentModeScaleToFill;
        
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
        
        cell.state.adjustsFontSizeToFitWidth = YES;
        
        returnCell = cell;
        
    }
    else
    {
        CarDetailOfMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carDetailOfMyOrder" forIndexPath:indexPath];
        
        // Configure the cell...
        Car* car = (Car*)[self.dataSource objectAtIndex:indexPath.row];
        cell.carNumber.text = [NSString stringWithFormat:@"车牌号：%@",car.number];
        cell.passengers.text = [NSString stringWithFormat:@"随车人数：%ld",car.peopleNum];
        cell.startDate.text = [NSString stringWithFormat:@"预计出车时间：%@",car.startTime];
        cell.endDate.text = [NSString stringWithFormat:@"预计还车时间：%@",car.endtime];
        NSString* url = [NSString stringWithFormat:@"%@%@",HOST,car.url];
        [cell.thumbnail setImageWithURL:[NSURL URLWithString:url]];
        cell.thumbnail.contentMode = UIViewContentModeScaleToFill;
        
        returnCell = cell;
    }
    
    
    return returnCell;
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
    if ([vc isKindOfClass:[CarOfMyOrderTableViewController class]]) {
        CarOfMyOrderTableViewController* carOfMyOrder = (CarOfMyOrderTableViewController*)vc;
        carOfMyOrder.car = self.selectedCar;
    }
}


/**
 *  车辆预约于我的预约的切换控制
 *
 *  @param sender UISegmentedControl
 *
 *  @since 1.0.x
 */
- (IBAction)selectedChange:(id)sender {
    
    if (self.orderAndMyOrderSeg.selectedSegmentIndex == 1) {
        
        self.showCarOrderBtn.hidden = YES;
        
        [self.myCarsDepart removeAllObjects];
        [self.myCarsNotDepart removeAllObjects];
        [self.myCarsBack removeAllObjects];
        
        self.dataSource = nil;
        
        AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
        [manager GET:URL_CAR_MY_APPOINTMENT parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
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
                
                if ([car.realStartTime isEqualToString:@""])
                {
                    [self.myCarsNotDepart addObject:car];
                    
                }
                else if (![car.realStartTime isEqualToString:@""])
                {
                    if ([car.realEndTime isEqualToString:@""]) {
                        [self.myCarsDepart addObject:car];
                    }
                }
                else if (![car.realStartTime isEqualToString:@""])
                {
                    if (![car.realEndTime isEqualToString:@""]) {
                        [self.myCarsBack addObject:car];
                    }
                }
                
                [self.myOrderDataSource addObject:car];
            }
            
            self.dataSource = self.myCarsNotDepart;
            
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [YLToast showWithText:@"网络连接失败，请检查网络配置"];
            
        }];
        
    }
    
    if (self.orderAndMyOrderSeg.selectedSegmentIndex == 0) {
        
        self.showCarOrderBtn.hidden = NO;
        
        if (self.typesView.superview != NULL)
        {
            [self.typesView removeFromSuperview];
        }
        
        self.dataSource = self.orderDataSource;
        
        [self.tableView reloadData];
    }
}

/**
 *  便捷预约界面
 *
 *  @param sender 公车界面-车辆预约-右下方按钮
 *
 *  @since 1.0.x
 */
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
    self.tableView.userInteractionEnabled = NO;
    
    __weak CarOrderView* weak_orderView = orderView;
    
    orderView.cancelBtnClickBlock = ^(){
        [weak_orderView removeFromSuperview];
        self.tableView.alpha = 1.0;
        self.tableView.userInteractionEnabled = YES;
    };
    
    orderView.submitBtnClickBlock = ^(){
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             weak_orderView.passenagersNunTxtField.text,@"peopleNumber",
                             [NSString stringWithFormat:@"%@ %@",weak_orderView.endDateBtn.titleLabel.text,weak_orderView.endTimeBtn.titleLabel.text], @"end",
                             [NSString stringWithFormat:@"%@ %@",weak_orderView.startDateBtn.titleLabel.text,weak_orderView.startTimeBtn.titleLabel.text], @"start",
                             nil];
//        NSDictionary* dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                              @"2",@"peopleNumber",
//                              @"2016-09-08 12:10", @"end",
//                              @"2016-09-07 12:10", @"start",
//                              nil];
        AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
        [manager POST:URL_CAR_APPOINTMENT_SUBMIT parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary* dic = (NSDictionary*)responseObject;
            NSArray* carManage_dic = [dic objectForKey:@"carManage"];
            NSArray* cars_arr = [dic objectForKey:@"cars"];
            
            [self.dataSource removeAllObjects];
            
            for (NSDictionary* car_dic in cars_arr) {
                Car* car = [[Car alloc] init];
                car.brand = [car_dic objectForKey:@"brand"];
                car.number = [car_dic objectForKey:@"carNumber"];
                car.color = [car_dic objectForKey:@"color"];
                car.carId = ((NSNumber*)[car_dic objectForKey:@"id"]).integerValue;
                car.purpose = [car_dic objectForKey:@"purpose"];
                car.seating = ((NSNumber*)[car_dic objectForKey:@"seating"]).integerValue;
                car.type = [car_dic objectForKey:@"type"];
                car.url = [car_dic objectForKey:@"url"];
                car.weight = ((NSNumber*)[car_dic objectForKey:@"loading"]).integerValue;
                car.state = DGCarNotAppointment;
                [self.dataSource addObject:car];
            }
            NSArray* departCarManage_dic = [dic objectForKey:@"departCarManage"];
            
            [self.tableView reloadData];
            
            self.orderAndMyOrderSeg.hidden = self.showCarOrderBtn.hidden =YES;
            self.title = @"当前可预约的车辆信息";
            [weak_orderView removeFromSuperview];
            self.tableView.alpha = 1.0;
            self.tableView.userInteractionEnabled = YES;
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            self.tableView.alpha = 1.0;
            self.tableView.userInteractionEnabled = YES;
            [YLToast showWithText:@"网络连接失败，请检查网络配置"];
        }];
    };
}

/**
 *  我的预约界面选择不同的类型显示不同的数据
 *
 *  @since 1.0.x
 */
-(void)selecteShowCarTypes
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShowCarsTypesView" owner:self options:nil];
    if ([nib count]>0)
    {
        self.typesView = [nib objectAtIndex:0];
    }
    self.typesView.frame = CGRectMake(0, 10, self.tableView.frame.size.width, 90);
    __weak ShowCarsTypesView* weak_view = self.typesView;
    __weak CarsTableViewController* weak_self = self;
    self.typesView.showCarsTypeBlock = ^(NSInteger index){
        if (0 == index) {
            [weak_self.sectionHeaderView setTitle:weak_view.notAppointmentBtn.titleLabel.text forState:UIControlStateNormal];
            [weak_view removeFromSuperview];
            weak_self.dataSource = weak_self.myCarsNotDepart;
            [weak_self.tableView reloadData];
        }
        else if (1 == index)
        {
            [weak_self.sectionHeaderView setTitle:weak_view.departBtn.titleLabel.text forState:UIControlStateNormal];
            [weak_view removeFromSuperview];
            weak_self.dataSource = weak_self.myCarsDepart;
            [weak_self.tableView reloadData];
        }
        else if (2 == index)
        {
            [weak_self.sectionHeaderView setTitle:weak_view.hasBackBtn.titleLabel.text forState:UIControlStateNormal];
            [weak_view removeFromSuperview];
            weak_self.dataSource = weak_self.myCarsBack;
            [weak_self.tableView reloadData];
        }
    };
    [self.tableView addSubview:self.typesView];
}
@end
