//
//  MyCollectionViewCell.m
//  CarNews
//
//  Created by Chenghui on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ImageLinkImageView;

@property (weak, nonatomic) IBOutlet UILabel *TotalVisitLabel;

@property (weak, nonatomic) IBOutlet UILabel *DurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;

@end

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCarListModel:(CarLsitMdoel *)carListModel
{
    _carListModel = carListModel;
    
    [self.ImageLinkImageView sd_setImageWithURL:[NSURL URLWithString:carListModel.ImageLink] placeholderImage:[UIImage imageNamed:@"progresshud_background"]];
    
    CHLog(@"%@",carListModel.TotalVisit);
    
    self.TotalVisitLabel.text = carListModel.TotalVisit;
    self.DurationLabel.text = carListModel.Duration;
    self.TitleLabel.text = carListModel.Title;
    
}

@end
