//
//  DinnerCommentInfo.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/7/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DinnerCommentInfo : NSObject
@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *authName;
@property (nonatomic, assign) NSInteger score;
@end
