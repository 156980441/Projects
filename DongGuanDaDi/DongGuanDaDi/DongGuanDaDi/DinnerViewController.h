//
//  DinnerViewController.h
//  DongGuanDaDi
//
//  Created by fanyl on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDayPicker.h"
#import "MenuView.h"

@interface DinnerViewController : UIViewController
@property (strong, nonatomic) IBOutlet ASDayPicker *dayPicker;
@property (strong, nonatomic) IBOutlet MenuView *menu;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;
@property (strong, nonatomic) IBOutlet UIButton *voteBtn;
@property (strong, nonatomic) IBOutlet UILabel *breakfastLabel;
@property (strong, nonatomic) IBOutlet UILabel *lunchLabel;
@property (strong, nonatomic) IBOutlet UILabel *dinnerLabel;
@property (strong, nonatomic) IBOutlet UILabel *selectedDateLabel;
@property (strong, nonatomic) IBOutlet UIButton *orderAllBtn;
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;

- (IBAction)moreBtnClick:(id)sender;
- (IBAction)orderBtnClick:(id)sender;
- (IBAction)selecteFoodBtnClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *submitBtnClick;
- (IBAction)submitBtnClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *dinnerBtn;
@property (strong, nonatomic) IBOutlet UIButton *lunchBtn;
@property (strong, nonatomic) IBOutlet UIButton *breakfastBtn;

@end
