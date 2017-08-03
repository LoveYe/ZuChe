//
//  CarListModel.h
//  ZuChe
//
//  Created by apple  on 2017/2/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarListModel : NSObject

@property (nonatomic , copy)NSString *carid;
@property (nonatomic , copy)NSString *cartype;
@property (nonatomic , copy)NSString *imgurl;
@property (nonatomic , copy)NSString *pj;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *num;

+(CarListModel *)viewWithDic:(NSDictionary *)dic;

@end

@interface CarlistModel11 : NSObject

@property (nonatomic , copy)NSString *error;
@property (nonatomic , copy)NSString *msg;



@end

@interface CarListModel22 : NSObject

@property (nonatomic , copy)NSString *userid;
@property (nonatomic , copy)NSString *username;

+(CarListModel22 *)viewWithDic:(NSDictionary *)dic;

@end

