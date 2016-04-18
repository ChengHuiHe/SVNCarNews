//
//  MineViewController.m
//  CarNews
//
//  Created by Chenghui on 16/4/13.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "MineViewController.h"

#import "NJProductItem.h"
#import "NJProductGroup.h"
#import "NJProductCell.h"
#import "NJProductArrowItem.h"
#import "NJProductSwitchItem.h"
#import "AboutViewController.h"

// 导入头文件
#import "UMSocial.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *headerLogionView;
@property (nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong)UIImageView *qqImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *imageViewBG;

@property (nonatomic, strong) NSMutableArray *datas;


@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建UI
    [self createUI];
    
    // 第三方登录
    [self logionImage];
    
    // 注册
    [self registerCount];
}

- (void)createUI
{
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
    
    
    // 创建表头部视图
    self.headerLogionView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, screen_width, 150)];
    self.imageViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 150)];
    self.imageViewBG.image = [UIImage imageNamed:@"img09.jpg"];
    [self.headerLogionView addSubview:self.imageViewBG];
    
    
    // 设置头像圆角
    self.headerLogionView.layer.masksToBounds = YES;
    self.headerLogionView.layer.borderWidth = 1.0f;
    self.headerLogionView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headerLogionView.layer.cornerRadius = 10.0;
    
    self.myTableView.tableHeaderView = self.headerLogionView;
}

- (void)logionImage
{
    self.qqImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width*0.5-40, 20, 80, 80)];
    self.qqImageView.backgroundColor = [UIColor purpleColor];
    self.qqImageView.userInteractionEnabled = YES;
    // 设置头像圆角
    self.qqImageView.layer.masksToBounds = YES;
    self.qqImageView.layer.borderWidth = 1.0f;
    self.qqImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.qqImageView.layer.cornerRadius = 40.0;
    
    self.qqImageView.tag = 1002;
    
    // 用户昵称
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width*0.5-40, CGRectGetMaxY(self.qqImageView.frame)+2, 100, 30)];
    [self.imageViewBG addSubview:self.nameLabel];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.qqImageView addGestureRecognizer:tap];
    
#pragma mark -- 添加 登录头像
    [self.headerLogionView addSubview:self.qqImageView];
    
}

//第三方登陆
- (void)tapAction:(UIGestureRecognizer *)tap
{
    //  获取该手势是放在哪个视图位置上的
//    UIImageView *imageView = (UIImageView*)tap.view;
    CHLog(@"---%@",tap);

    
    __weak typeof(self) weakself = self;

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取QQ用户名、uid、token等
        /*token 相当于QQ提供给你的一个用户的唯一标识符
         把token上传到自己公司的服务器当中保存
         用户下一次登陆,验证token是否一致
         
         */
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            
            //上传token验证的位置(接口)
            //B99A9FFA848AC50D8BBD13C320A0DEEC
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            // QQ 头像
            [weakself.qqImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",snsAccount.iconURL]]];
            // QQ 昵称
            weakself.nameLabel.text = snsAccount.userName;
            
        }});

}

#pragma mark -- 测试注册登录
- (void)registerCount
{
    
}
#pragma mark - 懒加载
- (NSMutableArray *)datas
{
    if (_datas == nil) {
        // 第一组数据
//        NJProductItem *item00 = [[NJProductArrowItem alloc] initWithIcon:@"MorePush" title:@"推送和提醒" destClass:[AboutViewController class]];
//        NJProductItem *item01 = [[NJProductSwitchItem alloc] initWithIcon:@"MorePush" title:@"夜间模式"];
//        
//        NJProductGroup *group1 = [[NJProductGroup alloc] init];
//        group1.items = @[item01];
        
        // 第2组数据
//        NJProductItem *item10 = [[NJProductItem alloc] initWithIcon:@"MorePush" title:@"关于"];
//        item10.option = ^{
//            //            NSLog(@"发送网络请求检查版本更新");
//            
//            // 模拟发送网络请求
//            [MBProgressHUD showMessage:@"正在拼命检查..."];
//            // 2秒之后删除提示
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD hideHUD];
//                // 提示没有新版本
//                [MBProgressHUD showSuccess:@"亲~没有新版本"];
//            });
//        };
        
        NJProductItem *item11 = [[NJProductArrowItem alloc] initWithIcon:@"MorePush" title:@"关于" destClass:[AboutViewController class]];
        
        
        NJProductGroup *group2 = [[NJProductGroup alloc] init];
        group2.items = @[item11];
        
        _datas = [NSMutableArray array];
//        [_datas addObject:group1];
        [_datas addObject:group2];
    }
    return _datas;
}

//- (id)init
//{
//    return [super initWithStyle:UITableViewStyleGrouped];
//}
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    return [super initWithStyle:UITableViewStyleGrouped];
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 先取出对应组的小数组
    NJProductGroup *g = self.datas[section];
    // 返回小数组的长度
    return g.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    NJProductCell *cell = [NJProductCell cellWithTableView:tableView];
    
    // 先取出对应组的组模型
    NJProductGroup *g = self.datas[indexPath.section];
    //  从组模型中取出对应行的模型
    NJProductItem *item = g.items[indexPath.row];
    cell.item = item;
    
    // 3.返回cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 立即取消选中
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
     // 判断是否是检查版本更新
     if (1 == indexPath.section) {
     if (0 == indexPath.row) {
     NSLog(@"检查版本更新");
     }
     }
     */
    
    
    // 先取出对应组的组模型
    NJProductGroup *g = self.datas[indexPath.section];
    //  从组模型中取出对应行的模型
    NJProductItem *item = g.items[indexPath.row];
    // 判断block中是否保存了代码
    if (item.option != nil) {
        // 如果保存,就执行block中保存的代码
        item.option();
    }else if ([item isKindOfClass:[NJProductArrowItem class]]) {
        // 创建目标控制并且添加到栈中
        NJProductArrowItem *arrowItem = (NJProductArrowItem *)item;
        
        UIViewController *vc = [[arrowItem.destVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 先取出对应组的组模型
    NJProductGroup *g = self.datas[section];
    return g.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    // 先取出对应组的组模型
    NJProductGroup *g = self.datas[section];
    return g.footerTitle;
}


@end
