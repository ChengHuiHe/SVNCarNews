//
//  BrandViewController.m
//  CarNews
//
//  Created by Chenghui on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//
//  品牌
#import "BrandViewController.h"
#import "BrandTableViewCell.h"
#import "BrandModel.h"
#import "CarRightCollectionViewCell.h"
#import "CarRightViewController.h"

#define kTableView_W 100
#define kCarVC_W (screen_width - kTableView_W)
#define kCell_H 80

@interface BrandViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar * searchBar;

/**
 *  左边的品牌列表
 */
@property (nonatomic,strong)NSMutableArray *brandListArray;

/**
 *  右边的详情列表
 */
@property (nonatomic,strong)NSMutableArray *detailListArray;

/**
 *  创建 2 张表
 */
@property (nonatomic,strong)UITableView *brandTableView;

/**
 *  右边的 瀑布流数据
 */
@property (nonatomic, strong)CarRightViewController * carVC;

/**
 *  默认选中第一个cell
 */
@property (nonatomic, assign) BOOL firstSelcetCell;
@property (nonatomic, assign) BOOL firstSelcetSearchCell;

@property (nonatomic, strong) NSIndexPath * currentIndexPath;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray * searchArray;

@end

@implementation BrandViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initInstance];

    // 创建UI
    [self creatUI];
    
    [self addSearchBar];

    // 添加右边的 collectionView
    [self addChildView];
    
    // 解析 plist 文件
    [self plistData];
}

-(void)initInstance{
    self.carTypeSet = [[NSMutableSet alloc] initWithCapacity:42];
    self.searchArray = [NSMutableArray array];
    self.pageIndex =1;
    _firstSelcetCell = YES;
    _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
}

-(void)addSearchBar{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    _searchBar.placeholder = @"输入品牌";
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    
}

#pragma mark -- 创建UI
- (void)creatUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.brandTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width , screen_height) style:UITableViewStylePlain];
    self.brandTableView.delegate = self;
    self.brandTableView.dataSource = self;
//    self.brandTableView.backgroundColor = [UIColor redColor];
    self.brandTableView.showsVerticalScrollIndicator = NO;

    // 去掉分割线
     self.brandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.brandTableView];

    
    self.brandTableView.rowHeight = 80;

    // 注册cell
    [self.brandTableView registerNib:[UINib nibWithNibName:@"BrandTableViewCell" bundle:nil] forCellReuseIdentifier:@"BrandTableViewCell"];
    

}

#pragma mark -- 加载数据
/**
 *  解析plsit 文件
 */
- (void)plistData
{
    NSString *strPatch = [[NSBundle mainBundle] pathForResource:@"brand.plist" ofType:nil];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:strPatch];
    
    // 存 索引的
    NSMutableSet *set = [[NSMutableSet alloc] initWithCapacity:42];


    for (int i = 0; i <dataArray.count; i++) {

        NSMutableArray * mArr = [NSMutableArray array];

        // 拿到 每个大数组 里面的 小数组
        NSArray *array = dataArray[i];
        
        for (NSDictionary *dict in array) {
            BrandModel *brandModel = [[BrandModel alloc] init];
            [brandModel setValuesForKeysWithDictionary:dict];
            
            CHLog(@"%@",brandModel.bphoto);
            
            [mArr addObject:brandModel];
            // A、B、C.....Z
            [set addObject:brandModel.firstchar];

        }
        
        [self.brandListArray addObject:mArr];
    
    }
    // 刷新
    [self.brandTableView reloadData];
    
}

#pragma mark --- 实现数据源 和代理
//组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.searchArray.count > 0) {
        return self.searchArray.count;//返回搜索结果
    }
    
    return self.brandListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchArray.count > 0) {
        return [self.searchArray[section] count];
    }

    return [self.brandListArray[section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandTableViewCell"];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    BrandModel *brandModel = [[BrandModel alloc] init];
    
#pragma mark -- 获得第几组里面的第几行！！！
//    brandModel = self.brandListArray[indexPath.section][indexPath.row];
    
    
#pragma mark -- 搜索
    NSArray * array;
    
    //两种情况cell的model
    
    if (self.searchArray.count > 0) {
        array = self.searchArray;
    }else{
        array = self.brandListArray;
    }
    
    
    // 获得 第几组中的第几行！！！
    brandModel = array[indexPath.section][indexPath.row];
    
#pragma mark --- 设置默认选中cell
    //默认选中一个cell，并加载数据
    if (indexPath.section == _currentIndexPath.section&&indexPath.row == _currentIndexPath.row) {
        
        [cell changeColor];
        [self tableView:tableView didSelectRowAtIndexPath:_currentIndexPath];
    }
    

    [cell setBrandModel:brandModel];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, kTableView_W, 30);
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kTableView_W, 30)];
    
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor colorWithRed:0 green:0.761 blue:0.337 alpha:1.000];
    label.textAlignment = NSTextAlignmentLeft;
    
    [view addSubview:label];
    
    
    //显示头部视图的标题
    if (self.brandListArray.count > 0) {
        
        label.text = [NSString stringWithFormat:@"    %@",[self.brandListArray[section][0]firstchar]];
    }
    else{
        label.text = [NSString stringWithFormat:@"    %@",[self.brandListArray[section][0]firstchar]];
    }
    
    return view;
}

//返回表格索引的代理方法
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    if (self.searchArray.count > 0) {
        return nil;
    }
    
    return @[@"A",@"B",@"C",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
    
}

#pragma mark ---- 点击了某个 cell
/**
 *  点击cell 加载数据
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //0,收键盘
    [_searchBar resignFirstResponder];
    
    if (!_firstSelcetCell) {
        //判断，如果是同一个cell，不用管
        if ([_currentIndexPath isEqual: indexPath]){
            return;
        }
    }
    
    
    _firstSelcetCell = NO;
    
    
    //1、代码块，当没有数据时会调用，隐藏具体的车型 _collectionView
    __weak typeof(self) weakself = self;
    _carVC.tapAtCellHide = ^{
        [weakself hideCarVC];
    };
    
    
    //1、代码块，当没有数据时会调用，呈现具体的车型 _collectionView
    _carVC.tapAtCellShow = ^{
        [weakself showCarVC];
    };
    
    
    //2、改变cell的选中状态
    BrandTableViewCell * cell = (BrandTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell changeColor];
    
    // 当前选中的cell 的颜色
    BrandTableViewCell * currentCell = (BrandTableViewCell *)[tableView cellForRowAtIndexPath:_currentIndexPath];
    [currentCell originColor];
    
    
    //3、加载数据
    BrandModel * model;
    if (self.searchArray.count > 0) {
        model = self.searchArray[indexPath.section][indexPath.row];
    }else{
        model  = self.brandListArray[indexPath.section][indexPath.row];
    }
    
    [self carVCLoadDataWithModel:model];
    
    //4、记录indexPath
    _currentIndexPath = indexPath;

    
}


#pragma mark -- 搜索
/**
 *  搜索
 */
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    
    if (self.brandListArray.count==0) {
        return;
    }
    
    
    if ([searchBar.text isEqualToString:@""]) {
        [self.searchArray removeAllObjects];
        _firstSelcetCell = YES;
        [self.brandTableView reloadData];
        BrandModel * model  = self.brandListArray[0][0];
        _carVC.cid = model.cid;
        
        [_carVC loadData];
        return;
    }
    
    
    [_searchArray removeAllObjects];//清空数据源
    
    //搜索
    for (int i = 0; i < self.brandListArray.count; i++) {
        NSMutableArray * mArr = [NSMutableArray array];
        for (int j = 0; j < [self.brandListArray[i] count]; j++) {
            BrandModel * model = self.brandListArray[i][j];
            NSArray * array = [model.name componentsSeparatedByString:@"--"];
            
            
            if ([array[1] rangeOfString:searchBar.text].location != NSNotFound ) {
                [mArr addObject:model]; //找到数据
            }
            
        }
        if (mArr.count > 0) {
            [self.searchArray addObject:mArr];
        }
    }
    NSLog(@"self.searchArray.count:%ld",(unsigned long)self.searchArray.count);
    _firstSelcetSearchCell = YES;
    [self.brandTableView reloadData];
    
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
    [searchBar setShowsCancelButton:NO animated:YES];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}



#pragma mark -- 添加右边的CollectionView
- (void)addChildView
{
    self.carVC = [[CarRightViewController alloc] init];
    _carVC.view.frame = CGRectMake(kTableView_W, -64-49, kCarVC_W-20, screen_height);
    //加手势
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAction)];
    // 拖拽方法,向右边
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_carVC.collectionView addGestureRecognizer:rightSwipe];
    _carVC.collectionView.userInteractionEnabled = YES;

    _carVC.view.clipsToBounds = NO;
    _carVC.collectionView.clipsToBounds = NO;

    // 把 CarVC的View 添加进去
    [self.view addSubview:_carVC.view];
    
#pragma mark --- 注意： addChildViewController 的使用！！！
    [self addChildViewController:_carVC];

}

#pragma mark -- 隐藏CarVC
- (void)rightSwipeAction
{
    [self hideCarVC];
}

-(void)showCarVC{
    [UIView animateWithDuration:0.5 animations:^{
        _carVC.view.frame = CGRectMake(kTableView_W, 0, kCarVC_W-20, screen_height-64-49);
//        _maskView.hidden = NO;
    }];
    
    
}
-(void)hideCarVC{
    [UIView animateWithDuration:0.5 animations:^{
        _carVC.view.frame = CGRectMake(screen_width, 0, kCarVC_W-20, screen_height-64-49);
//        _maskView.hidden = YES;
    }];
    
}


/**
 *  carVCLoadData
 */
-(void)carVCLoadDataWithModel:(BrandModel *)model{
    _carVC.cid = model.cid;//加载数据需要的参数
    _carVC.cidTableName = [NSString stringWithFormat:@"car%@",model.cid];//表名
    
    // CarRightViewController 里公开一个 loadData 接口
    [_carVC loadData];
    
}


#pragma mark --- 懒加载
- (NSMutableArray *)brandListArray
{
    if (_brandListArray == nil) {
        _brandListArray = [[NSMutableArray alloc] init];
    }
    return _brandListArray;
}

- (NSMutableArray *)detailListArray
{
    if (nil == _detailListArray) {
        _detailListArray = [[NSMutableArray alloc] init];
    }
    return _detailListArray;
}

@end
