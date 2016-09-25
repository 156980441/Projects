//
//  CarDepartTableViewController.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Car;

@interface CarDepartTableViewController : UITableViewController
@property (nonatomic, strong) Car *car;
@property (nonatomic, strong) NSMutableArray *appointCars; // 存放预约信息
@end
