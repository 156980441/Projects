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
#import "Staff.h"

#import "YLToast.h"
#import "YLCommon.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@interface MainViewController ()

@property (nonatomic, strong) NSArray* dataSources;
@property (nonatomic, strong) NSArray* imageDataSources;

@end

@implementation MainViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; //backBarButtonItem 颜色/文字修改
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.dataSources = @[@"用餐",@"公车",@"通讯录",@"任务",@"监控",@"个人"];
    self.imageDataSources = @[@"main_dinner",@"main_car",@"main_contact",@"main_office",@"main_map",@"main_person"];
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
        cell.title.text = [NSString stringWithFormat:@"%@,欢迎登陆本应用系统!",self.staff.name];
        cell.title.frame = CGRectMake(0, cell.frame.size.height - cell.title.frame.size.height, cell.frame.size.width, CGRectGetWidth(cell.title.frame));
        cell.title.backgroundColor = [UIColor colorWithRed:0.397 green:0.593 blue:1.000 alpha:1.000];
        [cell setNeedsLayout];
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_front"]];
        imageView.contentMode = UIViewContentModeCenter;
        cell.backgroundView = imageView;
        
        cell.appLabel.text = @"东莞大堤";
        cell.appLabel.font = [UIFont systemFontOfSize:45.0];// 来自Android client 数据
    }
    else if (1 == section)
    {
        cell.title.text = [self.dataSources objectAtIndex:indexPath.row];
        
        cell.appLabel.font = [UIFont systemFontOfSize:14.0];// 来自Android client 数据
        cell.appLabel.text = nil;

        cell.imageBtn.backgroundColor = [UIColor colorWithRed:0.397 green:0.593 blue:1.000 alpha:1.000];
        [cell.imageBtn setImage:[UIImage imageNamed:[self.imageDataSources objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
        
        cell.imageBtn.adjustsImageWhenDisabled = NO;
        
        cell.imageBtn.layer.cornerRadius = 25;
        [cell.imageBtn.layer setBorderWidth:1.0];
        [cell.imageBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    }
    
    cell.imageBtn.enabled = NO;
    
    
    return cell;
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
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
            [YLToast showWithText:@"暂不支持"];
        }
        else if (4 == indexPath.row)
        {
            [YLToast showWithText:@"暂不支持"];
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
            [YLToast showWithText:@"网络连接失败，请检查网络配置"];
        }];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
