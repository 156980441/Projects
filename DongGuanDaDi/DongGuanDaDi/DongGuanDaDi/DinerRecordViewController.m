//
//  DinerRecordViewController.m
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/4/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "DinerRecordViewController.h"
#import "DinnerRecordTableViewCell.h"
#import "DinnerRecord.h"
#import "Common.h"

#import "stdafx_DongGuanDaDi.h"
#import "AFHTTPSessionManager.h"

@interface DinerRecordViewController ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation DinerRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dataSource = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DinnerRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dinnerRecord" forIndexPath:indexPath];
    DinnerRecord* record = [self.dataSource objectAtIndex:indexPath.row];
    cell.dateLabel.text = record.date;
    switch (record.kind) {
        case 0:
            cell.typeLabel.text = @"早";
            break;
        case 1:
            cell.typeLabel.text = @"午";
            break;
        case 2:
            cell.typeLabel.text = @"晚";
            break;
        default:
            break;
    }
    cell.hasEatedLabel.text = record.eated ? @"是" : @"否";
    cell.isOrderedLabel.text = record.predetermined ? @"是" : @"否";
    // Configure the cell...
    
    return cell;
}

- (IBAction)selectDate:(id)sender {
    if (!self.datePiker) {
        UIButton* btn = (UIButton*)sender;
        self.datePiker = [[YLDatePicker alloc] init];
        self.datePiker.delegate = self;
        CGRect rect = CGRectMake(0, 0, 300, 250);
        CGPoint origin = CGPointMake(self.view.center.x - rect.size.width / 2, self.view.center.y - rect.size.height / 2);
        [self.datePiker showInView:self.view
                         withFrame:CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height)
                 andDatePickerMode:UIDatePickerModeDate];
        self.datePiker.picker.tag = btn.tag;// storyboard set StartBtn tag is 0, EndBtn tag is 1;
    }
    else
    {
        [self.datePiker dismiss];
        self.datePiker = nil;// System automatic release delay
    }
}

- (IBAction)queryRecord:(id)sender {
    // hide some buttons in storyboard. Such as date button. When query come back result appear them.
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self.startBtn.titleLabel.text,@"begin",self.endBtn.titleLabel.text,@"end", nil];
    self.manager = [AFHTTPSessionManager manager];
    [self.manager.requestSerializer setValue:@"/DongGuan/" forHTTPHeaderField:@"referer"];
    [self.manager POST:URL_RECORD parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray* arr = (NSArray*)responseObject;
        for (NSDictionary* dic in arr) {
            DinnerRecord* record = [[DinnerRecord alloc] init];
            record.date = [dic objectForKey:@"date"];
            record.eated = ((NSNumber*)[dic objectForKey:@"eated"]).boolValue;
            record.extendUserNum = ((NSNumber*)[dic objectForKey:@"extend_user_num"]).integerValue;
            record.recordId = ((NSNumber*)[dic objectForKey:@"id"]).integerValue;
            record.kind = ((NSNumber*)[dic objectForKey:@"kind"]).integerValue;
            record.predetermined = ((NSNumber*)[dic objectForKey:@"predetermined"]).integerValue;
            [self.dataSource addObject:record];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

- (void)picker:(UIDatePicker *)picker valueChanged:(NSDate *)date
{
    if (picker.tag == 0) {
        if (date) {
            [self.startBtn setTitle:[Common date2String:date] forState:UIControlStateNormal];
        }
    }
    else if (picker.tag == 1)
    {
        if (date) {
            [self.endBtn setTitle:[Common date2String:date] forState:UIControlStateNormal];
        }
    }
}

@end
