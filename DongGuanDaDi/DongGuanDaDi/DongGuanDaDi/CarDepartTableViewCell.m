//
//  CarDepartTableViewCell.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/31/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CarDepartTableViewCell.h"

@implementation CarDepartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSLog(@"awake from nib");
//    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"CarDepartTableViewCell" owner:self options:nil];
//    for (UIView* view in views) {
//        [self.contentView addSubview:view];
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
