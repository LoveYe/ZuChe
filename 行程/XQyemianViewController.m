//
//  TijiaodingdanViewController.m
//  ZuChe
//
//  Created by J.X.Y on 16/1/11.
//  Copyright © 2016年 佐途. All rights reserved.
//
#define DIZI [[NSUserDefaults standardUserDefaults] valueForKey:@"chezuweizi"]
#import "XQyemianViewController.h"
#import "AllPages.pch"
#import "Cubutton.h"
#import "SXFirsttableViewModel.h"
#import "OderManagementViewController.h"
#import "XWAlterview.h"
#import "TijiaopingjiaViewController.h"
#import "Order.h"
#import "MapViewController.h"
#import "NSDataEx.h"
#import <AlipaySDK/AlipaySDK.h>
#import "payRequsestHandler.h"
#import "WXUtil.h"
#import "UILabel+SizeLabel.h"
#import "MAPPViewController.h"
#import "ERWEIMARootViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入搜索功能所有的头文件

@implementation Product

@end
@interface XQyemianViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    AFHTTPRequestOperationManager *manager;
    NSMutableArray *countarray;
    NSDictionary *arrayList;
    UIButton *rightbutton;
    UIButton *btnn;
    NSMutableArray *carrr;
    NSString *Sdizi;
    int _zongjia;
    //按钮状态
    NSMutableArray *zhuangtaiarray;
    NSMutableArray *qianqian;
    UIView *dangbanview1;
    UIWindow *keyv;
    BMKMapView *_mapView;
    BMKGeoCodeSearch *_geoCodeSearch;
    BMKReverseGeoCodeOption *_reverseGeoCodeOption;
    BMKLocationService *_locService;
    NSString *SHANGJIA;
    UITextField *textFieldzzz1;
    UIAlertController *alertController;
    NSTimer *_timers;
    NSDate*m_pStartDate;
    BOOL _shouldCancel;
}
@property (nonatomic ,retain)UITableView *tableview;
@end

@implementation XQyemianViewController

- (void)dealloc {
    self.delegate = nil;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [_tableview reloadData];
    SHANGJIA=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SHANGJIA"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];//监听微信结果通知
    self.tabBarController.tabBar.hidden =YES;
    _shouldCancel =NO;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleColorChange:) name:@"do" object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];//移除通知
    self.tabBarController.tabBar.hidden =NO;
    _shouldCancel =YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithTitle:[NSString stringWithFormat:@"%@",self.dingdanhao8]];
    keyv=[[UIApplication sharedApplication] keyWindow];
    dangbanview1=[[UIView alloc]initWithFrame:keyv.bounds];
    UIButton *viewew=[[UIButton alloc]initWithFrame:keyv.bounds];
    [viewew addTarget:self action:@selector(removiewiew) forControlEvents:UIControlEventTouchUpInside];
    viewew.backgroundColor=[UIColor blackColor];
    viewew.alpha=0.5;
    [dangbanview1 addSubview:viewew];
    //设置支付宝支付按钮
    UIButton *alipaybutton=[UIButton buttonWithType:UIButtonTypeCustom];
    alipaybutton.frame=CGRectMake(ScreenWidth-Height(10)-Height(115), keyv.frame.size.height-Height(90), Height(115), Height(45));
    alipaybutton.backgroundColor=[UIColor whiteColor];
    alipaybutton.layer.cornerRadius=alipaybutton.frame.size.height/2;
    [alipaybutton setImage:[UIImage imageNamed:@"zfbicon"] forState:UIControlStateNormal];
    [alipaybutton setTitle:@"支付宝" forState:UIControlStateNormal];
    alipaybutton.titleLabel.font=Font(14);
    UIColor *dottextcolor=Color(32, 32, 32);
    [alipaybutton setImageEdgeInsets:UIEdgeInsetsMake(0, -Height(9), 0,Height(9))];
    [alipaybutton setTitleColor:dottextcolor forState:UIControlStateNormal];
    [alipaybutton addTarget:self action:@selector(alipaybtn) forControlEvents:UIControlEventTouchUpInside];
    [dangbanview1 addSubview:alipaybutton];
    //微信按钮
    UIButton *weixinbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    weixinbutton.frame=CGRectMake(Height(10), keyv.frame.size.height-Height(90), Height(115), Height(45));
    weixinbutton.backgroundColor=[UIColor whiteColor];
    weixinbutton.layer.cornerRadius=alipaybutton.frame.size.height/2;
    [weixinbutton setImage:[UIImage imageNamed:@"weixinbtn"] forState:UIControlStateNormal];
    [weixinbutton setTitle:@"微信" forState:UIControlStateNormal];
    weixinbutton.titleLabel.font=Font(14);
    [weixinbutton setImageEdgeInsets:UIEdgeInsetsMake(0, -Height(9), 0,Height(9))];
    [weixinbutton setTitleColor:dottextcolor forState:UIControlStateNormal];
    [weixinbutton addTarget:self action:@selector(weixinpay) forControlEvents:UIControlEventTouchUpInside];
    
    if ([WXApi isWXAppInstalled]) {
        
        NSLog(@"安装了微信");
    }else
    {
        NSLog(@"没安装微信");
    }
    
    [dangbanview1 addSubview:weixinbutton];
    
    
    //中间的取消按钮
    UIButton *celn=[UIButton buttonWithType:UIButtonTypeCustom];
    celn.frame=CGRectMake(ScreenWidth/2-Height(45)/2, keyv.frame.size.height-Height(90), Height(45), Height(45));
    celn.backgroundColor=[UIColor whiteColor];
    celn.layer.cornerRadius=alipaybutton.frame.size.height/2;
    [celn setTitle:@"取消" forState:UIControlStateNormal];
    celn.titleLabel.font=Font(14);
    [celn setTitleColor:dottextcolor forState:UIControlStateNormal];
    [celn addTarget:self action:@selector(quxiaobtn) forControlEvents:UIControlEventTouchUpInside];
    [dangbanview1 addSubview:celn];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chezuweizi"];
    self.view.backgroundColor=[UIColor whiteColor];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.removeFromSuperViewOnHide=YES;
    //            [HUD hide:YES afterDelay:50];
    HUD.labelText = @"正在加载数据...";
    [HUD showAnimated:YES whileExecutingBlock:^{
        [self Downwork];
        
    }completionBlock:^{
        
    }];
    
}
-(void)Downwork
{
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    //    hud.labelText = @"提交中...";
    
    carrr=[NSMutableArray array];
    countarray=[NSMutableArray array];
    arrayList=[NSDictionary dictionary];
    qianqian=[NSMutableArray array];
    NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:self.orderid,@"orderid",nil];
    [HttpManager postData:parameters andUrl:ZUKEDINGDANXQ success:^(NSDictionary *fanhuicanshu) {
        if ([ fanhuicanshu  isKindOfClass:[NSDictionary class]]) {
            qianqian=[fanhuicanshu objectForKey:@"carlist"];
            arrayList=fanhuicanshu;
            
            NSLog(@"arrayList：%@",arrayList);
            if ([[arrayList objectForKey:@"status"] isEqualToString:@"3.5"]) {
                _shouldCancel=YES;
            }
            //            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            if ([[arrayList objectForKey:@"status"]isEqualToString:@"4"]) {//进行中,等待尾款
                if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dsweikuan"]] isEqualToString:@"<null>"]) {
                    if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"]) {
                        __weak __typeof(self)weakSelf = self;
                        
                        alertController = [UIAlertController alertControllerWithTitle:@"提示（*必填项）" message:@"订单支付成功\n请输入尾款，" preferredStyle:UIAlertControllerStyleAlert];
                        alertController.view.userInteractionEnabled=NO;
                        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                            // 可以在这里对textfield进行定制，例如改变背景色
                            textField.keyboardType=UIKeyboardTypeNumberPad;
                            [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(handleTextFieldTextDidChangeNotification1:) name:UITextFieldTextDidChangeNotification object:textField];
                        }];
                        
                        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            NSLog(@"textField=%@",textFieldzzz1.text);
                            if ([textFieldzzz1.text isEqual:@""]) {
                                [self Downwork];
                            }else
                            {
                                NSDictionary *PROST3=[NSDictionary dictionaryWithObjectsAndKeys:
                                                      textFieldzzz1.text,@"weikuan",
                                                      self.orderid,@"orderid", nil];
                                
                                
                                [HttpManager postData:PROST3 andUrl:SHANGJIA_TIJIAO_WEIKUAN success:^(NSDictionary *fanhuicanshu) {
                                    
                                    [self Downwork];
                                    
                                } Error:^(NSString *cuowuxingxi) {
                                    
                                }];
                            }
                            
                            
                            
                        }];
                        
                        [alertController addAction:otherAction];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                    
                }
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:arrayList[@"status"] forKey:@"arrayList"];
            for (NSDictionary * dict in [fanhuicanshu objectForKey:@"carlist"])
            {
                
                NSString *weikuan=[NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"carmoney"] floatValue]-[[dict objectForKey:@"dingjin"] floatValue]];
                NSString *pingjie=[NSString stringWithFormat:@"carid:%@;dingjin:%.2f;weikuan:%@",[dict objectForKey:@"carid"],[[dict objectForKey:@"dingjin"] floatValue],weikuan];
                [carrr addObject:pingjie];
                SXFirsttableViewModel *model=[SXFirsttableViewModel ViewWithDictionary:dict];
                [countarray addObject:model];
            }
        }
        [self Tableview];
        
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"error==%@",cuowuxingxi);
    }];
    
}
-(void)Tableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height(44)) style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.backgroundColor=Color(245, 245, 245);
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    //    //MJ刷新
    //    _tableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        
    //        [self Downwork];
    //        //结束刷新
    //        [_tableview.mj_header endRefreshing];
    //    }];
    //小贾自定义刷新
    [self Refresh_JXY:_tableview VOID:^{
        [self Downwork];
    }];
    //这里判断是否显示地图按钮
    if ([[arrayList objectForKey:@"status"]isEqualToString:@"4"]) {//进行中,等待尾款
        
        
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"dd"];
        
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        
        NSString * jiheDay =[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"chuche"]];
        
        NSLog(@"集合的时间%@",jiheDay);
        
        NSArray * array =[jiheDay componentsSeparatedByString:@" "];
        NSString * shijian =[NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
        NSArray * arr=[shijian componentsSeparatedByString:@"-"];
        NSString *day =[NSString stringWithFormat:@"%@",[arr objectAtIndex:2]];
        
        
        NSLog(@"截取的时间%@",day);
        if ([locationString intValue]==[day intValue])
        {
            rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,Height(25),Height(25))];
            [rightbutton setImage:[UIImage imageNamed:@"定位地图"] forState:UIControlStateNormal];
            [rightbutton addTarget:self action:@selector(sousuobtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addItemWithCustomView:@[rightbutton] isLeft:NO];
            
        }
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGFloat num=0;
    if (section==0) {
        num=5;
    }if (section==1) {
        num=countarray.count;
    }if (section==2) {
        if ([[arrayList objectForKey:@"status"]isEqualToString:@"6"]) {
            num=4;
        }else
        {
            if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"]) {
                
                if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dsweikuan"]] isEqualToString:@"<null>"]) {
                    num=3;
                }else
                {
                    num=5;
                }
                
                
            }else
            {
                num=3;
            }
            
        }
        
    }if (section==3) {
        num=1;
    }
    return num;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            height=Height(35);
        }if (indexPath.row==4) {
            height=Height(100);
        }else
        {
            height=Height(35);
        }
        
    }if (indexPath.section==1) {
        height=Height(100);
    }if (indexPath.section==2) {
        height=Height(35);
    }if (indexPath.section==3) {
        height=Height(100);
    }
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"imageCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }else
    {
        for (UIView *sub in cell.contentView.subviews) {
            [sub removeFromSuperview];
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UIColor *huise=Color(81, 81, 81);
    //线
    UILabel *xian=[[UILabel alloc]initWithFrame:CGRectMake(Height(10), Height(35)-1, Height(305),0.3)];
    xian.backgroundColor=[UIColor colorWithRed:81/255 green:81/255 blue:81/255 alpha:0.5];
    xian.alpha=0.4;
    
    //左边字（出车日期。实际费用）
    UILabel *youbian=[MyUtil createLabelFrame:CGRectMake(Height(10), 0, Height(150), Height(35)) title:nil textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:Height(13)] color:[UIColor blackColor]];
    youbian.alpha=0.7;
    //左边图片
//    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(Height(10), (Height(35)-Height(14))/2, Height(14), Height(14))];
    //左边图片后面的字
    UILabel *zuobianxiao=[MyUtil createLabelFrame:CGRectMake(Height(25), 0, ScreenWidth, Height(35)) title:nil textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:Height(13)] color:huise];
    
    UIColor *jiedancolor=Color(246, 99, 107)//红
    
    //右边大字（钱 ¥678）
    UILabel *zuobianda=[MyUtil createLabelFrame:CGRectMake(ScreenWidth-2*Height(10)- Height(150), 0, Height(150), Height(35)) title:nil textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:Height(15)] color:[UIColor blackColor]];
    zuobianda.alpha=0.7;
    //对号（钱旁边的对号）
    UIImageView *duihaoimage=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-2*Height(12)- Height(90),(Height(35)-Height(18))/2, Height(18), Height(18))];
    duihaoimage.image=[UIImage imageNamed:@"没对号"];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.backgroundColor=Color(234, 234, 234);
            
            //时间前面的圆
            UIImageView *yuan=[[UIImageView alloc]initWithFrame:CGRectMake(Height(10),(Height(35)-Height(10))/2 , Height(10), Height(10))];
            [yuan setImage:[UIImage imageNamed:@"圆40-40"]];
            [cell.contentView addSubview:yuan];
            
            UILabel *labell=[[UILabel alloc]initWithFrame:CGRectMake(Height(25), 0, ScreenWidth, Height(35))];
            
            NSString *diyige=[[NSString alloc]init];
            if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"chuche"]]isEqualToString:@"(null)"]) {
                diyige=@"2016-03-18";
            }else
            {
                diyige=[NSString stringWithFormat:@"%@",[[arrayList objectForKey:@"chuche"] componentsSeparatedByString:@" "][0]];
            }
            labell.text=diyige;
            labell.textColor =[UIColor blackColor];
            labell.alpha=0.7;
            labell.font=[UIFont boldSystemFontOfSize:Height(15)];
            [cell.contentView addSubview:labell];
            [cell.contentView addSubview:xian];
        }else
        {
            cell.backgroundColor=[UIColor whiteColor];
        }
        if (indexPath.row==1) {
            //            img.image=[UIImage imageNamed:@"iconfont-03_03"];
            //            [cell.contentView addSubview:img];
            NSString *diyige=[[NSString alloc]init];
            if ([[[arrayList objectForKey:@"chuche"] componentsSeparatedByString:@" "] count]==1||[[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"chuche"]]isEqualToString:@"(null)"]) {
                diyige=@"时间：10:00";
            }else
            {
                diyige=[NSString stringWithFormat:@"时间：%@",[[arrayList objectForKey:@"chuche"] componentsSeparatedByString:@" "][1]];
            }
            
            if ([diyige isEqualToString:@"(null)"]) {
                diyige=@"";
            }
            zuobianxiao.text=diyige;
            zuobianxiao.textColor=[UIColor blackColor];
            zuobianxiao.font=[UIFont boldSystemFontOfSize:Height(13)];
            zuobianxiao.alpha=0.7;
            [cell.contentView addSubview:xian];
            [cell.contentView addSubview:zuobianxiao];
            //            [cell.contentView addSubview:XQ];
        }if (indexPath.row==2) {
            //            img.image=[UIImage imageNamed:@"iconfont-03_0"];
            //            [cell.contentView addSubview:img];
            NSString *diyige1=[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"jihe"]];
            if ([diyige1 isEqualToString:@"(null)"]) {
                diyige1=@"";
            }
            zuobianxiao.text=[NSString stringWithFormat:@"地址：%@",diyige1];
            zuobianxiao.textColor=[UIColor blackColor];
            zuobianxiao.font=[UIFont boldSystemFontOfSize:Height(13)];
            zuobianxiao.alpha=0.7;
            [cell.contentView addSubview:zuobianxiao];
            [cell.contentView addSubview:xian];
        }if (indexPath.row==3) {
            //            img.image=[UIImage imageNamed:@"iconfont-03_0"];
            //            [cell.contentView addSubview:img];
            NSString *diyige1=[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"name"]];
            if ([diyige1 isEqualToString:@"(null)"]) {
                diyige1=@"";
            }
            zuobianxiao.text=[NSString stringWithFormat:@"租客：%@",diyige1];
            zuobianxiao.textColor=[UIColor blackColor];
            zuobianxiao.font=[UIFont boldSystemFontOfSize:Height(13)];
            zuobianxiao.alpha=0.7;
            [cell.contentView addSubview:zuobianxiao];
            //            [cell.contentView addSubview:XQ];
            
        }
        
        if (indexPath.row==4) {
            
            UIImageView *map=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, Height(100))];
            map.backgroundColor=[UIColor whiteColor];
            map.userInteractionEnabled=YES;
            [cell.contentView addSubview:map];
            
            
            
            if (_mapView==nil) {
                
                _mapView=[[BMKMapView alloc]initWithFrame:map.bounds];
                
                [_mapView setMapType:BMKMapTypeStandard];// 地图类型 ->卫星／标准、
                
                _mapView.zoomLevel=19;
                
                _mapView.showsUserLocation = YES;
                
                
                
            }
            _mapView.delegate=self;
            
            _mapView.centerCoordinate = CLLocationCoordinate2DMake(121, 112);
            BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
            geocodeSearchOption.city= @"上海";
            NSString *diyige1=[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"jihe"]];
            if ([diyige1 isEqualToString:@"(null)"]) {
                diyige1=@"";
            }
            geocodeSearchOption.address =diyige1;
            BOOL flag = [_geoCodeSearch geoCode:geocodeSearchOption];
            if(flag)
            {
                NSLog(@"geo检索发送成功");
            }
            else
            {
                NSLog(@"geo检索发送失败");
            }
            
            [map addSubview:_mapView];
            UIButton *beee=[UIButton buttonWithType:UIButtonTypeCustom];
            beee.frame=map.bounds;
            beee.userInteractionEnabled=YES;
            [beee addTarget:self action:@selector(beee:) forControlEvents:UIControlEventTouchUpInside];
            beee.backgroundColor=[UIColor clearColor];
            [map addSubview:beee];
            
        }
    }if (indexPath.section==1) {
        for (int i=0; i<countarray.count; i++)
        {
//            cell=[self jxytableView:_tableview cellForRowAtIndexPath:indexPath];
        }
        
    }if (indexPath.section==2) {
        if (indexPath.row==0) {
            
            youbian.text=@"实际费用";
            [cell.contentView addSubview:youbian];
            zuobianda.text=[NSString stringWithFormat:@"¥ %.2f",[[arrayList objectForKey:@"money"] floatValue]];
            [cell.contentView addSubview:zuobianda];
            if ([[arrayList objectForKey:@"money"] floatValue]==0) {
                duihaoimage.image=[UIImage imageNamed:@"没对号"];
            }else
            {
                duihaoimage.image=[UIImage imageNamed:@"对号"];
            }
            
            [cell.contentView addSubview:duihaoimage];
            if ([[arrayList objectForKey:@"status"]isEqualToString:@"1"]){//等待
                
            }if ([[arrayList objectForKey:@"status"]isEqualToString:@"2"]) {//拒绝
                
            }if ([[arrayList objectForKey:@"status"]isEqualToString:@"3"]) {//等待支付定金，已接单
                
            }if ([[arrayList objectForKey:@"status"]isEqualToString:@"3.5"]) {//显示二维码按钮，不可点
                
            }if ([[arrayList objectForKey:@"status"]isEqualToString:@"4.5"]) {//显示二维码，可点
                
            }if ([[arrayList objectForKey:@"status"]isEqualToString:@"4"]) {//进行中,等待尾款
                
            }if ([[arrayList objectForKey:@"status"]isEqualToString:@"5"]) {//完成
                
            }if ([[arrayList objectForKey:@"status"]isEqualToString:@"6"]) {//取消
                
            }
            
            
            NSString * string =[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"status"]];
            
            if ([string isEqualToString:@"5"]||[string isEqualToString:@"7"])
            {
                duihaoimage.image=[UIImage imageNamed:@"对号"];
            }else
            {
                duihaoimage.image=[UIImage imageNamed:@"没对号"];
                zuobianda.textColor =[UIColor blackColor];
            }
            
            
            
            
            
            
        }if (indexPath.row==1) {
            youbian.text=@"需要支付租车定金";
            [cell.contentView addSubview:youbian];
            zuobianda.text=[NSString stringWithFormat:@"¥ %.2f",[[arrayList objectForKey:@"dingjin"] floatValue]];
            if ([[arrayList objectForKey:@"status"]isEqualToString:@"3"]) {
                zuobianda.textColor=jiedancolor;
                zuobianda.alpha=1;
            }
            if ([[arrayList objectForKey:@"status"]integerValue]>3) {
                if ([[arrayList objectForKey:@"dingjin"] floatValue]==0) {
                    duihaoimage.image=[UIImage imageNamed:@"没对号"];
                }else
                {
                    duihaoimage.image=[UIImage imageNamed:@"对号"];
                }
                
            }
            NSString * string =[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"status"]];
            
            if ([string isEqualToString:@"3.5"]||[string isEqualToString:@"4.5"]||[string isEqualToString:@"5"]|[string isEqualToString:@"7"]||[string isEqualToString:@"4"])
            {
                duihaoimage.image=[UIImage imageNamed:@"对号"];
            }else
            {
                duihaoimage.image=[UIImage imageNamed:@"没对号"];
                zuobianda.textColor =Color(246, 99, 107);//红
            }
            if ([string isEqualToString:@"3"])
            {
                zuobianda.textColor =Color(246, 99, 107);
            }
            if ([string isEqualToString:@"6"])
            {
                zuobianda.textColor =[UIColor blackColor];

            }

            
            
            
            
            
            [cell.contentView addSubview:duihaoimage];
            [cell.contentView addSubview:zuobianda];
        }if (indexPath.row==2) {
            youbian.text=@"需要支付租车尾款";
            [cell.contentView addSubview:youbian];
            zuobianda.text=[NSString stringWithFormat:@"¥ %.2f",[[arrayList objectForKey:@"weikuan"] floatValue]];
            if ([[arrayList objectForKey:@"status"]isEqualToString:@"4"]) {
                zuobianda.textColor=jiedancolor;
                zuobianda.alpha=1;
            }
            if ([[arrayList objectForKey:@"status"]integerValue]>4) {
                if ([[arrayList objectForKey:@"weikuan"] floatValue]==0) {
                    duihaoimage.image=[UIImage imageNamed:@"没对号"];
                }else
                {
                    duihaoimage.image=[UIImage imageNamed:@"对号"];
                }
                
                NSString * string =[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"status"]];

                if ([string isEqualToString:@"3.5"])
                {
                    zuobianda.textColor =Color(246, 99, 107);//红
                }
            }
            [cell.contentView addSubview:duihaoimage];
            [cell.contentView addSubview:zuobianda];
            
            
            if ([[arrayList objectForKey:@"status"]isEqualToString:@"6"])
            {
                
                youbian.text=@"支付违约金";
                
                NSString * str =[NSString stringWithFormat:@"¥ %.2f",[[arrayList objectForKey:@"dingjin"] floatValue]*0.05];
                zuobianda.text =str;
                
            }
            NSString * string =[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"status"]];

            if ([string isEqualToString:@"3.5"]||[string isEqualToString:@"4.5"])
            {
                duihaoimage.image=[UIImage imageNamed:@"没对号"];
                zuobianda.textColor =Color(246, 99, 107);
            }
            if ([string isEqualToString:@"3"])
            {
                duihaoimage.image=[UIImage imageNamed:@"没对号"];
                zuobianda.textColor =[UIColor blackColor];

            }
//            if ()
//            {
//                <#statements#>
//            }

            
            
        }
        if (indexPath.row==3) {
            youbian.text=@"线下需收尾款";
            [cell.contentView addSubview:youbian];
            
            if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"]) {
                NSString *  str=[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dsweikuan"]];
                if ([str isEqualToString:@"<null>"])
                {
                    zuobianda.text=@"";
                }else
                {
                    zuobianda.text=[NSString stringWithFormat:@"¥ %.2f",[[arrayList objectForKey:@"dsweikuan"] floatValue]];
                    
                }
                
            }else
            {
                zuobianda.text=[NSString stringWithFormat:@"¥ %.2f",[[arrayList objectForKey:@"weikuan"] floatValue]];
            }
            
            
            if ([[arrayList objectForKey:@"status"]isEqualToString:@"4"]) {
                zuobianda.textColor=jiedancolor;
                zuobianda.alpha=1;
            }
            if ([[arrayList objectForKey:@"status"]integerValue]>4) {
                if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"]) {
                    NSString *  str=[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dsweikuan"]];
                    if ([str isEqualToString:@"<null>"]||[str isEqualToString:@"0"]) {
                        duihaoimage.image=[UIImage imageNamed:@"没对号"];
                    }else
                    {
                        duihaoimage.image=[UIImage imageNamed:@"对号"];
                    }
                    
                }else
                {
                    if ([[arrayList objectForKey:@"weikuan"] floatValue]==0) {
                        duihaoimage.image=[UIImage imageNamed:@"没对号"];
                    }else
                    {
                        duihaoimage.image=[UIImage imageNamed:@"对号"];
                    }
                }
                
                
            }
            [cell.contentView addSubview:duihaoimage];
            [cell.contentView addSubview:zuobianda];
            
        }if (indexPath.row==4) {
            youbian.text=@"需补差价";
            [cell.contentView addSubview:youbian];
            zuobianda.text=[NSString stringWithFormat:@"¥ %.2f",[[arrayList objectForKey:@"chajia"] floatValue]];
            if ([[arrayList objectForKey:@"status"]isEqualToString:@"4"]) {
                zuobianda.textColor=jiedancolor;
                zuobianda.alpha=1;
            }
            if ([[arrayList objectForKey:@"status"]integerValue]>4) {
                if ([[arrayList objectForKey:@"chajia"] floatValue]==0) {
                    duihaoimage.image=[UIImage imageNamed:@"没对号"];
                }else
                {
                    duihaoimage.image=[UIImage imageNamed:@"对号"];
                }
            }
            [cell.contentView addSubview:duihaoimage];
            [cell.contentView addSubview:zuobianda];
        }
        
        if ([[arrayList objectForKey:@"status"]isEqualToString:@"6"]) {//取消
            if (indexPath.row==3) {
                youbian.text=@"返还现金";
                zuobianda.text=[NSString stringWithFormat:@"¥ %.2f",[[arrayList objectForKey:@"dingjin"] floatValue]*0.95];
                
                if ([[arrayList objectForKey:@"dingjin"] floatValue]==0) {
                    duihaoimage.image=[UIImage imageNamed:@"没对号"];
                    
                }else
                {
                    duihaoimage.image=[UIImage imageNamed:@"对号"];
                    zuobianda.textColor=jiedancolor;
                    zuobianda.alpha=1;
                }
                [cell.contentView addSubview:youbian];
                [cell.contentView addSubview:zuobianda];
                [cell.contentView addSubview:duihaoimage];
                
                UIButton *btn =[UIButton buttonWithType:UIButtonTypeSystem];
                float myWidth =[UILabel width:youbian.text heightOfFatherView:youbian.frame.size.height textFont:youbian.font];
                btn.frame =CGRectMake(Height(12)+myWidth, Height(35)/2 -ScreenWidth*0.04/2, ScreenWidth*0.04  ,  ScreenWidth*0.04);
                [btn setBackgroundImage:[UIImage imageNamed:@"问好"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(fanHuan) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn];
                
                
            }
            
        }
        
        
        
        [cell.contentView addSubview:xian];
    }if (indexPath.section==3) {
        UIColor *dianhuacolor=Color(18, 152, 233)//蓝
        btnn=[UIButton buttonWithType:UIButtonTypeCustom];
        btnn.backgroundColor=dianhuacolor;
        btnn.titleLabel.font=[UIFont systemFontOfSize:Height(14)];
        btnn.layer.cornerRadius=3;
        btnn.frame=CGRectMake(ScreenWidth/2-Height(305)/2, Height(30), Height(305), Height(35));
        if ([[arrayList objectForKey:@"status"]isEqualToString:@"3"])
            
        {//等待支付定金，已接单
            
            
            
            
            //            _timers=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calcuRemainTime) userInfo:nil repeats:YES];
            //            [[NSRunLoop mainRunLoop] addTimer:_timers forMode:NSDefaultRunLoopMode];
            
            
            //            m_pStartDate = [NSDate date];
            
            
            //            [btnn setTitle:@"支付定金" forState:UIControlStateNormal];
            [btnn addTarget:self action:@selector(zfdj) forControlEvents:UIControlEventTouchUpInside];
            
            btnn.frame =CGRectMake(ScreenWidth*0.028,Height(35), (ScreenWidth/2-2*ScreenWidth*0.028), Height(40));
            btnn.titleLabel.font=[UIFont systemFontOfSize:Height(11)];
            btnn.layer.cornerRadius=Height(5);
            
            
            [cell.contentView addSubview:btnn];
            
            UIButton *QXcar1=[UIButton buttonWithType:UIButtonTypeCustom];
            QXcar1.frame=CGRectMake(ScreenWidth*0.028+ScreenWidth/2, Height(35), (ScreenWidth/2-2*ScreenWidth*0.028), Height(40));
            [QXcar1 setTitle:@"取消订单" forState:UIControlStateNormal];
            [QXcar1 addTarget:self action:@selector(cacelBtnClick) forControlEvents:UIControlEventTouchUpInside];
            QXcar1.backgroundColor=[UIColor clearColor];
            QXcar1.layer.borderWidth=1;
            QXcar1.layer.borderColor=[UIColor colorWithRed:0 green:0.66 blue:0.933 alpha:1.00].CGColor;
            QXcar1.titleLabel.font=[UIFont systemFontOfSize:Height(14)];
            QXcar1.layer.cornerRadius=Height(5);
            UIColor *color =Color(0, 170, 238);
            [QXcar1 setTitleColor:color forState:UIControlStateNormal];
            [cell.contentView addSubview:QXcar1];
            
            
            NSString * str =[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"miao"]];
            NSLog(@"time=%@",str);
            __block int timeout=[str intValue]; //倒计时时间
            
            if (timeout<0)
            {
                
                NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",[arrayList objectForKey:@"dingdanhao"],@"orderid", nil];
                
                [HttpManager postData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=quxiaodingdan",NowUrl] success:^(NSDictionary *fanhuicanshu) {
                } Error:^(NSString *cuowuxingxi) {
                    NSLog(@"%@",cuowuxingxi);
                }];
                
                btnn.frame=CGRectMake(ScreenWidth/2-Height(305)/2, Height(30), Height(305), Height(35));
                [QXcar1 removeFromSuperview];
                
            }else
            {
                
            }
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            
            dispatch_source_set_event_handler(_timer, ^{
                
                if (_shouldCancel==YES)
                {
                    dispatch_source_cancel(_timer);
                    
                    
                    
                }else
                {
                    if(timeout<=0){ //倒计时结束，关闭
                        dispatch_source_cancel(_timer);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //设置界面的按钮显示 根据自己需求设置
                            [btnn setTitle:@"支付订单超时" forState:UIControlStateNormal];
                            btnn.userInteractionEnabled =NO;
                            btnn.alpha=0.5;
                            NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",[arrayList objectForKey:@"dingdanhao"],@"orderid", nil];
                            [HttpManager postData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=quxiaodingdan",NowUrl] success:^(NSDictionary *fanhuicanshu) {
                                NSLog(@"44%@",[fanhuicanshu objectForKey:@"msg"]);
                            } Error:^(NSString *cuowuxingxi) {
                                NSLog(@"%@",cuowuxingxi);
                            }];
                            
                        });
                    }else{
                        
                        
                        int seconds = timeout - 1;
                        NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //设置界面的按钮显示 根据自己需求设置
                            //NSLog(@"____%@",strTime);
                            [UIView beginAnimations:nil context:nil];
                            [UIView setAnimationDuration:1];
                            [self showTime:[strTime intValue ]];
                            [UIView commitAnimations];
                            
                        });
                        timeout--;
                    }
                    
                }
            });
            dispatch_resume(_timer);
            
            
            
        }if ([[arrayList objectForKey:@"status"]isEqualToString:@"3.5"]) {//扫描二维码(不可点)
            [btnn setTitle:@"等待车辆到达" forState:UIControlStateNormal];
            btnn.alpha = 0.4;
            btnn.enabled = NO;
            [cell.contentView addSubview:btnn];
        }if ([[arrayList objectForKey:@"status"]isEqualToString:@"4.5"]) {//扫描二维码(可点)
            [btnn setTitle:@"扫描二维码，结束行程" forState:UIControlStateNormal];
            btnn.alpha = 1;
            btnn.enabled = YES;
            [btnn addTarget:self action:@selector(erweima:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnn];
        } if ([[arrayList objectForKey:@"status"]isEqualToString:@"2"]) {//拒绝
            [btnn setTitle:@"拒绝" forState:UIControlStateNormal];
            btnn.alpha = 0.4;
            btnn.enabled = NO;
            [cell.contentView addSubview:btnn];
        }if ([[arrayList objectForKey:@"status"]isEqualToString:@"1"]) {//等待
            [btnn setTitle:@"等待车主接单" forState:UIControlStateNormal];
            btnn.alpha = 0.4;
            btnn.enabled = NO;
            [cell.contentView addSubview:btnn];
        }if ([[arrayList objectForKey:@"status"]isEqualToString:@"4"]) {//进行中,等待尾款
            if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"]) {
                if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"chajia"]] isEqualToString:@"<null>"]) {
                    
                }else
                {
                    if ([[arrayList objectForKey:@"chajia"] floatValue]>0) {
                        [btnn setTitle:@"请在用车之前补齐差价" forState:UIControlStateNormal];
                        [btnn addTarget:self action:@selector(BCJ_BCJ) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnn];
                    }else
                    {
                        [btnn setTitle:@"服务结束" forState:UIControlStateNormal];
                        [btnn addTarget:self action:@selector(JIESU_JIESU) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnn];
                    }
                }
                
                
                
            }else
            {
                UIButton * QXcar=[UIButton buttonWithType:UIButtonTypeCustom];
                QXcar.frame=CGRectMake(ScreenWidth*0.028,Height(35), (ScreenWidth/2-2*ScreenWidth*0.028), Height(40));
                [QXcar setTitle:@"支付尾款" forState:UIControlStateNormal];
                [QXcar addTarget:self action:@selector(cacel) forControlEvents:UIControlEventTouchUpInside];
                QXcar.backgroundColor=[UIColor colorWithRed:0 green:0.66 blue:0.933 alpha:1.00];
                QXcar.titleLabel.font=[UIFont systemFontOfSize:Height(14)];
                QXcar.layer.cornerRadius=Height(5);
                [cell.contentView addSubview:QXcar];
                
                UIButton *QXcar1=[UIButton buttonWithType:UIButtonTypeCustom];
                QXcar1.frame=CGRectMake(ScreenWidth*0.028+ScreenWidth/2, Height(35), (ScreenWidth/2-2*ScreenWidth*0.028), Height(40));
                [QXcar1 setTitle:@"取消订单" forState:UIControlStateNormal];
                [QXcar1 addTarget:self action:@selector(cacel1) forControlEvents:UIControlEventTouchUpInside];
                QXcar1.backgroundColor=[UIColor clearColor];
                QXcar1.layer.borderWidth=1;
                QXcar1.layer.borderColor=[UIColor colorWithRed:0 green:0.66 blue:0.933 alpha:1.00].CGColor;
                QXcar1.titleLabel.font=[UIFont systemFontOfSize:Height(14)];
                QXcar1.layer.cornerRadius=Height(5);
                UIColor *color =Color(0, 170, 238);
                [QXcar1 setTitleColor:color forState:UIControlStateNormal];
                [cell.contentView addSubview:QXcar1];
            }
            
            
        }if ([[arrayList objectForKey:@"status"]isEqualToString:@"5"]) {//完成
            [btnn setTitle:@"去评价" forState:UIControlStateNormal];
            [btnn addTarget:self action:@selector(qupingjia) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnn];
        }if ([[arrayList objectForKey:@"status"]isEqualToString:@"6"]) {//取消
            
            
        }
        
        
        
        cell.backgroundColor=[UIColor clearColor];
        
        
    }else
    {
        cell.backgroundColor=[UIColor whiteColor];
    }
    return cell;
    
}
-(void)erweima:(UIButton *)sender
{
    
    if(IOS7)
    {
        ERWEIMARootViewController *erweima=[[ERWEIMARootViewController alloc]init];
        [self presentViewController:erweima animated:YES completion:^{
            
        }];
    }else
    {
        [UIView animateWithDuration:2 animations:^{
            [self xiaojiadeTishiTitle:@"您系统版本过低,建议升级"];
        }];
        
    }
    
    
    
}
-(void)handleColorChange:(NSNotification*)sender{
    
    NSString *result = [sender object];
    
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:result,@"yanzm",self.orderid,@"orderid", nil];
    [HttpManager postData:dic andUrl:[NSString stringWithFormat:@"%@api.php?op=erweima",NowUrl] success:^(NSDictionary *fanhuicanshu) {
        if ([[fanhuicanshu objectForKey:@"error"] isEqualToString:@"0"]) {
            [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
            [self Downwork];
        }
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
}

-(void)cacelBtnClick
{
    XWAlterview *xwxw=[[XWAlterview alloc]initWithTitle:@"温馨提示" contentText:@"您已经考虑好，取消此订单了吗？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [xwxw show];
    xwxw.rightBlock=^{
        NSLog(@"你点击了右边");
    };
    xwxw.leftBlock=^{
        NSLog(@"你点击了左边");
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.removeFromSuperViewOnHide=YES;
        //            [HUD hide:YES afterDelay:50];
        HUD.labelText = @"正在加载数据...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            //取消车辆
            NSDictionary *PROST=[NSDictionary dictionaryWithObjectsAndKeys:
                                 [ZCUserData share].userId,@"userid",
                                 self.orderid,@"orderid", nil];
            [HttpManager postData:PROST andUrl:[NSString stringWithFormat:@"%@api.php?op=quxiaodingdan",NowUrl] success:^(NSDictionary *fanhuicanshu) {
                
                [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
                //                [self Downwork];
                
                [self.navigationController popViewControllerAnimated:YES];
                _shouldCancel = YES;
            } Error:^(NSString *cuowuxingxi) {
                
            }];
            sleep(1);
        }completionBlock:^{
            
        }];
        
    };
    
}
-(void)fanHuan
{
    
    [XWAlterview showmessage:nil subtitle:@"已经扣除5%的违约金，详情问题咨询闲车客服电话。" cancelbutton:@"确定"];
    
}
-(void)startTimebtn:(UIButton *)btn
{
}

- (void)showTime:(int)time
{
    int inputSeconds = (int)time;
    int hours =  inputSeconds / 3600;
    int minutes = ( inputSeconds - hours * 3600 ) / 60;
    int seconds = inputSeconds - hours * 3600 - minutes * 60;
    
    NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hours,minutes, seconds];
    
    //显示在文本视图中
    NSLog(@"==%@",strTime);
    [btnn setTitle:[NSString stringWithFormat:@"还有%@小时支付定金",strTime] forState:UIControlStateNormal];
    
}

-(void)zfdj
{
    NSString *qiann=[NSString stringWithFormat:@"%.2f",[[arrayList objectForKey:@"dingjin"] floatValue]];
    [[NSUserDefaults standardUserDefaults] setObject:qiann forKey:@"qianqianqian"];
    //支付宝支付
    [keyv addSubview:dangbanview1];
}
-(void)cacel
{
    NSString *qiann=[[NSString alloc]init];
    if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"])
    {
        qiann=[NSString stringWithFormat:@"%.2f",[[arrayList objectForKey:@"dsweikuan"] floatValue]];
    }else
    {
        qiann=[NSString stringWithFormat:@"%.2f",[[arrayList objectForKey:@"weikuan"] floatValue]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:qiann forKey:@"qianqianqian"];
    //支付宝支付尾款
    [keyv addSubview:dangbanview1];
    
}
-(void)cacel1
{
    
    //给他一次反悔的机会
    
    XWAlterview *xwxw=[[XWAlterview alloc]initWithTitle:@"温馨提示" contentText:@"订单取消后，您将扣除5%的手续费用，确定取消吗？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [xwxw show];
    xwxw.rightBlock=^{
        NSLog(@"你点击了右边");
    };
    xwxw.leftBlock=^{
        NSLog(@"你点击了左边");
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.removeFromSuperViewOnHide=YES;
        //            [HUD hide:YES afterDelay:50];
        HUD.labelText = @"正在加载数据...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            //取消车辆
            NSDictionary *PROST=[NSDictionary dictionaryWithObjectsAndKeys:
                                 [ZCUserData share].userId,@"userid",
                                 self.orderid,@"orderid", nil];
            [HttpManager postData:PROST andUrl:ZKQUXIAO success:^(NSDictionary *fanhuicanshu) {
                
                [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
                [self Downwork];
            } Error:^(NSString *cuowuxingxi) {
                
            }];
            sleep(1);
        }completionBlock:^{
            
        }];
        
    };
}
-(void)qupingjia
{
    //完成
    NSLog(@"进度到此结束");
    TijiaopingjiaViewController *give=[[TijiaopingjiaViewController alloc]init];
    give.dingdanhaoID=self.dingdanhao8;
    give.orderid=self.orderid;
    [self.navigationController pushViewController:give animated:YES];
}
//-(UITableViewCell *)jxytableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *addcell=@"addcell";
//    AddchezhuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:addcell];
//    
//    if (!cell) {
//        cell=[[[NSBundle mainBundle] loadNibNamed:@"AddchezhuTableViewCell" owner:self options:nil] firstObject];
//    }
//    //    线
//    UILabel *xian=[[UILabel alloc]initWithFrame:CGRectMake(Height(0), Height(100)-1, ScreenWidth,0.5)];
//    xian.backgroundColor=[UIColor lightGrayColor];
//    [cell.contentView addSubview:xian];
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.shenhe.hidden=YES;
//    cell.ShopCart.hidden=YES;
//    cell.Autojiedan.hidden=YES;
//    cell.biaoqian.hidden=YES;
//    cell.abc.hidden=YES;
//    cell.tuijian.hidden=YES;
//    UIColor *jiedancolor=Color(46, 51, 61)//红
//    UIColor *dianhuacolor=Color(18, 152, 233)//蓝
//    cell.Yjiedan.layer.borderWidth=0.5;
//    cell.Yjiedan.layer.masksToBounds=YES;
//    if ([cell.Yjiedan.text isEqual:@"已接单"]) {
//        cell.Yjiedan.layer.borderColor=dianhuacolor.CGColor;
//    } if ([cell.Yjiedan.text isEqual:@"拒绝"]) {
//        cell.Yjiedan.layer.borderColor=jiedancolor.CGColor;
//    }
//    cell.urlTitle.font=[UIFont systemFontOfSize:ScreenWidth*0.04375];
//    cell.paizhao.font=[UIFont systemFontOfSize:ScreenWidth*0.034375];
//    //    cell.qian.font=[UIFont systemFontOfSize:ScreenWidth*0.05];
//    //    cell.timeKm.font=[UIFont systemFontOfSize:ScreenWidth*0.0375];
//    [self label:cell.qian isBold:YES isFont:13];
//    [self label:cell.timeKm isBold:YES isFont:10];
//    cell.baifenbi.font=[UIFont systemFontOfSize:ScreenWidth*0.04375];
//    cell.fuwu.font=[UIFont systemFontOfSize:ScreenWidth*0.04375];
//    cell.tiqian.font=[UIFont systemFontOfSize:ScreenWidth*0.04375];
//    cell.wenzitiqian.font=[UIFont systemFontOfSize:ScreenWidth*0.034375];
//    cell.wenzijiedan.font=[UIFont systemFontOfSize:ScreenWidth*0.034375];
//    cell.wenzifuwu.font=[UIFont systemFontOfSize:ScreenWidth*0.034375];
//    cell.shenhe.font=[UIFont systemFontOfSize:Height(13)];
//    SXFirsttableViewModel *model=countarray[indexPath.row];
//    [cell confit:model];
//    cell.qian.text=[NSString stringWithFormat:@"¥ %@",[[qianqian objectAtIndex:indexPath.row] objectForKey:@"carmoney"]];
//    cell.timeKm.text=[NSString stringWithFormat:@"%@",[[qianqian objectAtIndex:indexPath.row] objectForKey:@"cargongli"]];
//    return cell;
//}


-(void)removiewiew{
    [keyv removeFromSuperview];
    [dangbanview1 removeFromSuperview];
}
//-(void)alipaybtn{
//    NSLog(@"你点击了支付宝支付");
//    [self HereIsPAY];
//}

-(void)weixinpay{
    //    NSLog(@"你点击了微信支付");
    //    if ([WXApi isWXAppInstalled]) {
    //        [keyv removeFromSuperview];
    //        [dangbanview1 removeFromSuperview];
    //        [XWAlterview showmessage:@"温馨提示" subtitle:@"您还没有微信，请选择其他支付方式" cancelbutton:@"确定"];
    //    }else
    //    {
    [self jumpToBizPay];
    //    }
    
    
}
-(void)quxiaobtn{
    NSLog(@"取消按钮");
    
    [keyv removeFromSuperview];
    [dangbanview1 removeFromSuperview];
}
#pragma mark   ==============微信点击订单支付==============
-(NSString *)jumpToBizPay {
    [keyv removeFromSuperview];
    [dangbanview1 removeFromSuperview];
    
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dictss = [req sendPay_demo];
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dictss objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dictss objectForKey:@"partnerid"];
                req.prepayId            = [dictss objectForKey:@"prepayid"];
                req.nonceStr            = [dictss objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dictss objectForKey:@"package"];
                req.sign                = [dictss objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dict objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }
}
-(void)getOrderPayResult:(NSNotification *)not
{
    NSLog(@"微信支付监听结果%@",not.object);
    if ([not.object isEqualToString:@"successs"]) {
        [self why];
        [XWAlterview showmessage:@"微信支付结果" subtitle:@"支付成功" cancelbutton:@"确定"];
    }if ([not.object isEqualToString:@"faill"]) {
        [XWAlterview showmessage:@"微信支付结果" subtitle:@"支付失败" cancelbutton:@"确定"];
    }
}

-(void)why
{
    NSString *arraylistlist=[[NSString alloc]init];
    arraylistlist=[[NSUserDefaults standardUserDefaults] valueForKey:@"arrayList"];
    NSLog(@"arrayList=%@", arraylistlist);
    
    if ([arraylistlist isEqualToString:@"3"]) {
        //支付定金
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.removeFromSuperViewOnHide=YES;
        //            [HUD hide:YES afterDelay:50];
        HUD.labelText = @"正在加载数据...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            NSDictionary *PROST=[NSDictionary dictionaryWithObjectsAndKeys:
                                 [ZCUserData share].userId,@"userid",
                                 self.orderid,@"orderid", nil];
            NSLog(@"PROST=%@",PROST);
            [HttpManager postData:PROST andUrl:ZKDINGJ success:^(NSDictionary *fanhuicanshu) {
                
                [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
                [self Downwork];
            } Error:^(NSString *cuowuxingxi) {
                
            }];
            sleep(1);
        }completionBlock:^{
            
        }];
        
    }
    if ([arraylistlist isEqualToString:@"4"]) {
        if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"]) {
            NSDictionary *DIC=[NSDictionary dictionaryWithObjectsAndKeys:
                               [NSString stringWithFormat:@"%.2f",[[arrayList objectForKey:@"chajia"] floatValue]],@"chajia",
                               self.orderid,@"orderid",nil];
            [HttpManager postData:DIC andUrl:BUCHAJIA success:^(NSDictionary *fanhuicanshu) {
                if ([[fanhuicanshu objectForKey:@"error"] isEqualToString:@"0"]) {
                    [self Downwork];
                    [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
                }
                
            } Error:^(NSString *cuowuxingxi) {
                
            }];
        }else
        {
            
            //支付尾款
            NSDictionary *PROST=[NSDictionary dictionaryWithObjectsAndKeys:
                                 [ZCUserData share].userId,@"userid",
                                 self.orderid,@"orderid", nil];
            [HttpManager postData:PROST andUrl:ZKWEIKUAN success:^(NSDictionary *fanhuicanshu) {
                
                [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
                [self Downwork];
            } Error:^(NSString *cuowuxingxi) {
                
            }];
            
        }
    }
    
}
#pragma mark   ==============支付宝点击订单支付==============
//
//选中商品调用支付宝极简支付
//

//-(void)HereIsPAY
//{
//    
//    [keyv removeFromSuperview];
//    [dangbanview1 removeFromSuperview];
//    
//    /*============================================================================*/
//    /*=======================需要填写商户app申请的===================================*/
//    /*============================================================================*/
//    NSString *partner = @"2088121536284884";
//    NSString *seller = @"zfhuang@huangsensh.com";
//    NSString *privateKey =@"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMqWVwiNI1u71b0bxh1OOz9IoYs7DkFBmWNBCA0AfagA/vIlDOrhSEaSHbi6l1ZWFDyVha5EiskHw8dw7egkneuomhL8nUiLzyXZ8Ut5RYRHGQWTtu2ks2ftDQ5pdWM+ZyjbHQCc0vDtzsmrS0yODbvBnMuTovc4k7hSuxVZaofXAgMBAAECgYAlcMOFARCX048c9BUZNWwdtf6lDLUFumnuvgYO4RhYBFcZyV8pyZjh8f8sNM/jVOVIjRm3q1M69ARqx6QwUxQcNQjWecwi3mAaH3RvFxALquamQHQ/k5WKkguWuOQphnn4CHj4eOgOjIEc5Ng7JTnDsCIJuTYjGWqUYBAQe4kPAQJBAPbw//uoMMZkYZDBicxNszfROfGFFW82nUSMn5HCdChm6SIkWm+bI8K7vV5oN9pwTlBmQuXpe+ymu/kU4mN/9WkCQQDSBNCqVDDpigmfHTAEPGireCFhYYbhgur2fYrRCyWlUG2pu2tLTfaq6ZeA26QkdllH1Ztg9hfhyYYZ+mTEAKs/AkEAq5IaaOEcslrAJvExKo+5u0hVN+c9Uz3g2uXRYFZ4mjGWPTCA3RYvLHeARP2oAM8Sum2ygUdN4MifxZmrCXK4MQJBAIrghj9r5uA32H7wJRVYAPsKOECV5kRvdwJCKC5tyZoUoj+v4JZuWqPQTc/27gbyf71hwhqPAWHcCiJZkpKNwq8CQBhH6YosBIYxMAA8ac4qS8q5h2ur4snSNPX/vXUqzlqnQ+tw71gKJ97Y4OVShrvxxXZX0iQbiIwugHrBs1wC3ck=";
//    /*============================================================================*/
//    /*============================================================================*/
//    /*============================================================================*/
//    if ([partner length] == 0 ||
//        [seller length] == 0 ||
//        [privateKey length] == 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少partner或者seller或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc]init];
//    order.tradeNO=[[NSString alloc]init];
//    order.partner = partner;
//    order.seller = seller;
//    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.productName = [NSString stringWithFormat:@"%@",self.dingdanhao8]; //商品标题
//    order.productDescription =@"闲车支付" ; //商品描述
//    
//    NSString *mon_mon=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"qianqianqian"]];
//    
//    order.amount = mon_mon; //商品价格
//    order.notifyURL =  @"http://zuche.ztu.wang/alipay.php"; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"alipayY";
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"6001"]) {
//                
//                [XWAlterview showmessage:@"支付宝支付结果" subtitle:@"支付失败" cancelbutton:@"确定"];
//            }else
//            {
//                
//                if ([[arrayList objectForKey:@"status"]isEqualToString:@"3"]) {
//                    //支付定金
//                    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//                    [self.view addSubview:HUD];
//                    HUD.delegate = self;
//                    HUD.removeFromSuperViewOnHide=YES;
//                    //            [HUD hide:YES afterDelay:50];
//                    HUD.labelText = @"正在加载数据...";
//                    [HUD showAnimated:YES whileExecutingBlock:^{
//                        NSDictionary *PROST=[NSDictionary dictionaryWithObjectsAndKeys:
//                                             [ZCUserData share].userId,@"userid",
//                                             self.orderid,@"orderid", nil];
//                        [HttpManager postData:PROST andUrl:ZKDINGJ success:^(NSDictionary *fanhuicanshu) {
//                            
//                            [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
//                            
//                            if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"]) {
//                                
//                                alertController = [UIAlertController alertControllerWithTitle:@"提示（*必填项）" message:@"订单支付成功\n请输入尾款" preferredStyle:UIAlertControllerStyleAlert];
//                                __weak __typeof(self)weakSelf = self;
//                                alertController.view.userInteractionEnabled=NO;
//                                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//                                    // 可以在这里对textfield进行定制，例如改变背景色
//                                    textField.keyboardType=UIKeyboardTypeNumberPad;
//                                    
//                                    [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(handleTextFieldTextDidChangeNotification1:) name:UITextFieldTextDidChangeNotification object:textField];
//                                }];
//                                
//                                
//                                
//                                
//                                
//                                
//                                NSLog(@"textFieldzzz1.text.length=%ld",textFieldzzz1.text.length);
//                                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                                    NSLog(@"textField=%@",textFieldzzz1.text);
//                                    if ([textFieldzzz1.text isEqual:@""]) {
//                                        [self Downwork];
//                                    }else
//                                    {
//                                        NSDictionary *PROST3=[NSDictionary dictionaryWithObjectsAndKeys:
//                                                              textFieldzzz1.text,@"weikuan",
//                                                              self.orderid,@"orderid", nil];
//                                        
//                                        _shouldCancel=YES;
//                                        [HttpManager postData:PROST3 andUrl:SHANGJIA_TIJIAO_WEIKUAN success:^(NSDictionary *fanhuicanshu) {
//                                            
//                                            [self Downwork];
//                                            
//                                        } Error:^(NSString *cuowuxingxi) {
//                                            
//                                        }];
//                                        
//                                    }
//                                    
//                                    
//                                }];
//                                
//                                [alertController addAction:otherAction];
//                                
//                                
//                                
//                                [self presentViewController:alertController animated:YES completion:nil];
//                                
//                            }else
//                            {
//                                [self Downwork];
//                                
//                                [XWAlterview showmessage:@"支付宝支付结果" subtitle:@"支付成功" cancelbutton:@"确定"];
//                            }
//                            
//                        } Error:^(NSString *cuowuxingxi) {
//                            
//                        }];
//                        
//                    }completionBlock:^{
//                        
//                    }];
//                    
//                }if ([[arrayList objectForKey:@"status"]isEqualToString:@"4"]) {
//                    if ([[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"dengji"]] isEqualToString:@"1"]) {
//                        NSDictionary *DIC=[NSDictionary dictionaryWithObjectsAndKeys:
//                                           [NSString stringWithFormat:@"%.2f",[[arrayList objectForKey:@"chajia"] floatValue]],@"chajia",
//                                           self.orderid,@"orderid",nil];
//                        [HttpManager postData:DIC andUrl:BUCHAJIA success:^(NSDictionary *fanhuicanshu) {
//                            if ([[fanhuicanshu objectForKey:@"error"] isEqualToString:@"0"]) {
//                                [self Downwork];
//                                [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
//                            }
//                            
//                        } Error:^(NSString *cuowuxingxi) {
//                            
//                        }];
//                    }else
//                    {
//                        HUD = [[MBProgressHUD alloc] initWithView:self.view];
//                        [self.view addSubview:HUD];
//                        HUD.delegate = self;
//                        HUD.removeFromSuperViewOnHide=YES;
//                        //            [HUD hide:YES afterDelay:50];
//                        HUD.labelText = @"正在加载数据...";
//                        [HUD showAnimated:YES whileExecutingBlock:^{
//                            //支付尾款
//                            NSDictionary *PROST=[NSDictionary dictionaryWithObjectsAndKeys:
//                                                 [ZCUserData share].userId,@"userid",
//                                                 self.orderid,@"orderid", nil];
//                            [HttpManager postData:PROST andUrl:ZKWEIKUAN success:^(NSDictionary *fanhuicanshu) {
//                                
//                                [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
//                                [self Downwork];
//                                
//                                [XWAlterview showmessage:@"支付宝支付结果" subtitle:@"支付成功" cancelbutton:@"确定"];
//                            } Error:^(NSString *cuowuxingxi) {
//                                
//                            }];        sleep(1);
//                        }completionBlock:^{
//                            
//                        }];
//                        
//                    }
//                    
//                }
//            }
//        }];
//    }
//}
-(void)sousuobtn:(UIButton *)sender
{
    //刚点击时按钮
    //    rightbutton.alpha=0.5;
    //    rightbutton.userInteractionEnabled=NO;
    //
    MapViewController *vc =[[MapViewController alloc]init];
    vc.orderid =self.orderid;
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"你点击了地图按钮");
}
-(void)beee:(UIButton *)sender
{
    MAPPViewController *mapp=[[MAPPViewController alloc]init];
    NSString *diyige1=[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"jihe"]];
    if ([diyige1 isEqualToString:@"(null)"]) {
        diyige1=@"";
    }
    mapp.addrr=diyige1;
    mapp.models=diyige1;
    [self.navigationController pushViewController:mapp animated:YES];
}
#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //设置地图中心为用户经纬度
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;
    [_locService stopUserLocationService];
    
}

#pragma mark BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate=[_mapView convertPoint:_mapView.center toCoordinateFromView:_mapView];
    
    if (_geoCodeSearch==nil) {
        //初始化地理编码类
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
        
    }
    if (_reverseGeoCodeOption==nil) {
        
        //初始化反地理编码类
        _reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    }
    
    //需要逆地理编码的坐标位置
    _reverseGeoCodeOption.reverseGeoPoint =  CLLocationCoordinate2DMake(MapCoordinate.latitude,MapCoordinate.longitude);
    [_geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];
    
}

#pragma mark BMKGeoCodeSearchDelegate

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //获取周边用户信息
    if (error==BMK_SEARCH_NO_ERROR) {
        
        for(BMKPoiInfo *poiInfo in result.poiList)
        {
            
            
        }
    }else{
        
        NSLog(@"BMKSearchErrorCode: %u",error);
    }
    
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        //        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude =item.coordinate.latitude ;
        coor.longitude = item.coordinate.longitude;
        
        annotation.coordinate = coor;
        //        annotation.title = [array3 objectAtIndex:i];
        [_mapView addAnnotation:annotation];
        
    }
}
- (void)handleTextFieldTextDidChangeNotification1:(NSNotification *)notification {
    textFieldzzz1 = notification.object;
    if (textFieldzzz1.text.length==0) {
        alertController.view.userInteractionEnabled=YES;
    }else
    {
        alertController.view.userInteractionEnabled=YES;
    }
}
-(void)BCJ_BCJ
{
    NSString *qiann=[NSString stringWithFormat:@"%@",[arrayList objectForKey:@"chajia"]];
    [[NSUserDefaults standardUserDefaults] setObject:qiann forKey:@"qianqianqian"];
    //支付宝支付
    [keyv addSubview:dangbanview1];
    
    
}
-(void)JIESU_JIESU
{
    NSLog(@"你点击了服务结束");
    NSDictionary *DIC=[NSDictionary dictionaryWithObjectsAndKeys:
                       [ZCUserData share].userId,@"userid",
                       self.orderid,@"orderid",nil];
    [HttpManager postData:DIC andUrl:FUWUJIESHU success:^(NSDictionary *fanhuicanshu) {
        if ([[fanhuicanshu objectForKey:@"error"] isEqualToString:@"0"]) {
            [self Downwork];
            [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
        }
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
}
@end
