//
//  TSBusinessController.m
//  项目
//
//  Created by 唐硕 on 16/2/19.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSBusinessController.h"

@interface TSBusinessController ()
{
    NSInteger _type; /**< segment */
}
@end

@implementation TSBusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255  blue:244.0/255  alpha:1];
    
    [self initdata];
    
    [self setupNav];
}

-(void)initdata {
    _type = 0;
}
-(void)setupNav {
    NSArray *segmentArray = [[NSArray alloc] initWithObjects:@"减肥推荐",@"减肥分类", nil];
    UISegmentedControl *segmentCtr = [[UISegmentedControl alloc] initWithItems:segmentArray];
    segmentCtr.frame = CGRectMake(0, 0, 160, 30);
    segmentCtr.selectedSegmentIndex = 0;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName,navigationBarColor, NSForegroundColorAttributeName, nil];
    [segmentCtr setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [segmentCtr setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    segmentCtr.tintColor = RGB(46, 158, 138);
    [segmentCtr addTarget:self action:@selector(OnTapSegmentCtr:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentCtr;
    
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(0, 0, 40, 35);
    //
    leftbtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [leftbtn setImage:[UIImage imageNamed:@"icon_homepage_map"] forState:UIControlStateNormal];
    //[leftbtn setBackgroundImage:[UIImage imageNamed:@"icon_homepage_map"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 25, 25);
    [right setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}

//响应事件
-(void)OnTapSegmentCtr:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    if (index == 0) {
        _type = 0;
    }else{
        _type = 1;
    }
}
@end
