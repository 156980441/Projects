//
//  MemuDetailViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "MemuDetailViewController.h"

@interface MemuDetailViewController ()
@property (nonatomic, strong) NSMutableDictionary *dataSource;
@end

@implementation MemuDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray* breakfast = [NSMutableArray array];
    [breakfast addObject:@"豆浆"];
    [breakfast addObject:@"油条"];
    [breakfast addObject:@"胡辣汤"];
    [breakfast addObject:@"豆汁"];
    NSMutableArray* lunch = [NSMutableArray array];
    [lunch addObject:@"炸酱面"];
    [lunch addObject:@"焦圈"];
    [lunch addObject:@"炒肝"];
    [lunch addObject:@"庆丰包子铺"];
    NSMutableArray* dinner = [NSMutableArray array];
    [dinner addObject:@"俏江南"];
    [dinner addObject:@"呷哺呷哺"];
    self.dataSource = [NSMutableDictionary dictionary];
    [self.dataSource setObject:breakfast forKey:@"早餐"];
    [self.dataSource setObject:lunch forKey:@"午餐"];
    [self.dataSource setObject:dinner forKey:@"晚餐"];
    
}

#pragma mark - Table view data source

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section    // fixed font style. use custom view (UILabel) if you want something different
{
    return [self.dataSource.allKeys objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray* arr = [self.dataSource.allValues objectAtIndex:section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MenuDetail"];
    NSArray* arr = [self.dataSource objectForKey:[self.dataSource.allKeys objectAtIndex:indexPath.section]];
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    return cell;
}
@end
