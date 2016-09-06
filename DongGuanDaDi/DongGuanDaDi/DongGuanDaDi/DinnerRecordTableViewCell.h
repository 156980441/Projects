//
//  DinnerRecordTableViewCell.h
//  DongGuanDaDi
//
//  Created by fanyl on 16/9/1.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DinnerRecordTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *hasEatedLabel;
@property (strong, nonatomic) IBOutlet UILabel *isOrderedLabel;

@end
