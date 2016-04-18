
//
//  RegistViewController.m
//  Day3_SNSTest
//
//  Created by qf on 16/1/27.
//  Copyright (c) 2016年 chenghui. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

- (void)initUI
{
    self.title = @"用户注册";
    _userTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, self.view.bounds.size.width - 20, 40)];
    _userTF.placeholder = @"@用户名";
    UIImage *userImage = [UIImage imageNamed:@"textfield_hl@2x.png"];
    userImage = [userImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_userTF setBackground:userImage];
    [self.view addSubview:_userTF];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _userTF.leftView = leftView;
    _userTF.leftViewMode = UITextFieldViewModeAlways;
   
    
    
    _pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_userTF.frame)+10, self.view.bounds.size.width - 20, 40)];
    [_pwdTF setBackground:[UIImage imageNamed:@"textfield_hl@2x.png"]];
    _pwdTF.placeholder = @"输入密码";
    _pwdTF.secureTextEntry = YES;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _pwdTF.leftView = rightView;
    _pwdTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_pwdTF];
    
    
    _eamilPwdTF = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_pwdTF.frame)+10, self.view.bounds.size.width - 20, 40)];
    [_eamilPwdTF setBackground:[UIImage imageNamed:@"textfield_hl@2x.png"]];
    _eamilPwdTF.placeholder = @"输入邮箱";
//    _eamilPwdTF.secureTextEntry = YES;
    
    UIView *rightView01 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _eamilPwdTF.leftView = rightView01;
    _eamilPwdTF.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:_eamilPwdTF];
    
    
    // BUTTON
     _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ _registerButton setTitle:@"登录" forState:UIControlStateNormal];
    
#warning parmak ---
    [ _registerButton setTitle:@"登录中。。。" forState:UIControlStateDisabled];// 不能点击。。。
     _registerButton.frame = CGRectMake(10, CGRectGetMaxY(_eamilPwdTF.frame)+20, [UIScreen mainScreen].bounds.size.width-20, 50);
     _registerButton.backgroundColor = [UIColor greenColor];
    
    UIImage *btnImg = [UIImage imageNamed:@"btn@2x.png"];
    btnImg = [btnImg resizableImageWithCapInsets:UIEdgeInsetsMake(btnImg.size.height*0.5, btnImg.size.width*0.5, btnImg.size.height*0.5, btnImg.size.width*0.5)];
    [ _registerButton setBackgroundImage:btnImg forState:UIControlStateNormal];

#pragma mark --- 注册方式2 (传个参数)，注册方式1（去掉参数，和改用方法：registAction01）
    [ _registerButton addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview: _registerButton];


}

#pragma mark --- 注册方式2
- (void)registButtonClick:(UIButton*)registButton
{
    // 参数 ---- 字典
    NSDictionary *dict = @{@"username":_userTF.text,@"password":_pwdTF.text,@"email":_eamilPwdTF.text};
//    [self registAction02:dict];
}

#pragma mark --- 注册方式1
// 注册 ----- 利用AFN 框架封装而已
- (void)registAction01
{
    NSLog(@"logion");

#pragma mark -- block
    // 如果注册成功
    if (self.block) { // 判断是否存在！！！
        self.block(@"gz15151008",@"123456");
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    
    _registerButton.selected = NO;
    if (_userTF.text.length == 0) {
        [self showMessage:@"请输入用户名！"];
        _registerButton.enabled = YES;
        return; //方法体
        // break; // 这个循环
    }
    if (_pwdTF.text.length == 0 ) {
        [self showMessage:@"请输入密码"];
        _registerButton.enabled = YES;
    }
   
    
    // ----- 注册方法
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 参数 ---- 字典
    NSDictionary *param = @{@"username":_userTF.text,@"password":_pwdTF.text,@"email":_eamilPwdTF.text};
    
    
    /**
     code = "email_format_is_wrong";
     "m_auth" = "1695052462@qq.com";
     message = "\U586b\U5199\U7684 Email \U683c\U5f0f\U6709\U8bef";
     */
    [manager GET:kRegisterURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) { // responseObject 是一个字典
        
        NSLog(@"成功:%@",responseObject); // 根据字典解析判断结果
        
        NSString *code = responseObject[@"code"];
        NSString *message = responseObject[@"message"];
        NSString *email = responseObject[@"email"];
        [self showMessage:message];
        if ([code isEqualToString:@"registered"] || ![email isEqualToString:@"email_format_is_wrong"]) {
            
             //注册成功
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *name = responseObject[@"username"];
            NSString *pasword = responseObject[@"password"];
            
            [userDefaults setObject:name forKey:@"name"];
            [userDefaults setObject:pasword forKey:@"password"];
            [userDefaults synchronize]; // 同步
            
            // 返回到登录界面
            UIViewController *VC = [[UIViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
            _registerButton.enabled = YES;
        }else {
            
            _registerButton.enabled = YES;
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败：%@",error);
        
        _registerButton.enabled = YES;
    }];
}



#pragma mark --- 注册方式2
#pragma mark --- 更高级的封装
// 在 AFN 框架的基础上再次封装（哈哈！）
//- (void)registAction02:(NSDictionary *)dict
//{
//    [CHDownloadObject downloadDataWithType:CHDownloadTypeGet Path:kRegisterURL parameters:dict success:^(NSData *data) {
//        NSDictionary * dict1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSString * code = dict1[@"code"];
//        NSLog(@"%@",code);
//
//        
//        if ([code isEqualToString:@"registered"]) {
//            //注册成功的
//             NSString * name = dict[@"username"];
//             NSString * password = dict[@"password"];
//            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
//            [userDefault setObject:name forKey:@"name"];
//            [userDefault setObject:password forKey:@"password"];
//            [userDefault synchronize]; //立即执行
//
//            // 返回到登录界面
//            ViewController *VC = [[ViewController alloc] init];
//            [self.navigationController pushViewController:VC animated:YES];
//            
//            _registerButton.enabled = YES;
//        }
//        
//    } fail:^(NSError *error) {
//        
//        NSLog(@"失败：%@",error);
//        
//        _registerButton.enabled = YES;
//    }];
//}
//
/**
 *  封装一个提示窗口
 *
 *  @param msg
 */
- (void)showMessage:(NSString*)msg{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
