//
//  MainViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/20/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewCell.h"
#import "DinnerViewController.h"
#import "CarsTableViewController.h"
#import "AddressListTableViewController.h"
#import "PersonalTableViewController.h"

@implementation MainViewController

#pragma mark -- UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    }
    else if (1 == section)
    {
        return 1;
    }
    else if (2 == section)
    {
        return 6;
    }
    else
    {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainViewCell" forIndexPath:indexPath];
    NSInteger section = indexPath.section;
    if (0 == section) {
        cell.backgroundColor = [UIColor redColor];
    }
    else if (1 == section)
    {
        cell.backgroundColor = [UIColor yellowColor];
    }
    else if (2 == section)
    {
        if (0 == indexPath.row)
        {
            cell.title.text = @"用餐";
        }
        else if (1 == indexPath.row)
        {
            cell.title.text = @"公车";
        }
        else if (2 == indexPath.row)
        {
            cell.title.text = @"通讯录";
        }
        else if (3 == indexPath.row)
        {
            cell.title.text = @"任务";
        }
        else if (4 == indexPath.row)
        {
            cell.title.text = @"监控";
        }
        else if (5 == indexPath.row)
        {
            cell.title.text = @"个人";
        }
        cell.backgroundColor = [UIColor blueColor];
    }
    return cell;
}
#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    UIViewController* vc;
    if (0 == section) {
        
    }
    else if (1 == section)
    {
        
    }
    else if (2 == section)
    {
        if (0 == indexPath.row)
        {
            vc= [[DinnerViewController alloc] init];
        }
        else if (1 == indexPath.row)
        {
            vc = [[CarsTableViewController alloc] init];
        }
        else if (2 == indexPath.row)
        {
            vc = [[AddressListTableViewController alloc] init];
        }
        else if (3 == indexPath.row)
        {
            vc = [[CarsTableViewController alloc] init];
        }
        else if (4 == indexPath.row)
        {
            vc = [[CarsTableViewController alloc] init];
        }
        else if (5 == indexPath.row)
        {
            vc = [[PersonalTableViewController alloc] init];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
