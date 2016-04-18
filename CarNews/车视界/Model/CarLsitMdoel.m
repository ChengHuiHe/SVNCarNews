//
//  CarLsitMdoel.m
//  CarNews
//
//  Created by Chenghui on 16/3/4.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CarLsitMdoel.h"


@implementation CarLsitMdoel

//+(BOOL)propertyIsOptional:(NSString *)propertyName
//{
//    return YES;
//}
//

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


///** 对象方法*/
//-(instancetype)initWithCarListDict:(NSDictionary*)dict
//{
//    if (self = [super init]) {
//        
//        self.Author = dict[@"Author"];
//        self.CategoryId = dict[@"CategoryId"];
//        self.ImageLink = dict[@"ImageLink"];
//        self.Mp4Link = dict[@"Mp4Link"];
//        self.PlayLink = dict[@"PlayLink"];
//        self.Summary = dict[@"Summary"];
//        self.Duration = dict[@"Duration"];
//        self.Title = dict[@"Title"];
//        self.TotalVisit = dict[@"TotalVisit"];
//        self.VideoId = dict[@"VideoId"];
//        
//    }
//    return self;
//}
//
///** 类方法*/
//+(instancetype)carListWithDict:(NSDictionary*)dict
//{
//    return [[self alloc] initWithCarListDict:dict];
//}


@end
