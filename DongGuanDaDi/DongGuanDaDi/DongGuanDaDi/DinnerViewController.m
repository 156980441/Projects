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
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSDateComponents *weeks = [[NSDateComponents alloc] init];
    weeks.weekOfMonth = 4;
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:weeks toDate:[NSDate date] options:0];
    [self.dayPicker setStartDate:[NSDate date] endDate:endDate];
    [self.dayPicker addObserver:self forKeyPath:@"selectedDate" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"/DongGuan/",@"referer", nil];
    NSArray* dates = [YLCommon getFirstAndLastDayOfThisWeek];
    NSString* url = [NSString stringWithFormat:@"%@beginDateString=%@&endDateString=%@",URL_GET_CUISINE,[YLCommon date2String:[dates objectAtIndex:0]],[YLCommon date2String:[dates objectAtIndex:1]]];
    
    [[AFHTTPSessionManager manager] GET:url
                             parameters:dic
                                success:^(NSURLSessionDataTask *task, id responseObject) {
        
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
        NSLog(@"Login failed, %@",error);
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    self.selecetedDate = change[NSKeyValueChangeNewKey];
    NSArray* arr = [self.dateAndDinners objectForKey:[YLCommon date2String:self.selecetedDate]];
    NSDictionary* dic = [arr objectAtIndex:0];
    NSArray* breakfast_arr = [dic objectForKey:@"早餐"];
    NSMutableString* breakfast_str = [NSMutableString string];
    for (DinnerInfo* info in breakfast_arr) {
        [breakfast_str appendString:info.name];
    }
    self.breakfastLabel.text = [NSString stringWithFormat:@"早餐：%@",breakfast_str];
    dic = [arr objectAtIndex:1];
    breakfast_arr = [dic objectForKey:@"午餐"];
    breakfast_str = [NSMutableString string];
    for (DinnerInfo* info in breakfast_arr) {
        [breakfast_str appendString:info.name];
    }
    self.lunchLabel.text = [NSString stringWithFormat:@"午餐：%@",breakfast_str];
    dic = [arr objectAtIndex:2];
    breakfast_arr = [dic objectForKey:@"晚餐"];
    breakfast_str = [NSMutableString string];
    for (DinnerInfo* info in breakfast_arr) {
        [breakfast_str appendString:info.name];
    }
    self.dinnerLabel.text = [NSString stringWithFormat:@"晚餐：%@",breakfast_str];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController* vc = [segue destinationViewController];
    if ([vc isKindOfClass:[MemuDetailViewController class]]) {
        MemuDetailViewController* carAppointVc = (MemuDetailViewController*)vc;
        carAppointVc.dataSource = [self.dateAndDinners objectForKey:[YLCommon date2String:self.selecetedDate]];
    }
}

- (IBAction)moreBtnClick:(id)sender {
    self.voteBtn.hidden = !self.voteBtn.hidden;
    self.recordBtn.hidden = !self.recordBtn.hidden;
}
@end
