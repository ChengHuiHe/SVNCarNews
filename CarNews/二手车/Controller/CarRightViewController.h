//
//  CarRightViewController.h
//  CarNews
//
//  Created by Chenghui on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//
// 右边的 collectionView

#import <UIKit/UIKit.h>

#import "CategoryCarValueModel.h"

@interface CarRightViewController : UIViewController

/**
 *  创建一个 collectionView
 */
@property (nonatomic, strong) UICollectionView * collectionView;
/**
 *  传 cid    00AU0BRA0BUV0BXd0QSC
 */
@property (nonatomic, copy) NSString * cid;


@property (nonatomic, copy) NSString * cidTableName;
@property (nonatomic, copy) NSString * nameTableName;


@property (nonatomic, copy) void(^tapAtCellHide)(void);
@property (nonatomic, copy) void(^tapAtCellShow)(void);

// 处理参数
-(void)loadData;


@end
