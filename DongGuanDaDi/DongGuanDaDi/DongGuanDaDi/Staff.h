//
//  Staff.h
//  DongGuanDaDi
//
//  Created by fanyl on 16/7/30.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Staff : NSObject
@property(nonatomic,strong) NSString* identifier;
@property(nonatomic,strong) NSString* name;
@property(nonatomic,assign) long long  phone;
@property (nonatomic, strong) NSString* wechat;
@property(nonatomic,assign) long long qq;
@property (nonatomic, strong) NSString *officeName;
@property (nonatomic, strong) NSString *pass;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSArray *authList;
@end
