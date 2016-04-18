//
//  DatabaseSingle.m
//  CarNews
//
//  Created by Chenghui on 16/3/3.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "DatabaseSingle.h"
#import "FMDB.h"

@interface DatabaseSingle ()


#pragma MARK --- 别忘了
@property (nonatomic,strong)FMDatabase *database;

@property (nonatomic, strong) NSLock * lock;

@end

@implementation DatabaseSingle

static DatabaseSingle *single = nil;
static dispatch_once_t token = 0;

+(instancetype)shareSingleton{
    
    
    dispatch_once(&token, ^{
        
        single = [[DatabaseSingle alloc] init];
        
    });
    
    return single;
}

// 当实例化一个对象的时候,如果调用了alloc方法,系统就会调用 allocWithZone
// zone 就代表一片内存
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (!single) {
        
        single = [super allocWithZone:zone];
        
    }
    return single;
}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        // 一个数据库，多张表
        _database = [[FMDatabase alloc] initWithPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/Car.rdb"]];
        
        CHLog(@"%@",NSHomeDirectory());
        
        if (![_database open]) {
            CHLog(@"数据库打开失败！");
        }
        
#pragma mark --- 创建 CarList 表
        if(![_database executeUpdate:@"create table if not exists CarList (id integer primary key autoincrement,title text,publishTime text,origin text,readCount text,picUrlList txt,strURL txt)"])
        {
            CHLog(@"创建表失败");
        }

        
    }
    
    return self;
}


#pragma mark --- 创建数据库
-(BOOL)createDBWithName:(NSString *)name{
    
    NSString * path = NSHomeDirectory();
    
    NSString * filePath = [NSString stringWithFormat:@"%@/Documents/%@",path, name];
    
    NSLog(@"%@", filePath);
    
    self.database = [[FMDatabase alloc] initWithPath:filePath];
    
    BOOL sucess = [self.database open];
    
    return sucess;
}


/**
 *  建表
 */
-(BOOL)createTabelWithName:(NSString *)tableName andKeys:(NSArray *)keys{
    [_lock lock];
    //创建keys string
    NSMutableString * mStr = [NSMutableString stringWithString:@"indexid integer primary key autoincrement"];
    for (NSString * key in keys) {
        [mStr appendFormat:@",%@ text",key];
    }
    
    
    NSString * sql = [NSString stringWithFormat:@"create table if not exists %@ (%@);",tableName,mStr];
    
    BOOL b = [self.database executeUpdate:sql];
    
    [_lock unlock];
    return b;
}


/**
 *  写数据
 */
-(BOOL)insertTable:(NSString *)tableName WithValus:(NSArray *)values andKeys:(NSArray *)keys{
    [_lock lock];
    
    if (values.count == 0) {
        NSLog(@"空数据不能插入表格");
        return NO;
    }
    
    NSMutableString * mKeys = [NSMutableString stringWithFormat:@"%@",keys[0]];
    NSMutableString * mValues = [NSMutableString stringWithFormat:@"'%@'",values[0]];
    
    for (int i = 1; i < values.count; i++) {
        
        [mKeys appendFormat:@",%@",keys[i]];
        [mValues appendFormat:@",'%@'",values[i]];
        
    }
    
    NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@) values(%@)",tableName, mKeys,mValues];
    BOOL b = [self.database executeUpdate:sql];
    
    [_lock unlock];
    
    return b;
}

/**
 *  将字典自如数据，需要字典的key和表的key相同
 */
-(BOOL)insertTable:(NSString *)tableName params:(NSDictionary *)dict{
    
    [_lock lock];
    
    if (dict.count==0) {
        NSLog(@"空数据不能插入表格");
        return NO;
    }
    
    NSMutableString * mKeys = [NSMutableString string];
    NSMutableString * mValues = [NSMutableString string];
    
    for (NSString * key in dict) {
        [mKeys appendFormat:@",%@",key];
        [mValues appendFormat:@",'%@'",[dict valueForKey:key]];
    }
    
    [mKeys deleteCharactersInRange:NSMakeRange(0, 1)];
    [mValues deleteCharactersInRange:NSMakeRange(0, 1)];
    
    NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@) values(%@)",tableName, mKeys,mValues];
    BOOL b = [self.database executeUpdate:sql];
    
    [_lock unlock];
    
    return b;
    
}

/**
 *  删除所有数据
 */
-(BOOL)deleteAllInTable:(NSString *)name{
    
    [_lock lock];
    
    NSString * sql = [NSString stringWithFormat: @"delete from %@", name];
    BOOL b = [self.database executeUpdate:sql];
    [_lock unlock];
    return b;
}

/**
 *  selectAllData, 返回装字典的数组
 */
-(NSArray *)selectAllFromTable:(NSString *)name{
    
    [_lock lock];
    
    NSString * sql = [NSString stringWithFormat: @"select * from %@", name];
    FMResultSet * set = [self.database executeQuery:sql];
    NSMutableArray * array = [NSMutableArray array];
    while (set.next) {
        [array addObject:[set resultDictionary]];
    }
    
    [_lock unlock];
    return array;
}

/**
 *  values
 */
+(NSArray *)valuesWithDict:(NSDictionary *)dict andKeys:(NSArray *)keys{
    
    NSMutableArray * values = [NSMutableArray array];
    for (NSString * key in keys) {
        if ([dict valueForKey:key] != nil) {
            [values addObject:[dict valueForKey:key]];
        }
    }
    return values;
}

/**
 *  条件删除记录
 */
-(BOOL)deleteRecordInTable:(NSString *)name withValue:(NSString *)value andKey:(NSString *)key{
    NSString * sql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", name, key, value];
    BOOL b = [self.database executeUpdate:sql];
    return b;
}


/**
 *  查询数据
 */
-(BOOL)existsRecordInTable:(NSString *)name withValue:(NSString *)value andKey:(NSString *)key{
    NSString * sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'", name, key, value];
    FMResultSet * set = [self.database executeQuery:sql];
    while (set.next) {
        return YES;
    }
    return NO;
}

/**
 *  删除表
 */
-(BOOL)dropTable:(NSString *)name{
    NSString * sql = [NSString stringWithFormat:@"drop table %@", name];
    BOOL b = [self.database executeUpdate:sql];
    return b;
}


#pragma mark--- 插入 数据
-(void)insertHomeCar:(HomeModel*)model
{
    if (![self.database executeUpdate:@"insert into CarList (title,publishTime,origin,readCount,picUrlList,strURL) values (?,?,?,?,?,?)",model.title,model.publishTime,model.origin,model.readCount,model.picUrlList,model.strURL]) {
        
        CHLog(@"插入失败");
    }
}


//- (void)insertMyCar:(MyCarModel *)model
//{
//    if (![self.database executeUpdate:@"insert into CarModel(imageUrl,title,IdCollection,dateStr) values(?,?,?,?)",model.image,model.title,model.IdInterf,model.pubDate]) {
//
//        CHLog(@"插入 MyCarModel 失败");
//
//    }else {
//        CHLog(@"%@,%@,%@,%@",model.image,model.title,model.IdInterf,model.pubDate);
//    }
//}


#pragma mark ---- 删除数据
-(void)deleteHomeCar:(HomeModel *)model
{
    if (![self.database executeUpdate:@"delete from CarList where title = ?",model.title]) {
        
        CHLog(@"删除失败");
        
    }

}

/**
 *  删除整个模型 --- 危险！！！
 *
 *  @param model
 */
//- (void)deleteMyCar:(MyCarModel *)model
//{
//    if (![self.database executeUpdate:@"delete from CarModel where title = ?",model.title]) {
//        
//        CHLog(@"删除失败");
//    }
//}


#pragma mark --- 删除失败
// 查询数据
-(NSArray *)searchDatabaseWithTitle
{
    FMResultSet *set = [self.database executeQuery:@"select * from CarList"];
    NSMutableArray *newArr = [NSMutableArray new];
    while ([set next]) {

        // 要是用CoreData就好方便了
        HomeModel *homeModel = [HomeModel new];
    
        homeModel.title = [set stringForColumn:@"title"];
        homeModel.publishTime = [set stringForColumn:@"publishTime"];
        homeModel.origin = [set stringForColumn:@"origin"];
        homeModel.readCount = [set stringForColumn:@"readCount"];
        
#pragma mark --- to do ???
        // ???
        homeModel.strURL = [set stringForColumn:@"strURL"];
        
        // 添加到数组
        [newArr addObject:homeModel];
    }
    
    CHLog(@"%ld",newArr.count);
    
    return newArr;
}

// 查询数据
-(NSArray *)searchDatabaseWithCarTitle
{
    FMResultSet *set = [self.database executeQuery:@"select * from CarModel"];
    NSMutableArray *newArr = [NSMutableArray new];
    while ([set next]) {
        
        // 要是用CoreData就好方便了
        MyCarModel *myCarModel = [MyCarModel new];
        
        myCarModel.title = [set stringForColumn:@"title"];
//        myCarModel.pubDate = [set stringForColumn:@"pubDate"];
//        myCarModel.image = [set stringForColumn:@"image"];
//        myCarModel.IdInterf = [set stringForColumn:@"IdCollection"];
        
        // 添加到数组
        [newArr addObject:myCarModel];
    }
    
    CHLog(@"%ld",newArr.count);
    
    return newArr;
}


@end
