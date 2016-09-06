//
//  CommentView.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/7/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CommentView.h"
@interface CommentView ()
@property (nonatomic, assign) NSInteger score;
@end
@implementation CommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)starBtnClick:(id)sender {
    UIButton* btn = (UIButton*)sender;
    self.score = btn.tag;
    if (btn.tag == 4) {
        
    }
}

- (IBAction)submitBtnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentView:stars:contents:)]) {
        [self.delegate commentView:self stars:self.score contents:self.contentsTxtView.text];
    }
    
    [self dismiss];
}
-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.center = window.center;
    [window addSubview:self];
}
-(void)dismiss
{
    [self removeFromSuperview];
}
@end
