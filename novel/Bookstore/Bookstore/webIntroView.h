//
//  webIntroView.h
//  Bookstore
//
//  Created by xue on 13-5-8.
//  Copyright (c) 2013年 xuejiannan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"

@interface webIntroView : UIViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
    BookModel *_book;
}
@property(nonatomic, strong)UIWebView *webView;
@property(nonatomic, strong)BookModel *book;

@end
