//
//  TSaddScorllView.h
//  项目
//
//  Created by 唐硕 on 16/3/1.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TSaddScorllViewButtonDelegate <NSObject>
@optional
-(void)areaButtonClick:(UIButton *)button;
@end

@protocol TSchangeButtonDelegate <NSObject>
@optional
-(void)changeButtonClick:(UIButton *)button;
@end


@interface TSaddScorllView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollView2;

@property (nonatomic, strong)id <TSaddScorllViewButtonDelegate>delegate;
@property (nonatomic, strong)id <TSchangeButtonDelegate>changeDelegate;
@end
