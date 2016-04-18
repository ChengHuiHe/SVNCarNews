//
//  CarVideoTableController.m
//  CarNews
//
//  Created by Chenghui on 16/3/4.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CarVideoTableController.h"

#import "MyCollectionViewCell.h"
#import "CarLsitMdoel.h"
#import "CarVideoModel.h"
#import "PlayerController.h"

@interface CarVideoTableController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

/**
 *  每个cell的 section 头视图，例如：更多！
 */
//@property (nonatomic,strong)CarVideoSectionHeadView *cellHeadView;

@property (nonatomic,strong)UICollectionView *collectionView;


@property(nonatomic,strong) NSMutableArray *dataListArray;

/**
 *  视频的cell 的个数
 */
@property (nonatomic,strong) NSMutableArray *listArray;

@property (nonatomic,strong) CarVideoModel *videoModel;

@end

@implementation CarVideoTableController


#pragma mark -- 懒加载
- (NSMutableArray *)dataListArray
{
    if (_dataListArray == nil) {
        _dataListArray = [NSMutableArray new];
    }
    return _dataListArray;
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}

- (CarVideoModel *)videoModel
{
    if (nil == _videoModel) {
        _videoModel = [[CarVideoModel alloc] init];
        
    }
    return _videoModel;
}


- (void)viewDidLoad {
 
    [super viewDidLoad];

    [self createUI];
    
    // 请求数据
    [self requestVideoDatas];
    
}

- (void)createUI
{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, KMainScreenHeight-50) collectionViewLayout:layout];
    
    layout.headerReferenceSize=CGSizeMake(KMainScreenWidth, 30);
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    
    // 注册 头部视图
    [self.collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
   
    // 注册 UICollectionViewCell --- xib 专用
    UINib *nib = [UINib nibWithNibName:@"MyCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    
    //    注册cell 的类 --- 纯代码
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
}

#pragma mark -- 请求数据

- (void)requestVideoDatas
{
    [QFHttpManager getWithURL:KVideo_URL andParamDic:nil returnBlock:^(NSURLResponse *response, NSError *error, id data) {
        
        if (error) {
            NSLog(@"error = %@",error);
        }else {
            
            NSArray *array = data[@"Data"];
            
            for (NSDictionary *dic in array) {
               
                self.videoModel = [[CarVideoModel alloc] init];
                self.videoModel.CatName = dic[@"CatName"];
            
                NSArray *carListArray = dic[@"CatList"];
            
//            self.listArray = [NSMutableArray new];
            //遍历数组
            for (NSDictionary *dataDic in carListArray) {
                
                CarLsitMdoel *listModel = [[CarLsitMdoel alloc] init];
                [listModel setValuesForKeysWithDictionary:dataDic];
                
                CHLog(@"%@, 观看次数：%@",listModel.Title,listModel.TotalVisit);
                
                [self.listArray addObject:listModel];
            }
            // 这样才完整解析
            self.videoModel.CatList = self.listArray;
            
            [self.dataListArray addObject:self.videoModel];
        
        }
    }
        
        [self.collectionView reloadData];

    }];

}


#pragma mark - Table view data source

#pragma mark --collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArray.count;
}

//返回每一个cell 的大小的方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(KMainScreenWidth/2-20, 200);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

        static NSString  *cellID = @"MyCollectionViewCell";
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
//    self.videoModel = self.dataListArray[indexPath.item];
//    [cell setCarListModel:model.CatList[indexPath.item]];
//    
    // 显示全部
        [cell setCarListModel:self.videoModel.CatList[indexPath.item]];
        
        return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
    
}


#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        
    PlayerController *playerVC = [[PlayerController alloc] init];
    
    playerVC.URLString = self.videoModel.CatList[indexPath.row].Mp4Link;
    
    
    CHLog(@"---%@",playerVC.URLString);
    
    [self.navigationController pushViewController:playerVC animated:YES];
    
}


//返回组头和组尾视图的方法
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
        UICollectionViewCell * cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, screen_width, 50)];
            //            [cell.contentView addSubview:]
        }
        
        cell.backgroundColor = [UIColor darkGrayColor];
    
    
        return cell;
}


//// 返回的cell 的高度
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 新秀推荐 的cell
//    if (indexPath.section==0) {
//        
//        return 145;
//    }else{
//        
//        return 280*KWidth_Scale;
//    }
//    
//    return 0;
//}

@end
