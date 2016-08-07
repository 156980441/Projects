//
//  Common.m
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/8/7.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "Common.h"

@implementation Common
+(NSString*)date2String:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
@end
