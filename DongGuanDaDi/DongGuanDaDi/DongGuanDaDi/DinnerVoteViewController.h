//
//  DinnerVoteViewController.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CanteenVoteInfo;
@interface DinnerVoteViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIScrollView *chatView;
@property (strong, nonatomic) IBOutlet UILabel *voteStateLabel;
@property (nonatomic, strong) CanteenVoteInfo *canteenVoteInfo;
@property (strong, nonatomic) IBOutlet UITableView *dinerInfoTableView;

@end
