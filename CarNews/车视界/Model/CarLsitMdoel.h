//
//  CarLsitMdoel.h
//  CarNews
//
//  Created by Chenghui on 16/3/4.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarLsitMdoel : NSObject

@property (nonatomic,copy) NSString *Author;
@property (nonatomic,copy) NSString *CategoryId;
@property (nonatomic,copy) NSString *CategoryName;

@property (nonatomic,strong) NSString *ImageLink;

@property (nonatomic,copy) NSString *Mp4Link;

@property (nonatomic,copy) NSString *PlayLink;

@property (nonatomic,copy) NSString *Summary;

@property (nonatomic,copy) NSString *Duration;

@property (nonatomic,copy) NSString *Title;
@property (nonatomic,copy) NSString *TotalVisit;
@property (nonatomic,copy) NSString *VideoId;

@end
