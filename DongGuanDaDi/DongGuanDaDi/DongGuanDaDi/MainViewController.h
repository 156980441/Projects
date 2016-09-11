//
//  MainViewController.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/20/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Staff;

@interface MainViewController : UICollectionViewController

@property (nonatomic, strong) Staff *staff;

- (IBAction)logout:(id)sender;

@end
