//
//  PayView.m
//  ZuChe
//
//  Created by apple  on 2017/4/10.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "PayView.h"
#import "ItineraryViewController.h"
#import "RootViewcontroller.h"
#import "Header.h"

#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "payRequsestHandler.h"
#import "WXUtil.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "MBProgressHUD.h"
#import "ZCUserData.h"
#import "NSDataEx.h"
#import "XWAlterview.h"
#import "MBProgressHUD.h"

#import "HttpManager.h"

#import "ZCUserData.h"

#import "RSADataSigner.h"
#import "GiFHUD.h"
#import "MBProgressHUD.h"

@interface PayView ()<MBProgressHUDDelegate,UIAlertViewDelegate>{
    
    CGFloat width;
    CGFloat height;
    UITableView *_tableView;
    
    UIWindow *keyv;
    UIView *dangbanview1;
    MBProgressHUD *HUD;
    NSDictionary *arrayList;
    UIAlertController *alertController;
    
    UIButton *duihao1;
    UIButton *duihao2;
  
    NSString *orderString;
    
    NSDictionary *_dict;
    
    NSString *string;
    
    NSDictionary *_alipayDic;
}
@property (nonatomic,retain)NSString *orderid;
@property (nonatomic,retain)NSString *dingdanhao8;

@end

@implementation PayView

- (void)viewWillAppear:(BOOL)animated{
    
    [GiFHUD dismiss];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *view = [GiFHUD new];
    [GiFHUD setGifWithImageName:@"动态gif.gif"];
    [GiFHUD show];
    [self performSelector:@selector(stopit) withObject:view afterDelay:0.5];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZfbPayOver:) name:@"aliPayResult" object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WxPayOver:) name:@"wxResult" object:nil];
}
- (void)stopit{
    
    [self downLoadData];
}
- (void)downLoadData{
    
    
    NSDictionary *dic = @{@"jiage":_jiage};
    
    [HttpManager postData:dic andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_alipay" success:^(NSDictionary *fanhuicanshu) {
        
        [[NSUserDefaults standardUserDefaults] setObject:fanhuicanshu[@"orderString"] forKey:@"orderString"];
        orderString = fanhuicanshu[@"orderString"];
        [GiFHUD dismiss];
        
    } Error:^(NSString *cuowuxingxi) {
        
        NSLog(@"%@",cuowuxingxi);
    }];
    
    [HttpManager postData:dic andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_wxpay" success:^(NSDictionary *fanhuicanshu) {
        
        _dict = fanhuicanshu[@"wx"];
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
    NSDictionary *hetong = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",_Dingdan,@"indentid",_phoneNumber,@"phone",_baoxianName,@"name",_baoxianAddress,@"address", _baoxianYouBian,@"code",nil];
    [HttpManager postData:hetong andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_mail" success:^(NSDictionary *fanhuicanshu) {
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    self.navigationController.navigationBar.hidden = NO;
    
    UIView *view = [self.view viewWithTag:10004];
    [view removeFromSuperview];
    
    [GiFHUD dismiss];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"aliPayResult" object:nil];
   // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"wxResult" object:nil];
    
}


// 切换动画
- (void)ZfbPayOver:(NSNotification *)notion{
    
    
    NSDictionary *zhifudict = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhifu"];
    
    //NSString   * s = notion.userInfo[@"result"][@"alipay_trade_app_pay_response"][@"trade_no"];
    NSDictionary *s = notion.userInfo[@"payString"];
    NSString *s1 = s[@"result"];
    NSDictionary *dic;
    if (s1  == nil) {
        
    }else {
        NSData *jsonData = [s1  dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:NSJSONReadingMutableContainers
                                                error:&err];
        if(err)
        {
            NSLog(@"json解析失败：%@",err);
            return;
        }
        
    }
    
    if ([zhifudict[@"zhifu_fenduan"]  isEqualToString:@"1"]) {
        
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:zhifudict[@"userid"],@"userid",zhifudict[@"id"],@"id",dic[@"alipay_trade_app_pay_response"][@"trade_no"],@"trade_no",dic[@"alipay_trade_app_pay_response"][@"total_amount"],@"total_fee",@"支付宝",@"types", nil];
        
        
        [HttpManager postData:dict1 andUrl:@"http://wx.leisurecarlease.com/tc.php?op=zhifudingjin" success:^(NSDictionary *fanhuicanshu) {
            
        } Error:^(NSString *cuowuxingxi) {
            
        }];
        
    }else if ([zhifudict[@"zhifu_fenduan"]  isEqualToString:@"2"]){
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:zhifudict[@"userid"],@"userid",zhifudict[@"id"],@"id",dic[@"alipay_trade_app_pay_response"][@"trade_no"],@"trade_no",dic[@"alipay_trade_app_pay_response"][@"total_amount"],@"total_fee",@"支付宝",@"types", nil];
        
        
        [HttpManager postData:dict1 andUrl:@"http://wx.leisurecarlease.com/tc.php?op=zhifuweikuan" success:^(NSDictionary *fanhuicanshu) {
            
        } Error:^(NSString *cuowuxingxi) {
            
        }];
        
        
    }else {
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:zhifudict[@"userid"],@"userid",zhifudict[@"id"],@"id",dic[@"alipay_trade_app_pay_response"][@"trade_no"],@"trade_no",dic[@"alipay_trade_app_pay_response"][@"total_amount"],@"total_fee",@"支付宝",@"types", nil];
        
        [HttpManager postData:dict1 andUrl:@" http://wx.leisurecarlease.com/tc.php?op=zhifuchaoshifei" success:^(NSDictionary *fanhuicanshu) {
            
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    imageView.image = [UIImage imageNamed:@"开始.png"];
    [self.view addSubview:imageView];
    
    [self performSelector:@selector(showSelectedViewController:) withObject:imageView afterDelay:2];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderString"];
    
    
}

- (void)showSelectedViewController:(UIImageView *)v {
    
    [v removeFromSuperview];
    self.tabBarController.selectedViewController =  self.tabBarController.childViewControllers[3];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    string = [[NSString alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    self.view.backgroundColor = Color(7, 187, 177);
    
    [self createMainView];
}
- (void)fanhui{
    
    self.tabBarController.selectedViewController =  self.tabBarController.childViewControllers[3];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)createMainView{
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(width*0.05, width*0.1, width*0.08, width*0.08);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回白1.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    
    UILabel *xuanze = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(fanhui.frame)+width*0.1, width*0.9, width*0.15)];
    xuanze.text = @"选择付款方式";
    xuanze.textColor = [UIColor whiteColor];
    xuanze.textAlignment = NSTextAlignmentLeft;
    xuanze.font = [UIFont fontWithName:@"Arial-BoldMT" size:30];
    [self.view addSubview:xuanze];
    
    UILabel *zhifubao = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xuanze.frame)+width*0.15, width*0.3, width*0.1)];
    zhifubao.text = @"支付宝";
    zhifubao.textColor = [UIColor whiteColor];
    zhifubao.textAlignment = NSTextAlignmentLeft;
    zhifubao.font = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    [self.view addSubview:zhifubao];
    UILabel *zhifubaolabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(xuanze.frame)+width*0.13, width, width*0.15)];
    [self.view addSubview:zhifubaolabel];
    zhifubaolabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction)];
    [zhifubaolabel addGestureRecognizer:labelRec];
    duihao1 = [UIButton buttonWithType:UIButtonTypeCustom];
    duihao1.frame = CGRectMake(width*0.8, CGRectGetMaxY(xuanze.frame)+width*0.15, width*0.1, width*0.1);
    duihao1.selected = NO;
    [self.view addSubview:duihao1];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(zhifubao.frame)+width*0.03, width*0.9, 1)];
    xian.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xian];
    
    UILabel *weixin = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xian.frame)+width*0.08, width*0.3, width*0.1)];
    weixin.text = @"微信";
    weixin.textColor = [UIColor whiteColor];
    weixin.textAlignment = NSTextAlignmentLeft;
    weixin.font = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    [self.view addSubview:weixin];
    UILabel *weixinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(xian.frame)+width*0.06, width, width*0.15)];
    [self.view addSubview:weixinLabel ];
    weixinLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *labelRec2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction2)];
    
    [weixinLabel addGestureRecognizer:labelRec2];
    duihao2 = [UIButton buttonWithType:UIButtonTypeCustom];
    duihao2.frame = CGRectMake(width*0.8, CGRectGetMaxY(xian.frame)+width*0.08, width*0.1, width*0.1);
    duihao2.selected = NO;
    [self.view addSubview:duihao2];
    
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(weixin.frame)+width*0.03, width*0.9, 1)];
    xian2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xian2];
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(width/2- width*0.35, CGRectGetMaxY(xian2.frame)+width*0.1, width*0.7, width*0.4)];
    timeView.backgroundColor = [UIColor whiteColor];
    timeView.layer.cornerRadius = width*0.02;
    [self.view addSubview:timeView];
    
    UILabel *payMoney = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width *0.3,CGRectGetMaxY(xian2.frame)+width*0.12,width*0.6,width*0.2)];
    payMoney.text = @"支付剩余时间";
    payMoney.textAlignment = NSTextAlignmentCenter;
    payMoney.textColor = Color(7, 187, 177);
    payMoney.font = [UIFont fontWithName:@"Arial-BoldMT" size:30];
    [self.view addSubview:payMoney];
    
    
    UIButton *zhifu = [UIButton buttonWithType:UIButtonTypeCustom];
    zhifu.frame = CGRectMake(width*0.75, CGRectGetMaxY(timeView.frame)+width*0.1, width*0.2, width*0.1);
    zhifu.backgroundColor = [UIColor whiteColor];
    zhifu.layer.cornerRadius = width*0.05;
    [zhifu setTitle:@"支付 >" forState:UIControlStateNormal];
    UIColor *color = Color(7, 187, 177);
    [zhifu setTitleColor:color forState:UIControlStateNormal];
    [zhifu addTarget:self action:@selector(zhifuAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhifu];
}
- (void)selectAction{
    
    duihao1.selected = YES;
    [duihao1 setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
    
    duihao2.selected = NO;
    [duihao2 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}
- (void)zhifuAction:(UIButton *)sender{
    
    if (duihao1.selected == YES && duihao2.selected == NO) {
        
        [self payByAlipay];
    }
    if (duihao1.selected == NO && duihao2.selected == YES) {
        
        [self wenxinPay];
    }
}
- (void)selectAction2{
    
    duihao1.selected = NO;
    [duihao1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    duihao2.selected = YES;
    [duihao2 setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
}


#pragma mark - 支付宝支付

- (void)payByAlipay{
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"alipayY" callback:^(NSDictionary *resultDic) {
        
        if (resultDic && [resultDic objectForKey:@"resultStatus"] && ([[resultDic objectForKey:@"resultStatus"] intValue] == 9000)) {
            
            
        }else{
            
            
        }
//        exit(0);
    }];
    
}

#pragma mark  - 微信支付

- (void)wenxinPay{
    
    PayReq *rep = [[PayReq alloc] init];
    // 由用户微信号和appid 组成的唯一标识符，用于校验微信用户
    rep.openID = _dict[@"appid"];
    // 商家id，申请好的
    rep.partnerId = _dict[@"partnerid"];
    // 固定格式
    rep.package = _dict[@"package"];
    // 预支付订单 后台获取 然后给到
    rep.prepayId = _dict[@"prepayid"];
    // 随机编码 ，后台生成
    rep.nonceStr = _dict[@"noncestr"];
    // 时间戳，后台生成，为了验证支付
    NSString *stamp = _dict[@"timestamp"];
    rep.timeStamp = stamp.intValue;
    // 签名，后台做的
    rep.sign = _dict[@"sign"];
    
    [WXApi sendReq:rep];
    
    [self createAlertView];
}
- (void)createAlertView{
    
    self.tabBarController.selectedViewController =  self.tabBarController.childViewControllers[3];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)moveAll{
    
    UIView *view = [self.view viewWithTag:10004];
    [view removeFromSuperview];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//#pragma mark   ==============微信点击订单支付==============
//-(NSString *)jumpToBizPay {
//    
//    
//    //创建支付签名对象
//    payRequsestHandler *req = [payRequsestHandler alloc];
//    //初始化支付签名对象
//    [req init:APP_ID mch_id:MCH_ID];
//    //设置密钥
//    [req setKey:PARTNER_ID];
//    //获取到实际调起微信支付的参数后，在app端调起支付
//    NSMutableDictionary *dictss = [req sendPay_demo];
//    //============================================================
//    // V3&V4支付流程实现
//    // 注意:参数配置请查看服务器端Demo
//    // 更新时间：2015年11月20日
//    //============================================================
//    //return pay para
//    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    //    NSURL *url = [NSURL URLWithString:urlString];
//    //    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSLog(@"will start response");
//    if ( response != nil) {
//        
//        NSLog(@"response result");
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"url:%@",urlString);
//        if(dict != nil){
//            
//            NSMutableString *retcode = [dict objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                
//                NSLog(@"weixinpaystart");
//                
//                NSMutableString *stamp  = [dictss objectForKey:@"timestamp"];
//                
//                //调起微信支付
//                PayReq* req             = [[PayReq alloc] init];
//                //商家向财付通申请的商家id
//                req.partnerId           = [dictss objectForKey:@"partnerid"];
//                // 预支付订单
//                req.prepayId            = [dictss objectForKey:@"prepayid"];
//                // 随机串，防重发
//                req.nonceStr            = [dictss objectForKey:@"noncestr"];
//                // 时间戳，防重发
//                req.timeStamp           = stamp.intValue;
//                // 商家根据财付通文档填写的数据和签名
//                req.package             = [dictss objectForKey:@"package"];
//                // 商家根据微信开放平台文档对数据做的签名
//                req.sign                = [dictss objectForKey:@"sign"];
//                /*! @brief 发送请求到微信，等待微信返回onResp
//                 *
//                 * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
//                 * SendAuthReq、SendMessageToWXReq、PayReq等。
//                 * @param req 具体的发送请求，在调用函数后，请自己释放。
//                 * @return 成功返回YES，失败返回NO。
//                 */
//                [WXApi sendReq:req];
//                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//                return @"";
//            }else{
//                NSLog(@"cuowule ..........");
//                return [dict objectForKey:@"retmsg"];
//            }
//        }else{
//            return @"服务器返回错误，未获取到json对象";
//        }
//    }else{
//        return @"服务器返回错误";
//    }
//}
//-(void)getOrderPayResult:(NSNotification *)not
//{
//    NSLog(@"微信支付监听结果%@",not.object);
//    if ([not.object isEqualToString:@"successs"]) {
//        [self why];
//        [XWAlterview showmessage:@"微信支付结果" subtitle:@"支付成功" cancelbutton:@"确定"];
//    }if ([not.object isEqualToString:@"faill"]) {
//        [XWAlterview showmessage:@"微信支付结果" subtitle:@"支付失败" cancelbutton:@"确定"];
//    }
//}
//
//-(void)why
//{
//    NSString *arraylistlist=[[NSString alloc]init];
//    arraylistlist=[[NSUserDefaults standardUserDefaults] valueForKey:@"arrayList"];
//    NSLog(@"arrayList=%@", arraylistlist);
//    
//    //    if ([arraylistlist isEqualToString:@"3"]) {
//    //支付定金
//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate = self;
//    HUD.removeFromSuperViewOnHide=YES;
//    //            [HUD hide:YES afterDelay:50];
//    HUD.labelText = @"正在加载数据...";
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        NSDictionary *PROST=[NSDictionary dictionaryWithObjectsAndKeys:
//                             [ZCUserData share].userId,@"userid",
//                             @"0.01",@"orderid", nil];
//        NSLog(@"PROST=%@",PROST);
//        [HttpManager postData:PROST andUrl:ZKDINGJ success:^(NSDictionary *fanhuicanshu) {
//            
//            //                [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
//            //                [self Downwork];
//        } Error:^(NSString *cuowuxingxi) {
//            
//        }];
//        sleep(1);
//    }completionBlock:^{
//        
//    }];
//    
//    //    }
//    //    if ([arraylistlist isEqualToString:@"4"]) {
//    //        if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"]) {
//    //            NSDictionary *DIC=[NSDictionary dictionaryWithObjectsAndKeys:
//    //                               [NSString stringWithFormat:@"%.2f",[[arrayList objectForKey:@"chajia"] floatValue]],@"chajia",
//    //                               self.orderid,@"orderid",nil];
//    //            [HttpManager postData:DIC andUrl:BUCHAJIA success:^(NSDictionary *fanhuicanshu) {
//    //                if ([[fanhuicanshu objectForKey:@"error"] isEqualToString:@"0"]) {
//    ////                    [self Downwork];
//    ////                    [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
//    //                }
//    //
//    //            } Error:^(NSString *cuowuxingxi) {
//    //
//    //            }];
//    //        }else
//    //        {
//    //
//    //            //支付尾款
//    //            NSDictionary *PROST=[NSDictionary dictionaryWithObjectsAndKeys:
//    //                                 [ZCUserData share].userId,@"userid",
//    //                                 self.orderid,@"orderid", nil];
//    //            [HttpManager postData:PROST andUrl:ZKWEIKUAN success:^(NSDictionary *fanhuicanshu) {
//    //
//    ////                [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
//    ////                [self Downwork];
//    //            } Error:^(NSString *cuowuxingxi) {
//    //
//    //            }];
//    //
//    //        }
//    //    }
//}
//#pragma mark   ==============支付宝点击订单支付==============
////
////选中商品调用支付宝极简支付
////
//
////-(void)HereIsPAY
////{
////    
////    [keyv removeFromSuperview];
////    [dangbanview1 removeFromSuperview];
////    
////    /*============================================================================*/
////    /*=======================需要填写商户app申请的===================================*/
////    /*============================================================================*/
////    NSString *partner = @"2088121536284884";
////    NSString *seller = @"zfhuang@huangsensh.com";
////    NSString *privateKey =@"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMqWVwiNI1u71b0bxh1OOz9IoYs7DkFBmWNBCA0AfagA/vIlDOrhSEaSHbi6l1ZWFDyVha5EiskHw8dw7egkneuomhL8nUiLzyXZ8Ut5RYRHGQWTtu2ks2ftDQ5pdWM+ZyjbHQCc0vDtzsmrS0yODbvBnMuTovc4k7hSuxVZaofXAgMBAAECgYAlcMOFARCX048c9BUZNWwdtf6lDLUFumnuvgYO4RhYBFcZyV8pyZjh8f8sNM/jVOVIjRm3q1M69ARqx6QwUxQcNQjWecwi3mAaH3RvFxALquamQHQ/k5WKkguWuOQphnn4CHj4eOgOjIEc5Ng7JTnDsCIJuTYjGWqUYBAQe4kPAQJBAPbw//uoMMZkYZDBicxNszfROfGFFW82nUSMn5HCdChm6SIkWm+bI8K7vV5oN9pwTlBmQuXpe+ymu/kU4mN/9WkCQQDSBNCqVDDpigmfHTAEPGireCFhYYbhgur2fYrRCyWlUG2pu2tLTfaq6ZeA26QkdllH1Ztg9hfhyYYZ+mTEAKs/AkEAq5IaaOEcslrAJvExKo+5u0hVN+c9Uz3g2uXRYFZ4mjGWPTCA3RYvLHeARP2oAM8Sum2ygUdN4MifxZmrCXK4MQJBAIrghj9r5uA32H7wJRVYAPsKOECV5kRvdwJCKC5tyZoUoj+v4JZuWqPQTc/27gbyf71hwhqPAWHcCiJZkpKNwq8CQBhH6YosBIYxMAA8ac4qS8q5h2ur4snSNPX/vXUqzlqnQ+tw71gKJ97Y4OVShrvxxXZX0iQbiIwugHrBs1wC3ck=";
////    /*============================================================================*/
////    /*============================================================================*/
////    /*============================================================================*/
////    if ([partner length] == 0 ||
////        [seller length] == 0 ||
////        [privateKey length] == 0)
////    {
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
////                                                        message:@"缺少partner或者seller或者私钥。"
////                                                       delegate:self
////                                              cancelButtonTitle:@"确定"
////                                              otherButtonTitles:nil];
////        [alert show];
////        return;
////    }
////    
////    /*
////     *生成订单信息及签名
////     */
////    //将商品信息赋予AlixPayOrder的成员变量
////    Order *order = [[Order alloc]init];
////    BizContent *biz = [[BizContent alloc] init];
////    
////    order.app_id = partner;
////    biz.seller_id = seller;
////    biz.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
////    //order.biz_content.subject = [NSString stringWithFormat:@"%@",self.dingdanhao8]; //商品标题
////    biz.subject = @"商品"; // 标题
////    biz.body =@"闲车支付" ; //商品描述
////    
////    //NSString *total_amount=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"qianqianqian"]];
////    
////    biz.total_amount = @"0.01"; //商品价格
////    //order.return_url =  @"http://wx.leisurecarlease.com/alipay.php"; //回调URL
////    
////    order.method = @"mobile.securitypay.pay";
////    order.sign_type = @"1";
////    order.charset = @"utf-8";
////    biz.timeout_express = @"30m";
////    order.notify_url = @"m.alipay.com";
////    order.biz_content =biz;
////    
////    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
////    NSString *appScheme = @"alipayY";
////    
////    //将商品信息拼接成字符串
////    NSString *orderSpec = [order description];
////    NSLog(@"orderSpec = %@",orderSpec);
////    
////    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
////    id<DataSigner> signer = CreateRSADataSigner(privateKey);
////    NSString *signedString = [signer signString:orderSpec];
////    
////    //将签名成功字符串格式化为订单字符串,请严格按照该格式
////    NSString *orderString = nil;
////    if (signedString != nil) {
////        
////        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
////                       orderSpec, signedString, @"RSA"];
////        
////        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
////            NSLog(@"apipay callback");
////            //            NSLog(@"")
////            NSLog(@"reslut = %@",resultDic);
////            
////            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"6001"]) {
////                
////                [XWAlterview showmessage:@"支付宝支付结果" subtitle:@"支付失败" cancelbutton:@"确定"];
////            }else{
////                
////                //                if ([[arrayList objectForKey:@"status"]isEqualToString:@"3"]) {
////                //支付定金
////                HUD = [[MBProgressHUD alloc] initWithView:self.view];
////                [self.view addSubview:HUD];
////                HUD.delegate = self;
////                HUD.removeFromSuperViewOnHide=YES;
////                //            [HUD hide:YES afterDelay:50];
////                HUD.labelText = @"正在加载数据...";
////                [HUD showAnimated:YES whileExecutingBlock:^{
////                    NSDictionary *PROST=[NSDictionary dictionaryWithObjectsAndKeys:
////                                         [ZCUserData share].userId,@"userid",
////                                         self.orderid,@"orderid", nil];
////                    [HttpManager postData:PROST andUrl:ZKDINGJ success:^(NSDictionary *fanhuicanshu) {
////                        
////                        //                            [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
////                        
////                        if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"]) {
////                            
////                            alertController = [UIAlertController alertControllerWithTitle:@"提示（*必填项）" message:@"订单支付成功\n请输入尾款" preferredStyle:UIAlertControllerStyleAlert];
////                            __weak __typeof(self)weakSelf = self;
////                            alertController.view.userInteractionEnabled=NO;
////                            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
////                                // 可以在这里对textfield进行定制，例如改变背景色
////                                textField.keyboardType=UIKeyboardTypeNumberPad;
////                                
////                                //                                    [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(handleTextFieldTextDidChangeNotification1:) name:UITextFieldTextDidChangeNotification object:textField];
////                            }];
////                            
////                            
////                            //                                NSLog(@"textFieldzzz1.text.length=%ld",textFieldzzz1.text.length);
////                            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////                                //                                    NSLog(@"textField=%@",textFieldzzz1.text);
////                                //                                    if ([textFieldzzz1.text isEqual:@""]) {
////                                //                                        [self Downwork];
////                                //                                    }else
////                                //                                    {
////                                //                                        NSDictionary *PROST3=[NSDictionary dictionaryWithObjectsAndKeys:
////                                //                                                              textFieldzzz1.text,@"weikuan",
////                                //                                                              self.orderid,@"orderid", nil];
////                                //
////                                //                                        _shouldCancel=YES;
////                                //                                        [HttpManager postData:PROST3 andUrl:SHANGJIA_TIJIAO_WEIKUAN success:^(NSDictionary *fanhuicanshu) {
////                                //
////                                //                                            [self Downwork];
////                                //
////                                //                                        } Error:^(NSString *cuowuxingxi) {
////                                //
////                                //                                        }];
////                                //
////                                //                                    }
////                                
////                                
////                            }];
////                            
////                            [alertController addAction:otherAction];
////                            
////                            
////                            
////                            [self presentViewController:alertController animated:YES completion:nil];
////                            
////                        }else
////                        {
////                            //                                [self Downwork];
////                            
////                            [XWAlterview showmessage:@"支付宝支付结果" subtitle:@"支付成功" cancelbutton:@"确定"];
////                        }
////                        
////                    } Error:^(NSString *cuowuxingxi) {
////                        NSLog(@"alipayerror:%@",cuowuxingxi);
////                    }];
////                    
////                }completionBlock:^{
////                    
////                }];
////                
////            }
////        }];
////    }
////}
////
////- (NSString *)generateTradeNO
////{
////    static int kNumber = 15;
////    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
////    
////    //NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
////    NSMutableString *resultStr = [[NSMutableString alloc] init];
////    //    srand((unsigned)time(0));
////    for (int i = 0; i < kNumber; i++)
////    {
////        unsigned index = rand() % [sourceStr length];
////        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
////        [resultStr appendString:oneStr];
////    }
////    return resultStr;
////}
@end
