//
//  TSGuessCell.m
//  项目
//
//  Created by 唐硕 on 16/3/1.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSGuessCell.h"

@implementation TSGuessCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *CellID = @"tangshaagadasgsgasgsgugsfjkljkhjo";
    TSGuessCell *cell = [tableview dequeueReusableCellWithIdentifier:CellID];
    if(cell == nil) {
        cell = [[TSGuessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.textLabel.text = @"猜你喜欢";
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 29.5, screen_width, 0.5)];
        lineview.backgroundColor = navigationBarColor;
        [cell addSubview:lineview];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



@end
