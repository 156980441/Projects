//
//  ThreeMeals.h
//  DongGuanDaDi
//
//  Created by 赵雪莹 on 16/9/7.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ThreeMealsState
{
    ThreeMealsState_canBook_canChange = 0,//可预订且当前可修改
    ThreeMealsState_booked_canChange,//已预定且可修改
    ThreeMealsState_noBook_noChange,//未预订且不可修改
    ThreeMealsState_booked_noChange//已经预订且当前不可修改
}ThreeMealsState;

typedef enum ThreeMealsType
{
    ThreeMealsType_breakfast = 0,
    ThreeMealsType_lunch,
    ThreeMealsType_dinner
}ThreeMealsType;

/**
 *  类似 Android 平台的 AllDayDinnerInfo
 *
 *  @since 1.0.x
 */
@interface ThreeMeals : NSObject
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) NSInteger mealsId;
@property (nonatomic, assign) ThreeMealsType kind;
@property (nonatomic, assign) ThreeMealsState state;
@end
