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

@property (strong, nonatomic) IBOutlet UIButton *starBtn1;
@property (strong, nonatomic) IBOutlet UIButton *starBtn2;
@property (strong, nonatomic) IBOutlet UIButton *starBtn3;
@property (strong, nonatomic) IBOutlet UIButton *starBtn4;
@property (strong, nonatomic) IBOutlet UIButton *starBtn5;

@property (strong, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (strong, nonatomic) IBOutlet UITextView *contentsTxtView;
@property (nonatomic, assign) id<CommentViewDelegate> delegate;

- (IBAction)starBtnClick:(id)sender;
- (IBAction)submitBtnClick:(id)sender;
- (IBAction)cancleBtnClick:(id)sender;
- (void)show;
- (void)dismiss;

@end
