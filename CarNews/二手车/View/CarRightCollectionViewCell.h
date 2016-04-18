//
//  CarRightCollectionViewCell.h
//  CarNews
//
//  Created by Chenghui on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryCarValueModel.h"

@interface CarRightCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) CategoryCarValueModel *carRightModel;

/**
 *  是否收藏
 */
@property (nonatomic, assign) BOOL isCollection;

@property (nonatomic, copy) void(^tapAtCollection)(BOOL isCollected);

@end
