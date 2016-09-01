//
//  Common.h
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/8/7.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLCommon : NSObject

// yyyy-MM-dd
+(NSString*)date2String:(NSDate*)date;
+(NSDate*)string2Date:(NSString*)string;

+(NSString*)time2String:(NSDate*)date;
+(NSDate*)string2time:(NSString*)string;

+(NSArray *)getFirstAndLastDayOfThisWeek;

@end
