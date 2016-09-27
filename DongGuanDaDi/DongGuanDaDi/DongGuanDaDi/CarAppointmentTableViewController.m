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
#import "YLToast.h"
#import "YLDatePicker.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"

@interface CarAppointmentTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
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
    
    self.cars = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];

    // 这里类比 CarOrderCurrentView initWithCoder 方法
    CarOrderCurrentView* carOrderView = [[CarOrderCurrentView alloc] init];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CarOrderCurrentView" owner:carOrderView options:nil];
    UIView* innerView = [nib objectAtIndex:0];// nib[0]表示的就是除了File‘s Owner 和 File Responder后的第一个东西。这里 File's owner 是 CarOrderCurrentView，第一个就是UIView。但是既然嵌套在 storyboard 里面就不会正确显示大小。
    [carOrderView addSubview:innerView];
    carOrderView.reasonTxtView.layer.borderColor = [UIColor grayColor].CGColor;
    carOrderView.reasonTxtView.layer.borderWidth =1.0;
    carOrderView.startDateTxtField.delegate = carOrderView;
    carOrderView.startTimeTxtField.delegate = carOrderView;
    carOrderView.endDateTxtField.delegate = carOrderView;
    carOrderView.endTimeTxtField.delegate = carOrderView;
    carOrderView.reasonTxtView.delegate = carOrderView;
    carOrderView.picker = [[YLDatePicker alloc] init];
    carOrderView.picker.delegate = carOrderView;
    carOrderView.picker.frame = CGRectMake(0, 0, 300, 250);
    carOrderView.passengerTxtField.keyboardType = UIKeyboardTypeNumberPad;
    innerView.frame = carOrderView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 400);//为什么必须设置？
    self.tableView.tableFooterView = carOrderView;
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSString stringWithFormat:@"%zd", self.car.carId],@"id",
                         nil];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    // 这里的返回值是一个标准 json
    [manager POST:URL_CAR_RESERVED parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary* result = (NSDictionary*)responseObject;
        NSArray* carAppoints = [result objectForKey:@"carAppoints"];
        for (NSDictionary* dic_car in carAppoints) {
            Car* car = [[Car alloc] init];
            car.driver = [dic_car objectForKey:@"driver"];
            car.endtime = [dic_car objectForKey:@"endTime"];
            car.peopleNum = ((NSNumber*)[dic_car objectForKey:@"followNumber"]).integerValue;
            car.reason = [dic_car objectForKey:@"reason"];
            car.startTime = [dic_car objectForKey:@"startTime"];
            [self.cars addObject:car];
            
            NSString* startStr = [NSString stringWithFormat:@"预约出车时间：%@",car.startTime];
            NSString* endStr = [NSString stringWithFormat:@"预约还车时间：%@",car.endtime];
            NSString* driver = [NSString stringWithFormat:@"预约人：%@",car.driver];
            NSString* passengers = [NSString stringWithFormat:@"随车人数：%zd", car.peopleNum];
            NSString* reason = [NSString stringWithFormat:@"出车事由：%@",car.reason];
            NSArray* carAppointInfo = @[startStr,endStr,driver,passengers,reason];
            [self.dataSource addObject:carAppointInfo];
        }
        
        UIImageView* imageView = [[UIImageView alloc] init];
        NSString* imageURL = [NSString stringWithFormat:@"%@%@",HOST,self.car.url];
        [imageView setImageWithURL:[NSURL URLWithString:imageURL]];
        imageView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 200);//为什么必须设置？
        self.tableView.tableHeaderView = imageView;
        
        [self.tableView reloadData];
//        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:error.localizedDescription];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray* carAppointInfo = [self.dataSource objectAtIndex:section];
    return carAppointInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"car_appointment_identifier" forIndexPath:indexPath];
    NSArray* carAppointInfo = [self.dataSource objectAtIndex:indexPath.section];
    cell.textLabel.text = [carAppointInfo objectAtIndex:indexPath.row];
    
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
