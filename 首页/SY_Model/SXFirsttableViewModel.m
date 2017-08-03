//
//  SXFirsttableViewModel.m
//  ZuChe
//
//  Created by J.X.Y on 15/11/20.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import "SXFirsttableViewModel.h"

@implementation SXFirsttableViewModel

+(SXFirsttableViewModel *)ViewWithDictionary:(NSDictionary *)dict
{
    SXFirsttableViewModel *zj =[[SXFirsttableViewModel alloc]init];
//    zj.userid =[dict objectForKey:@"userid"];
    zj.carid =[dict objectForKey:@"carid"];
    zj.models =[dict objectForKey:@"models"];
    zj.biansu =[dict objectForKey:@"biansu"];
    zj.autolist =[dict objectForKey:@"autolist"];
    zj.carmoney=[dict objectForKey:@"carmoney"];
    zj.carmoneyone =[dict objectForKey:@"carmoneyone"];
    zj.carmoneytwo=[dict objectForKey:@"carmoneytwo"];
    zj.cargonglione =[dict objectForKey:@"cargonglione"];
    zj.cargonglitwo =[dict objectForKey:@"cargonglitwo"];
    zj.bukezutime =[dict objectForKey:@"bukezutime"];
    zj.caradd =[dict objectForKey:@"caradd"];
    zj.plate =[dict objectForKey:@"plate"];
    zj.caryear =[dict objectForKey:@"caryear"];
    zj.renshu =[dict objectForKey:@"renshu"];
    zj.pailiang =[dict objectForKey:@"pailiang"];
    zj.ranyou =[dict objectForKey:@"ranyou"];
    zj.CarDescription =[dict objectForKey:@"CarDescription"];
    zj.thumb =[dict objectForKey:@"thumb"];
    zj.mobile =[dict objectForKey:@"mobile"];
    zj.nickname =[dict objectForKey:@"nickname"];
    zj.jiedan =[dict objectForKey:@"jiedan"];
    zj.fuwu =[dict objectForKey:@"fuwu"];
    zj.tiqian =[dict objectForKey:@"tiqian"];
    zj.xing =[dict objectForKey:@"xing"];
    zj.yinxiang =[dict objectForKey:@"CarDescription"];
    zj.baoxian=[dict objectForKey:@"baoxian"];
    zj.wanshan=[dict objectForKey:@"wanshan"];
    zj.yijiedan=[dict objectForKey:@"jiedanstatus"];
    zj.cargongli=[dict objectForKey:@"cargongli"];
    zj.everygongli=[dict objectForKey:@"everygongli"];
    zj.everyhour=[dict objectForKey:@"everyhour"];
    
    
    
    
    zj.tianchuang=[dict objectForKey:@"ranyou"];
    zj.feiyong=[dict objectForKey:@"feiyong"];
    zj.licheng=[dict objectForKey:@"carm"];
    zj.zuoyi=[dict objectForKey:@"zuoyi"];

    zj.chexing =[dict objectForKey:@"chexing"];
    zj.content =[dict objectForKey:@"content"];
    zj.fuwuxing=[dict objectForKey:@"fuwuxing"];
    zj.inputtime=[dict objectForKey:@"inputtime"];
    zj.shouxing=[dict objectForKey:@"shouxing"];
    zj.thumbs=[dict objectForKey:@"thumbs"];
    zj.grade =[dict objectForKey:@"grade"];
    return zj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
