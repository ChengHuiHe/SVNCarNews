//
//  CHRootViewController.m
//  CarNews
//
//  Created by Chenghui on 16/3/31.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CHRootViewController.h"
#import "CHTabView.h"
// "头条",@"新车",@"行业",@"导购",@"头条客",@"用车"
#import "CHTopViewController.h"
#import "CHNewCarViewController.h"
#import "CHIndustryViewController.h"
#import "CHGuideViewController.h"
//#import "CHTouTiaokeViewController.h"
//#import "CHUseCarViewController.h"

#import "DetailViewController.h"


@interface CHRootViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;

@property (nonatomic,strong) CHTabView *tabView;

/**
 *  标题
 */
@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation CHRootViewController

// 界面移除时 移除通知,不移除的话，你的通知方法会被调用多次
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"advImage" object:nil];
    
    // 3.移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNotification_CHTabView_btnClicked object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleArray = [[NSArray alloc] init];
    self.titleArray = @[@"头条",@"新车",@"行业",@"测评"];
    
    // 添加头部视图
    self.tabView = [[CHTabView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 35, 44) titlesArray:self.titleArray];
    
    self.navigationItem.titleView = self.tabView;
    
#pragma mark ------
    // 把内边距去掉（当有navgationBar的时候，默认会让它有边距，所以，要设置）
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark ------
// 约束产生作用后 --- 之前在storyboard 图片的大小一直是320，使用viewDidLayoutSubviews 后，约束生效！
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
//    // 添加子VC
    [self addClidVC];

    // 2. 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabViewButtonClicked:) name:NSNotification_CHTabView_btnClicked object:nil];

    // 2.监听通知 --- 广告的点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(advImageTap:) name:@"advImage" object:nil];

}


// 通知事件=== 传值
- (void)advImageTap:(NSNotification*)sender
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"advImage" object:nil];

    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    CHLog(@"传值啊：：：：%@",sender.object);
    
    detailVC.resourceLocID = sender.object;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark --- 把ViewController的视图，添加到scrollerview 上
- (void)addClidVC
{
    //1. 修改scrollView的contentSize
    self.scrollerView.contentSize = CGSizeMake(self.titleArray.count * _scrollerView.width, _scrollerView.height);
    
    // 添加视图控制器
    CHTopViewController *topVC = [[CHTopViewController alloc] init];
    //修改子ViewController.view的frame
    topVC.view.frame = CGRectMake(0, 0, _scrollerView.width, _scrollerView.height);
    [_scrollerView addSubview:topVC.view];

    
    CHNewCarViewController *newCarVC = [[CHNewCarViewController alloc] init];
    //修改子ViewController.view的frame
    newCarVC.view.frame = CGRectMake(_scrollerView.width, 0, _scrollerView.width, _scrollerView.height);
    [_scrollerView addSubview:newCarVC.view];
    
    
    // 3.驾游记
    CHGuideViewController *guideVC = [[CHGuideViewController alloc] init];
    //修改子ViewController.view的frame
    guideVC.view.frame = CGRectMake(2 * _scrollerView.width, 0, _scrollerView.width, _scrollerView.height);
    [_scrollerView addSubview:guideVC.view];
    

    
    CHIndustryViewController *indestryVC = [[CHIndustryViewController alloc] init];
    //修改子ViewController.view的frame
    indestryVC.view.frame = CGRectMake(3 * _scrollerView.width, 0, _scrollerView.width, _scrollerView.height);
    [_scrollerView addSubview:indestryVC.view];
    
    
//    CHTouTiaokeViewController *touTiaoKeVC = [[CHTouTiaokeViewController alloc] init];
    //修改子ViewController.view的frame
//    touTiaoKeVC.view.frame = CGRectMake(4 * _scrollerView.width, 0, _scrollerView.width, _scrollerView.height);
//    [_scrollerView addSubview:touTiaoKeVC.view];

    
#pragma mark -- 把这个小模块，暂时去掉！
//    CHUseCarViewController *userCarVC = [[CHUseCarViewController alloc] init];
//    //修改子ViewController.view的frame
//    userCarVC.view.frame = CGRectMake(5 * _scrollerView.width, 0, _scrollerView.width, _scrollerView.height);
//    [_scrollerView addSubview:userCarVC.view];

    
    // 添加视图控制器的层级关系
    [self addChildViewController:topVC];
    [self addChildViewController:newCarVC];
    [self addChildViewController:guideVC];
    [self addChildViewController:indestryVC];
//    [self addChildViewController:touTiaoKeVC];
//    [self addChildViewController:userCarVC];
    
    
    // 添加KVO
    [_scrollerView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == self.scrollerView && [keyPath isEqualToString:@"contentOffset"]) {
        
        // --- NSValue 类型 获取 contentOffset
        NSValue * pointValue = change[@"new"];
        CGPoint point;
        [pointValue getValue:&point]; // 容器不能存结构体，要这样才行
        
        self.tabView.selectedIndex = point.x / _scrollerView.width;
    }
}

// 3.实现通知方法
- (void)tabViewButtonClicked:(NSNotification*)notify
{
    // 获取 通知传来的值
    //    NSDictionary *dict = [notify userInfo];
    
    _scrollerView.contentOffset = CGPointMake(_scrollerView.width *self.tabView.selectedIndex, 0);
    
}


@end
