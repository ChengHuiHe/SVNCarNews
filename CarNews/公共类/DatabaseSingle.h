//
//  DatabaseSingle.h
//  CarNews
//
//  Created by Chenghui on 16/3/3.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HomeModel.h"

#import "MyCarModel.h"

@interface DatabaseSingle : NSObject


+(instancetype)shareSingleton;


// 插入数据
-(void)insertHomeCar:(HomeModel*)model;
// 删除数据
- (void)deleteHomeCar:(HomeModel*)model;
// 查询数据
-(NSArray *)searchDatabaseWithTitle;


#pragma mark --- 行业、驾游记、买买


// 插入数据
//-(void)insertMyCar:(MyCarModel*)model;
//
//// 删除数据
//- (void)deleteMyCar:(MyCarModel*)model;
//
//
//// 查询数据 --- 所有的数据
//-(NSArray *)searchDatabaseWithCarTitle;
//

#pragma mark ------
/**
 *  单例, 同时建立数据库
 */
//+(instancetype)sharedCenter;

/**
 *  建立数据库
 */
-(BOOL)createDBWithName:(NSString *)name;
/**
 *  建表
 */
-(BOOL)createTabelWithName:(NSString *)tableName andKeys:(NSArray *)keys;

/**
 *  写数据
 */
-(BOOL)insertTable:(NSString *)tableName WithValus:(NSArray *)values andKeys:(NSArray *)keys;
/**
 *  将字典自如数据，需要字典的key和表的key相同
 */
-(BOOL)insertTable:(NSString *)tableName params:(NSDictionary *)dict;

/**
 *  删除所有数据
 */
-(BOOL)deleteAllInTable:(NSString *)name;

/**
 *  selectAllData, 返回装字典的数组
 */
-(NSArray *)selectAllFromTable:(NSString *)name;

/**
 *  values
 */
+(NSArray *)valuesWithDict:(NSDictionary *)dict andKeys:(NSArray *)keys;

/**
 *  条件删除记录
 */
-(BOOL)deleteRecordInTable:(NSString *)name withValue:(NSString *)value andKey:(NSString *)key;

/**
 *  查询数据
 */
-(BOOL)existsRecordInTable:(NSString *)name withValue:(NSString *)value andKey:(NSString *)key;


/**
 *  删除表
 */
-(BOOL)dropTable:(NSString *)name;



@end
