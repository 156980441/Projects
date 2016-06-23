//
//  TSDiscountCell.m
//  项目
//
//  Created by 唐硕 on 16/2/28.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSDiscountCell.h"

@implementation TSDiscountCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *CellID = @"tangshufnfsdo";
    TSDiscountCell *cell = [tableview dequeueReusableCellWithIdentifier:CellID];
    if(cell == nil) {
        cell = [[TSDiscountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        for(int i = 0; i < 4; i++) {
        //
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(i*screen_width/2, 0, screen_width/2, 65)];
            if(i<2) {
                backView.frame = CGRectMake(i*screen_width/2, 0, screen_width/2, 65);
            }else {
                backView.frame = CGRectMake((i-2)*screen_width/2, 65, screen_width/2, 65);
            }
            backView.tag = 200 + i;
            backView.layer.borderWidth = 0.5;
            backView.layer.borderColor = [navigationBarColor CGColor];
            
            //
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapBackView:)];
            [backView addGestureRecognizer:tap];
            
            //
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, backView.frame.size.width/2+10, 30)];
            titleLabel.text = @"唐硕唐帅";
            titleLabel.tag = 260+i;
            titleLabel.textColor = navigationBarColor;
            titleLabel.font = [UIFont systemFontOfSize:15];
            [backView addSubview:titleLabel];
            //
            UILabel *subLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, backView.frame.size.width/2+10, 30)];
            subLable.text = @"唐硕帅还用你说";
            subLable.tag = 220+i;
            subLable.font = [UIFont systemFontOfSize:12];
            [backView addSubview:subLable];
            //
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(backView.frame.size.width/2+15, backView.frame.size.height/2-25, 50, 50)];
            imageView.tag = 240 + i;
            [imageView setImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 30;
            [backView addSubview:imageView];
            
            [self addSubview:backView];
        }
        
    }
    return self;
}




-(void)OnTapBackView:(UITapGestureRecognizer *)sender {
    NSLog(@"%d", (long)sender.view.tag);
}
@end
