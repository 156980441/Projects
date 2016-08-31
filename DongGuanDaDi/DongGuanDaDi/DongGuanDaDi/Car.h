//
//  Car.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/29/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum DGCarState
{
    DGCarDepart,
    DGCarAppointment,
    DGCarNotAppointment
} DGCarState;

@interface Car : NSObject
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, assign) NSInteger carId;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, strong) NSString *purpose;
@property (nonatomic, assign) NSInteger seating;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *driver;
@property (nonatomic, strong) NSString *endtime;
@property (nonatomic, assign) NSInteger infoId;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, assign) NSInteger peopleNum;
@property (nonatomic, strong) NSString *realStartTime;
@property (nonatomic, strong) NSString *realEndTime;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, assign) DGCarState state;
@end
