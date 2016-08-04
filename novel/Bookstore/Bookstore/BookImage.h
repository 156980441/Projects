//
//  BookImage.h
//  read
//
//  Created by 3g on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"
@protocol BookImageDelegate;

@interface BookImage : UIButton
{
    BookModel* bookModel;
    UIImageView* _bookImage;
}
@property(nonatomic,retain)UIImageView* bookImage;
@property(strong,nonatomic)id<BookImageDelegate> delegate;
- (id)initWithFrame:(CGRect)frame imageName:(NSString *)imagename;
@end

@protocol BookImageDelegate <NSObject>

- (void) bookImageDidClicked:(BookImage *)bookImage;

@end
