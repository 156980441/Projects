//
//  RootViewController.m
//  Bookstore
//
//  Created by xue on 13-4-26.
//  Copyright (c) 2013年 xuejiannan. All rights reserved.
//

#import "RootViewController.h"
#import "ReadView.h"
#import "SearchView.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar2.png"] forBarMetrics:UIBarMetricsDefault];
    self.title = @"在线书店";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"sharebg.png"]];
    
    scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 480 + 100);
    [self.view addSubview:scrollView];
    
    _searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)] autorelease];
    [_searchBar setBackgroundImage:[UIImage imageNamed:@"navbar2.png"]];
    _searchBar.delegate = self;
    [scrollView addSubview:_searchBar];
    
    for (int i = 1; i <= 4; i ++) {
        UIImageView *imageView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BookShelfCell.png"]] autorelease];
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, (i-1)*125 + 44, 320, 100)];
        [view addSubview:imageView];
        [scrollView addSubview:view];
    }
    [self bookImage];
}

- (void)bookImage{
    for (int i = 1; i < 4; i++){
        BookImage *book;
        book=[[[BookImage alloc] initWithFrame:CGRectMake(20 + (i-1)*100, 10+44, 80, 100) imageName:[NSString stringWithFormat:@"book%d.jpeg", i]] autorelease];
        book.tag = i;
        book.delegate = self;
        [scrollView addSubview:book];
    }
   
}

#pragma mark---
#pragma mark---UISearchBarDelegate methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text isEqualToString:@" "] || [searchBar.text length] <= 0) {
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }else{
        [UIView transitionWithView:self.navigationController.view duration:2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            SearchView *searchView = [[[SearchView alloc] init] autorelease];
            searchView.search = searchBar.text;
            [self.navigationController pushViewController:searchView animated:YES];
            
        }completion:nil];
    }
}


#pragma mark---BookImageDelegate methods
- (void)bookImageDidClicked:(BookImage *)bookImage{
    NSLog(@"点击");
    [_searchBar resignFirstResponder];
    ReadView *readView = [[[ReadView alloc] init] autorelease];
    if (bookImage.tag == 1){
        readView.str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aizaixianjingderizi" ofType:@"txt" ]encoding:NSUTF8StringEncoding error:nil];
    }else if (bookImage.tag == 2){
        readView.str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shinian" ofType:@"txt" ]encoding:NSUTF8StringEncoding error:nil];
    }else if (bookImage.tag == 3){
        readView.str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zuishuxidemoshengren" ofType:@"txt" ]encoding:NSUTF8StringEncoding error:nil];
    }else{
        return;
    }
    
    [self.navigationController pushViewController:readView animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
