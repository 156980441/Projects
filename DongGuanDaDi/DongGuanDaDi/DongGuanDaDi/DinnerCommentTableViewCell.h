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
@property (strong, nonatomic) IBOutlet UIImageView *commentImageView;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end
