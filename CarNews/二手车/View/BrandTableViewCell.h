//
//  BrandTableViewCell.h
//  CarNews
//
//  Created by Chenghui on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandModel.h"

@interface BrandTableViewCell : UITableViewCell

@property (nonatomic,strong) BrandModel *brandModel;

// 记录是否选中，存入数据库
@property (nonatomic, assign) BOOL isseleted;

// 提供2个接口，点击后的颜色
-(void)changeColor;
-(void)originColor;

@end
