//
//  ChangbaoDetailView.h
//  ZuChe
//
//  Created by apple  on 2017/7/14.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangbaoDetailView : UIViewController

@property (nonatomic , assign)BOOL isOK;
@property (nonatomic , copy)NSString *carid;
// 租车类型
@property (nonatomic , copy)NSString *cartype;
// 车辆类型
//@property (nonatomic , copy)NSString *typeCar;

@property (nonatomic , copy)NSString *carPrice;
@property (nonatomic , copy)NSString *carPrice1;
@property (nonatomic , copy)NSString *carPrice2;

@property (nonatomic , copy)NSString *username;
@property (nonatomic , copy)NSString *carPlate;

@end
