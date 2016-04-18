//
//  CHMyButton.h
//  CarNews
//
//  Created by Chenghui on 16/4/4.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHMyButton;

typedef void(^MyBlock)(CHMyButton *button);

@interface CHMyButton : UIButton

@property (nonatomic,copy) MyBlock buttonBlock;

/** 类方法，快速实例化按钮*/
+ (instancetype)addBlockButtonWithFrame:(CGRect)frame
                                  title:(NSString *)title
                                  image:(UIImage *)image
                                bgImage:(UIImage *)bgImage
                                    tag:(int)tag
                            actionBlock:(MyBlock)actionBlock;


@end
