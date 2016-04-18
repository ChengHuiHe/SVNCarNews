//
//  NJProductCell.m
//  09-彩票(lottery)
//
//  Created by apple on 14-6-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NJProductCell.h"
#import "NJProductItem.h"
#import "NJProductArrowItem.h"
#import "NJProductSwitchItem.h"

@interface NJProductCell ()
@property (nonatomic, strong) UIImageView *arrowIv;
@property (nonatomic, strong) UISwitch *switchBtn;

@end

@implementation NJProductCell

- (UIImageView *)arrowIv
{
    if (_arrowIv == nil) {
       _arrowIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowIv;
}

- (UISwitch *)switchBtn
{
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc] init];
    }
    return _switchBtn;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cell";
    NJProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NJProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setItem:(NJProductItem *)item
{
    _item = item;
    // 设置数据
    self.textLabel.text = _item.tilte;
    self.imageView.image = [UIImage imageNamed:_item.icon];
    
    // 设置辅助视图
    if ([_item isKindOfClass:[NJProductArrowItem class]]) {
        self.accessoryView = self.arrowIv;
    }else if ([_item isKindOfClass:[NJProductSwitchItem class]])
    {
        self.accessoryView = self.switchBtn;
        // 设置没有选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else
    {
        self.accessoryView = nil;
    }
    
}
@end
