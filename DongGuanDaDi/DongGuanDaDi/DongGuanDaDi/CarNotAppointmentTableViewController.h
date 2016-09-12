//
//  CarAppointmentTableViewController.h
//  DongGuanDaDi
//
//  Created by fanyl on 16/8/29.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Car;

/**
 *  未预约车辆界面控制器
 */
@interface CarNotAppointmentTableViewController : UITableViewController
@property (nonatomic, strong) Car *car;
@end
