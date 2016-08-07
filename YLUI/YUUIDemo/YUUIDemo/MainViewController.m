//
//  MainViewController.m
//  YUUIDemo
//
//  Created by 我叫不紧张 on 16/8/7.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "MainViewController.h"
#import "MainCell.h"

#import <YLUI/YLToast.h>
#import <YLUI/YLDatePicker.h>

@implementation MainViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = @[@"DatePicker",@"Toast"];
    self.collectionView.backgroundColor = [UIColor grayColor];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MAINCELL" forIndexPath:indexPath];
    cell.imageView.backgroundColor = [UIColor whiteColor];
    NSString* str = [self.dataSource objectAtIndex:indexPath.row];
    cell.title.text = str;
    return cell;
}
#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row) {
        YLDatePicker* picker = [[YLDatePicker alloc] init];
        CGRect rect = CGRectMake(0, 0, 300, 250);
        CGPoint origin = CGPointMake(self.view.center.x - rect.size.width / 2, self.view.center.y - rect.size.height / 2);
        [picker showInView:self.view withFrame:CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height) andDatePickerMode:UIDatePickerModeDate];;
    }
    else if (1 == indexPath.row)
    {
        [YLToast showWithText:@"Toast Test"];
    }
}
@end
