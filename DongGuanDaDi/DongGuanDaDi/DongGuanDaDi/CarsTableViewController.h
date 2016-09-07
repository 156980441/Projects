//
//  CarsTableViewController.h
//  DongGuanDaDi
//
//  Created by fanyl on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarsTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *orderAndMyOrderSeg;
- (IBAction)selectedChange:(id)sender;
- (IBAction)showCarOrderView:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *showCarOrderBtn;

@end
