//
//  ShowCarsTypesView.h
//  DongGuanDaDi
//
//  Created by fanyl on 16/8/31.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShowCarsTypesView : UIView
@property (strong, nonatomic) IBOutlet UIButton *notAppointmentBtn;
@property (strong, nonatomic) IBOutlet UIButton *departBtn;
@property (strong, nonatomic) IBOutlet UIButton *hasBackBtn;
@property (copy, nonatomic) void (^showCarsTypeBlock)(NSInteger index);
@end
