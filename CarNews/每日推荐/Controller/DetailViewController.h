//
//  DetailViewController.h
//  CarNews
//
//  Created by Chenghui on 16/3/3.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic,copy) NSString *resourceLocID;
/**
 *  HTML 的值
 */
@property (nonatomic,copy) NSString *htmlStr;

@end
