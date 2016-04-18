//
//  QFHttpManager.m
//  AppFree
//
//  Created by qianfeng on 16/2/29.
//  Copyright © 2016年 Qianfeng.liufy. All rights reserved.
//

#import "QFHttpManager.h"

@implementation QFHttpManager

+(void)getWithURL:(NSString *)url andParamDic:(NSDictionary *)paramDic returnBlock:(returnBlock)block{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
#pragma mark -- 注意！！！（点进去修改）
//    manager.responseSerializer.acceptableContentTypes
    [manager GET:url parameters:paramDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //成功返回
        block(operation.response,nil,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //失败返回
        block(nil,error,nil);
        
    }];
    
    
}

@end
