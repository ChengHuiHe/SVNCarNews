//
//  NJProductArrowItem.m
//  09-彩票(lottery)
//
//  Created by apple on 14-6-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NJProductArrowItem.h"

@implementation NJProductArrowItem

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVc
{
    if (self = [super initWithIcon:icon title:title]) {
        self.destVC = destVc;
    }
    return self;
}
@end
