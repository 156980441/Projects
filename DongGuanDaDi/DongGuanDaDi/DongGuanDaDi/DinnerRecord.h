//
//  DinerRecord.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/1/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DinnerRecord : NSObject
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) NSInteger extendUserNum;
@property (nonatomic, assign) BOOL eated;
@property (nonatomic, assign) NSInteger recordId;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, assign) BOOL predetermined;
@end
