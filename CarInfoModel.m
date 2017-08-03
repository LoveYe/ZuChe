//
//  CarInfoModel.m
//  ZuChe
//
//  Created by apple  on 2017/2/7.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "CarInfoModel.h"

@implementation StateModel



@end

@implementation CarInfoModel

+ (CarInfoModel *)viewWithDic:(NSDictionary *)dic{
    
    CarInfoModel *model = [[CarInfoModel alloc] init];
    
//    model.error = [dic objectForKey:@"error"];
//    model.msg = [dic objectForKey:@"msg"];
    
//    model.state = [dic objectForKey:@"state"];
//    
    model.biaoshi = [dic objectForKey:@"biaoshi"];
    model.biaoshi1 = [dic objectForKey:@"biaoshi1"];
    model.bz  = [dic objectForKey:@"bz"];
    model.carid = [dic objectForKey:@"carid"];
    model.cartu1 = [dic objectForKey:@"cartu1"];
    model.dizhi = [dic objectForKey:@"dizhi"];
    model.dizhi_info = [dic objectForKey:@"dizhi_info"];
    model.gaishu = [dic objectForKey:@"gaishu"];
    model.gaishu_info = [dic objectForKey:@"gaishu_info"];
    model.riqi = [dic objectForKey:@"riqi"];
    model.riqi_info = [dic objectForKey:@"riqi_info"];
    model.yongtu = [dic objectForKey:@"yongtu"];
    model.yongtu_info = [dic objectForKey:@"yongtu_info"];
    
    return model;
}

- (void)initWithValue:(id)value forKer:(NSString *)key{
    
}

@end
