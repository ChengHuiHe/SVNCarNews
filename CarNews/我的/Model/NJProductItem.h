//
//  NJProductItem.h
//  09-彩票(lottery)
//
//  Created by apple on 14-6-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum
//{
//    NJProductItemTypeArrow,
//    NJProductItemTypeSwitch
//}NJProductItemType;

typedef  void (^optionBlcok)();

@interface NJProductItem : NSObject
/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *tilte;
/**
 *  目标控制器
 */
//@property (nonatomic, assign) Class destVC;

// 定义block保存将来要执行的代码
@property (nonatomic, copy) optionBlcok option;


// 定义属性保存cell后面显示什么类型辅助视图
//@property (nonatomic, assign) NJProductItemType type;


//- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVc;
- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;
@end
