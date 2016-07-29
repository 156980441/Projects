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

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
}


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
            [self performSegueWithIdentifier:@"dinner" sender:self];
        }
        else if (1 == indexPath.row)
        {
            [self performSegueWithIdentifier:@"cars" sender:self];
        }
        else if (2 == indexPath.row)
        {
            [self performSegueWithIdentifier:@"cars" sender:self];
        }
        else if (3 == indexPath.row)
        {
            [self performSegueWithIdentifier:@"cars" sender:self];
        }
        else if (4 == indexPath.row)
        {
            vc = [[CarsTableViewController alloc] init];
        }
        else if (5 == indexPath.row)
        {
            [self performSegueWithIdentifier:@"personal" sender:self];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (IBAction)logout:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否注销" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
