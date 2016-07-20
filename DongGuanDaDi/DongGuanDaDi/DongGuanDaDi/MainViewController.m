//
//  MainViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 7/20/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "MainViewController.h"

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
    
}
@end
