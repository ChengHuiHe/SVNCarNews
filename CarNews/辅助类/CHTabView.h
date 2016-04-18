//
//  CHTabView.h
//  CHKitchen
//
//  Created by Chenghui on 16/3/31.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHTabView : UIView

// 标题数组
@property(nonatomic,strong)NSMutableArray *titlesArray;

// 当前选中的序号
@property(nonatomic,assign)NSInteger selectedIndex;

- (instancetype)initWithFrame:(CGRect)frame titlesArray:(NSArray*)titleArray;

@end
