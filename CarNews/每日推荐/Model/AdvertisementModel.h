//
//  AdvertisementModel.h
//  CarNews
//
//  Created by Chenghui on 16/4/2.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertisementModel : NSObject

@property (nonatomic,copy) NSString *jumpType;
@property (nonatomic,copy) NSString *picUrl;
@property (nonatomic,copy) NSString *playTime;
/**
 *  点击广告时调到详细页面 的参数
 */
@property (nonatomic,copy) NSString *resourceLoc;

@property (nonatomic,copy) NSString *title;


@end
