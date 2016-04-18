//
//  NJProductItem.m
//  09-彩票(lottery)
//
//  Created by apple on 14-6-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NJProductItem.h"

@implementation NJProductItem
/*
- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVc
{
    if (self = [super init]) {
        self.icon = icon;
        self.tilte = title;
        self.destVC = destVc ;
    }
    
    return self;
}
 */

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title
{
    if (self = [super init]) {
        self.icon = icon;
        self.tilte = title;
    }
    return self;
}
@end
