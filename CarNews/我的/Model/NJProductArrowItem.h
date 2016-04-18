//
//  NJProductArrowItem.h
//  09-彩票(lottery)
//
//  Created by apple on 14-6-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NJProductItem.h"

@interface NJProductArrowItem : NJProductItem
/**
 *  目标控制器
 */
@property (nonatomic, assign) Class destVC;

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVc;
@end
