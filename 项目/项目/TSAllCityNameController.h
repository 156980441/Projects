//
//  TSAllCityNameController.h
//  项目
//
//  Created by 唐硕 on 16/2/21.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSAllCityNameController : UIViewController

@property (nonatomic, strong) NSMutableDictionary *cities;

@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;

@property(nonatomic,strong)UITableView *tableView;


@end
