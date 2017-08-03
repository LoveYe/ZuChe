//
//  UserWayModel.m
//  ZuChe
//
//  Created by apple  on 2017/2/10.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "UserWayModel.h"

@implementation UserWayModel

+ (instancetype)viewWithDic:(NSDictionary *)dic{
    
    UserWayModel *model = [[UserWayModel alloc] init];
    
    model.carid   = [dic objectForKey:@"carid"];
    model.jiage11 = [dic objectForKey:@"jiage1"];
    model.jiage22 = [dic objectForKey:@"jiage2"];
    model.jiage33 = [dic objectForKey:@"jiage3"];
    model.jiage44 = [dic objectForKey:@"jiage4"];
    model.type    = [dic objectForKey:@"type"];
   
    return model;
    
}

@end
