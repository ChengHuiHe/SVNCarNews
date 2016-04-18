//
//  SectionCarTBVCell.m
//  CarNews
//
//  Created by Chenghui on 16/3/5.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "SectionCarTBVCell.h"


@interface SectionCarTBVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descripLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@property (weak, nonatomic) IBOutlet UILabel *kilermiterLabel;
@end


@implementation SectionCarTBVCell



- (void)awakeFromNib {

    // 设置头像圆角
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 1.0f;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.layer.cornerRadius = 5.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(SecondHandModel *)model
{
    _model = model;
    
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.picUrlList[0]]]];
    
    // 掘取字符串
    NSString *strURL = model.ImageURL;
    NSRange range = NSMakeRange(0, 39);
    NSString *str = [strURL substringWithRange:range];
    model.ImageURL = str;
    CHLog(@"%@",str);
    
    // 要处理 “|”
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.ImageURL]];
    
    
    self.carNameLabel.text = model.BrandName;
    
    self.descripLabel.text = model.CarName;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@万",model.DisPlayPrice];
    self.yearLabel.text = [NSString stringWithFormat:@"%@年",model.BuyCarDate];
    self.kilermiterLabel.text =[NSString stringWithFormat:@"%.1f万公里",[model.DrivingMileage intValue]*0.0001];
}

@end
