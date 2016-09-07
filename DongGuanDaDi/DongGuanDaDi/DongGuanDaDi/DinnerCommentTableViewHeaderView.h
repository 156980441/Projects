//
//  DinnerCommentTableViewHeaderView.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/7/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DinnerCommentTableViewHeaderView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)commentBtnClick:(id)sender;
- (IBAction)dateBtnClick:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *dinnerNameLabel;

@property (copy, nonatomic) void (^commentBtnClick)(NSInteger stars, NSString* content);
@property (copy, nonatomic) void (^dateBtnClick)(NSDate* date);

@end
