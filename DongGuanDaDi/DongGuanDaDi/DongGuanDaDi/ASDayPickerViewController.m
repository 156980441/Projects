//
//  ASDayPickerViewController.m
//  DongGuanDaDi
//
//  Created by 赵雪莹 on 16/7/23.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "ASDayPickerViewController.h"
#import "ASDayPicker.h"

@interface ASDayPickerViewController ()

@end

@implementation ASDayPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Allow picking from today until 4 weeks from now
    NSDateComponents *weeks = [[NSDateComponents alloc] init];
    weeks.week = 4;
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:weeks toDate:[NSDate date] options:0];
    ASDayPicker* dayPicker = (ASDayPicker*)self.view;
    [dayPicker setStartDate:[NSDate date] endDate:endDate];
    [dayPicker addObserver:self forKeyPath:@"selectedDate" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSDate *day = change[NSKeyValueChangeNewKey];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
