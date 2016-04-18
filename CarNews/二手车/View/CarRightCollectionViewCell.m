//
//  CarRightCollectionViewCell.m
//  CarNews
//
//  Created by Chenghui on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "CarRightCollectionViewCell.h"

@interface CarRightCollectionViewCell ()

//"name": "A3三厢",
@property (nonatomic, copy) UILabel * name;
/** 多少款车型 */
@property (nonatomic, copy) UILabel * productNum;
/** 图片 */
@property (nonatomic, copy) UIImageView * normal_pic;
/** 指导价格 */
@property (nonatomic, copy) UILabel * authorityprice;

/** 收藏 */
@property (nonatomic, strong) UIButton * button;

@end

@implementation CarRightCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1.0;
        /**
         *  边框颜色
         */
        self.layer.borderColor = [UIColor colorWithRed:127/255.0 green:0/255.0 blue:129/255.0 alpha:1.000].CGColor;
    }
    return self;
}

#pragma mark -- 创建UI
- (void)addUI
{
    _normal_pic = [[UIImageView alloc]init];
    _normal_pic.frame = CGRectMake(0, 0, self.frame.size.width, 225 *self.frame.size.width/300);
    [self.contentView addSubview:_normal_pic];
    
    _name= [[UILabel alloc] initWithFrame:CGRectMake(kLeft_Gap, CGRectGetMaxY(_normal_pic.frame), self.frame.size.width-kLeft_Gap*2, 20)];
    _name.font = [UIFont systemFontOfSize:14];
    _name.textColor = [UIColor blackColor];
    _name.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_name];
    
    //车型数量
    _productNum = [[UILabel alloc] initWithFrame:CGRectMake(kLeft_Gap, CGRectGetMaxY(_name.frame), self.frame.size.width-kLeft_Gap*2, 20)];
    _productNum.font = [UIFont systemFontOfSize:14];
    _productNum.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_productNum];
   
    //  指导价格
    _authorityprice = [[UILabel alloc] initWithFrame:CGRectMake(kLeft_Gap, CGRectGetMaxY(_productNum.frame), self.frame.size.width-kLeft_Gap, 40)];
    _authorityprice.font = [UIFont systemFontOfSize:14];
    _authorityprice.textColor = [UIColor colorWithRed:0.949 green:0.259 blue:0.200 alpha:1.000];
    _authorityprice.numberOfLines = 0;
    _authorityprice.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_authorityprice];
 
    // 收藏
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(self.frame.size.width - 70, CGRectGetMaxY(_authorityprice.frame), 70, 15);
    _button.selected = NO;
    _button.titleLabel.font = [UIFont systemFontOfSize:12];
    [_button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_button setTitle:@"收藏" forState:UIControlStateNormal];
    [_button setTitle:@"已收藏" forState:UIControlStateSelected];
    [_button setImage:[UIImage imageNamed:@"Me_yuanwang"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"My_xin"] forState:UIControlStateSelected];
    [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_button];

}

- (void)setCarRightModel:(CategoryCarValueModel *)carRightModel
{
    _carRightModel = carRightModel;
    [_normal_pic sd_setImageWithURL:[NSURL URLWithString:carRightModel.normal_pic]];
    _name.text = carRightModel.name;
    _productNum.text = [NSString stringWithFormat:@"%@款车型", carRightModel.productNum];
    _authorityprice.text = [NSString stringWithFormat:@"指导价: %@万",carRightModel.authorityprice];
    
    
    //收藏状态
    if ([carRightModel.isCollected intValue]==1) {
        _button.selected = YES;
    }else{
        _button.selected = NO;
    }
    if (self.isCollection) {
        [_button setTitle:@"删除" forState:UIControlStateSelected];
        _name.text = carRightModel.displayname;
    }
}


#pragma mark -- 利用block 回调
/**
 *  收藏按钮点击
 */
-(void)buttonClick{
    
    _button.selected = !_button.selected;
    
    _carRightModel.isCollected = [NSString stringWithFormat:@"%d",_button.selected];
    
    //传递店点击事件
    if (self.tapAtCollection) {
        self.tapAtCollection(_button.selected);
    }
}



@end
