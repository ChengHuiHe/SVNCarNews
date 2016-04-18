//
//  CHNewCarViewController.m
//  CarNews
//
//  Created by Chenghui on 16/3/31.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CHNewCarViewController.h"
#import "MyCarModel.h"
#import "CustomDetailViewController.h"
//#import "HeaderView.h"
#import "MyCarTableViewCell.h"
// 广告的头部视图
#import "SDCycleScrollView.h"

#import "DetailViewController.h"

@interface CHNewCarViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,assign)int page;

@property (nonatomic,strong)NSMutableArray *dataListArray;

/**
 *  广告
 */
@property (nonatomic,strong)NSMutableArray *advListArray;

@property (nonatomic,strong)MyCarModel *myCarModel;
@property (nonatomic,strong)AdvertisementModel *advModel;

@end

@implementation CHNewCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCarTableViewCell"];
    
    self.tableView.rowHeight = 89;
    
    /*UI相关*/
    [self addRefreshView];
    
    // 创建广告
    [self createAdv];

    // 广告请求
    [self advRequestData];
    
    [self requestData];
    
    // 检查网络转态
    //    [self updateNetWorkStatus];
    
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
#pragma mark -- 请求广告
- (void)advRequestData
{
    NSDictionary *params = @{@"region":@"北京", @"classId":@"1"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:KADV_TouTiao_URL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        CHLog(@"responseObject:%@",responseObject);
        NSDictionary *dicData = responseObject[@"data"];
        NSArray *array = dicData[@"focusList"];
        
        for (NSDictionary *dict in array) {
            
            self.advModel = [[AdvertisementModel alloc] init];
            [self.advModel setValuesForKeysWithDictionary:dict];
            CHLog(@"-----》》》》》》：%@",self.advModel.title);
            
            [self.advListArray addObject:self.advModel];
        }
        
        // 创建广告
        [self createAdv];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error description]);
    }];
}

#pragma mark -- 创建广告
- (void)createAdv
{
    // 添加广告视图
//    HeaderView *headerView =[[HeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_width, Adv_Height) allDataArray:self.advListArray];
    
//    self.tableView.tableHeaderView = headerView;
    
    
    NSMutableArray *imagesURLStrings = [[NSMutableArray alloc] init];
    NSMutableArray *titlesStrings = [[NSMutableArray alloc] init];
    
    for (int j =0; j < self.advListArray.count; j++) {
        
        self.advModel = self.advListArray[j];
        
        [imagesURLStrings addObject:self.advModel.picUrl];
        [titlesStrings addObject:self.advModel.title];
        
    }
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, Adv_Height)];
    
    scrollView.contentSize = CGSizeMake(self.advListArray.count * screen_width, Adv_Height);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    
    // 网络加载图片的轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screen_width, Adv_Height) delegate:self placeholderImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    
    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    cycleScrollView.titlesGroup = titlesStrings;
    
    [scrollView addSubview:cycleScrollView];
    
    [self.view addSubview:scrollView];
    
    
    self.tableView.tableHeaderView = scrollView;

}

#pragma mark-- 请求数据
- (void)requestData
{
    
    NSString *strUrl= [NSString stringWithFormat:@"%@?categoryid=3&pageindex=%d&pagesize=20&productid=17&v=1",KNewCar_URL,self.page];
    
    [QFHttpManager getWithURL:strUrl andParamDic:nil returnBlock:^(NSURLResponse *response, NSError *error, id data) {
        
        if (error) {
            NSLog(@"errror:%@",[error description]);
        }else {
            
            NSArray *dataArray = data[@"Data"];
            CHLog(@"%@",dataArray);
            
            for (NSDictionary *dict in dataArray) {
                
                self.myCarModel = [[MyCarModel alloc] init];
                [self.myCarModel setValuesForKeysWithDictionary:dict];
                
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
    
    MyCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCarTableViewCell" forIndexPath:indexPath];
    
    self.myCarModel = self.dataListArray[indexPath.row];

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



#pragma mark - SDCycleScrollViewDelegate 点击广告

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    CHLog(@"---点击了第%ld张图片", (long)index);
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    self.advModel = self.advListArray[index];
    
    detailVC.resourceLocID = self.advModel.resourceLoc;
    NSLog(@"传值啊：：：：%@",detailVC.resourceLocID);
    
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

- (NSMutableArray *)advListArray
{
    if (_advListArray == nil) {
        _advListArray = [[NSMutableArray alloc] init];
    }
    return _advListArray;
}

- (MyCarModel *)myCarModel
{
    if (_myCarModel == nil) {
        _myCarModel = [[MyCarModel alloc] init];
    }
    return _myCarModel;
}

- (AdvertisementModel*)advModel
{
    if (_advModel == nil) {
        _advModel = [[AdvertisementModel alloc] init];
    }
    return _advModel;
}


@end
