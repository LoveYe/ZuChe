//
//  DingdanViewC.m
//  ZuChe
//
//  Created by apple  on 2017/4/21.
//  Copyright © 2017年 佐途. All rights reserved.
//

#define TiJiaoURL @"http://wx.leisurecarlease.com/api.php?op=api_tjdd"

#import "DingdanViewC.h"
#import "Header.h"
#import "PayView.h"
#import "ZCUserData.h"

#import "MarriedCar.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"

#import "MainCarColorView.h"
#import "GenCarColorView.h"
#import "TimeSelectView.h"
#import "TimesSelected2.h"
//#import "AddressView.h"
#import "DituViewController.h"
#import "CCDatePickerView.h"

#import "HttpManager.h"

#import "YouhuiCell.h"
#import "BKYYouhuiCell.h"
#import "MarriedCar.h"
#import "GiFHUD.h"

@interface DingdanViewC ()<addressDelgate,LXKColorChoiceDelegate,LXKColorChoiceDelegate2,LXKColorChoiceDelegate3,LXKColorChoiceDelegate4,UITableViewDataSource,UITableViewDelegate>{
    
    CGFloat height;
    CGFloat width;
    
    UILabel *zong;
    UILabel *ding;
    UILabel *yu;
    int price;
    int price2;
    int price3;
    
    UILabel *tou1;
    UILabel *tou2;
    UIButton *xuanze;
    UILabel *address;
    UILabel *address1;
    
    UITextField *name;
    UITextField *phoneNUM;
    
    NSString *time;
    UITableView *_tableView;
    
    UILabel *zhuche1;
    UILabel *zhuche2;
    
    UILabel *chaoshi;
    UILabel *chaoshi2;
    
    int aCount;
    int bCount;
    UISwitch *kaiguan;
    UILabel *kong;
    
    int cCount;
    int dCount;
    int cCount2;
    int dCount2;
    
    NSString *xuanzeTIME;
    
    NSString *cartype1;
    NSString *carColor1;
    NSString *chaoshi1;
    NSString *chaoshi3;
    NSString *carType2;
    NSString *carColor2;
    
    NSString *touche1;
    NSString *genche1;
    
    UILabel *zhucheYanse;
    UILabel *gencheYanse;
    UILabel *zhucheFanwei;
    UILabel *gencheFanwei;
    
    UILabel *youhuiLabel;
    UILabel *jianqu;
    int youhuiP;
    int yesOrNO;
    NSDictionary *orderID;
    
    NSMutableArray *_youhuiArray;
    NSString *youhuiNumber;
    UILabel *youhuiPrice;
//    UITableView *_tableViewA;
    
    NSString *baoxianName;
    NSString *baoxianPhone;
    NSString *baoxianAddress;
    NSString *baoxianYouBian;
    
    UITextField *hetongText1;
    UITextField *hetongText2;
    UITextField *hetongText3;
    UITextField *hetongText4;
    
    UIView *baoxianView;
    UIButton *yunxu;
    
    NSString *zhucheChaoshi;
    NSString *gencheChaoshi;
    NSString *zongjiChaoshi;
    
    NSString *zhucheKongshi;
    NSString *gencheKongshi;
    NSString *zongjiKognshi;
    
    NSString *ksFanwei;
    
    NSString *bid;
}

@property (nonatomic , strong)MainCarColorView *view1;
@property (nonatomic , strong)GenCarColorView *view2;
@property (nonatomic , strong)TimeSelectView *view3;
@property (nonatomic , strong)TimesSelected2 *view4;

@property (nonatomic , strong)NSArray *carColor;
@property (nonatomic,retain) NSArray *timesArray;
@property (nonatomic ,retain)NSArray *kmsArray;

@end

@implementation DingdanViewC

- (NSArray *)colorArray{
    
    if (!_carColor) {
        
        _carColor = @[@"黑色",@"白色"];
    }
    return _carColor;
}
- (NSArray *)timeArray{
    
    if (!_timesArray) {
        
        _timesArray = @[@"5",@"6",@"7",@"8",@"9",@"10"];
    }
    return _timesArray;
}
- (NSArray *)kmArray{
    
    if (!_kmsArray) {
        
        _kmsArray = @[@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",@"105",@"110",@"115",@"120",@"125",@"130",@"135",@"140",@"145",@"150",@"155",@"160",@"165",@"170",@"175",@"180",@"185",@"190",@"195",@"200",@"205",@"210",@"215",@"220",@"225",@"230",@"235",@"240",@"245",@"250",@"255",@"260",@"265",@"270",@"275",@"280",@"285",@"290",@"295",@"300"];
    }
    return _kmsArray;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    _youhuiArray = [NSMutableArray array];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",@"婚车",@"type", nil];
    [HttpManager postData:dic andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_coupon" success:^(NSDictionary *fanhuicanshu) {
        
        NSLog(@"-------%@",fanhuicanshu);
        
        _youhuiArray = fanhuicanshu[@"coupon"];
        youhuiLabel.text = [NSString stringWithFormat:@"%ld张",(unsigned long)_youhuiArray.count];
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    _youhuiArray = [NSMutableArray array];
    
    [GiFHUD dismiss];
    
    UIView *view2 = (UIView *)[self.view.window viewWithTag:718];
    [view2 removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    cCount = 0;
    dCount = 0;
    cCount2 = 0;
    dCount2 = 0;
    price2 = 0;
    price3 = 0;
    youhuiP = 0;
    yesOrNO = 0;
    zhucheChaoshi = [NSString string];
    zhucheKongshi = [NSString string];
    gencheChaoshi = [NSString string];
    gencheKongshi = [NSString string];
    zongjiChaoshi = [NSString string];
    zongjiKognshi = [NSString string];
    
    bid = [NSString string];
    
    ksFanwei = [NSString string];
    orderID = [NSDictionary dictionary];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];;
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    self.title = @"婚车订单";
    UIColor *gColor = Color(107, 107, 107);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19], NSForegroundColorAttributeName:gColor}];
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width*4, 64)];
//    title.text = @"婚车订单";
//    title.textAlignment = NSTextAlignmentCenter;
//    title.textColor = Color(87, 87, 87);
//    title.font = [UIFont fontWithName:@"Arial-boldMT" size:20];
//    self.navigationItem.titleView = title;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    [self createView];
}
- (void)fanhui{
    
    MarriedCar *view = [[MarriedCar alloc] init];
    
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)createView{
    
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.alwaysBounceVertical = YES;
    view.backgroundColor = Color(237, 237, 237);
    [self.view addSubview:view];
    
    view.contentSize = CGSizeMake(0, width*4.9);
    // 选择日期
    UILabel *riqi = [[UILabel alloc] initWithFrame:CGRectMake(width/2- width*0.2, width*0.04, width*0.4, width*0.08)];
    riqi.text = @"选择日期";
    riqi.textColor = Color(107, 107, 107);
    riqi.font = [UIFont fontWithName:@"ArialMT" size:18];
    riqi.textAlignment = NSTextAlignmentCenter;
    [view addSubview:riqi];
    
    xuanze = [UIButton buttonWithType:UIButtonTypeCustom];
    xuanze.frame = CGRectMake(width/2-width*0.45, CGRectGetMaxY(riqi.frame)+width*0.04, width*0.9, width*0.13);
    [xuanze setBackgroundColor:[UIColor whiteColor]];
    [xuanze setTitle:@"请设置日期" forState:UIControlStateNormal];
    UIColor *zitiColor = Color(127, 127, 127);
    xuanze.layer.cornerRadius = 2.5;
    xuanze.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [xuanze setTitleColor:zitiColor forState:UIControlStateNormal];
    [xuanze addTarget:self action:@selector(xuanzeTime) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:xuanze];
    // 详细信息
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.2, CGRectGetMaxY(xuanze.frame)+width*0.04, width*0.4, width*0.08)];
    detail.text = @"详细信息";
    detail.textColor = Color(107, 107, 107);
    detail.font = [UIFont fontWithName:@"ArialMT" size:18];
    detail.textAlignment = NSTextAlignmentCenter;
    [view addSubview:detail];
    
    UIView *xinxi = [[UIView alloc] initWithFrame:CGRectMake(width/2- width*0.45, CGRectGetMaxY(detail.frame)+width*0.04, width*0.9, width*0.54)];
    xinxi.backgroundColor = [UIColor whiteColor];
    xinxi.layer.cornerRadius = 2.5;
    [view addSubview:xinxi];
    
    UILabel *lianxi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, width*0.025, width*0.3, width*0.08)];
    lianxi.text = @"联系人";
    lianxi.textAlignment = NSTextAlignmentLeft;
    lianxi.textColor = Color(157, 157, 157);
    lianxi.font = [UIFont fontWithName:@"ArialMT" size:17];
    [xinxi addSubview:lianxi];
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(width*0.27, width*0.03, width*0.6, width*0.08)];
    name.placeholder = @"姓名";
//    name.backgroundColor = [UIColor redColor];
    [name setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    name.font = [UIFont fontWithName:@"ArialMT" size:17];
    name.textColor = Color(77, 77, 77);
    name.textAlignment = NSTextAlignmentRight;
    [xinxi addSubview:name];
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(name.frame)+width*0.025, width*0.865, 0.5)];
    xian1.backgroundColor = Color(217, 217, 217);
    [xinxi addSubview:xian1];
    
    UILabel *typeC = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(lianxi.frame)+width*0.055, width*0.3, width*0.08)];
    typeC.text = @"联系方式";
    typeC.font = [UIFont fontWithName:@"ArialMT" size:17];
    typeC.textAlignment = NSTextAlignmentLeft;
    typeC.textColor = Color(157, 157, 157);
    [xinxi addSubview:typeC];
    
    phoneNUM = [[UITextField alloc] initWithFrame:CGRectMake(width*0.27, CGRectGetMaxY(name.frame)+width*0.055, width*0.6, width*0.08)];
    phoneNUM.placeholder = @"手机号";
    phoneNUM.textColor = Color(77, 77, 77);
    phoneNUM.keyboardType = UIKeyboardTypeNumberPad;
    [phoneNUM setValue:[UIFont fontWithName:@"ArialMT" size:17] forKeyPath:@"_placeholderLabel.font"];
    phoneNUM.textAlignment = NSTextAlignmentRight;
    [xinxi addSubview:phoneNUM];
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(phoneNUM.frame)+width*0.025, width*0.865, 0.5)];
    xian2.backgroundColor = Color(217, 217, 217);
    [xinxi addSubview:xian2];
    
    UILabel *dizhi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(typeC.frame)+width*0.055, width*0.3, width*0.08)];
    dizhi.textAlignment = NSTextAlignmentLeft;
    dizhi.text = @"集合地址";
    
    dizhi.font = [UIFont fontWithName:@"ArialMT" size:17];
    dizhi.textColor = Color(157, 157, 157);
    [xinxi addSubview:dizhi];
    
    NSLog(@"%f",width*0.6);
    
//    CGRectGetMaxX(xinxi.frame)-xinxi.frame.size.width*0.65
    address = [[UILabel alloc] initWithFrame:CGRectMake( width*0.27, CGRectGetMaxY(phoneNUM.frame)+width*0.055, width*0.6, width*0.08)];
//    address.backgroundColor = [UIColor redColor];
    address.text = @"预设集合点，可修改一次";
//    [address sizeToFit];
//    address.adjustsFontSizeToFitWidth = YES;
    address.tag = 12000;
//    [address layoutIfNeeded];
    address.font = [UIFont fontWithName:@"ArialMT" size:17];
    address.textColor = Color(187, 187, 187);
    address.textAlignment = NSTextAlignmentRight;
    address.userInteractionEnabled = YES;
    [xinxi addSubview:address];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dizhi:)];
    [address addGestureRecognizer:tapGesture];
    
    UILabel *xian3 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(address.frame)+width*0.025, width*0.865, 0.5)];
    xian3.backgroundColor = Color(217, 217, 217);
    [xinxi addSubview:xian3];
    
    UILabel *kongshi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(dizhi.frame)+width*0.055, width*0.2, width*0.08)];
    kongshi.text = @"空驶费";
    kongshi.font = [UIFont fontWithName:@"ArialMT" size:17];
    kongshi.textAlignment = NSTextAlignmentLeft;
    kongshi.textColor = Color(157, 157, 157);
    [xinxi addSubview:kongshi];
    
    UIButton *wenhao = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao.frame = CGRectMake(CGRectGetMaxX(kongshi.frame)-width*0.04, CGRectGetMaxY(dizhi.frame)+width*0.057, width*0.077, width*0.077);
    [wenhao setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao addTarget:self action:@selector(wenhao1) forControlEvents:UIControlEventTouchUpInside];
    [xinxi addSubview:wenhao];
    
//    kaiguan = [[UISwitch alloc] initWithFrame:CGRectMake(width*0.71, CGRectGetMaxY(dizhi.frame)+width*0.02, 0, 0)];
//    [kaiguan setOn:NO];
//    [xinxi addSubview:kaiguan];
    
    kong = [[UILabel alloc] initWithFrame:CGRectMake(width*0.27, CGRectGetMaxY(dizhi.frame)+width*0.055, width*0.6, width*0.08)];
//    kong.textColor
    kong.text = @"将根据地理位置自动设置";
//    kong.adjustsFontSizeToFitWidth = YES;
//    [kong sizeToFit];
    kong.textColor = Color(187, 187, 187);
    kong.textAlignment = NSTextAlignmentRight;
    kong.font = [UIFont fontWithName:@"ArialMT" size:17];
    [xinxi addSubview:kong];
    
    // 地图
    // 车辆信息
    UILabel *carInfo = [[UILabel alloc] initWithFrame:CGRectMake(width/2- width*0.2, CGRectGetMaxY(xinxi.frame)+width*0.04, width*0.4, width*0.08)];
    carInfo.text = @"车辆信息";
    carInfo.font = [UIFont fontWithName:@"ArialMT" size:18];
    carInfo.textAlignment = NSTextAlignmentCenter;
    carInfo.textColor = Color(107, 107, 107);
    [view addSubview:carInfo];
    
    UIView *carInfoMation = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(carInfo.frame)+width*0.04, width*0.9, width*1.04)];
    carInfoMation.backgroundColor = [UIColor whiteColor];
    [view addSubview:carInfoMation];
    carInfoMation.userInteractionEnabled = YES;
    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(carInfo.frame)+width*0.04, width*0.9, width*1.12)];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor whiteColor];
//    _tableView.tableFooterView.frame =CGRectZero;
//    [view addSubview:_tableView];
    
    UILabel *zhuche = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, width*0.025, width*0.25, width*0.08)];
    zhuche.text = @"婚礼主车";
    zhuche.textColor = Color(157, 157, 157);
    zhuche.textAlignment = NSTextAlignmentLeft;
    zhuche.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:zhuche];
    
    UILabel *zhucheCheXing = [[UILabel alloc] initWithFrame:CGRectMake(width*0.265, width*0.025, width*0.6, width*0.08)];
    zhucheCheXing.textAlignment = NSTextAlignmentRight;
    zhucheCheXing.textColor = Color(77, 77, 77);
    zhucheCheXing.text = self.zhucartype;
    cartype1 = zhucheCheXing.text;
    zhucheCheXing.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:zhucheCheXing];
    
    UILabel *xian101 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(zhuche.frame)+width*0.025, width*0.865, 0.5)];
    xian101.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian101];
    
    UILabel *Yanse = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian101.frame)+width*0.025, width*0.2, width*0.08)];
    Yanse.text = @"颜色";
    Yanse.textColor = Color(157, 157, 157);
    Yanse.textAlignment = NSTextAlignmentLeft;
    Yanse.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:Yanse];
    
    zhucheYanse = [[UILabel alloc] initWithFrame:CGRectMake(width*0.265, CGRectGetMaxY(xian101.frame)+width*0.025, width*0.56, width*0.08)];
    zhucheYanse.textAlignment = NSTextAlignmentRight;
    zhucheYanse.textColor = Color(77, 77, 77);
    zhucheYanse.text = self.zhucarColor;
    carColor1 = zhucheYanse.text;
    zhucheYanse.userInteractionEnabled = YES;
    zhucheYanse.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:zhucheYanse];
    UITapGestureRecognizer *regis4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yanseClick)];
    [zhucheYanse addGestureRecognizer:regis4];
    
    UIButton *youJinatou4 = [UIButton buttonWithType:UIButtonTypeCustom];
    youJinatou4.frame = CGRectMake(width*0.835, CGRectGetMaxY(xian101.frame)+width*0.045, width*0.04, width*0.04);
    [youJinatou4 setBackgroundImage:[UIImage imageNamed:@"右居中.png"] forState:UIControlStateNormal];
    [carInfoMation addSubview:youJinatou4];
    
    UILabel *xian102 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(Yanse.frame)+width*0.025, width*0.865, 0.5)];
    xian102.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian102];
    
    UILabel *Fanwei = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian102.frame)+width*0.025, width*0.2, width*0.08)];
    Fanwei.text = @"使用范围";
    Fanwei.textColor = Color(157, 157, 157);
    Fanwei.adjustsFontSizeToFitWidth = YES;
    Fanwei.textAlignment = NSTextAlignmentLeft;
    Fanwei.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:Fanwei];
    
    zhucheFanwei = [[UILabel alloc] initWithFrame:CGRectMake(width*0.265, CGRectGetMaxY(xian102.frame)+width*0.025, width*0.56, width*0.08)];
    zhucheFanwei.textAlignment = NSTextAlignmentRight;
    zhucheFanwei.textColor = Color(77, 77, 77);
    zhucheFanwei.text = @"5小时/50公里";
    chaoshi1 = zhucheFanwei.text;
    zhucheFanwei.userInteractionEnabled = YES;
    zhucheFanwei.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:zhucheFanwei];
    
    UIButton *wenhao2 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao2.frame = CGRectMake(CGRectGetMaxX(Fanwei.frame), CGRectGetMaxY(xian102.frame)+width*0.027, width*0.077, width*0.077);
    [wenhao2 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao2 addTarget:self action:@selector(wenhao2) forControlEvents:UIControlEventTouchUpInside];
    [carInfoMation addSubview:wenhao2];
    
    UIButton *youJinatou3 = [UIButton buttonWithType:UIButtonTypeCustom];
    youJinatou3.frame = CGRectMake(width*0.835, CGRectGetMaxY(xian102.frame)+width*0.045, width*0.04, width*0.04);
    [youJinatou3 setBackgroundImage:[UIImage imageNamed:@"右居中.png"] forState:UIControlStateNormal];
    [carInfoMation addSubview:youJinatou3];
    
    UILabel *xian103 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(Fanwei.frame)+width*0.025, width*0.865, 0.5)];
    xian103.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian103];
    
    UITapGestureRecognizer *regsi3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fanweiClick)];
    [zhucheFanwei addGestureRecognizer:regsi3];
    
    UILabel *Chaochu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian103.frame)+width*0.025, width*0.1, width*0.08)];
    Chaochu.text = @"超出";
    Chaochu.textColor = Color(157, 157, 157);
    Chaochu.textAlignment = NSTextAlignmentLeft;
    Chaochu.adjustsFontSizeToFitWidth = YES;
    Chaochu.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:Chaochu];
    
    UIButton *wenhao3 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao3.frame = CGRectMake(CGRectGetMaxX(Chaochu.frame), CGRectGetMaxY(xian103.frame)+width*0.027, width*0.077, width*0.077);
    wenhao3.tag = 10045;
    [wenhao3 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao3 addTarget:self action:@selector(wenhao3:) forControlEvents:UIControlEventTouchUpInside];
    [carInfoMation addSubview:wenhao3];
    
    UILabel *zhucheChaochu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.565, CGRectGetMaxY(xian103.frame)+width*0.025, width*0.3, width*0.08)];
    zhucheChaochu.textAlignment = NSTextAlignmentRight;
    zhucheChaochu.textColor = Color(77, 77, 77);
    zhucheChaochu.text = [NSString stringWithFormat:@"%@/%@",self.zhuchePrice1,self.zhuchePrice2];
//    chaoshi1 = zhucheChaochu.text;
    zhucheChaochu.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:zhucheChaochu];
    
    UILabel *xian104 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(Chaochu.frame)+width*0.025, width*0.865, 0.5)];
    xian104.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian104];
    
    UILabel *genche11 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian104.frame)+width*0.025, width*0.25, width*0.08)];
    genche11.text = @"婚礼跟车";
    genche11.textColor = Color(157, 157, 157);
    genche11.textAlignment = NSTextAlignmentLeft;
    genche11.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:genche11];
    
    UILabel *gencheLeixing = [[UILabel alloc] initWithFrame:CGRectMake(width*0.265, CGRectGetMaxY(xian104.frame)+width*0.025, width*0.6, width*0.08)];
    gencheLeixing.textAlignment = NSTextAlignmentRight;
    gencheLeixing.textColor = Color(77, 77, 77);
    gencheLeixing.text = self.genCartype;
    carType2 = gencheLeixing.text;
    gencheLeixing.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:gencheLeixing];
    
    UILabel *xian105 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(genche11.frame)+width*0.025, width*0.865, 0.5)];
    xian105.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian105];
    
    UILabel *Yanse2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian105.frame)+width*0.025, width*0.2, width*0.08)];
    Yanse2.text = @"颜色";
    Yanse2.textColor = Color(157, 157, 157);
    Yanse2.textAlignment = NSTextAlignmentLeft;
    Yanse2.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:Yanse2];
    
    gencheYanse = [[UILabel alloc] initWithFrame:CGRectMake(width*0.265, CGRectGetMaxY(xian105.frame)+width*0.025, width*0.56, width*0.08)];
//    gencheYanse.backgroundColor = [UIColor redColor];
    gencheYanse.textAlignment = NSTextAlignmentRight;
    gencheYanse.textColor = Color(77, 77, 77);
    gencheYanse.text = self.genCarcolor;
    carColor2 = gencheYanse.text;
    gencheYanse.userInteractionEnabled = YES;
    gencheYanse.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:gencheYanse];
    UITapGestureRecognizer *regis2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yanseClick1)];
    [gencheYanse addGestureRecognizer:regis2];
    
    UIButton *youJinatou = [UIButton buttonWithType:UIButtonTypeCustom];
    youJinatou.frame = CGRectMake(width*0.835, CGRectGetMaxY(xian105.frame)+width*0.045, width*0.04, width*0.04);
    [youJinatou setBackgroundImage:[UIImage imageNamed:@"右居中.png"] forState:UIControlStateNormal];
    [carInfoMation addSubview:youJinatou];
    
    UILabel *xian106 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(Yanse2.frame)+width*0.025, width*0.865, 0.5)];
    xian106.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian106];
    
    UILabel *Fanwei2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian106.frame)+width*0.025, width*0.2, width*0.08)];
    Fanwei2.text = @"使用范围";
//    Fanwei2.backgroundColor = [UIColor redColor];
    Fanwei2.adjustsFontSizeToFitWidth = YES;
    Fanwei2.textColor = Color(157, 157, 157);
    Fanwei2.textAlignment = NSTextAlignmentLeft;
    Fanwei2.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:Fanwei2];
    
    gencheFanwei = [[UILabel alloc] initWithFrame:CGRectMake(width*0.265, CGRectGetMaxY(xian106.frame)+width*0.025, width*0.56, width*0.08)];
//    gencheFanwei.backgroundColor = [UIColor redColor];
    gencheFanwei.textAlignment = NSTextAlignmentRight;
    gencheFanwei.textColor = Color(77, 77, 77);
    gencheFanwei.text = @"5小时/50公里";
    chaoshi3 = gencheFanwei.text;
    gencheFanwei.userInteractionEnabled = YES;
    gencheFanwei.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:gencheFanwei];
    
    UIButton *wenhao4 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao4.frame = CGRectMake(CGRectGetMaxX(Fanwei2.frame), CGRectGetMaxY(xian106.frame)+width*0.027, width*0.077, width*0.077);
//    wenhao4.backgroundColor = [UIColor greenColor];
    [wenhao4 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao4 addTarget:self action:@selector(wenhao2) forControlEvents:UIControlEventTouchUpInside];
//    wenhao4.backgroundColor = [UIColor blackColor];
    [carInfoMation addSubview:wenhao4];
    
    UIButton *youJIantou2 = [UIButton buttonWithType:UIButtonTypeCustom];
    youJIantou2.frame = CGRectMake(width*0.835, CGRectGetMaxY(xian106.frame)+width*0.045, width*0.04, width*0.04);
    [youJIantou2 setBackgroundImage:[UIImage imageNamed:@"右居中.png"] forState:UIControlStateNormal];
    [carInfoMation addSubview:youJIantou2];
    
    UITapGestureRecognizer *regis1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gongliClick1)];
    [gencheFanwei addGestureRecognizer:regis1];
    
    UILabel *xian107 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(Fanwei2.frame)+width*0.025, width*0.865, 0.5)];
    xian107.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian107];
    
    UILabel *Chaochu2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian107.frame)+width*0.025, width*0.1, width*0.08)];
    Chaochu2.text = @"超出";
//    Chaochu2.backgroundColor = [UIColor redColor];
    Chaochu2.textColor = Color(157, 157, 157);
    Chaochu2.textAlignment = NSTextAlignmentLeft;
    Chaochu2.adjustsFontSizeToFitWidth = YES;
    Chaochu2.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:Chaochu2];
    
    UIButton *wenhao5 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao5.frame = CGRectMake(CGRectGetMaxX(Chaochu2.frame), CGRectGetMaxY(xian107.frame)+width*0.027, width*0.077, width*0.077);
    wenhao5.tag = 10046;
//    wenhao5.backgroundColor = [UIColor greenColor];
    [wenhao5 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao5 addTarget:self action:@selector(wenhao3:) forControlEvents:UIControlEventTouchUpInside];
    [carInfoMation addSubview:wenhao5];
    
    UILabel *gencheChaochu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.565, CGRectGetMaxY(xian107.frame)+width*0.025, width*0.3, width*0.08)];
    gencheChaochu.textAlignment = NSTextAlignmentRight;
    gencheChaochu.textColor = Color(77, 77, 77);
    gencheChaochu.text = [NSString stringWithFormat:@"%@/%@",self.genchePrice1,self.genchePrice2];
    gencheChaochu.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:gencheChaochu];
    
    //车辆数量
    UILabel *touche = [[UILabel alloc] initWithFrame:CGRectMake(width/4-width*0.2, CGRectGetMaxY(carInfoMation.frame)+width*0.04, width*0.4, width*0.08)];
    touche.text = @"头车数量";
    touche.textAlignment = NSTextAlignmentCenter;
    touche.font = [UIFont fontWithName:@"ArialMT" size:18];
    touche.textColor = Color(108, 108, 108);
    [view addSubview:touche];
    
    UILabel *genche = [[UILabel alloc] initWithFrame:CGRectMake(width/4*3-width*0.2, CGRectGetMaxY(carInfoMation.frame)+width*0.04, width*0.4, width*0.08)];
    genche.text = @"跟车数量";
    genche.font = [UIFont fontWithName:@"ArialMT" size:18];
    genche.textAlignment = NSTextAlignmentCenter;
    genche.textColor = Color(108, 108, 108);
    [view addSubview:genche];
    
    UIView *Tou = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(touche.frame)+width*0.04, width*0.425, width*0.14)];
    Tou.backgroundColor = [UIColor whiteColor];
    [view addSubview:Tou];
    
    UIButton *jian1 = [UIButton buttonWithType:UIButtonTypeCustom];
    jian1.frame = CGRectMake(0, 0, width*0.14, width*0.14);
    [jian1 setBackgroundImage:[UIImage imageNamed:@"减号(1).png"] forState:UIControlStateNormal];
    [jian1 addTarget:self action:@selector(jianhao:) forControlEvents:UIControlEventTouchUpInside];
    [Tou addSubview:jian1];
    UILabel *qianxian1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.15, width*0.02, 0.5, width*0.1)];
    qianxian1.backgroundColor = Color(217, 217, 217);
    [Tou addSubview:qianxian1];
    
    tou1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.165, width*0.02, width*0.1, width*0.1)];
    tou1.text = @"1";
    tou1.tag = 22222;
    aCount = [tou1.text intValue];
    tou1.textAlignment = NSTextAlignmentCenter;
    tou1.textColor = Color(100, 200, 200);
    [Tou addSubview:tou1];
    touche1 = tou1.text;
    UILabel *houxian1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.275, width*0.02, 0.5, width*0.1)];
    houxian1.backgroundColor = Color(217, 217, 217);
    [Tou addSubview:houxian1];
    UIButton *jia1 = [UIButton buttonWithType:UIButtonTypeCustom];
    jia1.frame = CGRectMake(width*0.285, 0, width*0.14, width*0.14);
    [jia1 setBackgroundImage:[UIImage imageNamed:@"加号(1).png"] forState:UIControlStateNormal];
    [jia1 addTarget:self action:@selector(jiahao:) forControlEvents:UIControlEventTouchUpInside];
    [Tou addSubview:jia1];
    
    UIView *Gen = [[UIView alloc] initWithFrame:CGRectMake(width*0.525, CGRectGetMaxY(genche.frame)+width*0.04, width*0.425, width*0.14)];
    Gen.backgroundColor = [UIColor whiteColor];
    [view addSubview:Gen];
    
    UIButton *jian2 = [UIButton buttonWithType:UIButtonTypeCustom];
    jian2.frame = CGRectMake(0, 0, width*0.14, width*0.14);
    [jian2 setBackgroundImage:[UIImage imageNamed:@"减号(1).png"] forState:UIControlStateNormal];
    [jian2 addTarget:self action:@selector(jianhao1:) forControlEvents:UIControlEventTouchUpInside];
    [Gen addSubview:jian2];
    UILabel *qianxian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.15, width*0.02, 0.5, width*0.1)];
    qianxian2.backgroundColor = Color(217, 217, 217);
    [Gen addSubview:qianxian2];
    tou2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.165, width*0.02, width*0.1, width*0.1)];
    tou2.text = @"3";
    tou2.tag = 11111;
    bCount = [tou2.text intValue];
    tou2.textAlignment = NSTextAlignmentCenter;
    tou2.textColor = Color(0, 215, 200);
    [Gen addSubview:tou2];
    genche1 = tou2.text;
    UILabel *houxian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.275, width*0.02, 0.5, width*0.1)];
    houxian2.backgroundColor = Color(217, 217, 217);
    [Gen addSubview:houxian2];
    UIButton *jia2= [UIButton buttonWithType:UIButtonTypeCustom];
    jia2.frame = CGRectMake(width*0.285, 0, width*0.14, width*0.14);
    [jia2 setBackgroundImage:[UIImage imageNamed:@"加号(1).png"] forState:UIControlStateNormal];
    [jia2 addTarget:self action:@selector(jiahao1:) forControlEvents:UIControlEventTouchUpInside];
    [Gen addSubview:jia2];
    // 优惠券
    UILabel *youhui = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.2, CGRectGetMaxY(Tou.frame)+width*0.04, width*0.4, width*0.08)];
    youhui.text = @"优惠券";
    youhui.textColor = Color(108, 108, 108);
    youhui.textAlignment = NSTextAlignmentCenter;
    [view addSubview:youhui];
    
    UIView *youhuiView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(youhui.frame)+width*0.04, width*0.9, width*0.15)];
    youhuiView.backgroundColor = [UIColor whiteColor];
    [view addSubview:youhuiView];
    UITapGestureRecognizer *reg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addAlertView)];
    [youhuiView addGestureRecognizer:reg];
    
    UILabel *youh = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, width*0.025, width*0.15, width*0.1)];
    youh.text = @"优惠券";
    youh.textColor = Color(157, 157, 157);
    youh.textAlignment = NSTextAlignmentLeft;
    youh.font = [UIFont fontWithName:@"ArialMT" size:17];
    youh.adjustsFontSizeToFitWidth = YES;
    [youhuiView addSubview:youh];
    
    UIButton *wenhao11 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao11.frame = CGRectMake(CGRectGetMaxX(youh.frame), width*0.039, width*0.077, width*0.077);
    [wenhao11 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao11 addTarget:self action:@selector(wenhao11) forControlEvents:UIControlEventTouchUpInside];
    [youhuiView addSubview:wenhao11];
    
    youhuiLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.67, width*0.025, width*0.15, width*0.1)];
    youhuiLabel.text = [NSString stringWithFormat:@"%ld张",(unsigned long)_youhuiArray.count];
    youhuiLabel.textAlignment = NSTextAlignmentRight;
    youhuiLabel.textColor = Color(7, 187, 177);
    [youhuiView addSubview:youhuiLabel];
    
    UIImageView *image111 = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.825, width*0.055, width*0.04, width*0.04)];
    image111.image = [UIImage imageNamed:@"右居中.png"];
    [youhuiView addSubview:image111];
    
    // 价格信息
    UILabel *jiage = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.2, CGRectGetMaxY(youhuiView.frame)+width*0.04, width*0.4, width*0.08)];
    jiage.text = @"价格信息";
    jiage.textAlignment = NSTextAlignmentCenter;
    jiage.textColor = Color(108, 108, 108);
    [view addSubview:jiage];
    
    UIView *jiageInfo = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(jiage.frame)+width*0.04, width*0.9, width*0.52)];
    jiageInfo.backgroundColor = [UIColor whiteColor];
    [view addSubview:jiageInfo];
    
    UILabel *zongjia = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, width*0.025, width*0.1, width*0.08)];
    zongjia.text = @"总价";
    zongjia.textColor = Color(157, 157, 157);
    zongjia.adjustsFontSizeToFitWidth = YES;
    zongjia.textAlignment = NSTextAlignmentLeft;
    zongjia.font = [UIFont fontWithName:@"ArialMT" size:17];
    [jiageInfo addSubview:zongjia];
    
    UIButton *wenhao6 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao6.frame = CGRectMake(CGRectGetMaxX(zongjia.frame), width*0.027, width*0.077, width*0.077);
    [wenhao6 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao6 addTarget:self action:@selector(wenhao6) forControlEvents:UIControlEventTouchUpInside];
    [jiageInfo addSubview:wenhao6];
    
    
    
    zong = [[UILabel alloc] initWithFrame:CGRectMake(width*0.665, width*0.025, width*0.2, width*0.08)];
    zong.tag = 10001;
    price = [self.genCarprice intValue]*[tou2.text intValue]+[self.zhucarPrice intValue]*[tou1.text intValue];
    zong.text = [NSString stringWithFormat:@"¥ %d",price+cCount2+dCount+cCount+dCount2];
    zong.textColor = Color(255, 97, 57);
    zong.textAlignment = NSTextAlignmentRight;
    zong.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    [jiageInfo addSubview:zong];
    
    UILabel *xian11 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(zong.frame)+width*0.025, width*0.85, 0.5)];
    xian11.backgroundColor = Color(217, 217, 217);
    [jiageInfo addSubview:xian11];
    
    UILabel *dingjin = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian11.frame)+width*0.025, width*0.1, width*0.08)];
    dingjin.text = @"定金";
    dingjin.adjustsFontSizeToFitWidth = YES;
    dingjin.textColor = Color(157, 157, 157);
    dingjin.textAlignment = NSTextAlignmentLeft;
    dingjin.font = [UIFont fontWithName:@"ArialMT" size:17];
    [jiageInfo addSubview:dingjin];
    
    UIButton *wenhao7 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao7.frame = CGRectMake(CGRectGetMaxX(dingjin.frame), CGRectGetMaxY(xian11.frame)+width*0.027, width*0.077, width*0.077);
    [wenhao7 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao7 addTarget:self action:@selector(wenhao7) forControlEvents:UIControlEventTouchUpInside];
    [jiageInfo addSubview:wenhao7];
    
    ding = [[UILabel alloc] initWithFrame:CGRectMake(width*0.665, CGRectGetMaxY(xian11.frame)+width*0.025, width*0.2, width*0.08)];
    ding.tag = 10002;
    ding.text = [NSString stringWithFormat:@"¥ %d",(((price+cCount2+dCount+cCount+dCount2)/100)/3)*100];
    ding.textColor = Color(255, 97, 57);
    ding.textAlignment = NSTextAlignmentRight;
    ding.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    [jiageInfo addSubview:ding];
    
    UILabel *xian22 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(ding.frame)+width*0.025, width*0.85, 0.5)];
    xian22.backgroundColor = Color(217, 217, 217);
    [jiageInfo addSubview:xian22];
    
    UILabel *yhLbael = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian22.frame)+width*0.025, width*0.1, width*0.08)];
    yhLbael.text = @"优惠";
    yhLbael.textColor = Color(157, 157, 157);
    yhLbael.textAlignment = NSTextAlignmentLeft;
    yhLbael.adjustsFontSizeToFitWidth = YES;
    yhLbael.font = [UIFont fontWithName:@"ArialMT" size:17];
    [jiageInfo addSubview:yhLbael];
    
    youhuiPrice = [[UILabel alloc] initWithFrame:CGRectMake(width*0.665, CGRectGetMaxY(xian22.frame)+width*0.025, width*0.2, width*0.08)];
    youhuiPrice.text = [NSString stringWithFormat:@"¥%d",youhuiP];
    youhuiPrice.textColor = Color(255, 97, 57);
    youhuiPrice.textAlignment = NSTextAlignmentRight;
    youhuiPrice.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    youhuiPrice.adjustsFontSizeToFitWidth = YES;
    [jiageInfo addSubview:youhuiPrice];
    
    UILabel *xian33 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(yhLbael.frame)+width*0.025, width*0.85, 0.5)];
    xian33.backgroundColor = Color(217, 217, 217);
    [jiageInfo addSubview:xian33];
    
    UILabel *yue = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian33.frame)+width*0.025, width*0.1, width*0.08)];
    yue.text = @"尾款";
    yue.textColor = Color(157, 157, 157);
    yue.textAlignment = NSTextAlignmentLeft;
    yue.adjustsFontSizeToFitWidth = YES;
    yue.font = [UIFont fontWithName:@"ArialMT" size:17];
    [jiageInfo addSubview:yue];
    
    UIButton *wenhao8 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao8.frame = CGRectMake(CGRectGetMaxX(yue.frame), CGRectGetMaxY(xian33.frame)+width*0.027, width*0.077, width*0.077);
    [wenhao8 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao8 addTarget:self action:@selector(wenhao8) forControlEvents:UIControlEventTouchUpInside];
    [jiageInfo addSubview:wenhao8];
//    youhuiP = 200;
    
    yu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.665, CGRectGetMaxY(xian33.frame)+width*0.025, width*0.2, width*0.08)];
    yu.tag = 10003;
    yu.text = [NSString stringWithFormat:@"¥ %d",(price+cCount2+dCount+cCount+dCount2-youhuiP)-(((price+cCount2+dCount+cCount+dCount2)/100)/3)*100];
    yu.textColor = Color(255, 97, 57);
    yu.textAlignment = NSTextAlignmentRight;
    yu.adjustsFontSizeToFitWidth = YES;
    yu.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    [jiageInfo addSubview:yu];
    
    jianqu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.465, CGRectGetMaxY(xian33.frame)+width*0.025, width*0.2, width*0.08)];
//    jianqu.text = @"-200";
    jianqu.textAlignment = NSTextAlignmentRight;
    jianqu.textColor = Color(7, 187, 177);
    jianqu.font = [UIFont fontWithName:@"ArialMT" size:17];
    [jiageInfo addSubview:jianqu];
    jianqu.adjustsFontSizeToFitWidth = YES;
    
    UILabel *liuyan = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(jiageInfo.frame)+width*0.04, width*0.9, width*0.08)];
    liuyan.text = @"备注";
    liuyan.font = [UIFont fontWithName:@"ArialMT" size:18];
    liuyan.textAlignment = NSTextAlignmentCenter;
    liuyan.textColor = Color(108, 108, 108);
    [view addSubview:liuyan];
    
    
    UITextView *textField = [[UITextView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(liuyan.frame)+width*0.04, width*0.875, width*0.3)];
    textField.tag = 2016;
    textField.userInteractionEnabled = YES;
    textField.backgroundColor = [UIColor whiteColor];
    textField.textColor = Color(157, 157, 157);
    textField.tintColor = Color(7, 187, 177);
    textField.contentInset = UIEdgeInsetsMake(0, width*0.025f, 0, -width*0.025f);
    textField.font = [UIFont fontWithName:@"ArialMT" size:17];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [view addSubview:textField];
    
    UIView *buChongView = [[UIView alloc] initWithFrame:CGRectMake(width*0.925, CGRectGetMaxY(liuyan.frame)+width*0.04, width*0.025, width*0.3)];
    buChongView.backgroundColor = [UIColor whiteColor];
    [view addSubview:buChongView];
    
    
    baoxianView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(textField.frame)+width*0.04, width*0.9, width*0.12)];
    baoxianView.backgroundColor = [UIColor whiteColor];
    baoxianView.userInteractionEnabled = YES;
    [view addSubview:baoxianView];
    UITapGestureRecognizer *baoxianTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BaoxianTapView)];
    [baoxianView addGestureRecognizer:baoxianTap];
    
    UILabel *youji = [[UILabel alloc] initWithFrame:CGRectMake(baoxianView.frame.size.width*0.05, baoxianView.frame.size.width*0.02, baoxianView.frame.size.width*0.6, baoxianView.frame.size.width*0.09)];
    youji.text = @"邮寄合同";
    youji.textColor = Color(157, 157, 157);
    youji.textAlignment = NSTextAlignmentLeft;
    youji.font = [UIFont fontWithName:@"ArialMT" size:17];
    [baoxianView addSubview:youji];
    
    yunxu = [UIButton buttonWithType:UIButtonTypeCustom];
    yunxu.frame = CGRectMake(baoxianView.frame.size.width*0.88, baoxianView.frame.size.width*0.022, baoxianView.frame.size.width*0.08, baoxianView.frame.size.width*0.08);
    [yunxu setBackgroundImage:[UIImage imageNamed:@"勾选框(1).png"] forState:UIControlStateNormal];
    [yunxu addTarget:self action:@selector(BaoxianTapView) forControlEvents:UIControlEventTouchUpInside];
    [baoxianView addSubview:yunxu];
    yunxu.selected = NO;
//    [yunxu setBackgroundColor:[UIColor redColor]];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.075, CGRectGetMaxY(baoxianView.frame)+width*0.15, width*0.15, width*0.15)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view addSubview:iconImage];
    
    UIButton *tijiao = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiao.frame = CGRectMake(width/2-width*0.3, CGRectGetMaxY(iconImage.frame)+width*0.15, width*0.6, width*0.1);
    [tijiao setTitle:@"提交订单" forState:UIControlStateNormal];
    UIColor *color2 = Color(7, 187, 177);
    [tijiao setBackgroundColor:color2];
    [tijiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tijiao addTarget:self action:@selector(tijiaoINFO) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:tijiao];
}
- (void)yanseClick{
    
    self.view1 = [MainCarColorView makeViewWithMaskDatePicker2:self.view.frame setTitle2:@"主车颜色选择" Arr2:self.colorArray];
    self.view1.delegate = self;
}
- (void)yanseClick1{
    
    self.view2 = [GenCarColorView makeViewWithMaskDatePicker2:self.view.frame setTitle2:@"跟车颜色选择" Arr2:self.colorArray];
    self.view2.delegate = self;
}
- (void)fanweiClick{
    
    self.view3 = [TimeSelectView makeViewWithMaskDatePicker3:self.view.frame setTitle3:@"选择超时超公里" Arr3:self.timeArray Arr4:self.kmArray];
    self.view3.delegate = self;
}
- (void)gongliClick1{
    
    self.view4 = [TimesSelected2 makeViewWithMaskDatePicker4:self.view.frame setTitle4:@"选择超时超公里" Arr4:self.timeArray Arr4:self.kmArray];
    self.view4.delegate = self;
}
#pragma mark - tijiao dingdan
- (void)tijiaoINFO{
    
    UIView *view111 = [GiFHUD new];
    [GiFHUD setGifWithImageName:@"动态gif.gif"];
    [GiFHUD show];
    
    UITextView *textView = (UITextView *)[self.view viewWithTag:2016];
    
    NSLog(@"时间：%@  姓名：%@  手机号：%@  集合地址：%@  主车车型：%@  颜色：%@  超时：%@  跟车车型：%@  颜色：%@  超时：%@  头车数量：%@  跟车数量：%@  总价：%@  定金：%@  余额：%@  备注:%@",xuanzeTIME,name.text,phoneNUM.text,address.text,cartype1,carColor1,chaoshi1,carType2,carColor2,chaoshi3,touche1,genche1,zong.text,ding.text,yu.text,textView.text);
    
    if (xuanzeTIME == nil) {
        
        [self createPNMERROR:@"请设置日期"];
    }else{
        if (name.text == nil || name.text.length == 0 || [name.text isEqualToString:@""]) {
            
            [self createPNMERROR:@"请输入联系人"];
        }else{
            
            if ([address.text isEqualToString:@"预设集合点，可修改一次"]) {
                
                [self createPNMERROR:@"请输入停车地址"];
            }else{
                
                if (phoneNUM.text == nil || phoneNUM.text.length != 11) {
                    
                    [self createPNMERROR:@"请输入正确的联系方式"];
                }else{
                    
                    // 优惠券的使用接口
                    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",youhuiNumber,@"number", nil];
                    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_usecoupon" success:^(NSDictionary *fanhuicanshu) {
                        
                    } Error:^(NSString *cuowuxingxi) {
                        
                    }];
                    
                    gencheChaoshi = [NSString stringWithFormat:@"%d",[gencheChaoshi intValue]*[tou2.text intValue]];
                    zhucheChaoshi = [NSString stringWithFormat:@"%d",[zhucheChaoshi intValue]*aCount];
                    NSDictionary *dic= [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",xuanzeTIME,@"shijian",name.text,@"username",phoneNUM.text,@"tel",address.text,@"jihe",cartype1,@"zhuche",touche1,@"zhuche_num",carColor1,@"zhuche_yangse",[chaoshi1 componentsSeparatedByString:@"/"][0],@"zhuche_chaoshi",[chaoshi1 componentsSeparatedByString:@"/"][1],@"zhuche_chaogongli",carType2,@"genche",genche1,@"genche_num",carColor2,@"genche_yangse",[chaoshi3 componentsSeparatedByString:@"/"][0],@"genche_chaoshi",[chaoshi3 componentsSeparatedByString:@"/"][1],@"genche_chaogongli",[zong.text componentsSeparatedByString:@"¥"][1],@"jiage", [ding.text componentsSeparatedByString:@"¥"][1],@"dingjin",[yu.text componentsSeparatedByString:@"¥"][1],@"yue",textView.text,@"beizhu",zhucheKongshi,@"zhuche_ksf",gencheKongshi,@"genche_ksf",zongjiKognshi,@"heji_ksf",zhucheChaoshi,@"zhuche_csf",gencheChaoshi,@"genche_csf",zongjiChaoshi,@"heji_csf",[youhuiPrice.text componentsSeparatedByString:@"¥"][1],@"youhui",ksFanwei,@"ksffw",bid,@"bid", nil];
                    
                    [HttpManager postData:dic andUrl:TiJiaoURL success:^(NSDictionary *fanhuicanshu){
                        
                        orderID = fanhuicanshu;
                        [GiFHUD dismiss];
                        [self performSelector:@selector(stopit) withObject:view111 afterDelay:0.5];
                    
                    } Error:^(NSString *cuowuxingxi) {
                        
                    }];
                }
            }
        }
    }
}
- (void)stopit{
    
    [GiFHUD dismiss];
    PayView *view = [[PayView alloc] init];
    
    view.jiage = [ding.text componentsSeparatedByString:@"¥"][1];
    view.Dingdan = orderID[@"orderid"];
    view.baoxianName = baoxianName;
    view.phoneNumber = baoxianPhone;
    view.baoxianAddress = baoxianAddress;
    view.baoxianYouBian = baoxianYouBian;
    
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void)dizhi:(UITapGestureRecognizer *)tapGesture{
    
    DituViewController *view = [[DituViewController alloc] init];
    view.delegate = self;
    [self.navigationController pushViewController:view animated:YES];
}
- (void)postAddressString:(NSString *)addressString priceTag:(float)priceTag{
    
    address.text = addressString;
    address.textColor = Color(77, 77, 77);
    
    price2 = [self.zhuchePrice1 intValue]*priceTag;
    price3 = [self.genchePrice1 intValue]*priceTag;
    
    if (priceTag == 0) {
        
        ksFanwei = @"14000";
    }else if (priceTag == 0.5){
        
        ksFanwei = @"25000";
    }else if (priceTag == 1){
        
        ksFanwei = @"35000";
    }else if (priceTag == 2){
        
        ksFanwei = @"50000";
    }else if (priceTag == 3){
        
        ksFanwei = @"60000";
    }
    
    int x = [tou1.text intValue]+[tou2.text intValue];
    if (x < 4) {
        
        zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
        ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
        yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
        
        kong.text = [NSString stringWithFormat:@"¥ %d",price2*aCount+price3*bCount];
        kong.textColor = Color(255, 97, 57);
        kong.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    }else{
        
        if (yesOrNO == 1) {
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)/100/3)*100];
            
            kong.text = [NSString stringWithFormat:@"¥ %d",price2*aCount+price3*bCount];
            kong.textColor = Color(255, 97, 57);
            kong.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
        }else{
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
            
            kong.text = [NSString stringWithFormat:@"¥ %d",price2*aCount+price3*bCount];
            kong.textColor = Color(255, 97, 57);
            kong.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
        }
        
    }
    
    zhucheKongshi = [NSString stringWithFormat:@"%d",price2*aCount];
    gencheKongshi = [NSString stringWithFormat:@"%d",price3*bCount];
    zongjiKognshi = [NSString stringWithFormat:@"%d",price2*aCount+price3*bCount];
}

//- (void)dituSendPrice:(float)sender{
//    
//    price2 = [self.zhuchePrice1 intValue]*sender;
//    price3 = [self.genchePrice1 intValue]*sender;
//    
//    if (sender == 0) {
//        
//        ksFanwei = @"14000";
//    }else if (sender == 0.5){
//        
//        ksFanwei = @"25000";
//    }else if (sender == 1){
//        
//        ksFanwei = @"35000";
//    }else if (sender == 2){
//        
//        ksFanwei = @"50000";
//    }else if (sender == 3){
//        
//        ksFanwei = @"60000";
//    }
//    
//    int x = [tou1.text intValue]+[tou2.text intValue];
//    if (x < 4) {
//        
//        zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
//        ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
//        yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
//        
//        kong.text = [NSString stringWithFormat:@"¥ %d",price2*aCount+price3*bCount];
//        kong.textColor = Color(255, 97, 57);
//        kong.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
//    }else{
//        
//        if (yesOrNO == 1) {
//            
//            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
//            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
//            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)/100/3)*100];
//            
//            kong.text = [NSString stringWithFormat:@"¥ %d",price2*aCount+price3*bCount];
//            kong.textColor = Color(255, 97, 57);
//            kong.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
//        }else{
//            
//            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
//            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
//            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
//            
//            kong.text = [NSString stringWithFormat:@"¥ %d",price2*aCount+price3*bCount];
//            kong.textColor = Color(255, 97, 57);
//            kong.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
//        }
//        
//    }
//    
//    zhucheKongshi = [NSString stringWithFormat:@"%d",price2*aCount];
//    gencheKongshi = [NSString stringWithFormat:@"%d",price3*bCount];
//    zongjiKognshi = [NSString stringWithFormat:@"%d",price2*aCount+price3*bCount];
//}
- (void)xuanzeTime{
    
    CCDatePickerView *dateView = [[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view.window addSubview:dateView];
    
    dateView.blcok = ^(NSDate *dateString){
        
//        NSLog(@"年 = %ld  月 = %.2ld  日 = %.2ld  时 = %.2ld  分 = %.2ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute);
        
        NSString *datestr = [NSString stringWithFormat:@"%d-%d-%d %d:%d",(int)dateString.year,(int)dateString.month,(int)dateString.day,(int)dateString.hour,(int)dateString.minute];
        [xuanze setTitle:datestr forState:UIControlStateNormal];
        UIColor *color = Color(77, 77, 77);
        [xuanze setTitleColor:color forState:UIControlStateNormal];
        xuanzeTIME = datestr;
    };
    dateView.chooseTimeLabel.text = @"选择时间";
    [dateView fadeIn];
}
- (void)jiahao:(UIButton *)sender{
    
    UILabel *label = (UILabel *)[self.view viewWithTag:22222];
    aCount = [label.text intValue];
    aCount = aCount+1;
    label.text = [NSString stringWithFormat:@"%d",aCount];
    touche1 = label.text;
    
    price = [self.genCarprice intValue]*[tou2.text intValue] + [self.zhucarPrice intValue]*aCount;
    if (aCount + [tou2.text intValue] <= 4) {
        if (yesOrNO == 1) {
            
            price = price + youhuiP;
            yesOrNO = 0;
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
        }else{
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
        }
        
    }else{
        
        if (yesOrNO == 1) {
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+cCount+cCount2+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)/100/3)*100];
        }else{
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
        }
    }
    zhucheKongshi = [NSString stringWithFormat:@"%d",price2*aCount];
    gencheKongshi = [NSString stringWithFormat:@"%d",price3*bCount];
    zongjiKognshi = [NSString stringWithFormat:@"%d",price2*aCount + price3*bCount];
    kong.text = [NSString stringWithFormat:@"¥ %@",zongjiKognshi];
    zhucheChaoshi = [NSString stringWithFormat:@"%d",cCount + cCount2];
    gencheChaoshi = [NSString stringWithFormat:@"%d",dCount2 + dCount];
    zongjiChaoshi = [NSString stringWithFormat:@"%d",(cCount + cCount2)*aCount+ (dCount2 + dCount)*[tou2.text intValue]];
}
- (void)jianhao:(UIButton *)sender{
    
    UILabel *label  = (UILabel *)[self.view viewWithTag:22222];
    
    aCount = [label.text intValue];
    aCount = aCount-1;
    
    bCount = [tou2.text intValue];
    
    if (aCount <= 0) {
        
        aCount = 0;
        price = [self.genCarprice intValue]*bCount;
        
        if (aCount+bCount >= 4){
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)/100/3)*100];
        }else{
            
            if (yesOrNO == 1) {
                
                [self addYOUhuiAlert];
                
//                price = price +200;
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
                
                jianqu.text = @"";
                youhuiLabel.text = [NSString stringWithFormat:@"%d张",(int)_youhuiArray.count];
                yesOrNO = 0;
            }else{
                
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
                
                jianqu.text = @"";
                youhuiLabel.text = [NSString stringWithFormat:@"%d张",(int)_youhuiArray.count];
            }
            
        }
        
        if (bCount == 0) {
            
            [self createAlertView];
            
            bCount = 0;
            aCount = 1;
            UILabel *bLabel = (UILabel *)[self.view viewWithTag:11111];
            bLabel.text = [NSString stringWithFormat:@"%d",bCount];
            
            price = [self.zhucarPrice intValue];
            
            jianqu.text = @"";
            youhuiLabel.text = [NSString stringWithFormat:@"%d张",(int)_youhuiArray.count];
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+cCount+cCount2+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+cCount+cCount2+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+price2*aCount+price3*bCount)/100/3)*100];
        }
    }else{
        
        price = [self.zhucarPrice intValue]*aCount + [self.genCarprice intValue]*bCount;
        
        if (aCount+bCount >= 4) {
            
            if (yesOrNO == 1) {
                
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP];
                ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)/100/3)*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)/100/3)*100];
            }else{
                
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
            }
            
        }else{
            
            if (yesOrNO == 1) {
                
                [self addYOUhuiAlert];
                
                jianqu.text = @"";
                youhuiLabel.text = [NSString stringWithFormat:@"%d张",(int)_youhuiArray.count];
                yesOrNO = 0;
                price = [self.genCarprice intValue]*bCount;
                
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount-youhuiP)/100/3)*100];
            }else{
                
                jianqu.text = @"";
                youhuiLabel.text = [NSString stringWithFormat:@"%d张",(int)_youhuiArray.count];
                
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*[tou2.text intValue]+price2*aCount+price3*bCount)/100/3)*100];
            }
            
        }
        
    }
    
    label.text = [NSString stringWithFormat:@"%d",aCount];
    touche1 = label.text;
    
    zhucheKongshi = [NSString stringWithFormat:@"%d",price2*aCount];
    gencheKongshi = [NSString stringWithFormat:@"%d",price3*bCount];
    zongjiKognshi = [NSString stringWithFormat:@"%d",price2*aCount + price3*bCount];
    kong.text = [NSString stringWithFormat:@"¥ %@",zongjiKognshi];
    zhucheChaoshi = [NSString stringWithFormat:@"%d",cCount + cCount2];
    gencheChaoshi = [NSString stringWithFormat:@"%d",dCount2 + dCount];
    zongjiChaoshi = [NSString stringWithFormat:@"%d",(cCount + cCount2)*aCount+ (dCount2 + dCount)*[tou2.text intValue]];
}
- (void)jiahao1:(UIButton *)sender{
    
    UILabel *label = [self.view viewWithTag:11111];
    bCount = [label.text intValue];
    bCount = bCount+1;
    label.text = [NSString stringWithFormat:@"%d",bCount];
    genche1 = label.text;
    
    price = [self.zhucarPrice intValue]*[tou1.text intValue] + [self.genCarprice intValue]*bCount;
    
    if (aCount + bCount <= 4) {
        
        if (yesOrNO == 1) {
            
            [self addYOUhuiAlert];
            
            yesOrNO = 0;
            price = price + youhuiP;
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3)*100];
        }else{
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3)*100];
        }
        
    }else{
        
        if (yesOrNO == 1) {
        
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount-youhuiP)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount-youhuiP)/100/3)*100];
        }else{
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",((price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3)*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)-((price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3)*100];
        }
    }
    zhucheKongshi = [NSString stringWithFormat:@"%d",price2*aCount];
    gencheKongshi = [NSString stringWithFormat:@"%d",price3*bCount];
    zongjiKognshi = [NSString stringWithFormat:@"%d",price2*aCount + price3*bCount];
    kong.text = [NSString stringWithFormat:@"¥ %@",zongjiKognshi];
    zhucheChaoshi = [NSString stringWithFormat:@"%d",cCount + cCount2];
    gencheChaoshi = [NSString stringWithFormat:@"%d",dCount2 + dCount];
    zongjiChaoshi = [NSString stringWithFormat:@"%d",(cCount + cCount2)*aCount+ (dCount2 + dCount)*[tou2.text intValue]];
}
- (void)jianhao1:(UIButton *)sender{
    
    UILabel *label  = (UILabel *)[self.view viewWithTag:11111];
    
    bCount = [label.text intValue];
    bCount = bCount-1;
    
    aCount = [tou1.text intValue];
    
    if (bCount < 0) {
        
        bCount = 0;
        price = [self.zhucarPrice intValue]*aCount;
        
        if (aCount >= 4) {
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount-youhuiP)-(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount-youhuiP)/100/3*100];
        }else{
            
            jianqu.text = @"";
            youhuiLabel.text = [NSString stringWithFormat:@"%d张",(int)_youhuiArray.count];
            if (yesOrNO == 1) {
                
                 [self addYOUhuiAlert];
                
                yesOrNO = 0;
                price = [self.zhucarPrice intValue]*aCount;
                
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",(price+cCount+cCount2+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)-(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
            }else{
                
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)-(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
            }
        }
        
        if (aCount == 0) {
            
            [self createAlertView];
            UILabel *aLabel = (UILabel *)[self.view viewWithTag:22222];
            aCount = 0;
            bCount = 1;
            aLabel.text = [NSString stringWithFormat:@"%d",aCount];
            
            price = [self.genCarprice intValue];
            
            jianqu.text = @"";
            youhuiLabel.text = [NSString stringWithFormat:@"%d张",(int)_youhuiArray.count];
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)-(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
        }
    }else{
        
        price = price - [self.genCarprice intValue];
        if (aCount+bCount >= 4) {
            
            if (yesOrNO == 1) {
            
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount-youhuiP)-(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount-youhuiP)/100/3*100];
            }else{
                
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)-(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
            }
            
        }else{
            
            jianqu.text = @"";
            youhuiLabel.text = [NSString stringWithFormat:@"%d张",(int)_youhuiArray.count];
            
            if (yesOrNO == 1) {
                
                 [self addYOUhuiAlert];
                
                yesOrNO = 0;
                price = price + youhuiP;
                
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount-youhuiP)-(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount-youhuiP)/100/3*100];
            }else{
                
                zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount];
                ding.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
                yu.text = [NSString stringWithFormat:@"¥%d",(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)-(price+(cCount+cCount2)*aCount+(dCount2+dCount)*bCount+price2*aCount+price3*bCount)/100/3*100];
            }
        }
    }
    label.text = [NSString stringWithFormat:@"%d",bCount];
    genche1 = label.text;
    
    zhucheKongshi = [NSString stringWithFormat:@"%d",price2*aCount];
    gencheKongshi = [NSString stringWithFormat:@"%d",price3*bCount];
    zongjiKognshi = [NSString stringWithFormat:@"%d",price2*aCount + price3*bCount];
    kong.text = [NSString stringWithFormat:@"¥ %@",zongjiKognshi];
    
    zhucheChaoshi = [NSString stringWithFormat:@"%d",cCount + cCount2];
    gencheChaoshi = [NSString stringWithFormat:@"%d",dCount2 + dCount];
    zongjiChaoshi = [NSString stringWithFormat:@"%d",(cCount + cCount2)*aCount+ (dCount2 + dCount)*[tou2.text intValue]];
}

- (void)getColorChoiceValues333:(NSString *)values{
    
    if ([values isEqualToString:@""]||values == nil) {
        
        zhucheFanwei.text = @"5小时/50公里";
        chaoshi1 = @"5小时/50公里";
        chaoshi3 = zhucheFanwei.text;
        gencheFanwei.text = @"5小时/50公里";
    }else{
        zhucheFanwei.text = values;
        gencheFanwei.text = values;
        chaoshi1 = values;
        chaoshi3 = values;
    }
//    NSLog(@"主车  %@",zhucheFanwei.text);
    
    NSArray *array = [zhucheFanwei.text componentsSeparatedByString:@"小时/"];
    NSString *a = array[0];
    
    NSString *bcount = array[1];
    NSArray *array2 = [bcount componentsSeparatedByString:@"公里"];
    NSString *b = array2[0];
    
    if ([a intValue] >= 5|| [a intValue]<=8) {
        
        cCount = [self.zhuchePrice1 intValue]*0.5*([a intValue] - 5);
        dCount = [self.genchePrice1 intValue]*0.5*([a intValue] - 5);
        
    }else if ([a intValue]>8 || [a intValue] <= 10) {
        
        cCount = [self.zhuchePrice1 intValue]*0.3*([a intValue] - 8)+[self.zhuchePrice1 intValue]*0.5*3;
        dCount = [self.genchePrice1 intValue]*0.3*([a intValue] - 8)+[self.genchePrice1 intValue]*0.5*3;
    }
    if ([b intValue]>=50&&[b intValue]<=200) {
        
        cCount2 = [self.zhuchePrice2 intValue]*0.5*([b intValue] - 50);
        dCount2 = [self.genchePrice2 intValue]*0.5*([b intValue] - 50);
        
    }if ([b intValue]>200 && [b intValue]<=300) {
        
        cCount2 = [self.zhuchePrice2 intValue]*0.3*([b intValue] - 200) + [self.zhuchePrice2 intValue]*0.5*150;
        dCount2 = [self.genchePrice2 intValue]*0.3*([b intValue] - 200)*[tou2.text intValue] + [self.genchePrice2 intValue]*0.5*150*[tou2.text intValue];
    }
    
    if (aCount+bCount >= 4) {
        
        zong.text = [NSString stringWithFormat:@"¥%d",price+cCount+cCount2+dCount*[tou2.text intValue]+dCount2*[tou2.text intValue]+price2*aCount+price3*bCount];
        ding.text = [NSString stringWithFormat:@"¥%d",(price+dCount*[tou2.text intValue]+dCount2*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount)/100/3*100];
        yu.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+(cCount+cCount2)*aCount+price2*aCount+price3*bCount-youhuiP)-(price+(dCount+dCount2)*[tou2.text intValue]+(cCount+cCount2)*aCount+price2*aCount+price3*bCount-youhuiP)/100/3*100];
    }else{
        
        if (yesOrNO == 1) {
            
            yesOrNO = 0;
            price = price + youhuiP;
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount+dCount2)*[tou2.text intValue]+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+(cCount+cCount2)*aCount+price2*aCount+price3*bCount)/100/3*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+(cCount+cCount2)*aCount+price2*aCount+price3*bCount)-(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount)/100/3*100];
        }else{
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(cCount+cCount2)*aCount+(dCount+dCount2)*[tou2.text intValue]+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+(cCount+cCount2)*aCount+price2*aCount+price3*bCount)/100/3*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+(cCount+cCount2)*aCount+price2*aCount+price3*bCount)-(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount)/100/3*100];
        }
    }
    
    zhucheChaoshi = [NSString stringWithFormat:@"%d",cCount + cCount2];
    gencheChaoshi = [NSString stringWithFormat:@"%d",dCount2 + dCount];
    zongjiChaoshi = [NSString stringWithFormat:@"%d",(cCount + cCount2)*[tou1.text intValue]+ (dCount2 + dCount)*[tou2.text intValue]];
    kong.text = [NSString stringWithFormat:@"¥ %@",zongjiKognshi];
}
- (void)getColorChoiceValues22:(NSString *)values{
    
    zhucheYanse.text = values;
    carColor1 = values;
}
- (void)getColorChoiceValues222:(NSString *)values{
    
    gencheYanse.text = values;
    carColor2 = values;
}
- (void)getColorChoiceValues444:(NSString *)values{
    
//    NSLog(@"gen车  %@",values);
    if ([values isEqualToString:@""]||values == nil) {
        
        gencheFanwei.text = @"5小时/50公里";
        chaoshi3 = gencheFanwei.text;
        chaoshi1 = gencheFanwei.text;
        zhucheFanwei.text = @"5小时/50公里";
    }else{
        gencheFanwei.text = values;
        zhucheFanwei.text = values;
        chaoshi3 = values;
        chaoshi1 = values;
    }
    NSArray *array = [gencheFanwei.text componentsSeparatedByString:@"小时/"];
    NSString *a = array[0];
    
    NSString *bcount = array[1];
    NSArray *array2 = [bcount componentsSeparatedByString:@"公里"];
    NSString *b = array2[0];
    
    if ([a intValue] >= 5|| [a intValue]<=8) {
        
        dCount = [self.genchePrice1 intValue]*0.5*([a intValue] - 5);
        cCount = [self.zhuchePrice1 intValue]*0.5*([a intValue] - 5);
        
    }else if ([a intValue]>8 || [a intValue] <= 10) {
        
        dCount = [self.genchePrice1 intValue]*0.3*([a intValue] - 8)+[self.genchePrice1 intValue]*0.5*3;
        cCount = [self.zhuchePrice1 intValue]*0.3*([a intValue] - 8)+[self.zhuchePrice1 intValue]*0.5*3;
    }
    if ([b intValue]>=50&&[b intValue]<=200) {
        
        dCount2 = [self.genchePrice2 intValue]*0.5*([b intValue] - 50);
        cCount2 = [self.zhuchePrice2 intValue]*0.5*([b intValue] - 50);;
        
    }if ([b intValue]>200 && [b intValue]<=300) {
        
        dCount2 = [self.genchePrice2 intValue]*0.3*([b intValue] - 200) + [self.genchePrice2 intValue]*0.5*150;
        cCount2 = [self.zhuchePrice2 intValue]*0.3*([b intValue] - 200) + [self.zhuchePrice2 intValue]*0.5*150;
    }
    
    if (aCount+bCount >= 4){
        
        zong.text = [NSString stringWithFormat:@"¥%d",price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount];
        ding.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount)/100/3*100];
        yu.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount-youhuiP)-(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount-youhuiP)/100/3*100];
    }else{
        
        if (yesOrNO == 1) {
            
            yesOrNO = 0;
            price = price + youhuiP;
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount)/100/3*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount)-(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount)/100/3*100];
        }else{
            
            zong.text = [NSString stringWithFormat:@"¥%d",price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount];
            ding.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount)/100/3*100];
            yu.text = [NSString stringWithFormat:@"¥%d",(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount)-(price+(dCount+dCount2)*[tou2.text intValue]+cCount+cCount2+price2*aCount+price3*bCount)/100/3*100];
        }
    }
    
    zhucheChaoshi = [NSString stringWithFormat:@"%d",cCount + cCount2];
    gencheChaoshi = [NSString stringWithFormat:@"%d",dCount2 + dCount];
    zongjiChaoshi = [NSString stringWithFormat:@"%d",(cCount + cCount2)*[tou1.text intValue]+ (dCount2 + dCount)*[tou2.text intValue]];
    kong.text = [NSString stringWithFormat:@"¥ %@",zongjiKognshi];
}
#pragma mark - alertView
- (void)createAlertView{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    view1.tag = 718;
    [self.view.window addSubview:view1];
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(width/2-width*0.375, height/2-width*0.25, width*0.75, width*0.3)];
    alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    alertView.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:alertView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"主车与跟车数量不能同时为0";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [alertView addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [alertView addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [alertView addSubview:queding];
}
- (void)moveAll{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
    [view removeFromSuperview];
}
#pragma mark - alertView - wenhao
#pragma mark - 空驶费说明
- (void)wenhao1{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.4, width*0.9, width*0.79)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(width*0.035, width*0.035, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(cuowuDianji) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.055, width*0.17, view2.frame.size.width, view2.frame.size.width/2)];
    image.image = [UIImage imageNamed:@"空驶说明图.png"];
    [view2 addSubview:image];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
}
#pragma mark - 范围说明
- (void)wenhao2{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.4, width*0.9, width*0.79)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(width*0.035, width*0.035, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(cuowuDianji) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.055, width*0.17, view2.frame.size.width, view2.frame.size.width/2)];
    image.image = [UIImage imageNamed:@"范围说明图.png"];
    [view2 addSubview:image];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
}
#pragma mark - 使用说明
- (void)wenhao3:(UIButton *)sender{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.4, width*0.9, width*0.79)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(width*0.035, width*0.035, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(cuowuDianji) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    NSString *string = [[NSString alloc] init];
    if (sender.tag == 10045) {
        
        string = [NSString stringWithFormat:@"%@每小时/%@每公里;",self.zhuchePrice1,self.zhuchePrice2];
    }if (sender.tag == 10046) {
        
        string = [NSString stringWithFormat:@"%@每小时/%@每公里;",self.genchePrice1,self.genchePrice2];
    }
    
    NSArray *array = @[@"超出5小时50公里收费标准;",string,@"时间与公里叠加计费;",@"不足一小时按一小时计费;",@"超出费用与驾驶员现场结算;"];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.055, CGRectGetMaxY(cuowu.frame)+width*0.02+i*width*0.1, width*0.8, width*0.1)];
        label.text = array[i];
        label.textColor = Color(137, 137, 137);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:17];
        [view2 addSubview:label];
    }
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];

}
#pragma mark - 总价说明
- (void)wenhao6{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.2, width*0.9, width*1.18)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(view2.frame.size.width*0.03, view2.frame.size.width*0.03, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(cuowuDianji) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    NSArray *array = @[@"基础使用范围费用",@"提前预定超出费用",@"空驶费"];
    for (int i = 0; i <3; i++) {
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(cuowu.frame)+width*0.01+width*0.3*i, view2.frame.size.width*0.9, width*0.1)];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = Color(77, 77, 77);
        label1.text = array[i];
        label1.font = [UIFont boldSystemFontOfSize:18];
        [view2 addSubview:label1];
    }
    
//    int a = [zhucheChaoshi intValue]/[tou1.text intValue];
    NSString *text = [NSString stringWithFormat:@"主车：¥ %@ X %@",self.zhucarPrice,tou1.text];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *colore = Color(137, 137, 137);
    [attr setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
    UIColor *colll = Color(255, 97, 57);
    if (text.length == 13) {
        
        [attr setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 10)];
    }else{
        
        [attr setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 11)];
    }
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.24, view2.frame.size.width*0.9, width*0.1)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.attributedText = attr;
    label2.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label2];
    
//    int c = [gencheChaoshi intValue]/[tou2.text intValue];
    NSString *text2 = [NSString stringWithFormat:@"跟车：¥ %@ X %@",self.genCarprice,tou2.text];
    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:text2];
    [attr2 setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
    if (text2.length == 8) {
        
        [attr2 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 5)];
    }else{
        
        [attr2 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 6)];
    }
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label2.frame), view2.frame.size.width*0.9, width*0.1)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = Color(255, 97, 57);
    label3.attributedText = attr2;
    label3.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label3];
    
    int a = [zhucheChaoshi intValue];
    NSString *text3 = [NSString stringWithFormat:@"主车：¥ %d X %@",a*[tou1.text intValue]/[tou1.text intValue],tou1.text];
    NSMutableAttributedString *attr3 = [[NSMutableAttributedString alloc] initWithString:text3];
    [attr3 setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
    if (text3.length == 10) {
        
        [attr3 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 7)];
    }if (text3.length == 12) {
        
        [attr3 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 9)];
    }if (text3.length == 13) {
        
        [attr3 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 10)];
    }
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label3.frame)+width*0.1, view2.frame.size.width*0.9, width*0.1)];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.textColor = Color(255, 97, 57);
    label4.attributedText = attr3;
    label4.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label4];
    
    int b = [gencheChaoshi intValue];
    NSString *text4 = [NSString stringWithFormat:@"跟车：¥ %d X %@",b,tou2.text];
    NSMutableAttributedString *attr4 = [[NSMutableAttributedString alloc] initWithString:text4];
    [attr4 setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
    if (text4.length == 10) {
        
        [attr4 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 7)];
    }if (text4.length == 12) {
        
        [attr4 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 9)];
    }if (text4.length == 13) {
        
        [attr4 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 10)];
    }
//    [attr4 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 6)];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label4.frame), view2.frame.size.width*0.9, width*0.1)];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.textColor = Color(255, 97, 57);
    label5.attributedText = attr4;
    label5.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label5];
    
    NSString *text5 = [NSString stringWithFormat:@"主车：¥ %d X %@",price2,tou1.text];
    NSMutableAttributedString *attr5 = [[NSMutableAttributedString alloc] initWithString:text5];
    [attr5 setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
    if (text5.length == 10) {
        
        [attr5 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 7)];
    }if (text5.length == 12) {
        
        [attr5 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 9)];
    }if (text5.length == 13) {
        
        [attr5 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 10)];
    }
//    [attr5 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 6)];
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label5.frame)+width*0.1, view2.frame.size.width*0.9, width*0.1)];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.textColor = Color(255, 97, 57);
    label6.attributedText = attr5 ;
    label6.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label6];
    
    
    NSString *text6 = [NSString stringWithFormat:@"跟车：¥ %d X %@",price3*bCount/bCount,tou2.text];
    NSMutableAttributedString *attr6 = [[NSMutableAttributedString alloc] initWithString:text6];
    [attr6 setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
    if (text6.length == 10) {
        
        [attr6 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 7)];
    }if (text6.length == 12) {
        
        [attr6 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 9)];
    }if (text6.length == 13) {
        
        [attr6 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 10)];
    }
//    [attr6 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 6)];
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label6.frame), view2.frame.size.width*0.9, width*0.1)];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.textColor = Color(255, 97, 57);
    label7.attributedText = attr6;
    label7.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label7];
    
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
}
#pragma mark - 定金说明
- (void)wenhao7{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.4, width*0.9, width*0.79)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(view2.frame.size.width*0.03, view2.frame.size.width*0.03, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(cuowuDianji) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(cuowu.frame)+width*0.02, view2.frame.size.width*0.9, width*0.1)];
    label.text = @"定金为总价的30%收取";
    label.textColor = Color(137, 137, 137);
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label.frame), view2.frame.size.width*0.9, width*0.1)];
    label2.text = @"支付定金即生成订单";
    label2.textColor = Color(137, 137, 137);
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label2];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
}
#pragma mark - 尾款说明
- (void)wenhao8{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.4, width*0.9, width*0.79)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(view2.frame.size.width*0.03, view2.frame.size.width*0.03, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(cuowuDianji) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.055, width*0.17, view2.frame.size.width, view2.frame.size.width/2)];
    image.image = [UIImage imageNamed:@"尾款说明图.png"];
    [view2 addSubview:image];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
}

- (void)removeAll{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
    [view removeFromSuperview];
}
- (void)cuowuDianji{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
    [view removeFromSuperview];
}
#pragma mark - 优惠券说明
- (void)addAlertView{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.2, width*0.9, width*0.99)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(view2.frame.size.width*0.03, view2.frame.size.width*0.03, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(cuowuDianji) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UILabel *youhui = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, view2.frame.size.width*0.04, view2.frame.size.width*0.9, width*0.1)];
    youhui.textColor = Color(107, 107, 107);
    youhui.textAlignment = NSTextAlignmentCenter;
    youhui.text = @"优惠券";
    youhui.font = [UIFont systemFontOfSize:20];
    [view2 addSubview:youhui];
    
    
    int x = [tou1.text intValue]+[tou2.text intValue];
    
    if (_youhuiArray.count == 0) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.3, view2.frame.size.width, width*0.1)];
        label.text = @"暂无优惠券";
        label.textColor = Color(107, 107, 107);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18];
        label.adjustsFontSizeToFitWidth = YES;
        [view2 addSubview:label];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width/2-width*0.075, CGRectGetMaxY(label.frame)+width*0.2, width*0.15, width*0.15)];
        image.image = [UIImage imageNamed:@"logo浅.png"];
        [view2 addSubview:image];
    }else{
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, view2.frame.size.width, view2.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [view2 addSubview:_tableView];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = YES;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (x < 4) {
            
            _tableView.tag = 1234;
        }else {
            
            _tableView.tag = 12345;
        }
    }
}
#pragma mark - youhuiquan TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _youhuiArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return width*0.25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_tableView.tag == 12345) {
        
        YouhuiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stac"];
        if (!cell) {
            cell = [[YouhuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stac"];
        }
        cell.model = _youhuiArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }if (_tableView.tag == 1234) {
        
        BKYYouhuiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stav"];
        if (!cell) {
            
            cell = [[BKYYouhuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stav"];
        }
        cell.model = _youhuiArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_tableView.tag == 12345) {
        
        UIView *view = (UIView *)[self.view.window viewWithTag:718];
        [view removeFromSuperview];
        
        
        if ([tou1.text intValue]+[tou2.text intValue] >= 4) {
            
            youhuiLabel.text = [NSString stringWithFormat:@"- %@",_youhuiArray[indexPath.row][@"total"]];
            jianqu.text = [NSString stringWithFormat:@"(已减去%@)",_youhuiArray[indexPath.row][@"total"]];
            
            youhuiP = [_youhuiArray[indexPath.row][@"total"] intValue];
            yesOrNO = 1;
            //    NSString *a = [zong.text componentsSeparatedByString:@"¥"][1];
            int b = price + price2*aCount + price3*bCount+ (dCount+dCount2)*bCount+(cCount+cCount2)*aCount;
            int c = b/100/3*100;
            int d = b - c - youhuiP;
            zong.text = [NSString stringWithFormat:@"¥%d",b];
            ding.text = [NSString stringWithFormat:@"¥%d",c];
            yu.text = [NSString stringWithFormat:@"¥%d",d];
            youhuiPrice.text = [NSString stringWithFormat:@"¥%d",youhuiP];
            
            youhuiNumber = _youhuiArray[indexPath.row][@"number"];
            
            bid = _youhuiArray[indexPath.row][@"bid"];
       
        }else{
            
            youhuiLabel.text = @"";
            jianqu.text = @"";
            youhuiP = 0;
            yesOrNO = 0;
            
            int b = price + price2*aCount + price3*bCount+ (dCount+dCount2)*bCount+(cCount+cCount2)*aCount;
            int c = b/100/3*100;
            int d = b - c;
            zong.text = [NSString stringWithFormat:@"¥%d",b];
            ding.text = [NSString stringWithFormat:@"¥%d",c];
            yu.text = [NSString stringWithFormat:@"¥%d",d];
        }
    }
    if (_tableView.tag == 12345) {
        
        UIView *view = (UIView *)[self.view.window viewWithTag:718];
        [view removeFromSuperview];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headVCiew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, width*0.12)];
    headVCiew.backgroundColor = [UIColor whiteColor];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(headVCiew.frame.size.width*0.03, headVCiew.frame.size.width*0.03, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [headVCiew addSubview:cuowu];
    [cuowu addTarget:self action:@selector(cuowuDianji) forControlEvents:UIControlEventTouchUpInside];
    [headVCiew addSubview:cuowu];
    
    UILabel *youhui = [[UILabel alloc] initWithFrame:CGRectMake(headVCiew.frame.size.width*0.02, headVCiew.frame.size.width*0.04, headVCiew.frame.size.width*0.85, width*0.1)];
    youhui.textColor = Color(107, 107, 107);
    youhui.textAlignment = NSTextAlignmentCenter;
    youhui.text = @"优惠券";
    youhui.font = [UIFont systemFontOfSize:20];
    [headVCiew addSubview:youhui];
    
    return headVCiew;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return width*0.14;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, width*0.12)];
    footView.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *youhuiPrice11 = [[UIImageView alloc] initWithFrame:CGRectMake(footView.frame.size.width/2-footView.frame.size.width*0.125, CGRectGetMaxY(footView.frame)+footView.frame.size.width*0.1, footView.frame.size.width*0.15, footView.frame.size.width*0.15)];
    youhuiPrice11.image = [UIImage imageNamed:@"logo浅.png"];
    [footView addSubview:youhuiPrice11];
    
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return width*0.12;
}





//- (void)touchInSide{
//    
//    UIView *view = [self.view viewWithTag:1013];
//    [view removeFromSuperview];
//    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd 'T'HH:mm"];
//    
//    if ([tou1.text intValue]+[tou2.text intValue] >= 4) {
//        
//        youhuiLabel.text = @"-200";
//        jianqu.text = @"(已减去200)";
//        
//        youhuiP = 200;
//        yesOrNO = 1;
//        //    NSString *a = [zong.text componentsSeparatedByString:@"¥"][1];
//        int b = price + price2 + price3 - youhuiP+dCount+dCount2+cCount+cCount2;
//        int c = b/100/3*100;
//        int d = b - c;
//        zong.text = [NSString stringWithFormat:@"¥%d",b];
//        ding.text = [NSString stringWithFormat:@"¥%d",c];
//        yu.text = [NSString stringWithFormat:@"¥%d",d];
//    }else{
//        
//        youhuiLabel.text = @"";
//        jianqu.text = @"";
//        youhuiP = 0;
//        yesOrNO = 0;
//        
//        int b = price + price2 + price3+dCount+dCount2+cCount+cCount2;
//        int c = b/100/3*100;
//        int d = b - c;
//        zong.text = [NSString stringWithFormat:@"¥%d",b];
//        ding.text = [NSString stringWithFormat:@"¥%d",c];
//        yu.text = [NSString stringWithFormat:@"¥%d",d];
//    }
//}

#pragma mark - 优惠券的问号说明
- (void)wenhao11{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.4, width*0.9, width*0.79)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(width*0.035, width*0.035, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(cuowuDianji) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.055, width*0.17, view2.frame.size.width, view2.frame.size.width/2)];
    image.image = [UIImage imageNamed:@"优惠券说明.png"];
    [view2 addSubview:image];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
}
#pragma mark - 个人信息
- (void)createInfoERROR{
    
    [GiFHUD dismiss];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.1, height/2-width*0.25, width*0.8, width*0.3)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.03, view2.frame.size.width*0.9, width*0.1)];
    label.text = @"请注意填充完整个人信息";
    label.textColor = Color(157, 157, 157);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [view2 addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label.frame)+width*0.03, view2.frame.size.width*0.9, 1)];
    xian.backgroundColor = Color(237, 237, 237);
    [view2 addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, CGRectGetMaxY(xian.frame)+width*0.02, view2.frame.size.width, width*0.1);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [view2 addSubview:queding];
}

- (void)createPNMERROR:(NSString *)str{
    
    [GiFHUD dismiss];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.1, height/2-width*0.25, width*0.8, width*0.3)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.03, view2.frame.size.width*0.9, width*0.1)];
    label.text = str;
    label.textColor = Color(157, 157, 157);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [view2 addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label.frame)+width*0.03, view2.frame.size.width*0.9, 1)];
    xian.backgroundColor = Color(237, 237, 237);
    [view2 addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, CGRectGetMaxY(xian.frame), view2.frame.size.width, width*0.14);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [view2 addSubview:queding];
}

#pragma mark - 优惠券使用提示
- (void)addYOUhuiAlert{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.1, height/2-width*0.25, width*0.8, width*0.3)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.03, view2.frame.size.width*0.9, width*0.1)];
    label.text = @"请注意4辆以下不能使用优惠券";
    label.textColor = Color(157, 157, 157);
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [view2 addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label.frame)+width*0.03, view2.frame.size.width*0.9, 1)];
    xian.backgroundColor = Color(237, 237, 237);
    [view2 addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, CGRectGetMaxY(xian.frame)+width*0.02, view2.frame.size.width, width*0.1);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [view2 addSubview:queding];
    
    youhuiPrice.text = @"¥0";
}
#pragma mark - 合同邮寄
- (void)BaoxianTapView{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.4, width*0.9, width*0.79)];
    view2.backgroundColor = [UIColor whiteColor];
    view2.userInteractionEnabled = YES;
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    CGFloat view2Width = view2.frame.size.width;
    
    UILabel *shuoming = [[UILabel alloc] initWithFrame:CGRectMake(view2Width*0.05, view2Width*0.05, view2Width*0.9, view2Width*0.08)];
    shuoming.text = @"合同详情";
    shuoming.textColor = Color(77, 77, 77);
    shuoming.textAlignment = NSTextAlignmentCenter;
    shuoming.font = [UIFont systemFontOfSize:17];
    [view2 addSubview:shuoming];
    
    NSArray *nameArray = @[@"姓名",@"电话",@"邮寄地址",@"邮政编码"];
    for (int i = 0; i < 4; i++) {
        
        UILabel *hetongName = [[UILabel alloc] initWithFrame:CGRectMake(view2Width*0.05, CGRectGetMaxY(shuoming.frame)+view2Width*0.02+view2Width*0.1*i+view2Width*0.02*i, view2Width*0.2, view2Width*0.1)];
        hetongName.text = nameArray[i];
        hetongName.adjustsFontSizeToFitWidth = YES;
        hetongName.textColor = Color(157, 157, 157);
        hetongName.textAlignment = NSTextAlignmentLeft;
        [view2 addSubview:hetongName];
    }
    
    hetongText1 = [[UITextField alloc] initWithFrame:CGRectMake(view2Width*0.3, CGRectGetMaxY(shuoming.frame)+view2Width*0.02, view2Width*0.6, view2Width*0.1)];
    hetongText1.tintColor = Color(7, 187, 177);
    hetongText1.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"hetong1"];
    hetongText1.textAlignment = NSTextAlignmentRight;
    hetongText1.layer.borderWidth = 0.5;
    UIColor *coclor = Color(237, 237, 237);
    hetongText1.layer.borderColor = [coclor CGColor];
    [view2 addSubview:hetongText1];
    
    hetongText2 = [[UITextField alloc] initWithFrame:CGRectMake(view2Width*0.3, CGRectGetMaxY(shuoming.frame)+view2Width*0.02+view2Width*0.1+view2Width*0.02, view2Width*0.6, view2Width*0.1)];
    hetongText2.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"hetong2"];
    hetongText2.tintColor = Color(7, 187, 177);
    hetongText2.textAlignment = NSTextAlignmentRight;
    hetongText2.layer.borderWidth = 0.5;
    hetongText2.layer.borderColor = [coclor CGColor];
    [view2 addSubview:hetongText2];
    
    hetongText3 = [[UITextField alloc] initWithFrame:CGRectMake(view2Width*0.3, CGRectGetMaxY(shuoming.frame)+view2Width*0.02+(view2Width*0.1+view2Width*0.02)*2, view2Width*0.6, view2Width*0.1)];
    hetongText3.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"hetong3"];
    hetongText3.tintColor = Color(7, 187, 177);
    hetongText3.textAlignment = NSTextAlignmentRight;
    hetongText3.layer.borderWidth = 0.5;
    hetongText3.layer.borderColor = [coclor CGColor];
    [view2 addSubview:hetongText3];
    
    hetongText4 = [[UITextField alloc] initWithFrame:CGRectMake(view2Width*0.3, CGRectGetMaxY(shuoming.frame)+view2Width*0.02+(view2Width*0.1+view2Width*0.02)*3, view2Width*0.6, view2Width*0.1)];
    hetongText4.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"hetong4"];
    hetongText4.tintColor = Color(7, 187, 177);
    hetongText4.textAlignment = NSTextAlignmentRight;
    hetongText4.layer.borderWidth = 0.5;
    hetongText4.layer.borderColor = [coclor CGColor];
    [view2 addSubview:hetongText4];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(view2Width*0.1, view2Width*0.7, view2Width*0.3, view2Width*0.1);
    [queding setTitle:@"取消" forState:UIControlStateNormal];
    UIColor *zhutise = Color(7, 187, 177);
    [queding setBackgroundColor:zhutise];
    [queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:queding];
    
    UIButton *quxiao = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiao.frame = CGRectMake(view2Width*0.6, view2Width*0.7, view2Width*0.3, view2Width*0.1);
    [quxiao setTitle:@"确定" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quxiao setBackgroundColor:zhutise];
    [quxiao addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:quxiao];
}
- (void)queding{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
    [view removeFromSuperview];
    
    [[NSUserDefaults standardUserDefaults] setObject:hetongText1.text forKey:@"hetong1"];
    [[NSUserDefaults standardUserDefaults] setObject:hetongText2.text forKey:@"hetong2"];
    [[NSUserDefaults standardUserDefaults] setObject:hetongText3.text forKey:@"hetong3"];
    [[NSUserDefaults standardUserDefaults] setObject:hetongText4.text forKey:@"hetong4"];
    
    baoxianName = hetongText1.text;
    baoxianPhone = hetongText2.text;
    baoxianAddress = hetongText3.text;
    baoxianYouBian = hetongText4.text;
    
    [yunxu setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1).png"] forState:UIControlStateNormal];
}
- (void)quxiao{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
    [view removeFromSuperview];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hetong1"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hetong2"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hetong3"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hetong4"];
    
    baoxianName = @"";
    baoxianPhone = @"";
    baoxianAddress = @"";
    [yunxu setBackgroundImage:[UIImage imageNamed:@"勾选框(1).png"] forState:UIControlStateNormal];
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

@end
