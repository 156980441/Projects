//
//  TSRecommentCell.h
//  项目
//
//  Created by 唐硕 on 16/3/1.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSRecommentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *shopImage;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *shopInfoLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *soldedLabel;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@end
