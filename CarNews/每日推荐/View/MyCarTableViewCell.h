//
//  MyCarTableViewCell.h
//  CarNews
//
//  Created by Chenghui on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCarModel.h"

@interface MyCarTableViewCell : UITableViewCell

@property (nonatomic,strong)MyCarModel *myCarModel;



/**
 *  定义一个属性来判断是否是 选择 收藏！
 */
@property (nonatomic, assign) BOOL isCollection;

/**
 *  使用 block 或 代理等，处理“复用” 和 点击事件
 */
@property (nonatomic,copy) void(^tapAtFavoriteButton)(BOOL isCollected);


@end
