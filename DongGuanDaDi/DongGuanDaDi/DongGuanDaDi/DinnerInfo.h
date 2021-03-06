//
//  Food.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum DinnerInfoType
{
    DinnerInfoType_breakfasts,
    DinnerInfoType_lunches,
    DinnerInfoType_dinners
} DinnerInfoType;

@interface DinnerInfo : NSObject
@property (nonatomic, assign) DinnerInfoType type;
@property (nonatomic, assign) NSInteger foodId;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* date;

@property (nonatomic, strong) NSString* foodVote;
@property (nonatomic, strong) NSString* profile;
@property (nonatomic, assign) NSInteger voteNumber;

@property (nonatomic, assign) bool isSelected;// 用于投票
@end
