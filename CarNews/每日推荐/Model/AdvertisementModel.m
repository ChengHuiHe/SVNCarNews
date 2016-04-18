//
//  AdvertisementModel.m
//  CarNews
//
//  Created by Chenghui on 16/4/2.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "AdvertisementModel.h"

@implementation AdvertisementModel

/**
 利用kvc解析json，一定要实现下面的两个方法！
 */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //找到和属性不一致名字的key，然后赋值给self的属性
//    if ([key isEqualToString:@"description"]) {
//        self.descriptionStr = value;
//    }
}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
@end
