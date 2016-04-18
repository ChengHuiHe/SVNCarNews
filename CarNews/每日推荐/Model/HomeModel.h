//
//  HomeModel.h
//  CarNews
//
//  Created by Chenghui on 16/3/3.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PictUrlListMoel.h"


//@protocol PictUrlListMoel <NSObject>
//
//@end

@interface HomeModel : JSONModel

/**
 *  要传值的ID号
 */
@property (nonatomic,copy) NSString *resourceLoc;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *publishTime;

@property (nonatomic,copy) NSString *origin;

@property (nonatomic,copy) NSString *readCount;

// 没有图片色时候，显示的描述
@property (nonatomic,copy) NSString *excerpt;


/**
 *  评论数
 */
@property (nonatomic,copy) NSString *CommuntCount;


/**
 *  6为 头客条，2 为原创
 */
@property (nonatomic,assign) NSString *articleType;



// 图片---数组
@property (nonatomic,strong) NSArray<PictUrlListMoel *> *picUrlList;
@property (nonatomic,copy) NSString *strURL; // 额外添加

@end

