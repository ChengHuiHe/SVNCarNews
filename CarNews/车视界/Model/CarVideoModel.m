//
//  CarVideoModel.m
//  CarNews
//
//  Created by Chenghui on 16/3/4.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CarVideoModel.h"

@implementation CarVideoModel

//+(BOOL)propertyIsOptional:(NSString *)propertyName
//{
//    return YES;
//}

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


//- (instancetype)initWithCarModelDict:(NSDictionary*)dict
//{
//    if (self = [super init]) {
//        
//        self.CatName = dict[@"CatName"];
//        NSArray *array = dict[@"CatList"];
//        // 获取List数组
//        NSMutableArray *mutableArray = [NSMutableArray new];
//        for (NSDictionary *dict in array) {
//            // KVC
//            CarLsitMdoel *listModel = [CarLsitMdoel carListWithDict:dict];
//            CHLog(@"----=====---%@",listModel.Mp4Link);
//            
//            [mutableArray addObject:listModel];
//        }
//        
//        
//        self.CatList = mutableArray;
//        
//    }
//    return self;
//}
//
//+(instancetype)carVideoWithDict:(NSDictionary*)dict
//{
//    return [[self alloc] initWithCarModelDict:dict];
//}


@end
