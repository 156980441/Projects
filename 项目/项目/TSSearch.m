//
//  TSSearch.m
//  项目
//
//  Created by 唐硕 on 16/2/19.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSSearch.h"

@implementation TSSearch

/**
 *  init方法内部会调用这个方法
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        // 背景
        self.background = [UIImage imageNamed:@"icon_homepage_search"];
        // 占位文字
        self.placeholder = @"输入商家，品类，商圈";
        self.font = [UIFont systemFontOfSize:9.0];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
        
        // 文本框左边的放大镜图片 selfbar_textfield_self_icon
        UIImageView *leftIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_homepage_search"]];
        leftIcon.contentMode = UIViewContentModeCenter;
        leftIcon.bounds = CGRectMake(0, 0, 25, 25);
        self.leftView = leftIcon;
        
        // 设置左边的view永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 设置字体
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
@end
