//
//  AbstractView.h
//  Bookstore
//
//  Created by xue on 13-5-6.
//  Copyright (c) 2013年 xuejiannan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"
#import "RatingView.h"

@interface AbstractView : UIViewController<NSXMLParserDelegate>
{
    UIImageView *_iconImage;
    BookModel *_model;
}

@property (nonatomic, strong)UIImageView *icnoImage;
@property (nonatomic, strong)BookModel *model;

@end
