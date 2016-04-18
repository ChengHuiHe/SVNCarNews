//
//  SecondTabViewController.m
//  CarNews
//
//  Created by Chenghui on 16/3/8.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "SecondTabViewController.h"

@interface SecondTabViewController ()

@property (nonatomic,assign)int  UcarID;

@property (weak, nonatomic) IBOutlet UILabel *MainbranNamelabe;// 汽车名字
@property (weak, nonatomic) IBOutlet UILabel *CarNameLabel;// 13款
// 上牌时间
@property (weak, nonatomic) IBOutlet UILabel *BuyCarDate_NewLabel;
/**
 *  公里
 */
@property (weak, nonatomic) IBOutlet UILabel *DrivingMileageLabel;

/**
 *  发布日期
 */
@property (weak, nonatomic) IBOutlet UILabel *CarPublishTimeLabel;

/**
 *  2.0L
 */
@property (weak, nonatomic) IBOutlet UILabel *ExhaustLabel;
/**
 *  2015-03-03
 */
@property (weak, nonatomic) IBOutlet UILabel *CarPublishTimeShortLabel;

/**
 *  当前价格
 */
@property (weak, nonatomic) IBOutlet UILabel *DisplayPriceLabel;
/**
 *  过户费
 */
@property (weak, nonatomic) IBOutlet UILabel *IsIncTransferPirceLabel;
/**
 *  新车价格
 */
@property (weak, nonatomic) IBOutlet UILabel *GetReferPrice;

#pragma mark --- section 2

/**
 *  广州
 */
@property (weak, nonatomic) IBOutlet UILabel *CityName;
/**
 *  上市年份
 */
@property (weak, nonatomic) IBOutlet UILabel *MarketTimeLabel;

/**
 *  年检到期
 */
@property (weak, nonatomic) IBOutlet UILabel *InsuranceExpireDateLabel;
/**
 *  保险测期
 */
@property (weak, nonatomic) IBOutlet UILabel *ExamineExpireDateLabel;
/**
 *  非运营
 */
@property (weak, nonatomic) IBOutlet UILabel *CarTypeLabe;
/**
 *  商家
 */
@property (weak, nonatomic) IBOutlet UILabel *CarSourceLabel;
/**
 *  平均耗油
 */
@property (weak, nonatomic) IBOutlet UILabel *ConsumptionLabel;
/**
 *  特色亮点
 */
@property (weak, nonatomic) IBOutlet UILabel *BrightSpotLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;




@end

@implementation SecondTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myScrollView = [[UIScrollView alloc] init];
    _myScrollView.frame = CGRectMake(0, 0, screen_width, screen_height);
    _myScrollView.showsHorizontalScrollIndicator = NO;
    

    // 请求数据
    [self requestData];

}

#pragma mark -- 请求数据
- (void)requestData
{
    // 导航栏标题
    self.navigationItem.title = self.model.BrandName;
    
    self.BrightSpotLabel.text = self.model.BrandName;
    
    self.MainbranNamelabe.text = self.model.MainBrandName;

    self.CarNameLabel.text = self.model.CarName;

    // 7.0万公里
    self.DrivingMileageLabel.text = [NSString stringWithFormat:@"%.2f万公里",[self.model.DrivingMileage intValue] *0.0001];
    
    self.BuyCarDate_NewLabel.text = [NSString stringWithFormat:@"上牌时间:%@",self.model.BuyCarDate_New];

    self.CarPublishTimeLabel.text = [NSString stringWithFormat:@"发布日期：%@",self.model.CarPublishTime];
    self.DisplayPriceLabel.text = [NSString stringWithFormat:@"%@万",self.model.DisPlayPrice];// 6.89万
    self.GetReferPrice.text = self.model.NewCarPrice;
    
//#pragma mark --- 
    self.CityName.text = self.model.CityName;
    self.MarketTimeLabel.text = self.model.BuyCarDate;

    self.InsuranceExpireDateLabel.text = self.model.Authenticated;// 非品牌认证
    self.ExamineExpireDateLabel.text = self.model.IsDealerAuthorized;
    self.CarTypeLabe.text = self.model.IsZhiBao;
    self.CarSourceLabel.text = self.model.CarShortPublishTime;
    self.ConsumptionLabel.text = self.model.Exhaust;
}

@end
