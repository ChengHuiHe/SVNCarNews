 //
//  CHTopViewController.m
//  CarNews
//
//  Created by Chenghui on 16/3/31.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CHTopViewController.h"
#import "HomeCell.h"
#import "DetailViewController.h"

// 广告的头部视图
#import "SDCycleScrollView.h"

//#import "HeaderView.h"

@interface CHTopViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,assign)int page;

@property (nonatomic,strong)NSMutableArray *dataListArray;

/**
 *  广告
 */
@property (nonatomic,strong)NSMutableArray *advListArray;

@property (nonatomic,strong)HomeModel *homeModel;
@property (nonatomic,strong)AdvertisementModel *advModel;

@end

@implementation CHTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
    
    self.tableView.rowHeight = 86;

    //一:从本地读取旧数据展示
    [self loadDataFromDatabase];
    
    /*UI相关*/
    [self addRefreshView];

//    [self createAdv];
    
    // 广告请求
    [self advRequestData];

    [self requestData];
    
    // 检查网络转态
//    [self updateNetWorkStatus];
    
}

#pragma mark- 数据库相关
- (void)loadDataFromDatabase
{
    DatabaseSingle *single = [DatabaseSingle shareSingleton];
    
    // 装载旧数据
    [self.dataListArray addObjectsFromArray:[single searchDatabaseWithTitle]];
    
    // 如果有数据，就刷新数据
    if (self.dataListArray.count!=0) {
        [self.tableView reloadData];
    }else {
        // 加载
        [self requestData];

    }
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

    NSDictionary *params = @{@"region":@"北京", @"classId":@"0"};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:KADV_TouTiao_URL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        CHLog(@"responseObject:%@",responseObject);
        NSDictionary *dicData = responseObject[@"data"];
        NSArray *array = dicData[@"focusList"];
        
        for (NSDictionary *dict in array) {
            
             self.advModel = [[AdvertisementModel alloc] init];
            [self.advModel setValuesForKeysWithDictionary:dict];
         
            NSLog(@"----%@",self.advModel.resourceLoc);
            
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
//    HeaderView *headerView =[[HeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160) allDataArray:self.advListArray];
    
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
    [SVProgressHUD showProgress:0 status:@"正在加载中。。。。"];

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    NSString *strUrl= [NSString stringWithFormat:@"%@?page=%d&classId=0",KTouTiao_URL,self.page];
    
    [QFHttpManager getWithURL:strUrl andParamDic:nil returnBlock:^(NSURLResponse *response, NSError *error, id data) {
        
        if (error) {
            NSLog(@"errror:%@",[error description]);
        }else {
            
            //三:更新数据
            //清空数组当中旧数据
            if (self.dataListArray.count!=0) {
                for (HomeModel *model in self.dataListArray) {
                    
                    //清除本地旧数据
                    [[DatabaseSingle shareSingleton] deleteHomeCar:model];
                }
                [self.dataListArray removeAllObjects];
            }
            
            NSArray *dataArray = [data[@"data"] objectForKey:@"newsList"];
            for (NSDictionary *dict in dataArray) {
                
                self.homeModel = [[HomeModel alloc] initWithDictionary:dict error:nil];
                [self.dataListArray addObject:self.homeModel];
                
                // 本地插入数据
                [[DatabaseSingle shareSingleton] insertHomeCar:self.homeModel];
            }


            // 消失
            [SVProgressHUD dismiss];

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
    
    self.homeModel = self.dataListArray[indexPath.row];

    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    [cell setHomeModel:_homeModel];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    self.homeModel = self.dataListArray[indexPath.row];
    
    detailVC.resourceLocID = self.homeModel.resourceLoc;
    
    
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

- (HomeModel *)homeModel
{
    if (_homeModel == nil) {
        _homeModel = [[HomeModel alloc] init];
    }
    return _homeModel;
}

- (AdvertisementModel*)advModel
{
    if (_advModel == nil) {
        _advModel = [[AdvertisementModel alloc] init];
    }
    return _advModel;
}


@end
