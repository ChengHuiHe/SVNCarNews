//
//  Defination.h
//  CarNews
//
//  Created by Chenghui on 16/3/3.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#ifndef Defination_h
#define Defination_h

/*
 * 屏幕宽度
 */
#define KMainScreenWidth  [UIScreen mainScreen].bounds.size.width
/*
 *屏幕高度
 */
#define KMainScreenHeight [UIScreen mainScreen].bounds.size.height


#ifdef DEBUG // 调试阶段
#define CHLog(...) NSLog(__VA_ARGS__)
#else // 发布阶段
#define CHLog(...)
#endif



#endif /* Defination_h */
