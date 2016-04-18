//
//  QFHttpManager.h
//  AppFree
//
//  Created by qianfeng on 16/2/29.
//  Copyright © 2016年 Qianfeng.liufy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//回调block
/*
 response 响应头
 error 错误
 data 数据
 */
typedef void (^returnBlock)(NSURLResponse *response,NSError *error,id data);

@interface QFHttpManager : NSObject



//get请求
+(void)getWithURL:(NSString *)url andParamDic:(NSDictionary *)paramDic returnBlock:(returnBlock)block;



@end
