//
//  DinnerViewController.m
//  DongGuanDaDi
//
//  Created by 赵雪莹 on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "DinnerViewController.h"
#import "ASDayPickerViewController.h"

@interface DinnerViewController ()

@property(nonatomic,strong) ASDayPickerViewController* dayPickerVc;

@end

@implementation DinnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dayPickerVc = [[ASDayPickerViewController alloc] init];
    self.dayPickerVc.view.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:self.dayPickerVc.view];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
