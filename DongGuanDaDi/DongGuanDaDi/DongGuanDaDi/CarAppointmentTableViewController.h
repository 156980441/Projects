//
//  CarAppointmentTableViewController.h
//  DongGuanDaDi
//
//  Created by fanyl on 16/9/4.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Car;
/**
 *  已预约车辆控制器
 */
@interface CarAppointmentTableViewController : UITableViewController
@property (nonatomic, strong) Car *car;
@property (nonatomic, strong) NSMutableArray *cars;
@end
