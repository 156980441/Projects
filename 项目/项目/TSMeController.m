//
//  TSMeController.m
//  项目
//
//  Created by 唐硕 on 16/2/19.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSMeController.h"
#import "TSMeTopCell.h"

@interface TSMeController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *NavView;

@end

@implementation TSMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self initView];
    
    [self initScrollView];
    
    [self setNav];
    
  
    
}

-(void)setNav {
    self.NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    self.NavView.backgroundColor = [UIColor whiteColor];
    self.NavView.backgroundColor = [self.NavView.backgroundColor colorWithAlphaComponent:0];
    [self.view addSubview:self.NavView];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, screen_width, 40)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"我的";
    lab.textColor = [UIColor blackColor];
    [self.NavView addSubview:lab];
    
    }

-(void)initScrollView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -50, screen_width, 50)];
    self.scrollView.backgroundColor = navigationBarColor;
    [self.scrollView setContentOffset:CGPointMake(screen_width, 0)];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.tableView addSubview:self.scrollView];
    
}
-(void)initView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height+40) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    //self.tableView.tableHeaderView = self.scrollView;
    [self.view addSubview:self.tableView];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        CGFloat offsetY = self.tableView.contentOffset.y;
        if (offsetY <= 0 && offsetY >= -100) {
            self.scrollView.frame = CGRectMake(0, -50 + offsetY / 2, screen_width, 220 - offsetY / 2);
            self.NavView.backgroundColor = [self.NavView.backgroundColor colorWithAlphaComponent:0];
            
        }
        else if (offsetY < -100) {
            [self.tableView setContentOffset:CGPointMake(0, -100)];
        }
        else if (offsetY > 0) {
            
            self.NavView.backgroundColor = [self.NavView.backgroundColor colorWithAlphaComponent:offsetY / 120];
            self.scrollView.frame = CGRectMake(0, -50 + offsetY / 2, screen_width, 220 - offsetY / 2);

            }
    }
}


#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 50;
    }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return 180;
    }else {
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *CEllID = @"tangshuo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CEllID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CEllID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}
@end
