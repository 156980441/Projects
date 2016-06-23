//
//  TSShoppingCell.m
//  项目
//
//  Created by 唐硕 on 16/2/29.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSShoppingCell.h"

@implementation TSShoppingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *CellID = @"tangshugsfjjo";
    TSShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if(cell == nil) {
        cell = [[TSShoppingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.textLabel.text = @"购物中心";
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 29.5, screen_width, 0.5)];
        lineview.backgroundColor = navigationBarColor;
        [cell addSubview:lineview];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
