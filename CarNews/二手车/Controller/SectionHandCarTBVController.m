//
//  SectionHandCarTBVController.m
//  CarNews
//
//  Created by Chenghui on 16/3/5.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "SectionHandCarTBVController.h"
#import "SectionCarTBVCell.h"
#import "SecondHandModel.h"
#import "SecondTabViewController.h"
#import "BrandViewController.h"

@interface SectionHandCarTBVController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)NSUInteger page;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SectionHandCarTBVController

-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navItem];
    
    self.page = 1;
    
    /*UI相关*/
    [self addRefreshView];
    
    self.tableView.rowHeight = 110;
    
    // 请求数据
    [self requestData];
}

#pragma mark -- 刷新
// 添加上下拉刷新
- (void)addRefreshView{
    
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

#pragma mark -- 请求数据
- (void)requestData
{
    
//    NSString *str =@"&psize=20&sign=43fc6265d3d0f8973464c8f5e4624383";//北京
NSString *str = @"&psize=20&sign=16ccc1a946512873f908236ab302a690";
    [QFHttpManager getWithURL:[NSString stringWithFormat:@"%@?cid=501&pindex=%lu%@",KErshou_URL,(unsigned long)self.page,str] andParamDic:nil returnBlock:^(NSURLResponse *response, NSError *error, id data) {
       
        if (error) {
            CHLog(@"error:%@",[error description]);
        }else{
            
            for (NSDictionary *dict in data[@"CarList"]) {

            // JSONModel
             SecondHandModel *model = [[SecondHandModel alloc] initWithDictionary:dict error:nil];
                
                [self.dataArray addObject:model];
                
            }
            
            // 刷新数据
            [self.tableView reloadData];
            
            // 结束刷新
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }
            
            
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionCarTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionCarTBVCell"];
    
    SecondHandModel *model = self.dataArray[indexPath.row];
    [cell setModel:model];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHLog(@"------>>>>>__----");

//    SecondHandModel *model = [self.dataArray objectAtIndex:indexPath.row];
//    NSLog(@"%ld",indexPath.row);
    // 调到详细信息页面
    SecondTabViewController *secVC = [[SecondTabViewController alloc] init];
    
    // 用一个模型来接受
    SecondHandModel *model =  [self.dataArray objectAtIndex:indexPath.row];
    secVC.model = model;
    [self.navigationController pushViewController:secVC animated:YES];
    
}

//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        //x和y的最终值为1
        [UIView animateWithDuration:1 animations:^{
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    
        }];
    
}


#pragma mark - Navigation

#pragma mark- UIStroryBoard 正向传值方法（点击表格里的小cell，传值并，调到详情页面）

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    CHLog(@"------>>>>>__----");
//    
//    if ([segue.destinationViewController isKindOfClass:[SecondTabViewController class]]) {
//        
//        // 获取目标控制器
//        SecondTabViewController *ctl = segue.destinationViewController;
//        
//        ctl.UcarsID = [sender UcarID];
//    }
//
//}


#pragma mark -- 导航栏左边视图
- (void)navItem

{
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(190/255.0) green:(193/255.0) blue:(255/255.0) alpha:1.0]];
        // 导航栏标题颜色
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor purpleColor]}];
        
        
        // 返回按钮
        CHMyButton *backButton = [CHMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 60, 30) title:@"品牌" image:nil bgImage:nil tag:100 actionBlock:^(CHMyButton *button) {
            
            /**
             *  品牌
             */
            
            BrandViewController *brandVC = [[BrandViewController alloc] init];
            [self.navigationController pushViewController:brandVC animated:YES];
            
            
        }];
    

        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
#pragma mark --- 右边导航栏按钮
    
//
//        CHMyButton *shareButton = [CHMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 60, 30) title:@"发现" image:[UIImage imageNamed:@"share.png"]  bgImage:nil tag:1001 actionBlock:^(CHMyButton *button) {
//            
//            // 处理的事件
//            
//        }];
//        [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
  
}


@end
