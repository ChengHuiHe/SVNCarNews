//
//  AboutViewController.m
//  CarNews
//
//  Created by Chenghui on 16/4/14.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelName = [[UILabel  alloc] initWithFrame:CGRectMake(screen_width*0.5 - 50, 100, 100, 200)];
    labelName.text = @"欢迎关注!\n如果您在使用中遇到什么问题，请发送至邮箱：1695052462@qq.com谢谢！";
    labelName.numberOfLines = 0;
    [self.view addSubview:labelName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
