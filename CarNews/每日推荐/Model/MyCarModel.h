//
//  MyCarModel.h
//  CarNews
//
//  Created by Chenghui on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//
// 新车和行业 模型

#import <Foundation/Foundation.h>

@interface MyCarModel : NSObject

//@property (nonatomic,copy) NSString *image;

/**
 *  到时 删除收藏 要用到此ID
 */
//@property (nonatomic,copy) NSString *IdInterf;
//
//@property (nonatomic,copy) NSString *mtime;
//
//@property (nonatomic,copy) NSString *pubDate;

@property (nonatomic,copy) NSString *title;

//@property (nonatomic,copy) NSString *url;

/**
 *  设置 判断 cell 里面的收藏
 */
@property (nonatomic, copy) NSString <Optional> * isCollected;


#pragma mark --- 新车

@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *facetitle;
@property (nonatomic,copy) NSString *author;

//@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *filepath;// html

@property (nonatomic,copy) NSString *newsid;
// 图片
@property (nonatomic,copy) NSString *PicCover;
// 时间
@property (nonatomic,copy) NSString *publishtime;

@property (nonatomic,copy) NSString *summary;


@end
