//
//  DinnerViewController.m
//  DongGuanDaDi
//
//  Created by fanyl on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "DinnerViewController.h"
#import "DinnerInfo.h"
#import "MemuDetailViewController.h"
#import "ThreeMeals.h"
#import "YLCommon.h"
#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

enum FoodBtnTpye
{
    foodBtnTpye_breakfast = 0,
    foodBtnTpye_lunch,
    foodBtnTpye_dinner
};

@interface DinnerViewController ()
@property (nonatomic, strong) NSMutableDictionary *dateAndDinners;
@property (nonatomic, strong) NSMutableArray* breakfasts_arr;
@property (nonatomic, strong) NSMutableArray* lunch_arr;
@property (nonatomic, strong) NSMutableArray* dinner_arr;
@property (nonatomic, strong) NSDate* selecetedDate;
@property (nonatomic, strong) NSMutableArray* seletedFoods;// 用于提交预约饭菜
@property (nonatomic, strong) NSMutableArray* seletedThreeMeals; // 用于提交预约饭菜
@end

@implementation DinnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dateAndDinners = [NSMutableDictionary dictionary];
    self.breakfasts_arr = [NSMutableArray array];
    self.lunch_arr = [NSMutableArray array];
    self.dinner_arr = [NSMutableArray array];
    self.seletedFoods = [NSMutableArray array];
    self.seletedThreeMeals = [NSMutableArray array];
    
    self.breakfastBtn.tag = foodBtnTpye_breakfast;
    [self.breakfastBtn.layer setBorderWidth:1.0];
    [self.breakfastBtn.layer setBorderColor:[[UIColor grayColor] CGColor]];

    self.dinnerBtn.tag = foodBtnTpye_dinner;
    [self.dinnerBtn.layer setBorderWidth:1.0];
    [self.dinnerBtn.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    self.lunchBtn.tag = foodBtnTpye_lunch;
    [self.lunchBtn.layer setBorderWidth:1.0];
    [self.lunchBtn.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    self.moreBtn.layer.cornerRadius = 15.0;
    
    // 已优化，使用 UIButton 自身属性来改变 title 和 image 位置，减少内存开销
    
    [self changeBtnLayout:self.voteBtn];
    [self changeBtnLayout:self.recordBtn];
    
    self.title = @"用餐预约";
}
-(void)changeBtnLayout:(UIButton*)btn
{
    CGPoint buttonBoundsCenter = CGPointMake(CGRectGetMidX(btn.bounds), CGRectGetMidY(btn.bounds));
    
    // 找出imageView最终的center
    
    CGPoint endImageViewCenter = CGPointMake(buttonBoundsCenter.x + btn.bounds.size.width/2-btn.imageView.bounds.size.width/2, buttonBoundsCenter.y);
    
    // 找出titleLabel最终的center
    
    CGPoint endTitleLabelCenter = CGPointMake(buttonBoundsCenter.x-btn.bounds.size.width/2 + btn.titleLabel.bounds.size.width/2, buttonBoundsCenter.y);
    
    // 取得imageView最初的center
    
    CGPoint startImageViewCenter = btn.imageView.center;
    
    // 取得titleLabel最初的center
    
    CGPoint startTitleLabelCenter = btn.titleLabel.center;
    
    // 设置imageEdgeInsets
    
    CGFloat imageEdgeInsetsTop = endImageViewCenter.y - startImageViewCenter.y;
    
    CGFloat imageEdgeInsetsLeft = endImageViewCenter.x - startImageViewCenter.x;
    
    CGFloat imageEdgeInsetsBottom = -imageEdgeInsetsTop;
    
    CGFloat imageEdgeInsetsRight = -imageEdgeInsetsLeft;
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeInsetsTop, imageEdgeInsetsLeft, imageEdgeInsetsBottom, imageEdgeInsetsRight);
    
    // 设置titleEdgeInsets
    
    CGFloat titleEdgeInsetsTop = endTitleLabelCenter.y-startTitleLabelCenter.y;
    
    CGFloat titleEdgeInsetsLeft = endTitleLabelCenter.x - startTitleLabelCenter.x;
    
    CGFloat titleEdgeInsetsBottom = -titleEdgeInsetsTop;
    
    CGFloat titleEdgeInsetsRight = -titleEdgeInsetsLeft;
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeInsetsTop, titleEdgeInsetsLeft, titleEdgeInsetsBottom, titleEdgeInsetsRight);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 日历控件
    NSDateComponents *weeks = [[NSDateComponents alloc] init];
    weeks.weekOfMonth = 4;
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:weeks
                                                                    toDate:[NSDate date]
                                                                   options:0];
    [self.dayPicker setStartDate:[NSDate date] endDate:endDate];
    [self.dayPicker setWeekdayTitles:[NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"日",nil]];
    [self.dayPicker addObserver:self
                     forKeyPath:@"selectedDate"
                        options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                        context:nil];
    
    AFHTTPSessionManager* manger = [AFHTTPSessionManager manager];
    [manger.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    NSArray* dates = [YLCommon getFirstAndLastDayOfThisWeek];
    NSString* url = [NSString stringWithFormat:@"%@beginDateString=%@&endDateString=%@",URL_GET_CUISINE,[YLCommon date2String:[dates objectAtIndex:0]],[YLCommon date2String:[dates objectAtIndex:1]]];
    
    [manger GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray* arr = (NSArray*)responseObject;
        if (arr.count != 0) {
            
            for (NSDictionary* dic in arr) {
                
                NSArray* breakfasts_arr = [dic objectForKey:@"breakfasts"];
                
                for (NSDictionary* breakfasts_dic in breakfasts_arr) {
                    DinnerInfo* breakfastsInfo = [[DinnerInfo alloc] init];
                    breakfastsInfo.desc = [breakfasts_dic objectForKey:@"description"];
                    breakfastsInfo.foodId = ((NSNumber*)[breakfasts_dic objectForKey:@"id"]).integerValue;
                    breakfastsInfo.name = [breakfasts_dic objectForKey:@"name"];
                    breakfastsInfo.url = [breakfasts_dic objectForKey:@"url"];
                    breakfastsInfo.date = [dic objectForKey:@"date"];
                    breakfastsInfo.type = DinnerInfoType_breakfasts;
                    [self.breakfasts_arr addObject:breakfastsInfo];
                    
                }
                
                NSArray* dinner_arr = [dic objectForKey:@"dinners"];
                
                for (NSDictionary* dinner_dic in dinner_arr) {
                    DinnerInfo* dinnerInfo = [[DinnerInfo alloc] init];
                    dinnerInfo.desc = [dinner_dic objectForKey:@"description"];
                    dinnerInfo.foodId = ((NSNumber*)[dinner_dic objectForKey:@"id"]).integerValue;
                    dinnerInfo.name = [dinner_dic objectForKey:@"name"];
                    dinnerInfo.url = [dinner_dic objectForKey:@"url"];
                    dinnerInfo.date = [dic objectForKey:@"date"];
                    dinnerInfo.type = DinnerInfoType_dinners;
                    [self.dinner_arr addObject:dinnerInfo];
                    
                }
                
                NSArray* lunch_arr = [dic objectForKey:@"lunches"];
                
                for (NSDictionary* lunch_dic in lunch_arr) {
                    DinnerInfo* lunchInfo = [[DinnerInfo alloc] init];
                    lunchInfo.desc = [lunch_dic objectForKey:@"description"];
                    lunchInfo.foodId = ((NSNumber*)[lunch_dic objectForKey:@"id"]).integerValue;
                    lunchInfo.name = [lunch_dic objectForKey:@"name"];
                    lunchInfo.url = [lunch_dic objectForKey:@"url"];
                    lunchInfo.date = [dic objectForKey:@"date"];
                    lunchInfo.type = DinnerInfoType_lunches;
                    [self.lunch_arr addObject:lunchInfo];
                    
                }
                
                NSDictionary* breakfasts_local_dic = [NSDictionary dictionaryWithObjectsAndKeys:[self.breakfasts_arr copy],@"早餐", nil];
                NSDictionary* lunches_local_dic = [NSDictionary dictionaryWithObjectsAndKeys:[self.lunch_arr copy],@"午餐", nil];
                NSDictionary* dinners_local_dic = [NSDictionary dictionaryWithObjectsAndKeys:[self.dinner_arr copy],@"晚餐", nil];
                NSArray* allDinnerInDay = [NSArray arrayWithObjects:breakfasts_local_dic,lunches_local_dic,dinners_local_dic,nil];
                
                // 数据结构：字典[日期：当天饭菜（数组）]

                [self.dateAndDinners setObject:allDinnerInDay forKey:[dic objectForKey:@"date"]];
                
                [self.breakfasts_arr removeAllObjects];
                [self.lunch_arr removeAllObjects];
                [self.dinner_arr removeAllObjects];
                
                [self updateDinnerLabel:self.dayPicker.selectedDate];
                
            }
        }
        else
        {
            [YLToast showWithText:@"暂无该周菜式数据"];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
        
//        NSLog(@"URL_GET_CUISINE failed, %@",error);
        
    }];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 在此方法中去除监听，防止手动来回拖动返回造成崩溃。
    [self.dayPicker removeObserver:self forKeyPath:@"selectedDate"];
    
    // 今日 MenuViewController 界面后
    self.recordBtn.hidden = self.voteBtn.hidden = YES;
    
    for (UIView* view in self.view.subviews) {
        if (view != self.voteBtn && view != self.recordBtn && view != self.moreBtn) {
            view.alpha = view.alpha != 1 ? 1.0 : 0.7;
            view.userInteractionEnabled = !view.userInteractionEnabled;
        }
    }
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateSingleDinnerBtnsState:(UIButton*) button byMeal:(ThreeMeals*)meal
{
    switch (meal.state) {
        case ThreeMealsState_canBook_canChange: {
            button.enabled = YES;
            [button setSelected:NO];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
            break;
        }
        case ThreeMealsState_booked_canChange: {
            button.enabled = YES;
            [button setSelected:YES];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor blueColor]];
            break;
        }
        case ThreeMealsState_noBook_noChange: {
            button.enabled = NO;
            [button setSelected:NO];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor lightGrayColor]];
            break;
        }
        case ThreeMealsState_booked_noChange: {
            button.enabled = NO;
            [button setSelected:YES];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor blueColor]];
            break;
        }
    }
}

-(void)updateAllDinnerBtnsState {
    NSDate* today = [NSDate date];
    if ([self.selecetedDate compare:today] == NSOrderedDescending) {
        self.breakfastBtn.backgroundColor = self.lunchBtn.backgroundColor = self.dinnerBtn.backgroundColor = [UIColor whiteColor];
        UIColor* color = [UIColor blackColor];
        [self.breakfastBtn setTitleColor:color forState:UIControlStateNormal];
        [self.lunchBtn setTitleColor:color forState:UIControlStateNormal];
        [self.dinnerBtn setTitleColor:color forState:UIControlStateNormal];
    } else if ([self.selecetedDate compare:today] == NSOrderedAscending) {
        self.breakfastBtn.backgroundColor = self.lunchBtn.backgroundColor = self.dinnerBtn.backgroundColor = [UIColor grayColor];
        self.breakfastBtn.enabled = self.lunchBtn.enabled = self.dinnerBtn.enabled = NO;
        UIColor* color = [UIColor whiteColor];
        [self.breakfastBtn setTitleColor:color forState:UIControlStateNormal];
        [self.lunchBtn setTitleColor:color forState:UIControlStateNormal];
        [self.dinnerBtn setTitleColor:color forState:UIControlStateNormal];
    }
}

- (void)updateDinnerLabel:(NSDate*)date
{
    NSString* date_str = [YLCommon date2String:date];
    self.selectedDateLabel.text = [NSString stringWithFormat:@"选定日期：%@",date_str];
    
    NSArray* arr = [self.dateAndDinners objectForKey:date_str];
    
    if (arr.count > 0) {
        NSDictionary* dic = [arr objectAtIndex:0];
        NSArray* temp_arr = [dic objectForKey:@"早餐"];
        NSMutableString* temp_str = [NSMutableString string];
        for (DinnerInfo* info in temp_arr) {
            [temp_str appendString:info.name];
            if (info != [temp_arr lastObject]) {
                [temp_str appendString:@","];
            }
        }
        self.breakfastLabel.text = [NSString stringWithFormat:@"早餐：%@",temp_str];
        
        dic = [arr objectAtIndex:1];
        temp_arr = [dic objectForKey:@"午餐"];
        temp_str = [NSMutableString string];
        for (DinnerInfo* info in temp_arr) {
            [temp_str appendString:info.name];
            if (info != [temp_arr lastObject]) {
                [temp_str appendString:@","];
            }
        }
        self.lunchLabel.text = [NSString stringWithFormat:@"午餐：%@",temp_str];
        
        dic = [arr objectAtIndex:2];
        temp_arr = [dic objectForKey:@"晚餐"];
        temp_str = [NSMutableString string];
        for (DinnerInfo* info in temp_arr) {
            [temp_str appendString:info.name];
            if (info != [temp_arr lastObject]) {
                [temp_str appendString:@","];
            }
        }
        self.dinnerLabel.text = [NSString stringWithFormat:@"晚餐：%@",temp_str];
    }
    else {
        self.lunchLabel.text = @"暂无菜式数据";
        self.breakfastLabel.text = nil;
        self.dinnerLabel.text = nil;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
//    [self updateAllDinnerBtnsState];
    
    self.selecetedDate = change[NSKeyValueChangeNewKey];
    
    [self updateDinnerLabel:self.selecetedDate];
    NSString* date_str = [YLCommon date2String:self.selecetedDate];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_RESERVE_INFO,date_str];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray* result = (NSArray*)responseObject;
        
        [self.seletedThreeMeals removeAllObjects];
        
        for (NSDictionary* dic in result) {
            ThreeMeals *meals = [[ThreeMeals alloc] init];
            meals.date = [dic objectForKey:@"date"];
            meals.mealsId = ((NSNumber*)[dic objectForKey:@"id"]).integerValue;
            meals.kind = (ThreeMealsType)((NSNumber*)[dic objectForKey:@"kind"]).integerValue;
            meals.state = (ThreeMealsState)((NSNumber*)[dic objectForKey:@"state"]).integerValue;
            if (meals.kind == ThreeMealsType_breakfast) {
                [self updateSingleDinnerBtnsState:self.breakfastBtn byMeal:meals];
            }
            if (meals.kind == ThreeMealsType_lunch) {
                [self updateSingleDinnerBtnsState:self.lunchBtn byMeal:meals];
            }
            if (meals.kind == ThreeMealsType_dinner) {
                [self updateSingleDinnerBtnsState:self.dinnerBtn byMeal:meals];
            }
            if (self.dinnerBtn.backgroundColor == self.lunchBtn.backgroundColor && self.lunchBtn.backgroundColor == self.breakfastBtn.backgroundColor && self.dinnerBtn.backgroundColor == [UIColor blueColor]) {
                [self.orderAllBtn setSelected:YES];
            }
            else
            {
                self.orderAllBtn.backgroundColor = [UIColor whiteColor];
            }
            [self.seletedThreeMeals addObject:meals];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
        
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController* vc = [segue destinationViewController];
    if ([vc isKindOfClass:[MemuDetailViewController class]]) {
        MemuDetailViewController* menuDetailVc = (MemuDetailViewController*)vc;
        NSString* date = [YLCommon date2String:self.selecetedDate];
        menuDetailVc.dataSource = [self.dateAndDinners objectForKey:date];
        menuDetailVc.selectedDate = date;
    }
}

#pragma mark - UIButton Event

- (IBAction)moreBtnClick:(id)sender {
    self.voteBtn.hidden = !self.voteBtn.hidden;
    self.recordBtn.hidden = !self.recordBtn.hidden;
    self.voteBtn.backgroundColor = self.recordBtn.backgroundColor = [UIColor whiteColor];
    
    for (UIView* view in self.view.subviews) {
        if (view != self.voteBtn && view != self.recordBtn && view != self.moreBtn) {
            view.alpha = view.alpha == 1 ? 0.7 : 1.0;
            view.userInteractionEnabled = !view.userInteractionEnabled;
        }
    }
}

// 全部预约
- (IBAction)orderBtnClick:(id)sender {
    
    UIColor* color = nil;
    UIColor* titleColor = nil;
    
    [self.orderAllBtn setSelected:!self.orderAllBtn.selected];
    
    if (self.orderAllBtn.isSelected) {
        color = [UIColor blueColor];
        titleColor = [UIColor whiteColor];
        
        if (self.breakfastBtn.enabled) {
            [self.breakfastBtn setSelected:YES];
            self.breakfastBtn.backgroundColor = color;
            [self.breakfastBtn setTitleColor:titleColor forState:UIControlStateNormal];
        }
        if (self.dinnerBtn.enabled) {
            [self.dinnerBtn setSelected:YES];
            self.dinnerBtn.backgroundColor = color;
            [self.dinnerBtn setTitleColor:titleColor forState:UIControlStateNormal];
        }
        if (self.lunchBtn.enabled) {
            [self.lunchBtn setSelected:YES];
            self.lunchBtn.backgroundColor = color;
            [self.lunchBtn setTitleColor:titleColor forState:UIControlStateNormal];
        }
    }
    else {
        color = [UIColor whiteColor];
        if (self.breakfastBtn.enabled) {
            [self.breakfastBtn setSelected:NO];
            self.breakfastBtn.backgroundColor = color;
            [self.breakfastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (self.dinnerBtn.enabled) {
            [self.dinnerBtn setSelected:NO];
            self.dinnerBtn.backgroundColor = color;
            [self.dinnerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (self.lunchBtn.enabled) {
            [self.lunchBtn setSelected:NO];
            self.lunchBtn.backgroundColor = color;
            [self.lunchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

/**
 *  点击早餐，午餐，晚餐按钮响应
 *
 *  @param sender 对应的按钮
 *
 *  @since 1.0.x
 */
- (IBAction)selecteFoodBtnClick:(id)sender
{
    // 首先在点击日期消息里面处理了该按钮是否可以点击
    // updateSingleDinnerBtnsState
    
    UIButton* btn = (UIButton*)sender;
    
    if (!btn.enabled)
    {
        if ([self.selecetedDate compare:[NSDate date]] != NSOrderedSame) {
            [YLToast showWithText:@"未在可预约日期内，该状态不可修改"];
        }
        else
        {
            [YLToast showWithText:@"已过修改时间，该状态不可修改"];
        }
        
        return;
    }
    
    [btn setSelected:!btn.selected];
    
    if (btn.isSelected) {
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 只要有一个按钮不是选中，那么则关闭全选按钮的选中模式
        [self.orderAllBtn setSelected:NO];
        
    }
    
    if (self.breakfastBtn.isSelected && self.lunchBtn.isSelected && self.dinnerBtn.isSelected) {
        // 三个按钮全部选中，那么则打开全选按钮的选中模式
        [self.orderAllBtn setSelected:YES];
    }
    
    for (ThreeMeals* meal in self.seletedThreeMeals) {
        NSString* foodId = [NSString stringWithFormat:@"%ld",meal.mealsId];
        if (YES == btn.selected) {
            [self.seletedFoods addObject:foodId];
        }
        else
        {
            [self.seletedFoods removeObject:foodId];
        }
    }
}

- (IBAction)submitBtnClick:(id)sender {
    __block NSInteger submitedNum = 0;
    for (NSString* foodId in self.seletedFoods) {
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:foodId,@"id", nil];
        AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
        [manager POST:URL_RESERVE
           parameters:dic
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  submitedNum ++;
                  if (submitedNum == self.seletedFoods.count) {
                      [YLToast showWithText:@"提交成功"];
                      [self.seletedFoods removeAllObjects];
                  }
                  else
                  {
                      [YLToast showWithText:@"提交失败"];
                  }
                  
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  [YLToast showWithText:error.localizedDescription];
              }];
    }
}

@end
