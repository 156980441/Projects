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

@interface DinnerViewController ()
@property (nonatomic, strong) NSMutableDictionary *dateAndDinners;
@property (nonatomic, strong) NSMutableArray* breakfasts_arr;
@property (nonatomic, strong) NSMutableArray* lunch_arr;
@property (nonatomic, strong) NSMutableArray* dinner_arr;
@property (nonatomic, strong) NSDate* selecetedDate;
@end

@implementation DinnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dateAndDinners = [NSMutableDictionary dictionary];
    self.breakfasts_arr = [NSMutableArray array];
    self.lunch_arr = [NSMutableArray array];
    self.dinner_arr = [NSMutableArray array];
    
    [self.breakfastBtn.layer setBorderWidth:1.0];
    [self.breakfastBtn.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.dinnerBtn.layer setBorderWidth:1.0];
    [self.dinnerBtn.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.lunchBtn.layer setBorderWidth:1.0];
    [self.lunchBtn.layer setBorderColor:[[UIColor grayColor] CGColor]];
    self.breakfastBtn.tintColor = self.dinnerBtn.tintColor = self.lunchBtn.tintColor = [UIColor blueColor];
    
    self.title = @"用餐预约";
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
    [self.dayPicker setWeekdayTitles:[NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六",nil]];
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
                
                NSMutableString* breakfast_str = [NSMutableString string];
                for (NSDictionary* breakfasts_dic in breakfasts_arr) {
                    DinnerInfo* breakfastsInfo = [[DinnerInfo alloc] init];
                    breakfastsInfo.desc = [breakfasts_dic objectForKey:@"description"];
                    breakfastsInfo.foodId = ((NSNumber*)[breakfasts_dic objectForKey:@"id"]).integerValue;
                    breakfastsInfo.name = [breakfasts_dic objectForKey:@"name"];
                    breakfastsInfo.url = [breakfasts_dic objectForKey:@"url"];
                    breakfastsInfo.date = [dic objectForKey:@"date"];
                    breakfastsInfo.type = DinnerInfoType_breakfasts;
                    [self.breakfasts_arr addObject:breakfastsInfo];
                    [breakfast_str appendString:breakfastsInfo.name];
                }
                
                NSArray* dinner_arr = [dic objectForKey:@"dinners"];
                
                NSMutableString* dinner_str = [NSMutableString string];
                for (NSDictionary* dinner_dic in dinner_arr) {
                    DinnerInfo* dinnerInfo = [[DinnerInfo alloc] init];
                    dinnerInfo.desc = [dinner_dic objectForKey:@"description"];
                    dinnerInfo.foodId = ((NSNumber*)[dinner_dic objectForKey:@"id"]).integerValue;
                    dinnerInfo.name = [dinner_dic objectForKey:@"name"];
                    dinnerInfo.url = [dinner_dic objectForKey:@"url"];
                    dinnerInfo.date = [dic objectForKey:@"date"];
                    dinnerInfo.type = DinnerInfoType_dinners;
                    [self.dinner_arr addObject:dinnerInfo];
                    [dinner_str appendString:dinnerInfo.name];
                }
                
                NSArray* lunch_arr = [dic objectForKey:@"lunches"];
                
                NSMutableString* lunch_str = [NSMutableString string];
                for (NSDictionary* lunch_dic in lunch_arr) {
                    DinnerInfo* lunchInfo = [[DinnerInfo alloc] init];
                    lunchInfo.desc = [lunch_dic objectForKey:@"description"];
                    lunchInfo.foodId = ((NSNumber*)[lunch_dic objectForKey:@"id"]).integerValue;
                    lunchInfo.name = [lunch_dic objectForKey:@"name"];
                    lunchInfo.url = [lunch_dic objectForKey:@"url"];
                    lunchInfo.date = [dic objectForKey:@"date"];
                    lunchInfo.type = DinnerInfoType_lunches;
                    [self.lunch_arr addObject:lunchInfo];
                    [lunch_str appendString:lunchInfo.name];
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
                
                self.breakfastLabel.text = [NSString stringWithFormat:@"早餐：%@",breakfast_str];
                self.lunchLabel.text = [NSString stringWithFormat:@"午餐：%@",lunch_str];
                self.dinnerLabel.text = [NSString stringWithFormat:@"晚餐：%@",dinner_str];
            }
        }
        else
        {
            [YLToast showWithText:@"暂无该周菜式数据"];
        }
        
//        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
        
//        NSLog(@"URL_GET_CUISINE failed, %@",error);
        
    }];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.dayPicker removeObserver:self forKeyPath:@"selectedDate"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateSingleDinnerBtnsState:(UIButton*) button byMeal:(ThreeMeals*)meal
{
    button.enabled = NO;
    if (meal.state != ThreeMealsState_booked_noChange) {
        button.enabled = YES;
    }
}

-(void)updateSingleDinnerBtnsState:(UIButton*) button {
    
    UIColor* color = nil;
    
    button.selected = !button.selected;
    if (button.isSelected) {
        color = [UIColor blueColor];
        button.selected = YES;
    }
    else {
        color = [UIColor whiteColor];
        button.selected = NO;
        UIColor* color = [UIColor blackColor];
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    
    button.backgroundColor = color;
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
//    [self updateAllDinnerBtnsState];
    
    self.selecetedDate = change[NSKeyValueChangeNewKey];
    
    NSString* date_str = [YLCommon date2String:self.selecetedDate];
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
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_RESERVE_INFO,date_str];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray* result = (NSArray*)responseObject;
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

- (IBAction)moreBtnClick:(id)sender {
    self.voteBtn.hidden = !self.voteBtn.hidden;
    self.recordBtn.hidden = !self.recordBtn.hidden;
}

// 全部预约
- (IBAction)orderBtnClick:(id)sender {
    UIColor* color = nil;
    
    self.orderAllBtn.selected = !self.orderAllBtn.selected;
    if (self.orderAllBtn.isSelected) {
        color = [UIColor blueColor];
        self.dinnerBtn.selected = self.lunchBtn.selected = self.breakfastBtn.selected = YES;
    }
    else {
        color = [UIColor whiteColor];
        self.dinnerBtn.selected = self.lunchBtn.selected = self.breakfastBtn.selected = NO;
    }
    self.dinnerBtn.backgroundColor = self.lunchBtn.backgroundColor = self.breakfastBtn.backgroundColor = color;
    
}

- (IBAction)breakfastBtnClick:(id)sender {
    [self updateSingleDinnerBtnsState:sender];
}

- (IBAction)lunchBtnClick:(id)sender {
    [self updateSingleDinnerBtnsState:sender];
}

- (IBAction)dinnerBtnClick:(id)sender {
    [self updateSingleDinnerBtnsState:sender];
}
@end
