//
//  TSAllCityNameController.m
//  项目
//
//  Created by 唐硕 on 16/2/21.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "TSAllCityNameController.h"
#import "TSHotCityCell.h"

@interface TSAllCityNameController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TSAllCityNameController

//使用系统的tabBar时，当导航push到下一个页面时隐藏tabBar
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.arrayHotCity = [NSMutableArray arrayWithObjects:@"港头镇",@"新沂市",@"无锡市",@"上海",@"娘子",@"啊哈",@"青岛市",@"济南市",@"深圳市",@"长沙市",@"滨湖区", nil];
        self.keys = [NSMutableArray array];
        self.arrayCitys = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNav];
    
    [self getCityData];
    
    [self initViews];

}

-(void)initViews {
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

-(void)initNav{
    self.title = @"城市列表";
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back@2x"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn) forControlEvents:UIControlEventTouchUpInside];;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
}
-(void)OnTapBackBtn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    //添加热门城市
    NSString *strHot = @"热";
    [self.keys insertObject:strHot atIndex:0];
    [self.cities setObject:_arrayHotCity forKey:strHot];
}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return self.keys.count;
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 1;
    } else {
        NSString *key = [self.keys objectAtIndex:section];
        NSArray *city = [self.cities objectForKey:key];
        return city.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return 250;
    } else {
        return 50;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        TSHotCityCell *cell = [TSHotCityCell cellWithTableView:tableView HotCitArray:self.arrayHotCity];
        return cell;
    } else {
    static NSString *cellID = @"asdasfasfa";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"wo ";
    return cell;
    }
}


@end
