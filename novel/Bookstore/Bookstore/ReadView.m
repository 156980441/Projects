//
//  ReadView.m
//  read
//
//  Created by 3g on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReadView.h"

@interface ReadView (){
    BOOL right;
    UIBarButtonItem *rightBarButton;
    int cont;
    CGSize winSize;
}

@end

@implementation ReadView
@synthesize str = _str;

- (void)viewDidLoad{
    [super viewDidLoad];
    rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"翻页" style:UIBarButtonItemStylePlain target:self action:@selector(rightButton)];
    //UINavigationItem *item = [[[UINavigationItem alloc] initWithTitle:nil] autorelease];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    [rightBarButton release];
    
    textView = [[[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
    [self.view addSubview:textView];
    textView.text = _str;
    textView.font = [UIFont systemFontOfSize:19];
    textView.textColor = [UIColor blackColor];
    textView.editable = NO;
    winSize = textView.contentSize;
    
    [textView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg6.png"]]];
    NSLog(@"%f",textView.contentSize.height);
    
    allPage = textView.contentSize.height/430 + 1;
    currentPage = 1;
    textView.contentSize = self.view.frame.size;
    
    self.title = [NSString stringWithFormat:@"%d/%d",currentPage,allPage];
    
    //手势
    //单击手势
    UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    tapGesture.delegate=self;
    
    [self.view addGestureRecognizer:tapGesture];
    
    [tapGesture release];
    //左轻扫手势
    UISwipeGestureRecognizer* leftswipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(LeftswipeGestureAction:)];
    leftswipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    leftswipeGesture.delegate=self;
    [self.view addGestureRecognizer:leftswipeGesture];
    //右轻扫手势
    UISwipeGestureRecognizer* RightswipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(RightswipeGestureAction:)];
    RightswipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    RightswipeGesture.delegate=self;
    [self.view addGestureRecognizer:RightswipeGesture];
}
- (void)rightButton
{
    if (right == NO) {
        rightBarButton.title = @"下滑";
        right = YES;
        textView.contentSize = winSize;
    }else{
        rightBarButton.title = @"翻页";
        right = NO;
        textView.contentSize = self.view.frame.size;
    }
}

-(void)tapGestureAction:(UITapGestureRecognizer*)tapGesture{
    NSLog(@"tapGesture");
    if (cont++%2==0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }
}

-(void)LeftswipeGestureAction:(UISwipeGestureRecognizer*)swipeGesture{
    if (currentPage == allPage) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"这已是最后一页" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        return;
    }
    currentPage = currentPage + 1;
    
    NSLog(@"%d",currentPage);
    //[button04 setTitle:[NSString stringWithFormat:@"%d/%d",currentPage ,allPage]];
    self.title = [NSString stringWithFormat:@"%d/%d",currentPage,allPage];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [textView setContentOffset:CGPointMake(0, (currentPage - 1) * 430) animated:YES];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    [UIView commitAnimations];
    
    return;
}

-(void)RightswipeGestureAction:(UISwipeGestureRecognizer*)swipeGesture{
    if (currentPage == 1) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"这已是第一页" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        return;
    }
    currentPage = currentPage - 1;
    NSLog(@"%d",currentPage);
    self.title = [NSString stringWithFormat:@"%d/%d",currentPage,allPage];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [textView setContentOffset:CGPointMake(0, (currentPage - 1) * 430) animated:YES];
    [UIView commitAnimations];
    //
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    
    
    [UIView commitAnimations];
    
    //[button04 setTitle:[NSString stringWithFormat:@"%d/%d",currentPage,allPage]];
    return;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
