//
//  CustomDetailViewController.m
//  CarNews
//
//  Created by Chenghui on 16/4/12.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CustomDetailViewController.h"
#import "UMSocial.h"

@interface CustomDetailViewController ()<UMSocialUIDelegate>

@property (nonatomic,strong) UIScrollView *scrollerView;

@property (nonatomic,strong) UIImageView *myImageView;

@property (nonatomic,strong) UILabel *aurhorLabel;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextView *contentTV;



@end

@implementation CustomDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 1、导航栏的设置
    [self setNac];

    // 创建UI
    [self createUI];
    // 返回按钮
    [self backButtonUI];
}

- (void)backButtonUI
{
    // 返回按钮
    CHMyButton *backButton = [CHMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 60, 30) title:@"返回" image:nil bgImage:[UIImage imageNamed:@"buttonbar_back.png"] tag:100 actionBlock:^(CHMyButton *button) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)createUI
{
    self.scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.scrollerView.backgroundColor = [UIColor whiteColor];
    self.scrollerView.showsVerticalScrollIndicator = YES;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.contentSize = CGSizeMake(screen_width, screen_height);
    [self.view addSubview:self.scrollerView];
    
    // title
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, screen_width - 20, 60)];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:25.0];
    [self.scrollerView addSubview:self.titleLabel];
    
    //autor
    self.aurhorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame)+10 , screen_width - 20, 30)];
    self.aurhorLabel.numberOfLines = 0;
    self.aurhorLabel.font = [UIFont systemFontOfSize:15.0];
    [self.scrollerView addSubview:self.aurhorLabel];
    
    // 图片
    self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.aurhorLabel.frame)+20, screen_width - 20, 160)];
    self.myImageView.backgroundColor = [UIColor grayColor];
    [self.scrollerView addSubview:self.myImageView];
    
    // 描述
    self.contentTV = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.myImageView.frame)+10, screen_width -20, 160)];
    self.contentTV.font = [UIFont systemFontOfSize:18.0];
    self.contentTV.editable = NO;
    [self.scrollerView addSubview:self.contentTV];
 
    
#pragma mark -- 加载数据
     self.titleLabel.text = self.myCarmodel.title;
    self.titleLabel.textColor = [UIColor redColor];
    self.aurhorLabel.text = [NSString stringWithFormat:@"作者：%@", self.myCarmodel.author];
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.myCarmodel.PicCover]] placeholderImage:[UIImage imageNamed:@"blueArrow"]];
    self.contentTV.text = self.myCarmodel.summary;
}


- (void)setNac
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(190/255.0) green:(193/255.0) blue:(255/255.0) alpha:1.0]];
    // 导航栏标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor purpleColor]}];

    
    // 返回按钮
    CHMyButton *backButton = [CHMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 60, 30) title:@"返回" image:nil bgImage:[UIImage imageNamed:@"back.png"] tag:100 actionBlock:^(CHMyButton *button) {
        
#pragma mark -- 解决多次入栈问题
        [self.navigationController popViewControllerAnimated:YES];
        
    }];

    
[backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

// 横屏
[UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];



    CHMyButton *shareButton = [CHMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 60, 30) title:@"分享" image:[UIImage imageNamed:@"share.png"]  bgImage:nil tag:1001 actionBlock:^(CHMyButton *button) {
    
    // 分享的图片 和文字
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"570dd7ebe0f55a76530017e3"
                                      shareText:self.titleLabel.text
                                     shareImage:self.myImageView.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                       delegate:self];
    
#pragma mark ---这代码 点击分享自动跳转回来，不能在分享的页面看自己的分享内容！
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    //        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina,UMShareToWechatSession,UMShareToQQ] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
    //            if (response.responseCode == UMSResponseCodeSuccess) {
    //                NSLog(@"分享成功！");
    //            }
    //        }];
    
    
    //    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"570dd7ebe0f55a76530017e3" shareText:@"房价暴涨" shareImage:[UIImage imageNamed:@"1"] shareToSnsNames:@[UMShareToSina,UMShareToQQ] delegate:self];
    
    
}];
[shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
}


@end
