//
//  HomeCell.m
//  CarNews
//
//  Created by Chenghui on 16/3/3.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "HomeCell.h"

typedef enum {
    
    typeState_one = 2,
    
    typeState_two = 4,
    
    typeState_three = 6
    
}typeState;



@interface HomeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icomImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;

// 如果不是评论数，那就是 原创、推广等
@property (weak, nonatomic) IBOutlet UILabel *CommuntCountLabe;

@end

@implementation HomeCell

- (void)awakeFromNib {

    // 设置头像圆角
    self.icomImageView.layer.masksToBounds = YES;
    self.icomImageView.layer.borderWidth = 1.0f;
    self.icomImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.icomImageView.layer.cornerRadius = 5.0;
    
}

-(void)setHomeModel:(HomeModel *)homeModel
{
    _homeModel = homeModel;
    
    [self.icomImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",homeModel.picUrlList[0]]]];
    
    self.titleLabel.text = homeModel.title;
    self.timeLabel.text = homeModel.publishTime;
    self.originLabel.text = [NSString stringWithFormat:@"来自%@",homeModel.origin];
    
    if ([self.CommuntCountLabe.text hasPrefix:@"评论"]) {
        self.CommuntCountLabe.text = [NSString stringWithFormat:@"评论(%@)",homeModel.CommuntCount];
    }else {
        
        if (([homeModel.articleType intValue] == typeState_one)) {

            [self.CommuntCountLabe setTextColor:[UIColor colorWithRed:84/217.0 green:105/255.0 blue:251/255.0 alpha:1.0]];
            self.CommuntCountLabe.text = @"原创";

        }else if ([homeModel.articleType intValue] == typeState_two){
        
            self.CommuntCountLabe.text = @"";
    
        }else if ([homeModel.articleType intValue] == typeState_three){
            
            // 设置为红色
            [self.CommuntCountLabe setTextColor:[UIColor colorWithRed:248/255.0 green:105/255.0 blue:172/255.0 alpha:1.0]];
            self.CommuntCountLabe.text = @"头客条";
            
        }else{

            [self.CommuntCountLabe setTextColor:[UIColor colorWithRed:22/255.0 green:141/255.0 blue:252/255.0 alpha:1.0]];
            self.CommuntCountLabe.text = @"推广";
   
        }

    }
    
}



@end
