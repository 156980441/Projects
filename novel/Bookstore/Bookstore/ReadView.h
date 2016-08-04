//
//  ReadView.h
//  read
//
//  Created by 3g on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadView : UIViewController<UITextViewDelegate, UIGestureRecognizerDelegate>{
    UITextView *textView;
    int currentPage;
    int allPage;
}
@property (nonatomic, strong) NSString *str;
@end
