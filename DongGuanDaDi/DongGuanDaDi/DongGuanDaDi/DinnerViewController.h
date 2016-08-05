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
- (IBAction)moreBtnClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;
@property (strong, nonatomic) IBOutlet UIButton *voteBtn;

@end
