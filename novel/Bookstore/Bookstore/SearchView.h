//
//  SearchView.h
//  Bookstore
//
//  Created by xue on 13-5-4.
//  Copyright (c) 2013年 xuejiannan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "BookModel.h"

@interface SearchView : UIViewController<NSURLConnectionDataDelegate, ASIHTTPRequestDelegate, UITableViewDelegate, UITableViewDataSource>{
    UITableView* _tableView;
    NSString* _search;
    
    NSMutableArray* bookArr;
    BookModel* model;
    NSURLConnection* Myconnection;
    
    NSMutableData* MyJSONData;
    
    int starIndex;
    int maxResult;
}
@property (nonatomic, strong) NSString *search;
@property (nonatomic, strong) UITableView *tableView;

@end
