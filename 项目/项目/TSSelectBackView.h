//
//  TSSelectBackView.h
//  项目
//
//  Created by 唐硕 on 16/3/1.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSaddScorllView;

@protocol TSSelectBackViewTapDelegate <NSObject>
@optional
-(void)removeMaskView;
@end


@interface TSSelectBackView : UIView

@property (nonatomic, strong) TSaddScorllView *addScrollView;
@property (nonatomic, strong)id <TSSelectBackViewTapDelegate>Tapdelegate;

@end
