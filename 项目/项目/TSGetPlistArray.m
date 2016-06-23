//
//  TSGetPlistArray.m
//  项目
//
//  Created by 唐硕 on 16/2/21.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSGetPlistArray.h"

@implementation TSGetPlistArray

+(NSArray *)ArrayWithString:(NSString *)string{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:string ofType:nil];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:plistPath];
    return array;
    
}




@end
