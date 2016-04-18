//
//  CHIndustryViewController.m
//  CarNews
//
//  Created by Chenghui on 16/3/31.
//  Copyright © 2016年 Chenghui. All rights reserved.
//
//  行业
#import "CHIndustryViewController.h"
#import "MyCarTableViewCell.h"
#import "MyCarModel.h"
#import "CustomDetailViewController.h"

@interface CHIndustryViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,assign)int page;

@property (nonatomic,strong)NSMutableArray *dataListArray;
@property (nonatomic,strong)MyCarModel *myCarModel;

@end

@implementation CHIndustryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.page = 1;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCarTableViewCell"];
    
    self.tableView.rowHeight = 86;

    /*UI相关*/
    [self addRefreshView];
   
    // 请求数据
//    [self requestData];
    
}

#pragma mark -- 刷新
// 添加上下拉刷新
- (void)addRefreshView
{
    
#pragma mark -- 刷新
    __weak typeof (self) weakSelf = self;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 下拉刷新
        weakSelf.page = 1;
        [weakSelf requestData];
        
    }];
    
    // 上拉刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page++;
        [weakSelf requestData];
        
    }];
}

#pragma mark-- 请求数据
- (void)requestData
{
    NSString *strUrl= [NSString stringWithFormat:@"%@?categoryid=1&pageindex=%d&pagesize=20&productid=17&v=1",KIndustr_URL,self.page];
    
    CHLog(@"%@",strUrl);
    
    [QFHttpManager getWithURL:strUrl andParamDic:nil returnBlock:^(NSURLResponse *response, NSError *error, id data) {
        
        if (error) {
            NSLog(@"errror:%@",[error description]);
        }else {
            
            
            NSArray *dataArray = data[@"Data"];
            CHLog(@"%@",dataArray);
            
            for (NSDictionary *dict in dataArray) {
                
                self.myCarModel = [[MyCarModel alloc] init];
                [self.myCarModel setValuesForKeysWithDictionary:dict];
                
                CHLog(@"%@",self.myCarModel.title);
                
                [self.dataListArray addObject:self.myCarModel];
            }
            
            // 刷新UI
            [self.tableView reloadData];
            
            // 结束刷新
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.myCarModel = self.dataListArray[indexPath.row];
    
    MyCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCarTableViewCell"];
    
    [cell setMyCarModel:self.myCarModel];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomDetailViewController *detailVC = [[CustomDetailViewController alloc] init];
    MyCarModel *myCarModel = self.dataListArray[indexPath.row];
    detailVC.myCarmodel = myCarModel;
    
    CHLog(@"%@,%@",detailVC.myCarmodel.title,detailVC.myCarmodel.author);
    
    [self.navigationController pushViewController:detailVC animated:YES];

}

#pragma mark -- 懒加载
-(NSMutableArray *)dataListArray
{
    if (_dataListArray == nil) {
        _dataListArray = [[NSMutableArray alloc] init];
    }
    return _dataListArray;
}

- (MyCarModel *)myCarModel
{
    if (_myCarModel == nil) {
        _myCarModel = [[MyCarModel alloc] init];
    }
    return _myCarModel;
}

@end
