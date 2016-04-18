//
//  CHMyButton.m
//  CarNews
//
//  Created by Chenghui on 16/4/4.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CHMyButton.h"

@implementation CHMyButton

+ (instancetype)addBlockButtonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image bgImage:(UIImage *)bgImage tag:(int)tag actionBlock:(MyBlock)actionBlock{
    CHMyButton *button = [CHMyButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    button.tag = tag;
    button.buttonBlock = actionBlock;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (void)buttonClick:(CHMyButton *)button{
    if (button.buttonBlock) {
        button.buttonBlock(button);
    }
}

@end
