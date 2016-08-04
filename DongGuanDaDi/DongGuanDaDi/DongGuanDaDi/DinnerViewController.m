//
//  DinnerViewController.m
//  DongGuanDaDi
//
//  Created by 赵雪莹 on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "DinnerViewController.h"

@interface DinnerViewController ()

@end

@implementation DinnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDateComponents *weeks = [[NSDateComponents alloc] init];
    weeks.weekOfMonth = 4;
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:weeks toDate:[NSDate date] options:0];
    [self.dayPicker setStartDate:[NSDate date] endDate:endDate];
    [self.dayPicker addObserver:self forKeyPath:@"selectedDate" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    NSDate *day = change[NSKeyValueChangeNewKey];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)moreBtnClick:(id)sender {
    self.voteBtn.hidden = !self.voteBtn.hidden;
    self.recordBtn.hidden = !self.recordBtn.hidden;
}
@end
