//
//  CacheClear.h
//  CarNews
//
//  Created by Chenghui on 16/4/12.
//  Copyright © 2016年 Chenghui. All rights reserved.
//
// 清除缓存
#import <Foundation/Foundation.h>

@interface CacheClear : NSObject

/**
 *  文件大小
 */
+(float)fileSizeAtPath:(NSString *)path;

/**
 *  文件夹大小
 */
+(float)folderSizeAtPath:(NSString *)path;

/**
 *  清除缓存
 */
+(void)clearCache:(NSString *)path;

@end
