//
//  TSTabBarController.m
//  项目
//
//  Created by 唐硕 on 16/2/19.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSTabBarController.h"
#import "TSHomeController.h"
#import "TSBusinessController.h"
#import "TSMeController.h"
#import "TSMoreController.h"

@interface TSTabBarController ()

@end

@implementation TSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self initTabbarItem];
    
}

-(void)initTabbarItem{
    
    TSHomeController *home = [[TSHomeController alloc]init];
    [self controller:home title:@"首页" image:@"icon_tabbar_homepage@2x" selectedimage:@"icon_tabbar_homepage_selected@2x"];
    
    TSBusinessController *business = [[TSBusinessController alloc]init];
    [self controller:business title:@"商家" image:@"icon_tabbar_merchant_normal@2x" selectedimage:@"icon_tabbar_merchant_selected@2x"];
    
    TSMeController *me = [[TSMeController alloc]init];
    [self controller:me title:@"我的" image:@"icon_tabbar_mine@2x" selectedimage:@"icon_tabbar_mine_selected@2x"];
    
    TSMoreController *more = [[TSMoreController alloc]init];
    [self controller:more title:@"更多" image:@"icon_tabbar_misc@2x" selectedimage:@"icon_tabbar_misc_selected@2x"];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:navigationBarColor,UITextAttributeTextColor, nil] forState:UIControlStateSelected];
}


//初始化一个zi控制器
-(void)controller:(UIViewController *)TS title:(NSString *)title image:(NSString *)image selectedimage:(NSString *)selectedimage
{
    TS.tabBarItem.title = title;
    TS.tabBarItem.image = [UIImage imageNamed:image];
    TS.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:TS];
    [self addChildViewController:nav];
}
@end
