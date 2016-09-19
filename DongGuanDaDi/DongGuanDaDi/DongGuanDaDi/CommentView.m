//
//  CommentView.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/7/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "CommentView.h"
@interface CommentView () <UITextViewDelegate>
@property (nonatomic, assign) NSInteger score;
@end
@implementation CommentView

- (void)awakeFromNib
{
    self.starBtn1.tag = 1;
    self.starBtn2.tag = 2;
    self.starBtn3.tag = 3;
    self.starBtn4.tag = 4;
    self.starBtn5.tag = 5;
    
    self.contentsTxtView.delegate = self;
    self.contentsTxtView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    self.contentsTxtView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.contentsTxtView.scrollEnabled = YES;//是否可以拖动
    self.contentsTxtView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
}
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
    if (btn.tag == 5) {
        [self.starBtn1 setSelected:YES];
        [self.starBtn2 setSelected:YES];
        [self.starBtn3 setSelected:YES];
        [self.starBtn4 setSelected:YES];
        [self.starBtn5 setSelected:YES];
    }
    if (btn.tag == 4) {
        [self.starBtn1 setSelected:YES];
        [self.starBtn2 setSelected:YES];
        [self.starBtn3 setSelected:YES];
        [self.starBtn4 setSelected:YES];
        [self.starBtn5 setSelected:NO];
    }
    if (btn.tag == 3) {
        [self.starBtn1 setSelected:YES];
        [self.starBtn2 setSelected:YES];
        [self.starBtn3 setSelected:YES];
        [self.starBtn4 setSelected:NO];
        [self.starBtn5 setSelected:NO];
    }
    if (btn.tag == 2) {
        [self.starBtn1 setSelected:YES];
        [self.starBtn2 setSelected:YES];
        [self.starBtn3 setSelected:NO];
        [self.starBtn4 setSelected:NO];
        [self.starBtn5 setSelected:NO];
    }
    if (btn.tag == 1) {
        [self.starBtn1 setSelected:!self.starBtn1.selected];
        [self.starBtn2 setSelected:NO];
        [self.starBtn3 setSelected:NO];
        [self.starBtn4 setSelected:NO];
        [self.starBtn5 setSelected:NO];
    }
}

- (IBAction)submitBtnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentView:stars:contents:)]) {
        [self.delegate commentView:self stars:self.score contents:self.contentsTxtView.text];
    }
    
    [self dismiss];
}

- (IBAction)cancleBtnClick:(id)sender {
    [self dismiss];
}
-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.center = window.center;
    [window addSubview:self];
    
    for (UIView* view in self.window.subviews) {
        if (![view isKindOfClass:[self class]]) {
            view.alpha = view.alpha == 1 ? 0.7 : 1.0;
            view.userInteractionEnabled = NO;
        }
    }
}
-(void)dismiss
{
    for (UIView* view in self.window.subviews) {
        if (![view isKindOfClass:[self class]]) {
            view.alpha = view.alpha != 1.0 ? 1.0 : 0.7;
            view.userInteractionEnabled = YES;
        }
    }
    
    [self removeFromSuperview];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeholderLabel.text = nil;
    
    // 调整键盘和视图高度
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    
    CGFloat textView_center = textView.center.y;
    self.center = CGPointMake(self.center.x, self.center.y - textView_center);
    
    [UIView commitAnimations];
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeholderLabel.text = @"填写评论";
    }
    [textView resignFirstResponder];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.center = window.center;
    
    [UIView commitAnimations];
    
}

@end
