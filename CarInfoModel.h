//
//  CarInfoModel.h
//  ZuChe
//
//  Created by apple  on 2017/2/7.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StateModel : NSObject



@end

@interface CarInfoModel : NSObject


@property (nonatomic , copy)NSString *biaoshi;
@property (nonatomic , copy)NSString *biaoshi1;
@property (nonatomic , copy)NSString *bz;
@property (nonatomic , copy)NSString *carid;
@property (nonatomic , copy)NSString *cartu1;
@property (nonatomic , copy)NSString *dizhi;
@property (nonatomic , copy)NSString *dizhi_info;
@property (nonatomic , copy)NSString *gaishu;
@property (nonatomic , copy)NSString *gaishu_info;
@property (nonatomic , copy)NSString *riqi;
@property (nonatomic , copy)NSString *riqi_info;
@property (nonatomic , copy)NSString *yongtu;
@property (nonatomic , copy)NSString *yongtu_info;

+(CarInfoModel *)viewWithDic:(NSDictionary *)dic;

@end
