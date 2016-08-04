//
//  MemuDetailViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "MemuDetailViewController.h"
#import "Food.h"

@interface MemuDetailViewController ()
@property (nonatomic, strong) NSMutableDictionary *dataSource;
@end

@implementation MemuDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray* breakfast = [NSMutableArray array];
    Food* food = [[Food alloc] init];
    food.name = @"豆浆";
    food.image = nil;
    food.describe = @"一种种子榨汁而成";
    [breakfast addObject:food];
    Food* food2 = [[Food alloc] init];
    food2.name = @"油条";
    food2.image = nil;
    food2.describe = @"用面放入锅中油炸";
    [breakfast addObject:food2];
    NSMutableArray* lunch = [NSMutableArray array];
    Food* food3 = [[Food alloc] init];
    food3.name = @"炸酱面";
    food3.image = nil;
    food3.describe = @"面，豆芽，萝卜，豆瓣酱卤制而成";
    [lunch addObject:food3];
    Food* food4 = [[Food alloc] init];
    food4.name = @"庆丰包子铺";
    food4.image = nil;
    food4.describe = @"从事包子，粥，饺子文明";
    [lunch addObject:food4];
    NSMutableArray* dinner = [NSMutableArray array];
    Food* food5 = [[Food alloc] init];
    food5.name = @"俏江南";
    food5.image = nil;
    food5.describe = @"某著名演员开的";
    [dinner addObject:food5];
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
    NSArray* arr = [self.dataSource.allValues objectAtIndex:indexPath.section];
    Food* food = [arr objectAtIndex:indexPath.row];
    cell.textLabel.text = food.name;
    cell.detailTextLabel.text = food.describe;
    cell.imageView.image = food.image;
    return cell;
}
@end
