//
//  MyCarModel.m
//  CarNews
//
//  Created by Chenghui on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//
// 新车和行业 模型
#import "MyCarModel.h"

@implementation MyCarModel

/**
 利用kvc解析json，一定要实现下面的两个方法！
 */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //找到和属性不一致名字的key，然后赋值给self的属性
//    if ([key isEqualToString:@"id"]) {
//        self.IdInterf = value;
//    }
}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
