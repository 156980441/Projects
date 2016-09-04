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

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@interface MainViewController ()

@property (nonatomic, strong) NSArray* dataSources;

@end

@implementation MainViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.dataSources = @[@"用餐",@"公车",@"通讯录",@"任务",@"监控",@"个人"];
}


#pragma mark -- UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    }
    else if (1 == section)
    {
        return self.dataSources.count;
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
        cell.title.text = @"Welcome";
    }
    else if (1 == section)
    {
        cell.title.text = [self.dataSources objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor greenColor];
    }
    cell.title.backgroundColor = [UIColor blueColor];
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
            [self performSegueWithIdentifier:@"addressList" sender:self];
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
    }
}

#pragma mark -
#pragma mark UICollectionViewFlowLayoutDelegate

//这里可以通过storyboard来做吗，即不同的cell不同的大小。
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    NSInteger section = indexPath.section;
    if (0 == section) {
        size = CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height / 2.2);
    }
    else if (1 == section)
    {
        size = CGSizeMake(collectionView.frame.size.width / 3, collectionView.frame.size.height / 2.2 / 2);
    }
    return size;
}

- (IBAction)logout:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否注销" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
        [manager GET:URL_LOGOUT parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"Logout success, %@",responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Logout failed, %@",error);
        }];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
