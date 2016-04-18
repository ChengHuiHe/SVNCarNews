//
//  MyCarTableViewCell.m
//  CarNews
//
//  Created by Chenghui on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "MyCarTableViewCell.h"

@interface MyCarTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *BigimageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  时间戳
 */
@property (weak, nonatomic) IBOutlet UILabel *mtimeLabel;

/**
 *  收藏
 */
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;


@end

@implementation MyCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}


- (void)setMyCarModel:(MyCarModel *)myCarModel
{
    _myCarModel = myCarModel;

    
    // 新车

    [self.BigimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",myCarModel.PicCover]]];
    self.mtimeLabel.text = myCarModel.publishtime;// 时间
    self.titleLabel.text = myCarModel.title;
    

    
//    [self.BigimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",myCarModel.image]] placeholderImage:[UIImage imageNamed:@"blueArrow"]];
//    
//    self.titleLabel.text = myCarModel.title;
//    self.mtimeLabel.text = myCarModel.pubDate;
    
    
#pragma mark --- 是否收藏
//    [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"collection_normal"] forState:UIControlStateNormal];
//    [self.favoriteButton setTitle:@"收藏" forState:UIControlStateNormal];
//    
//    [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"collection_highlight"] forState:UIControlStateSelected];
//    [self.favoriteButton setTitle:@"已收藏" forState:UIControlStateSelected];
//    
//    //收藏状态
//    if ([myCarModel.isCollected intValue]==1) {
//
//        self.favoriteButton.selected = YES;
//
//    }else{
//        
//        self.favoriteButton.selected = NO;
//        
//    }
//    if (self.isCollection) {
//        self.favoriteButton.hidden = YES;
//    }
    
}

// 设置收藏
- (IBAction)favouriteBtnAction:(UIButton*)sender {

    CHLog(@"点击-----sender%@---",[sender class]);
    
    [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"collection_normal"] forState:UIControlStateNormal];
    [self.favoriteButton setTitle:@"收藏" forState:UIControlStateNormal];
    
    [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"collection_highlight"] forState:UIControlStateSelected];
    [self.favoriteButton setTitle:@"已收藏" forState:UIControlStateSelected];
    

    CHLog(@"%d",sender.selected);// NO 默认，第一次来到这里就为YES
    
    // 收藏
    if (sender.selected) {
        sender.selected = NO;
    } else {
        sender.selected = YES;
    }

#pragma mark ---- block
    /**
     *  传递点击事件
     */
    if (self.tapAtFavoriteButton) {
        
        self.tapAtFavoriteButton(self.favoriteButton.selected);
        
        DatabaseSingle *single = [DatabaseSingle shareSingleton];

        //    //查询数据, 如果存在则对每个model的收藏值赋值
        if ([single existsRecordInTable:@"CarModel" withValue:self.myCarModel.title andKey:@"title"]) {
            
            
            self.myCarModel.isCollected = @"1";
            
        }else{
            self.myCarModel.isCollected = @"0";
        }
    }
}


@end
