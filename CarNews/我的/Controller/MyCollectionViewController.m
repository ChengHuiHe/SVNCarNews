//
//  MyCollectionViewController.m
//  CarNews
//
//  Created by Chenghui on 16/4/12.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "MyCollectionViewController.h"

#import "CategoryCarValueModel.h"
#import "CategoryCarModel.h"
#import "CarRightCollectionViewCell.h"

@interface MyCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSString * collectionTableName;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, copy) NSString * cid;
@property (nonatomic, copy) NSString * cidTableName;

@property (nonatomic, strong) NSMutableArray * seletedArray;
@property (nonatomic, assign) BOOL isEditing;

// 总得数据
@property (nonatomic, strong) NSMutableArray * dataSource;


@property (nonatomic, strong) DatabaseSingle * dataCenter;

@end

@implementation MyCollectionViewController

- (NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(instancetype)init{
    if ( self = [super init]) {
        [self initInstance];
        //建表
        _collectionTableName = @"carvalues";
    }
    return self;
}


-(void)initInstance{
    self.dataSource = [NSMutableArray array];
    self.seletedArray = [NSMutableArray array];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.dataCenter = [DatabaseSingle shareSingleton];//会调用方法创建数据库
    
    [self addCollectionView];
    [self loadDataFromDB];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
    
}

-(void)loadData{
    NSLog(@"categoryCarVC: loadd data from database");
    [self loadDataFromDB];
    
}


-(void)loadDataFromDB{
    
    [self.dataSource removeAllObjects];
    
    
    NSArray * values = [self.dataCenter selectAllFromTable:self.collectionTableName];
    
    CHLog(@"%@",values);
    
    for (NSDictionary * dict in values) {
        CategoryCarValueModel * avalue = [[CategoryCarValueModel alloc] initWithDictionary:dict error:nil];
        CHLog(@"%@",avalue);
        [self.dataSource addObject:avalue];
    }
    
    
    [self.collectionView reloadData];
    
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
/**
 *  选中cell事件
 */
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    CategoryCarValueModel * avalue = self.dataSource[indexPath.row];
//    
//    if ([avalue.productNum floatValue] > 0) {
//        
//        [self pushToParamsVC:avalue];//推至paramsVC；
//        
//    }else{
//        UIAlertView * alvertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时没有数据" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//        [alvertView show];
//    }
//    
//}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CarRightCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarRightCollectionViewCell" forIndexPath:indexPath];
    
    
    CategoryCarValueModel * avalue = self.dataSource[indexPath.row];
    
    
    avalue.isCollected = @"1";//显示按钮
    cell.isCollection = YES;//根据此状态设置按钮的标题
    
    cell.tapAtCollection =^(BOOL isCollected){
        if (!isCollected) {
            [self.dataSource removeObject:avalue];//
            [self.dataCenter deleteRecordInTable:self.collectionTableName withValue:avalue.autoid andKey:@"autoid"];//删除数据
            [self.collectionView reloadData];//更新UI
            
        }
    };
    
    
    cell.carRightModel =avalue;
    return cell;
}

-(void)addCollectionView{
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    
    
    CGFloat width = (screen_width - 15*2 - 10)/2;
    CGFloat height = 230;
    
    layout.itemSize = CGSizeMake(width, height);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    //注册cell
    [_collectionView registerClass:[CarRightCollectionViewCell class] forCellWithReuseIdentifier:@"CarRightCollectionViewCell"];
    
    
    [self.view addSubview:_collectionView];
    
}

-(void)insertDBWithModel:(CategoryCarValueModel *)model{
    //新数据插入数据库
    NSArray * keys = [CategoryCarValueModel allKeys];
    NSMutableArray * values = [NSMutableArray array];
    for (NSString * key  in keys) {
        [values addObject:[model valueForKey:key]];
    }
    [self.dataCenter insertTable:self.collectionTableName WithValus:values andKeys:keys];
}

/**
 *  pushToParamsVC
 */
//-(void)pushToParamsVC:(CategoryCarValueModel *)avalue{
//    
//    if (kNetworkNotReachability) {
//        UIAlertView * alvertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有网络,没有缓存数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//        [alvertView show];
//        return;
//    }
//    
//    CategoryCarParamsViewController * carParamsVC = [[CategoryCarParamsViewController alloc] init];
//    
//    carParamsVC.cid = avalue.cid;
//    carParamsVC.autoid = avalue.autoid;
//    carParamsVC.title = avalue.name;
//    carParamsVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:carParamsVC animated:YES];
//}
//
@end
