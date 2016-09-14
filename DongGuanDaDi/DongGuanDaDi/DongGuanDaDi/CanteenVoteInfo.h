//
//  CanteenVoteInfo.h
//  DongGuanDaDi
//
//  Created by 赵雪莹 on 16/9/12.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum CanteenVoteState
{
    CanteenVoteState_no_vote,
    CanteenVoteState_can_vote,
    CanteenVoteState_have_voted
}CanteenVoteState;

@interface CanteenVoteInfo : NSObject
@property (nonatomic, assign) CanteenVoteState state;
@property (nonatomic, assign) NSInteger voteId;
@property (nonatomic, strong) NSString* startDate;
@property (nonatomic, strong) NSString* endDate;
@property (nonatomic, strong) NSArray* foodList;
@end
