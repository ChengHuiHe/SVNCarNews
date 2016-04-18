//
//  CategoryCarModel.h
//  CarNews
//
//  Created by Chenghui on 16/4/12.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CategoryCarValueModel;
@protocol CategoryCarValueModel <NSObject>


@end

@interface CategoryCarModel : JSONModel

//"name": "一汽奥迪",
@property (nonatomic, copy) NSString<Optional> * name;

// 由解析数据可知 values 这是一个数组！所以，在建立一个Model 咯！
//"value": [ 大数组 ],
@property (nonatomic, strong) NSMutableArray<CategoryCarValueModel, Optional> * values;
//"ordertime": "70"


+(NSArray *)allKeys;

@end
