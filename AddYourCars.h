//
//  AddYourCars.h
//  ZuChe
//
//  Created by apple  on 16/11/7.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addCarDelegate <NSObject>

- (void)addANum;

@end

@interface AddYourCars : UIViewController

@property (nonatomic ,assign)NSString *catid;
@property (nonatomic , assign)NSString *number;

@property (nonatomic , assign) int aNUmber;

@property (nonatomic , assign)int tag;

@property (nonatomic , copy)NSString *dizhi;

@property (nonatomic , weak)id <addCarDelegate>delegate;

@end

