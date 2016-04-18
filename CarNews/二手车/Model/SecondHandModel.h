//
//  SecondHandModel.h
//  CarNews
//
//  Created by Chenghui on 16/3/5.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondHandModel : JSONModel

@property (nonatomic,copy) NSString *UcarID;

/**
 *  城市ID
 */
//@property (nonatomic,copy) NSString *CityID;

@property (nonatomic,copy) NSString *CityName;

//@property (nonatomic,copy) NSString *ProvinceID;
@property (nonatomic,copy) NSString *ProvinceName;

//@property (nonatomic,copy) NSString *MainBrandId;
/**
 *  比亚迪（品牌）
 */
@property (nonatomic,copy) NSString *MainBrandName;
//@property (nonatomic,copy) NSString *BrandId;
/**
 *  比亚迪S6（车型）
 */
@property (nonatomic,copy) NSString *BrandName;
//@property (nonatomic,copy) NSString *CarID;
@property (nonatomic,copy) NSString *CarName;
@property (nonatomic,copy) NSString *Exhaust;
@property (nonatomic,copy) NSString *CarPublishTime;
@property (nonatomic,copy) NSString *PictureCount;
@property (nonatomic,copy) NSString *BuyCarDate;
@property (nonatomic,copy) NSString *DisPlayPrice;
@property (nonatomic,copy) NSString *DrivingMileage;
@property (nonatomic,copy) NSString *CarSource1l;
@property (nonatomic,copy) NSString *UcarSerialNumber;

/**
 *  多张图片
 */
@property (nonatomic,copy) NSString *GImgs;
@property (nonatomic,copy) NSString *ImageURL;
/**
 *  非品牌认证
 */
@property (nonatomic,copy) NSString *Authenticated;

@property (nonatomic,copy) NSString *IsDealerAuthorized; //非淘车认证
@property (nonatomic,copy) NSString *IsZhiBao;// 非质保

/**
 *  25分钟前
 */
@property (nonatomic,copy) NSString *CarShortPublishTime;
@property (nonatomic,copy) NSString *ShowPublisTime;
@property (nonatomic,copy) NSString *CarService;

@property (nonatomic,copy) NSString *CarDetailUrl;
/**
 *  上市时间
 */
@property (nonatomic,copy) NSString *BuyCarDate_New;
@property (nonatomic,copy) NSString *CarServiceNew;
/**
 *  出厂价格
 */
@property (nonatomic,copy) NSString *NewCarPrice;

@end
