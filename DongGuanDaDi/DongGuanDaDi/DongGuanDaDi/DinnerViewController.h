//
//  DinnerViewController.h
//  DongGuanDaDi
//
//  Created by 赵雪莹 on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDayPicker.h"
#import "MenuView.h"

@interface DinnerViewController : UIViewController
@property (strong, nonatomic) IBOutlet ASDayPicker *dayPicker;
@property (strong, nonatomic) IBOutlet MenuView *menu;

@end
