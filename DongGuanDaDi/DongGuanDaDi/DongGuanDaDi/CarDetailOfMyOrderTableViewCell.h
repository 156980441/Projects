//
//  CarDetailOfMyOrderTableViewCell.h
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/9/8.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  我的预约下的公车界面展示
 */
@interface CarDetailOfMyOrderTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* thumbnail;
@property (nonatomic, strong) IBOutlet UILabel* carNumber;
@property (nonatomic, strong) IBOutlet UILabel* startDate;
@property (nonatomic, strong) IBOutlet UILabel* endDate;
@property (nonatomic, strong) IBOutlet UILabel* passengers;
@end
