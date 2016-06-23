//
//  TSMeTopCell.m
//  项目
//
//  Created by 唐硕 on 16/2/29.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSMeTopCell.h"

@implementation TSMeTopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *CellID = @"tangshuo";
    TSMeTopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if(cell == nil) {
        cell = [[TSMeTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -50, screen_width, 200)];
        scrollView.backgroundColor = navigationBarColor;
        [self addSubview:scrollView];
        
        
    }
    return self;
}
@end
