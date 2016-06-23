//
//  TSMoreCell.m
//  项目
//
//  Created by 唐硕 on 16/2/20.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSMoreCell.h"

@implementation TSMoreCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath*)indexPath MoreArray:(NSArray *)MoreArray {
    static NSString *TSMore = @"tangshuo";
    TSMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:TSMore];
    if(cell == nil) {
        cell = [[TSMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TSMore];
         UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, screen_width, 0.5)];
        lineView.backgroundColor = separaterColor;
        [cell addSubview:lineView];
    }
    cell.textLabel.text = [MoreArray[indexPath.section]objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}



@end
