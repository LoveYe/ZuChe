//
//  Header.h

//
//  Created by 佐途 on 15/7/8.
//  Copyright (c) 2015年 佐途. All rights reserved.


#ifndef _____Header_h
#define _____Header_h
#define  ScreenSize  [[UIScreen mainScreen] bounds].size
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight [[UIScreen mainScreen]bounds].size.height
#define IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size) : NO)
#define Color(a,b,c)  [UIColor colorWithRed:a/255.0 green:b/255.0  blue:c/255.0  alpha:1.0];
#define IOS7  ([[[UIDevice currentDevice] systemVersion] floatValue]>7.0)
#define NowUrl  @"http://wx.leisurecarlease.com/"

//#define CITY_CT @"上海"
//首页
#define SHOUYE [NSString stringWithFormat:@"%@api.php?op=catindex",NowUrl]
//首页进筛选
#define SHOUYESHAIXUAN [NSString stringWithFormat:@"%@api.php?op=indexsx",NowUrl]
//一级筛选接口
#define FIRSTURL [NSString stringWithFormat:@"%@api.php?op=jiagesx",NowUrl]
//二级赛选页面
#define CARLIST [NSString stringWithFormat:@"%@api.php?op=Carlistfilter",NowUrl]
//找车二级内页
#define CARNEIYE  [NSString stringWithFormat:@"%@api.php?op=Carshow",NowUrl]

//添加车辆的字段
#define ADDCARURL [NSString stringWithFormat:@"%@api.php?op=addcarfid",NowUrl]

//一审接口
#define YISHENURL [NSString stringWithFormat:@"%@api.php?op=UploadVehicle",NowUrl]
//一审接删除
#define YISHENURL_cal [NSString stringWithFormat:@"%@api.php?op=deletechushen",NowUrl]

//二审接口
#define ERSHENGurl [NSString stringWithFormat:@"%@api.php?op=ershen",NowUrl]

//车主车辆列表
#define CHEZULIST [NSString stringWithFormat:@"%@api.php?op=Czcarinfo",NowUrl]

//车主车辆内页
#define CARNEIYE1 [NSString stringWithFormat:@"%@api.php?op=Czcarshow",NowUrl]

//车主车辆内页  修改图片
#define CAR_PIC [NSString stringWithFormat:@"%@api.php?op=update_thumb",NowUrl]

//出租价格
#define CHUZUMONEY [NSString stringWithFormat:@"%@api.php?op=update_carmoney",NowUrl]

//车主修改车辆自动接单
#define ZIDONGJIEDAN [NSString stringWithFormat:@"%@api.php?op=update_autolist",NowUrl]

//车主修改车辆接单
#define JIEDANORNO [NSString stringWithFormat:@"%@api.php?op=update_jiedan",NowUrl]

//车主修改车辆接紧急单
#define JINJIJIEDAN [NSString stringWithFormat:@"%@api.php?op=update_jinjidan",NowUrl]

//车主修改车辆停车地点
#define STOPCARPIC [NSString stringWithFormat:@"%@api.php?op=update_caradd",NowUrl]

//车主修改车辆用途
#define CARYONGTU [NSString stringWithFormat:@"%@api.php?op=update_caryongtu",NowUrl]

//车主修改可租时间
#define CARTIME [NSString stringWithFormat:@"%@api.php?op=update_kezhutime",NowUrl]

//车主完善资料api.php?op=yhtijiao
#define WANSANZILIAO [NSString stringWithFormat:@"%@api.php?op=wanshaninfo",NowUrl]

//结算下一步后的节后
#define JIESUANHOU [NSString stringWithFormat:@"%@api.php?op=yhtijiao",NowUrl]

//提交订单
#define TIJIAODINGDAN [NSString stringWithFormat:@"%@api.php?op=Submitorder",NowUrl]

//车主我的订单列表
#define DINGDANLIEBIAO [NSString stringWithFormat:@"%@api.php?op=Czorderlist",NowUrl]


//车主拒绝接单
#define JUJUE [NSString stringWithFormat:@"%@api.php?op=Czjujueorder",NowUrl]

//车主接受接单
#define JIESHOU [NSString stringWithFormat:@"%@api.php?op=Czjieorder",NowUrl]

//租客订单详情
#define ZUKEDINGDANXQ [NSString stringWithFormat:@"%@api.php?op=zkordershow",NowUrl]

//租客支付定金
#define ZKDINGJ [NSString stringWithFormat:@"%@api.php?op=jiesuan",NowUrl]

//租客订支付尾款
#define ZKWEIKUAN [NSString stringWithFormat:@"%@api.php?op=weikuan",NowUrl]

//租客取消订单
#define ZKQUXIAO [NSString stringWithFormat:@"%@api.php?op=Cancelorder",NowUrl]

//获得评价页数据
#define PINGJIEYE [NSString stringWithFormat:@"%@api.php?op=pingjia",NowUrl]

//提交评价页数据
#define TIJIAOPINGJIEYE [NSString stringWithFormat:@"%@api.php?op=submitpingjia",NowUrl]

//判断行程有没有订单
#define PANDUANXINGCHENG [NSString stringWithFormat:@"%@api.php?op=iforder",NowUrl]

//修改个人信息
#define XIUGAIZILIAO [NSString stringWithFormat:@"%@api.php?op=member_update",NowUrl]

//意见反馈
#define YIJIAN [NSString stringWithFormat:@"%@api.php?op=yijian",NowUrl]

//申请提现
#define TIXIAN [NSString stringWithFormat:@"%@api.php?op=tixian",NowUrl]

//上传头像
#define THUMB [NSString stringWithFormat:@"%@api.php?op=thumb",NowUrl]

//商家订单提交尾款金额
#define SHANGJIA_TIJIAO_WEIKUAN [NSString stringWithFormat:@"%@api.php?op=update_weikuan",NowUrl]


//补差价
#define BUCHAJIA [NSString stringWithFormat:@"%@api.php?op=buchajia",NowUrl]

//结束服务 
#define FUWUJIESHU [NSString stringWithFormat:@"%@api.php?op=jieshufuwu",NowUrl]


//热门关键词
#define HOT_WORLD [NSString stringWithFormat:@"%@api.php?op=Hotsearch",NowUrl]

//搜索车辆
#define SEARCH_CAR [NSString stringWithFormat:@"%@api.php?op=search",NowUrl]

//修改车辆描述
#define MIAOSHU [NSString stringWithFormat:@"%@api.php?op=update_description",NowUrl]
//最近浏览
#define ZUIJIN [NSString stringWithFormat:@"%@api.php?op=listzuijin",NowUrl]


#endif
