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
    CommentView *commentView = [[[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:nil options:nil] lastObject];
    commentView.delegate = self;
    [commentView show];
}

- (IBAction)dateBtnClick:(id)sender {
    YLDatePicker* picker = [[YLDatePicker alloc] initWithMode:UIDatePickerModeDate];
    picker.frame = CGRectMake(0, 0, 300, 250);
    picker.delegate = self;
    picker.backgroundColor = [UIColor whiteColor];
    [picker show];
}

- (void)picker:(UIDatePicker *)picker valueChanged:(NSDate *)date
{
    if (self.dateBtnClick) {
        self.dateBtnClick(date);
    }
}
-(void)commentView:(CommentView *)view stars:(NSInteger)stars contents:(NSString*)contents
{
    if (self.commentBtnClick) {
        self.commentBtnClick(stars,contents);
    }
}
@end
