//
//  BrandTableViewCell.m
//  CarNews
//
//  Created by Chenghui on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BrandTableViewCell.h"

@interface BrandTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bphotoImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation BrandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setBrandModel:(BrandModel *)brandModel
{
    _brandModel = brandModel;
    
//    CHLog(@"%@",brandModel.bphoto);
    
    [self.bphotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",brandModel.bphoto]]];

    // 切割分割符号将字符串切割成数组 --- 处理 “--”
    NSArray * array = [brandModel.name componentsSeparatedByString:@"--"];
    NSString * string = [NSString stringWithFormat:@"%@.png",array[1]];
    
    UIImage * image = [UIImage imageNamed:string];
    
    self.bphotoImageView.image = image;
    
    self.nameLabel.text = array[1];
}


-(void)changeColor{
    //    UIColor *color = [UIColor colorWithWhite:0.808 alpha:1.000];
    //     UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
    //    view.backgroundColor = [UIColor colorWithWhite:0.808 alpha:1.000];
    //    self.selectedBackgroundView = view;
    //    _bphoto.image = [_bphoto.image imageWithColor:color]
    self.nameLabel.textColor = [UIColor colorWithRed:0.6 green:0.267 blue:0.6 alpha:1.000];
}

-(void)originColor{

    self.nameLabel.textColor = [UIColor blackColor];
}

@end
