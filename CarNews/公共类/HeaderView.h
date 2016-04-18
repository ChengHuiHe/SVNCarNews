//
//  HeaderView.h
//  CarNews
//
//  Created by Chenghui on 16/4/2.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

/**
 *  标题数组
 */
@property (nonatomic,strong) NSMutableArray *allDataArray;

/**
 *  当前选中的广告序号
 */
@property (nonatomic,assign) NSInteger selectedIndex;

//公开一个带所有广告信息数组的构造方法
- (instancetype)initWithFrame:(CGRect)frame allDataArray:(NSArray*)allDataArray;

@end
