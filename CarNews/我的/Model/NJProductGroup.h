
//
//  NJProductGroup.h
//  09-彩票(lottery)
//
//  Created by apple on 14-6-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJProductGroup : NSObject
/**
 *   头部标题
 */
@property (nonatomic, copy) NSString *headerTitle;
/**
 *  底部标题
 */
@property (nonatomic, copy) NSString *footerTitle;
/**
 *  当前分组中所有行的数据(保存的是NJProductItem模型)
 */
@property (nonatomic, strong) NSArray *items;

@end
