//
//  CategoryCarValueModel.h
//  CarNews
//
//  Created by Chenghui on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CategoryCarValueModel : JSONModel

//"displayname": "奥迪A3三厢",
@property (nonatomic, copy) NSString<Optional> * displayname;
//"name": "A3三厢",
@property (nonatomic, copy) NSString<Optional> * name;
//"firstchar": "A",
//"autoid": "16962",
@property (nonatomic, copy) NSString<Optional> * autoid;
//"flag": "0",
//"status": "0",
//"cid": "00AU0BRA0BUV0BXd0QSC",
@property (nonatomic, copy) NSString<Optional> * cid;
//"topicid": "56NS0008",
//"cover_white": "http://img3.cache.netease.com/photo/0008/2015-05-25/t_AQF5NU6O56NS0008.jpg",
//"cover_white_big": "http://img3.cache.netease.com/photo/0008/2015-05-25/300x225_AQF5NU6O56NS0008.jpg",
//"normal_pic": "http://img3.cache.netease.com/photo/0008/2015-05-25/t_AQF5NU6O56NS0008.jpg",
@property (nonatomic, copy) NSString<Optional> * normal_pic;
//"normal_pic_big": "http://img3.cache.netease.com/photo/0008/2015-05-25/300x225_AQF5NU6O56NS0008.jpg",
//"productNum": 9,
@property (nonatomic, copy) NSString<Optional> * productNum;
//"updatetime": "2015-10-08 15:53:35",
//"ordertime": "490",
//"authorityprice": "20.59"
@property (nonatomic, copy) NSString<Optional> * authorityprice;

@property (nonatomic, copy) NSString <Optional> * isCollected;


#pragma mark --- 数据库操作
+(NSArray *)allKeys;

@end
