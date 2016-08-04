//
//  RootViewController.h
//  Bookstore
//
//  Created by xue on 13-4-26.
//  Copyright (c) 2013年 xuejiannan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookImage.h"
@interface RootViewController : UIViewController<UISearchBarDelegate, BookImageDelegate>
{
    UIScrollView *scrollView;
    NSString* _search;
    UISearchBar *_searchBar;
}

@end
