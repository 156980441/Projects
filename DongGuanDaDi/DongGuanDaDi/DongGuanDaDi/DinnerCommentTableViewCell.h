//
//  DinnerCommentTableViewCell.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/7/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DinnerCommentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *autherNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UIButton *starBtn1;
@property (strong, nonatomic) IBOutlet UIButton *starBtn2;
@property (strong, nonatomic) IBOutlet UIButton *starBtn3;
@property (strong, nonatomic) IBOutlet UIButton *starBtn4;
@property (strong, nonatomic) IBOutlet UIButton *starBtn5;

@end
