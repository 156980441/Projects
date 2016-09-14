//
//  DinnerVoteViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "DinnerVoteViewController.h"
#import "CanteenVoteInfo.h"
#import "DinnerInfo.h"

#import "YLCommon.h"
#import "YLToast.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

#import "EColumnChart.h"
#import "EColumnDataModel.h"
#import "EColumnChartLabel.h"
#import "EFloatBox.h"
#import "EColor.h"

#include <stdlib.h>

@interface DinnerVoteViewController () <EColumnChartDelegate, EColumnChartDataSource>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) EFloatBox *eFloatBox;

@property (strong, nonatomic) EColumnChart *eColumnChart;
@property (nonatomic, strong) EColumn *eColumnSelected;
@property (nonatomic, strong) UIColor *tempColor;

@end

@implementation DinnerVoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"饭菜投票";
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    [manager GET:URL_FOOD_VOTE parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary* result = (NSDictionary*)responseObject;
        CanteenVoteInfo* info = [[CanteenVoteInfo alloc] init];
        info.startDate = [result objectForKey:@"begin_date"];
        info.endDate = [result objectForKey:@"end_date"];
        NSArray* list = (NSArray*)[result objectForKey:@"food_list"];
        NSMutableArray* temp = [NSMutableArray array];
        for (NSDictionary* food in list) {
            DinnerInfo* dinnerInfo = [[DinnerInfo alloc] init];
            dinnerInfo.foodId = ((NSNumber*)[food objectForKey:@"id"]).integerValue;
            dinnerInfo.voteNumber = ((NSNumber*)[food objectForKey:@"vote_number"]).integerValue;
            dinnerInfo.foodVote = [food objectForKey:@"foodVote"];
            dinnerInfo.name = [food objectForKey:@"food_name"];
            dinnerInfo.profile = [food objectForKey:@"profile"];
            [temp addObject:dinnerInfo];
        }
        info.foodList = [temp copy];
        info.state = (CanteenVoteState)((NSNumber*)[result objectForKey:@"state"]).integerValue;
        info.voteId = ((NSNumber*)[result objectForKey:@"vote_id"]).integerValue;
        self.canteenVoteInfo = info;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
    }];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < self.canteenVoteInfo.foodList.count; i++)
    {
        DinnerInfo* dinner = [self.canteenVoteInfo.foodList objectAtIndex:i];
        EColumnDataModel *eColumnDataModel = [[EColumnDataModel alloc] initWithLabel:dinner.name value:dinner.voteNumber index:i unit:@"票数"];
        [temp addObject:eColumnDataModel];
    }
    self.data = [NSArray arrayWithArray:temp];
    
    
    CGRect chatViewBounds = self.chatView.bounds;
    self.eColumnChart = [[EColumnChart alloc] initWithFrame:CGRectMake(chatViewBounds.origin.x + 50, chatViewBounds.origin.y, CGRectGetWidth(chatViewBounds) - 50, CGRectGetHeight(chatViewBounds))];
    [_eColumnChart setNormalColumnColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000]];
    [_eColumnChart setColumnsIndexStartFromLeft:YES];
    [_eColumnChart setShowHorizontalLabelsWithInteger:YES];
    [_eColumnChart setDelegate:self];
    [_eColumnChart setDataSource:self];
    
    
    [self.chatView addSubview:_eColumnChart];
    
    switch (self.canteenVoteInfo.state) {
        case CanteenVoteState_no_vote: {
            self.voteStateLabel.text = @"投票情况：暂无进行中的投票";
            break;
        }
        case CanteenVoteState_can_vote: {
            
            break;
        }
        case CanteenVoteState_have_voted: {
            self.voteStateLabel.text = @"投票情况：已投票";
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark- EColumnChartDataSource

- (NSInteger)numberOfColumnsInEColumnChart:(EColumnChart *)eColumnChart
{
    return self.data.count;
}

- (NSInteger)numberOfColumnsPresentedEveryTime:(EColumnChart *)eColumnChart
{
    return self.data.count;
}

- (EColumnDataModel *)highestValueEColumnChart:(EColumnChart *)eColumnChart
{
    EColumnDataModel *maxDataModel = nil;
    float maxValue = -FLT_MIN;
    for (EColumnDataModel *dataModel in self.data)
    {
        if (dataModel.value > maxValue)
        {
            maxValue = dataModel.value;
            maxDataModel = dataModel;
        }
    }
    return maxDataModel;
}

- (EColumnDataModel *)eColumnChart:(EColumnChart *)eColumnChart valueForIndex:(NSInteger)index
{
    if (index >= [_data count] || index < 0) return nil;
    return [_data objectAtIndex:index];
}

//- (UIColor *)colorForEColumn:(EColumn *)eColumn
//{
//    if (eColumn.eColumnDataModel.index < 5)
//    {
//        return [UIColor purpleColor];
//    }
//    else
//    {
//        return [UIColor redColor];
//    }
//
//}

#pragma -mark- EColumnChartDelegate
- (void)eColumnChart:(EColumnChart *)eColumnChart
     didSelectColumn:(EColumn *)eColumn
{
    
    if (_eColumnSelected)
    {
        _eColumnSelected.barColor = _tempColor;
    }
    _eColumnSelected = eColumn;
    _tempColor = eColumn.barColor;
    eColumn.barColor = [UIColor blackColor];
    
}

- (void)eColumnChart:(EColumnChart *)eColumnChart
fingerDidEnterColumn:(EColumn *)eColumn
{
    /**The EFloatBox here, is just to show an example of
     taking adventage of the event handling system of the Echart.
     You can do even better effects here, according to your needs.*/
    CGFloat eFloatBoxX = eColumn.frame.origin.x + eColumn.frame.size.width * 1.25;
    CGFloat eFloatBoxY = eColumn.frame.origin.y + eColumn.frame.size.height * (1-eColumn.grade);
    if (_eFloatBox)
    {
        [_eFloatBox removeFromSuperview];
        _eFloatBox.frame = CGRectMake(eFloatBoxX, eFloatBoxY, _eFloatBox.frame.size.width, _eFloatBox.frame.size.height);
        [_eFloatBox setValue:eColumn.eColumnDataModel.value];
        [eColumnChart addSubview:_eFloatBox];
    }
    else
    {
        _eFloatBox = [[EFloatBox alloc] initWithPosition:CGPointMake(eFloatBoxX, eFloatBoxY) value:eColumn.eColumnDataModel.value unit:@"票数" title:nil];
        _eFloatBox.alpha = 0.0;
        [eColumnChart addSubview:_eFloatBox];
        
    }
    eFloatBoxY -= (_eFloatBox.frame.size.height + eColumn.frame.size.width * 0.25);
    _eFloatBox.frame = CGRectMake(eFloatBoxX, eFloatBoxY, _eFloatBox.frame.size.width, _eFloatBox.frame.size.height);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        _eFloatBox.alpha = 1.0;
        
    } completion:^(BOOL finished) {
    }];
    
}

- (void)eColumnChart:(EColumnChart *)eColumnChart
fingerDidLeaveColumn:(EColumn *)eColumn
{
    
}

- (void)fingerDidLeaveEColumnChart:(EColumnChart *)eColumnChart
{
    if (_eFloatBox)
    {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            _eFloatBox.alpha = 0.0;
            _eFloatBox.frame = CGRectMake(_eFloatBox.frame.origin.x, _eFloatBox.frame.origin.y + _eFloatBox.frame.size.height, _eFloatBox.frame.size.width, _eFloatBox.frame.size.height);
        } completion:^(BOOL finished) {
            [_eFloatBox removeFromSuperview];
            _eFloatBox = nil;
        }];
        
    }
    
}

@end
