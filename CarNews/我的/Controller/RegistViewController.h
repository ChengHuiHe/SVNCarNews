//
//  RegistViewController.h
//  Day3_SNSTest
//
//  Created by qf on 16/1/27.
//  Copyright (c) 2016年 chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  谁传值谁建 block，谁接收谁实现block
 */
typedef void(^RegistDelegate)(NSString *name,NSString *passWord);



@interface RegistViewController : UIViewController



@property (nonatomic,copy) RegistDelegate block;

@property (nonatomic,strong) UITextField *userTF;
@property (nonatomic,strong) UITextField *pwdTF;
@property (nonatomic,strong) UITextField *eamilPwdTF;

@property (nonatomic,strong) UIButton *registerButton;


@end
