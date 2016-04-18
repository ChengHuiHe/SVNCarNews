//
//  CarRightViewController.m
//  CarNews
//
//  Created by Chenghui on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CarRightViewController.h"
#import "CarRightCollectionViewCell.h"
#import "CategoryCarModel.h"

#define kColletionView_W (screen_width - 100-20-2)

@interface CarRightViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataSource;

// URL
@property (nonatomic, copy) NSString * urlStr;

@property (nonatomic,strong)DatabaseSingle *singleDB;

// 创建一个表名
@property (nonatomic, copy) NSString * collectionTableName;

@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation CarRightViewController


// 数据库表！！！
-(instancetype)init{
    if ( self = [super init]) {
        [self initInstance];
        //建表
        _collectionTableName = @"carvalues";
        [self.singleDB createTabelWithName:_collectionTableName andKeys:[CategoryCarValueModel allKeys]];
        //        [self.dataCenter dropTable:self.collectionTableName];
    }
    return self;
}

// 懒加载
- (NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.singleDB = [DatabaseSingle shareSingleton];//会调用方法创建数据库

    
    // 创建 UI
    [self createUI];
    
}

#pragma mark -- 创建collectionView
- (void)createUI
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(kColletionView_W, 25);
    
    CGFloat width = (kColletionView_W - 5*2-5)*0.5;
    CGFloat height = 200;
    layout.itemSize = CGSizeMake(width, height);
    
    // 设置collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kColletionView_W, screen_height-64-49) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // 打开用户交互
    self.collectionView.userInteractionEnabled = YES;
#pragma mark -- 注册 cell
    //    注册cell 的类
    [self.collectionView registerClass:[CarRightCollectionViewCell class] forCellWithReuseIdentifier:@"CarRightCollectionViewCell"];
    
    
    //注册 _collectionView 的header
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark -- collectionView 的数据源方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
#pragma mark -- 这里定义一个模型 怪怪的，主要是根据 数据解析来设置的
    CategoryCarModel * model = self.dataSource[section];
    return  model.values.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarRightCollectionViewCell" forIndexPath:indexPath];
    
#pragma mark --- 添加的数据，先拿到 values
    NSArray * values =  [self.dataSource[indexPath.section] values];
    CategoryCarValueModel *model = values[indexPath.row];
    
    
    //查询数据, 如果存在则对每个avalue的收藏值赋值
    if ([self.singleDB existsRecordInTable:self.collectionTableName withValue:model.autoid andKey:@"autoid"]) {
        model.isCollected = @"1";
    }else{
        model.isCollected = @"0";
    }

    // 点击插入或移除 数据库数据
    cell.tapAtCollection =^(BOOL isCollected){
        if (isCollected) {
            [self insertDBWithModel:model];//插入数据
            
        }else{
            [self.singleDB deleteRecordInTable:self.collectionTableName withValue:model.autoid andKey:@"autoid"];//删除数据
        }
    };

    
    [cell setCarRightModel:model];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor colorWithRed:0.941 green:0.255 blue:0.200 alpha:1.000];
        for (UIView * view in header.subviews) {
            [view removeFromSuperview];
        }
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(kLeft_Gap, 0, kColletionView_W, 30)];
        label.text = [self.dataSource[indexPath.section] name];
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [header addSubview:label];
        
        return header;
    }
    
    return nil;
}

#pragma mark --- 选中 collectionViewCell



#pragma mark --- 加载数据
- (void)loadData
{
    if (kNetworkNotReachability) {
        NSLog(@"categoryCarVC: loadd data from database");
        [self loadDataFromDB];
    }else{
        
#pragma mark -- 请求数据！！！！
        self.urlStr = [NSString stringWithFormat:kURLCategoryCar, self.cid];
        CHLog(@"categoryCarVC:%@", self.urlStr);
        [self loadDataWithString:self.urlStr andParams:nil];
    }
}


-(void)loadDataWithString:(NSString *)urlStr andParams:(NSDictionary *)dict{
    
    /**
     *  GBK2312中文编码
     *  @param kCFStringEncodingGB_18030_2000
     */
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];// 服务器，那边的问题，具体设置，看请求体
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString * retStr = [[NSString alloc] initWithData:responseObject encoding:enc];
        
        NSData * data = [retStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError * error = [[NSError alloc] init];
        
        //json解析
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        
        [self parserArray:array];//解析数据
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        
    }];
    
}

-(void)parserArray:(NSArray *)array{
    
    CHLog(@"%lu",(unsigned long)self.dataSource.count);// 0
    
    [self.dataSource removeAllObjects];
    //建表
    [self.singleDB createTabelWithName:self.cidTableName andKeys:[CategoryCarModel allKeys]];
    
    CHLog(@"表的名字：%@",self.cidTableName);// car00AU0BRA0BUV
    
    //数据库只保留最新数据
    [self.singleDB deleteAllInTable:self.cidTableName];
    
    for (NSDictionary * dict in array) {
        CategoryCarModel * model = [[CategoryCarModel alloc] initWithDictionary:dict error:nil];
        model.values = [NSMutableArray array];
        
        
        //将name属性写入cidTable
        [self.singleDB insertTable:self.cidTableName WithValus:@[model.name] andKeys:@[@"name"]];
        
        
        //nameTable, 装value
        self.nameTableName = model.name;
        [self.singleDB createTabelWithName:self.nameTableName andKeys:[CategoryCarValueModel allKeys]];
        [self.singleDB deleteAllInTable:self.nameTableName];
        
        
        for (NSDictionary * dic in dict[@"value"]) {
            CategoryCarValueModel * avalue = [[CategoryCarValueModel alloc] initWithDictionary:dic error:nil];
            
            [model.values addObject:avalue];
            
            //新数据插入数据库
            NSArray * keys = [CategoryCarValueModel allKeys];
            NSArray * values = [DatabaseSingle valuesWithDict:dic andKeys:keys];
            [self.singleDB insertTable:self.nameTableName WithValus:values andKeys:keys];
        }
        
        [self.dataSource addObject:model];
    }
    [self refreshUI];//更新UI
    
}

- (void)refreshUI
{
    //没有数据
    if (self.dataSource.count==0) {
        
        if (kNetworkNotReachability) {
            
            UIAlertView * alvertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有网络,没有缓存数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alvertView show];
            
            if (self.tapAtCellHide) {
                self.tapAtCellHide();
            }
            
            return;
        }
        
        UIAlertView * alvertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时没有车型数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alvertView show];
        
        if (self.tapAtCellHide) {
            self.tapAtCellHide();
        }
    }else{
        [self.collectionView reloadData];
        
        //_carVC的_collectionView滚至开头
        [self.collectionView scrollsToTop];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        
        
        if (self.tapAtCellShow) {
            self.tapAtCellShow();
        }
    }

}

-(void)loadDataFromDB{
    
    [self.dataSource removeAllObjects];
    
    //从cidtalbe读出name
    NSArray * nameArr = [self.singleDB selectAllFromTable:self.cidTableName];
    if (nameArr.count >0) {
        for (NSDictionary * dict in nameArr) {
            
            CategoryCarModel * model = [[CategoryCarModel alloc] initWithDictionary:dict error:nil];
            //从cidtalbe读出values
            self.nameTableName = model.name;
            NSArray * values = [self.singleDB selectAllFromTable:self.nameTableName];
            if (values.count>0) {
                model.values = [NSMutableArray array];
                for (NSDictionary * dic in values) {
                    CategoryCarValueModel * avalue = [[CategoryCarValueModel alloc] initWithDictionary:dic error:nil];
                    [model.values addObject:avalue];
                }
                [self.dataSource addObject:model];
            }
        }
    }
    
    
    [self refreshUI];
    
}
-(void)insertDBWithModel:(CategoryCarValueModel *)model{
    //新数据插入数据库
    NSArray * keys = [CategoryCarValueModel allKeys];
    NSMutableArray * values = [NSMutableArray array];
    for (NSString * key  in keys) {
        [values addObject:[model valueForKey:key]];
    }
    [self.singleDB insertTable:self.collectionTableName WithValus:values andKeys:keys];
}


-(void)initInstance{
    self.dataSource = [NSMutableArray array];
    self.pageIndex = 1;
    
}

@end
