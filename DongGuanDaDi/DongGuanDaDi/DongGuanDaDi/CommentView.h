//
//  CommentView.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 9/7/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentView;

@protocol CommentViewDelegate <NSObject>

@optional
-(void)commentView:(CommentView *)view stars:(NSInteger)stars contents:(NSString*)contents;

@end

/**
 *  这里有五个 UIButton 代表五个星星，在 CommentView.xib 中分别对 UIButton 进行 tag 赋值操作
 *
 *  @since 1.0.x
 */
@interface CommentView : UIView
- (IBAction)starBtnClick:(id)sender;
- (IBAction)submitBtnClick:(id)sender;
- (void)show;
- (void)dismiss;
@property (strong, nonatomic) IBOutlet UITextView *contentsTxtView;
@property (nonatomic, assign) id<CommentViewDelegate> delegate;
@end