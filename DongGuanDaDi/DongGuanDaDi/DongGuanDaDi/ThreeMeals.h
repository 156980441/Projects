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
    ThreeMealsState_canBook_canChange,//可预订且当前可修改
    ThreeMealsState_noBook_canChange,//未预订且当前可修改
    ThreeMealsState_booked_noChange//已经预订且当前不可修改
}ThreeMealsState;

typedef enum ThreeMealsType
{
    ThreeMealsType_breakfast,
    ThreeMealsType_lunch,
    ThreeMealsType_dinner
}ThreeMealsType;

@interface ThreeMeals : NSObject
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) NSInteger mealsId;
@property (nonatomic, assign) ThreeMealsType kind;
@property (nonatomic, assign) ThreeMealsState state;
@end
