//
//  BrandModel.h
//  CarNews
//
//  Created by Chenghui on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandModel : NSObject

//"firstchar": "A",
@property (nonatomic, copy) NSString<Optional> * firstchar;
//normal_pic
@property (nonatomic, copy) NSString<Optional> * normal_pic;
//"updatetime": "2015-09-17 16:26:27",
@property (nonatomic, copy) NSString<Optional> * updatetime;
//"status": 0,
@property (nonatomic, copy) NSString<Optional> * status;
//"autoid": "1685",
@property (nonatomic, copy) NSString<Optional> * autoid;

//"cid": "00AU0BRA0BUV", --- 传值，然后显示右边的列表！！！
@property (nonatomic, copy) NSString<Optional> * cid;
//"bphoto": "http://img3.cache.netease.com/photo/0008/autolib/logo/white/1685.jpg",256 * 256
@property (nonatomic, copy) NSString * bphoto;
//"urlkeyword1": "audi",
@property (nonatomic, copy) NSString<Optional> * urlkeyword1;
//"name": "A--奥迪"
@property (nonatomic, copy) NSString<Optional> * name;

/**
 *  本地数据
 */
+(NSArray *)allkeys;

@end
