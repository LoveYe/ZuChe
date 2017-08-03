//
//  CarListModel.m
//  ZuChe
//
//  Created by apple  on 2017/2/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "CarListModel.h"

@implementation CarListModel

+ (CarListModel *)viewWithDic:(NSDictionary *)dic{
    
    CarListModel *model = [[CarListModel alloc] init];
    
    model.carid = [dic objectForKey:@"carid"];
    model.cartype = [dic objectForKey:@"cartype"];
    model.status = [dic objectForKey:@"status"];
    model.imgurl = [dic objectForKey:@"imgurl"];
    model.pj = [dic objectForKey:@"pj"];
    model.num = [dic objectForKey:@"num"];
    
    return model;
}

@end

@implementation CarlistModel11

@end

@implementation CarListModel22

+ (CarListModel22 *)viewWithDic:(NSDictionary *)dic{
    
    CarListModel22 *model = [[CarListModel22 alloc] init];
    
    model.userid = [dic objectForKey:@"userid"];
    model.username = [dic objectForKey:@"username"];
    
    return model;
}

@end

