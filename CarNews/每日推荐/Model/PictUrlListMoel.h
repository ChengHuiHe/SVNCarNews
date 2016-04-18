//
//  PictUrlListMoel.h
//  CarNews
//
//  Created by Chenghui on 16/3/3.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictUrlListMoel : JSONModel

//@property (nonatomic,strong) NSArray *picUrlList;

// 二外添加字段，给数据库添加标记
@property (nonatomic,copy)NSString *strURL;

@end
