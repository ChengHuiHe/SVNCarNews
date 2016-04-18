//
//  NJProductCell.h
//  09-彩票(lottery)
//
//  Created by apple on 14-6-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NJProductItem;

@interface NJProductCell : UITableViewCell

@property (nonatomic, strong) NJProductItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
