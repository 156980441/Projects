//
//  Staff.m
//  DongGuanDaDi
//
//  Created by fanyl on 16/7/30.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "Staff.h"

@implementation Staff

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.pass forKey:@"pass"];
}
-(id)initWithCoder:(NSCoder *)encoder
{
    self.pass = [encoder decodeObjectForKey:@"pass"];
    self.name = [encoder decodeObjectForKey:@"name"];
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    Staff* copy = [[[self class] allocWithZone:zone]init];
    copy.pass = [self.pass copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    copy.staffId = [self.staffId copyWithZone:zone];
//    copy.phone = [self.phone copyWithZone:zone];//怎么弄？
//    copy.qq = [self.qq copyWithZone:zone];//怎么弄？
//    copy.authList = [self.authList copyWithZone:zone];//怎么弄？
    copy.wechat = [self.wechat copyWithZone:zone];
    copy.officeName = [self.officeName copyWithZone:zone];
    copy.sex = [self.sex copyWithZone:zone];
    return copy;
}

@end
