//
//  TSaddScorllView.m
//  项目
//
//  Created by 唐硕 on 16/3/1.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSaddScorllView.h"

@implementation TSaddScorllView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initViews];
    }
    return self;
}

-(void)initViews {
    UIView *Backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height/2)];
    Backview.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:0.9];
    [self addSubview:Backview];
    //搞scrollview
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 220)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [Backview addSubview:self.scrollView];
    //
    self.scrollView2 = [[UIScrollView alloc]initWithFrame:CGRectMake(screen_width/2-150, 235, 300, 30)];
    self.scrollView2.backgroundColor = [UIColor grayColor];
    self.scrollView2.tag = 1;
    [self addSubview:self.scrollView2];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicktap:)];
    [self.scrollView2 addGestureRecognizer:tap];
    //
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15-12.5, 60, 25)];
    lab1.font = [UIFont systemFontOfSize:13.0];
    lab1.textColor = [UIColor whiteColor];
    lab1.text = @"当前城市:";
    [self.scrollView2 addSubview:lab1];
    //
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(70, 15-12.5, 60, 25)];
    lab2.font = [UIFont systemFontOfSize:13.0];
    lab2.textColor = [UIColor whiteColor];
    lab2.text = @"无锡";
    [self.scrollView2 addSubview:lab2];
    //
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(220, 15-12.5, 80, 25);
    [btn setImage:[UIImage imageNamed:@"btn_backItem"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"btn_backItem"] forState:UIControlStateSelected];
    //
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    //
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 55, 0, 0);
    [btn setTitle:@"更换" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView2 addSubview:btn];
        
}

-(void)layoutSubviews {
    NSArray *array = [TSGetPlistArray ArrayWithString:@"citydata.plist"];
    NSArray *cityArray = [array objectAtIndex:9][@"citylist"];
    NSArray *areaArray = [cityArray objectAtIndex:1][@"arealist"];
    //NSLog(@"%@", areaArray);

    self.scrollView.alwaysBounceVertical = YES;

    self.scrollView.contentSize = CGSizeMake(screen_width, screen_height-350);

    int totalloc = 3;
    CGFloat buttonw = 70;
    CGFloat buttonh = 30;
    
    CGFloat margin=(self.frame.size.width - totalloc * buttonw) / (totalloc + 1);
    //int count=11;
    for (int i = 0; i < areaArray.count; i++) {
        NSDictionary *dict = areaArray[i];
        NSString *titleStr = dict[@"areaName"];
        int row = i / totalloc;//行号
        //0/3=0,1/3=0,2/3=1; (i 从0到2都是第一行) i＝ 3的时候第二行
        int loc = i % totalloc;//列号

        CGFloat buttonx = margin + (margin + buttonw) * loc;

        CGFloat buttony = margin + (margin + buttonh) * row;
        //创建uiview控件
        UIButton *areaButton=[[UIButton alloc]initWithFrame:CGRectMake(buttonx, buttony, buttonw, buttonh)];
        [areaButton setTitle:titleStr forState:UIControlStateNormal];
        [areaButton setBackgroundColor: navigationBarColor];
        [areaButton addTarget:self action:@selector(areaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:areaButton];
        
    }
    
    
}

-(void)areaButtonClick:(UIButton *)button {
    if([self.delegate respondsToSelector:@selector(areaButtonClick:)]) {
        [self.delegate areaButtonClick:button];
    }
    
}

-(void)changeButtonClick:(UIButton *)button {
    if([self.changeDelegate respondsToSelector:@selector(changeButtonClick:)]) {
        [self.changeDelegate changeButtonClick:button];
    }
}

-(void)Clicktap:(UITapGestureRecognizer *)sender{
    if([self.changeDelegate respondsToSelector:@selector(changeButtonClick:)]) {
        [self.changeDelegate changeButtonClick:sender];
    }

}

@end
