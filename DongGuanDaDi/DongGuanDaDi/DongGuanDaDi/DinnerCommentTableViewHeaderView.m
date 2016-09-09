//
//  DinnerCommentTableViewHeaderView.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/7/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "DinnerCommentTableViewHeaderView.h"
#import "CommentView.h"

#import "YLDatePicker.h"

@interface DinnerCommentTableViewHeaderView () <YLDatePickerDelegate,CommentViewDelegate>
@property (nonatomic, strong) CommentView *commentView;
@property (nonatomic, strong) YLDatePicker *picker;
@end

@implementation DinnerCommentTableViewHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)commentBtnClick:(id)sender {
    self.commentView = [[[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:nil options:nil] lastObject];
    self.commentView.delegate = self;
    [self.commentView show];
    
}

- (IBAction)dateBtnClick:(id)sender {
    self.picker = [[YLDatePicker alloc] initWithMode:UIDatePickerModeDate];
    self.picker.frame = CGRectMake(0, 0, 300, 250);
    self.picker.delegate = self;
    self.picker.backgroundColor = [UIColor whiteColor];
    [self.picker show];
    
}

- (void)picker:(UIDatePicker *)picker valueChanged:(NSDate *)date
{
    if (self.dateBtnClick) {
        self.dateBtnClick(date);
    }
    
    [self.picker dismiss];
}
-(void)commentView:(CommentView *)view stars:(NSInteger)stars contents:(NSString*)contents
{
    if (self.commentBtnClick) {
        self.commentBtnClick(stars,contents);
    }
    
    [self.commentView dismiss];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.commentView.superview) {
        [self.commentView.contentsTxtView endEditing:YES];
        [self.commentView dismiss];
    }
    if (self.picker.superview) {
        [self.picker dismiss];
    }
    
}
@end
