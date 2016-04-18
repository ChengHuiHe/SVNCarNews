//
//  HeaderView.m
//  CarNews
//
//  Created by Chenghui on 16/4/2.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "HeaderView.h"
#import "UIImageView+WebCache.h"
#import "AdvertisementModel.h"
#import "DetailViewController.h"
#import "SDCycleScrollView.h"

@interface HeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)UIImageView * advImage;

@property (nonatomic,strong)AdvertisementModel *advModel;

@end

@implementation HeaderView

- (NSMutableArray *)allDataArray
{
    if (nil == _allDataArray) {
        _allDataArray = [NSMutableArray new];
    }
    return _allDataArray;
}

- (instancetype)initWithFrame:(CGRect)frame allDataArray:(NSMutableArray *)allDataArrays
{
    if (self == [super initWithFrame:frame]) {
        
        self.allDataArray = [NSMutableArray arrayWithArray:allDataArrays];
        
        // 创建 广告图片
        [self createADVImage];
    }
    return self;
}

#pragma mark -- 创建广告
- (void)createADVImage
{
    NSMutableArray *imagesURLStrings = [[NSMutableArray alloc] init];
    NSMutableArray *titlesStrings = [[NSMutableArray alloc] init];
    
    for (int j =0; j < self.allDataArray.count; j++) {
        
        self.advModel = self.allDataArray[j];
        
        [imagesURLStrings addObject:self.advModel.picUrl];
        [titlesStrings addObject:self.advModel.title];
        
    }
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, Adv_Height)];
    
    scrollView.contentSize = CGSizeMake(self.allDataArray.count * screen_width, Adv_Height);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    
    // 网络加载图片的轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screen_width, Adv_Height) delegate:self placeholderImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
  
    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    cycleScrollView.titlesGroup = titlesStrings;

    [scrollView addSubview:cycleScrollView];
    
    [self addSubview:scrollView];
    
//    UITapGestureRecognizer *tap;



/*
    for (int i = 0; i < self.allDataArray.count; i++) {
        
        self.advImage = [[UIImageView alloc] init];
        self.advImage.frame = CGRectMake(i * screen_width, 0, screen_width, Adv_Height);
        
        // 打开手势（图像）
        self.advImage.userInteractionEnabled = YES;
        self.advImage.tag = 100 + i;
        self.advImage.backgroundColor = [UIColor blackColor];
        
#pragma mark --- 用一个模型来接受数组，并取得数组里的每个元素
        self.advModel = self.allDataArray[i];
        CHLog(@"需要传得值：：：%@",self.advModel.resourceLoc);
        
        // 创建View并添加 小标题
        UIView *advShowLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.advImage.frame)-25, screen_width, 25)];
        advShowLabelView.backgroundColor = [UIColor blackColor];
        advShowLabelView.alpha = 0.5;
        // 添加标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, screen_width - 30, 25)];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        [titleLabel setTextColor:[UIColor whiteColor]];
        titleLabel.text = self.advModel.title;
        
        // 数字标签
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, 30, 25)];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.font = [UIFont systemFontOfSize:15.0];
        numLabel.text = [NSString stringWithFormat:@"%d/%lu",i+1,(unsigned long)self.allDataArray.count];
        [advShowLabelView addSubview:numLabel];
        
        [advShowLabelView addSubview:titleLabel];
        [self.advImage addSubview:advShowLabelView];
        
        
        // 把 Model 路径传过来
        [self.advImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.advModel.picUrl]] placeholderImage:[UIImage imageNamed:@"blueArrow"]];
        
        
        // 给图片添加点击事件
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        // 添加手势
        [self.advImage addGestureRecognizer:tap];
        
        [scrollView addSubview:self.advImage];
    }
*/
    
}

#pragma mark --点击广告的事件
//- (void)tapAction:(UITapGestureRecognizer*)tap
//{
//    // 获取该手势是放在那个视图上的
//    UIImageView *imageAVD = (UIImageView*)tap.view;
//    
//    CHLog(@"点击的tag值：%ld",(long)imageAVD.tag);
//    
//    // 移除所有的手势
////    [imageAVD removeGestureRecognizer:tap];
//    
//    
//    for (int j = 0; j < self.allDataArray.count; j++) {
//        
//        CHLog(@"tag:: %ld , i::%d",(long)imageAVD.tag,j);
//        
//        if ( j == ((imageAVD.tag) - 100)){
//            
//            self.advModel = self.allDataArray[j];
//            
//            CHLog(@"%d , %@",j,self.advModel.resourceLoc);
//            
//            // 创建一个通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"advImage" object:self.advModel.resourceLoc userInfo:nil];
//            // 移除通知
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"advImage" object:nil];
//            
//            break;
//        }
//        
//    }
//    
//}



#pragma mark ---- 懒加载
- (AdvertisementModel *)advModel
{
    if (_advModel == nil) {
        _advModel = [AdvertisementModel new];
    }
    return _advModel;
}

@end
