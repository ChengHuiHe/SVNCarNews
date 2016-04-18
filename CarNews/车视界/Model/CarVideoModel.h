//
//  CarVideoModel.h
//  CarNews
//
//  Created by Chenghui on 16/3/4.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CarLsitMdoel.h"

//@protocol  CarLsitMdoel <NSObject>
//
//@end

// 用KVC

@interface CarVideoModel : NSObject

/**
 *  原创节目(头部标题)
 */
@property (nonatomic,copy) NSString *CatName;


/**
 *  到时这个数组，可以在外面一层通过: self.model.CarList[indexPath.row]; 在子类调用
 */
@property (nonatomic,strong) NSArray<CarLsitMdoel *> *CatList;


// KVC
//- (instancetype)initWithCarModelDict:(NSDictionary*)dict;
//
//+(instancetype)carVideoWithDict:(NSDictionary*)dict;

@end


