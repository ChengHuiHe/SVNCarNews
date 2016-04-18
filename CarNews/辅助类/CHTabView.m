//
//  CHTabView.m
//  CHKitchen
//
//  Created by Chenghui on 16/3/31.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CHTabView.h"

@interface CHTabView ()<UIScrollViewDelegate>

/**
 *  红色，小标记线
 */
@property(nonatomic,strong)UIView *indicatorView;

@property (retain,nonatomic)UIScrollView * titleScrollView;

@end


@implementation CHTabView

- (instancetype)initWithFrame:(CGRect)frame titlesArray:(NSArray*)titleArray
{
    if (self = [super initWithFrame:frame]) {
        
        self.titlesArray = [NSMutableArray arrayWithArray:titleArray];
        
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, (CGFloat)screen_width, 44)];
        
//        self.titleScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _titleScrollView.contentSize = CGSizeMake((screen_width/5)*self.titlesArray.count , 44);
        _titleScrollView.showsHorizontalScrollIndicator = YES;
        _titleScrollView.delegate = self;
        [self addSubview:_titleScrollView];
        
        [self createButtons];
        
        [self createIndicatorView];
    }
    return self;
}

// 创建线
- (void)createIndicatorView
{
    CGFloat btnWidth = self.width / self.titlesArray.count;
    
    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 2 , btnWidth, 2)];
    
    self.indicatorView.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:self.indicatorView];
    
}

- (void)createButtons
{
    // 这样设计的好处是 只改自己想要的，而frame 要 改 4 个
    NSLog(@"%@",[self class]);

    for (int i = 0; i < self.titlesArray.count; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*buttonWidth -10, 0, buttonWidth, self.height)];
        
        // 设置标题
        [btn setTitle:self.titlesArray[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        btn.tag =  100 + i;
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_titleScrollView addSubview:btn];
        
        
//        if (self.selectedIndex == 0) {
//            btn.selected = YES;
//        }
    }
}

- (void)buttonClick:(UIButton*)btn
{
    // 切换选中的序号
    self.selectedIndex = btn.tag - 100;
    
#pragma mark --- 使用通知 3 个步骤！！
    // 1、通知 （也可以代理！！）
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotification_CHTabView_btnClicked object:nil];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    // 取消之前选中的按钮
    UIButton *preciousBtn = [self viewWithTag:self.selectedIndex+100];
    preciousBtn.selected =  NO;
    
    // 设置新的按钮
    UIButton *button = [self viewWithTag:100+ selectedIndex];
    button.selected =  YES;
    
    
    _selectedIndex = selectedIndex;
    
    
    //    获取用户滑动到第几页了
    int page = _titleScrollView.contentOffset.x / screen_width;
    
    // 修改指示器的位置
    CGFloat btnWith = self.width/self.titlesArray.count;
    // 添加动画
    [UIView animateWithDuration:0.2 animations:^{
        
        if (page == 4) {
            [_titleScrollView setContentOffset:CGPointMake(64*self.titlesArray.count - screen_width, 0) animated:YES];
            
        }else if (page == 3){
            [_titleScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            
        }

        self.indicatorView.x = selectedIndex * btnWith;

    }];
    

}


@end
