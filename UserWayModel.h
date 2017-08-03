//
//  UserWayModel.h
//  ZuChe
//
//  Created by apple  on 2017/2/10.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserWayModel : NSObject

@property (nonatomic , copy)NSString *carid;
@property (nonatomic , copy)NSString *jiage11;
@property (nonatomic , copy)NSString *jiage22;
@property (nonatomic , copy)NSString *jiage33;
@property (nonatomic , copy)NSString *jiage44;
@property (nonatomic , copy)NSString *type;

+ (instancetype)viewWithDic:(NSDictionary *)dic;

@end
