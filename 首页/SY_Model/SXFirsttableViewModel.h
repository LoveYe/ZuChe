//
//  SXFirsttableViewModel.h
//  ZuChe
//
//  Created by J.X.Y on 15/11/20.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXFirsttableViewModel : NSObject
@property (nonatomic, copy) NSString *userid;//用户ID
@property (nonatomic, copy) NSString *carid;//"车辆ID
@property (nonatomic, copy) NSString *models;//"宝马5系
@property (nonatomic, copy) NSString *biansu;//自动
@property (nonatomic, copy) NSString *autolist;//自动接单",   0自动   1不自动
@property (nonatomic, copy) NSString *carmoneyone;//"￥250"
@property (nonatomic, copy) NSString *carmoney;//也是钱
@property (nonatomic, copy) NSString *cargonglione;//5小时/50公里
@property (nonatomic, copy) NSString *carmoneytwo;//￥500
@property (nonatomic, copy) NSString *cargonglitwo;//8小时/80公里
@property (nonatomic, copy) NSString *everyhour;//10元/小时
@property (nonatomic, copy) NSString *everygongli;//50元/公里
@property (nonatomic, copy) NSString *listshop;

@property (nonatomic, copy) NSString *bukezutime;//2015-11-22,2015-11-23",  不可租的时间用“,”分割
@property (nonatomic, copy) NSString *caradd;//上海普陀联合大厦楼底下
@property (nonatomic, copy) NSString *plate;//沪A980M5
@property (nonatomic, copy) NSString *caryear;//2012年
@property (nonatomic, copy) NSString *renshu;//5人
@property (nonatomic, copy) NSString *pailiang;//1.6L以下
@property (nonatomic, copy) NSString *ranyou;//燃油90
@property (nonatomic, copy) NSString *tianchuang;//天窗
@property (nonatomic, copy) NSString *feiyong;//费用
@property (nonatomic, copy) NSString *licheng;//历程
@property (nonatomic, copy) NSString *zuoyi;//座椅

@property (nonatomic, copy) NSString *CarDescription;//车辆描述
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, readonly) NSString *description;
@property (nonatomic, copy) NSString *thumb;// 头像
@property (nonatomic, copy) NSString *mobile;//手机号
@property (nonatomic, copy) NSString *nickname;//昵称
@property (nonatomic, copy) NSString *jiedan;//接单率
@property (nonatomic, copy) NSString *fuwu;//服务次数
@property (nonatomic, copy) NSString *tiqian;//提前
@property (nonatomic, copy) NSString *xing;//星星
@property (nonatomic, copy) NSString *yinxiang;//印象
@property (nonatomic, copy) NSMutableArray *baoxian;//保险
@property (nonatomic, copy) NSString *wanshan;//完善
@property (nonatomic,copy) NSString* yijiedan;//已接单
@property (nonatomic,copy) NSString* cargongli;//结算后的cell
//****************下面是找车infor内页的评论***************//
@property (nonatomic, copy) NSString *chexing;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *fuwuxing;
@property (nonatomic, copy) NSString *inputtime;
@property (nonatomic,copy) NSString* shouxing;
@property (nonatomic,copy) NSString* thumbs;
@property (nonatomic,copy) NSString* grade;


+(SXFirsttableViewModel *)ViewWithDictionary:(NSDictionary *)dict;


@end
