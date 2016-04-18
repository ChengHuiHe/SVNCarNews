//
//  DetailViewController.m
//  CarNews
//
//  Created by Chenghui on 16/3/3.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "DetailViewController.h"
#import "CHRootViewController.h"
#import "UMSocial.h"

@interface DetailViewController ()<UIWebViewDelegate,UMSocialUIDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 1、导航栏的设置
    [self setNac];

  self.detailWebView.delegate = self;

   CHLog(@"%@",self.resourceLocID);
    
    // 加载数据
    [self requestData];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('navs-news')[0].style.visibility = 'hidden'"];
}

- (void)requestData
{
    NSString *strURL = [NSString stringWithFormat:@"%@%@.html",KDetail_URL,self.resourceLocID];
    CHLog(@"%@",strURL);

    if (_resourceLocID.length >= 5) {
        [self.detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strURL]]];
        
    }else{
        
        [self.detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.htmlStr]]];
    }

}


- (void)setNac
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(190/255.0) green:(193/255.0) blue:(255/255.0) alpha:1.0]];
    // 导航栏标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor purpleColor]}];
    // IOS7
    // 版本的判断
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        // 向右边滑动，返回到上一个界面
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
    
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"advImage" object:nil];

    
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 返回按钮
    CHMyButton *backButton = [CHMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 60, 30) title:@"返回" image:nil bgImage:[UIImage imageNamed:@"back.png"] tag:100 actionBlock:^(CHMyButton *button) {
        
#pragma mark -- 解决多次入栈问题
//        [self.navigationController popToRootViewControllerAnimated:YES];

        [self.navigationController popViewControllerAnimated:YES];

//        CHRootViewController *rootVC = [[CHRootViewController alloc] init];
//        [self.navigationController popToViewController:rootVC animated:YES];
        
        
    }];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    // 横屏
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
    
    
    
    __weak typeof(self) weakself = self;

    CHMyButton *shareButton = [CHMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 60, 30) title:@"分享" image:[UIImage imageNamed:@"share.png"] bgImage:nil tag:1001 actionBlock:^(CHMyButton *button) {
       
        // 分享的图片 和文字
        
        //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"570dd7ebe0f55a76530017e3"
                                          shareText:@"你要分享的文字"
                                         shareImage:[UIImage imageNamed:@"icon.png"]
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

/**
 *  封装一个系统按钮
 *
 *  @param frame    系统按钮的大小
 *  @param fontSize 字体大小
 *  @param target   target
 *
 *  @return 按钮
 */

+(UIButton *)addSystemButton:(CGRect)frame setTitle:(NSString *)title addTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}




@end
