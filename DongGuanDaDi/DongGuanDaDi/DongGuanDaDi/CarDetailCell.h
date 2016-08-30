//
//  CarDetailCell.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/30/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *state;
@property (nonatomic, strong) IBOutlet UIImageView* thumbnail;
@property (nonatomic, strong) IBOutlet UILabel* brand;
@property (nonatomic, strong) IBOutlet UILabel* number;
@property (nonatomic, strong) IBOutlet UILabel* seats;
@property (nonatomic, strong) IBOutlet UILabel* weight;
@end
