//
//  AddressListTableViewController.h
//  DongGuanDaDi
//
//  Created by 赵雪莹 on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *staffDataSources;
@property (strong,nonatomic) NSMutableArray *filteredStaffArray;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end
