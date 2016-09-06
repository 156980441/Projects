//
//  DinnerCommentTableViewHeaderView.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/7/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "DinnerCommentTableViewHeaderView.h"
#import "CommentView.h"

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
    [commentView show];
}

- (IBAction)dateBtnClick:(id)sender {
}
@end
