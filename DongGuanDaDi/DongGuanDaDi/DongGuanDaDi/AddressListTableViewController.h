//
//  AddressListTableViewController.h
//  DongGuanDaDi
//
//  Created by fanyl on 16/7/22.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableDictionary *staffDataSources;
@property (strong,nonatomic) NSMutableArray *orginDataSource;
@property (strong,nonatomic) NSMutableArray *filteredStaffArray;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end
