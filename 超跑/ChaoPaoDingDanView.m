//
//  ChaoPaoDingDanView.m
//  ZuChe
//
//  Created by apple  on 2017/7/6.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ChaoPaoDingDanView.h"

#import "Header.h"
#import "ZCUserData.h"
#import "HttpManager.h"
#import "CCDatePickerView.h"
#import "ChaoPaoMapController.h"
#import "TimeSelectView.h"
#import "YouhuiCell.h"
#import "BKYYouhuiCell.h"
#import "PayView.h"

@interface ChaoPaoDingDanView ()<DituMapDelegate,LXKColorChoiceDelegate3,UITableViewDelegate,UITableViewDataSource>{
    
    CGFloat width;
    CGFloat height;
    NSMutableArray *_youhuiArray;
    
    UIButton *xuanze;
    
    UITextField *userName;
    UITextField *phoneNUM;
    UILabel *address1;
    UILabel *address2;
    UILabel *kong;
    
    UILabel *cheFanwei;
    UILabel *shuliang;
    
    NSString *time;
    NSString *name;
    NSString *telPhone;
    NSString *startAddress;
    NSString *endAddress;
    NSString *carType;
    NSString *carFanwei1;
    NSString *carFanwei2;
    NSString *carChaochu1;
    NSString *carChaochu2;
    NSString *carNum;
    NSString *carUseType;
    NSString *fuwuTell;
    NSString *zongjia;
    NSString *dingjin;
    NSString *weikuan;
    NSString *youhui;
    int kongshiPrice;
    
    int jia1;
    int jian1;
    UIButton *quanju;
    UITableView *_tableView;
    
    UILabel *zPrice;
    UILabel *dPrice;
    UILabel *wPrice;
    UILabel *yPrice;
    
    int jiage;
    int outPrice1;
    int outPrice2;
    int youhuiJiaGe;
    
    UITextView *fuwuText;
    NSString *youHuiType;
}

@property (nonatomic , strong)TimeSelectView *view3;
@property (nonatomic,retain) NSArray *timesArray;
@property (nonatomic ,retain)NSArray *kmsArray;

@end

@implementation ChaoPaoDingDanView

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
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.tabBarController.tabBar.hidden = YES;
    
    _youhuiArray = [NSMutableArray array];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",@"商务",@"type", nil];
    [HttpManager postData:dic andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_coupon" success:^(NSDictionary *fanhuicanshu) {
        
        _youhuiArray = fanhuicanshu[@"coupon"];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    jia1  = 0;
    jian1 = 0;
    kongshiPrice = 0;
    time = [NSString new];
    carChaochu1 = [NSString new];
    carNum = [NSString new];
    carUseType = [NSString new];
    name = [NSString new];
    telPhone = [NSString new];
    startAddress = [NSString new];
    endAddress = [NSString new];
    carType = [NSString new];
    carFanwei1 = [NSString new];
    carFanwei2 = [NSString new];
    carChaochu1 = [NSString new];
    carChaochu2 = [NSString new];
    carNum = [NSString new];
    carUseType = [NSString new];
    fuwuTell = [NSString new];
    zongjia = [NSString new];
    dingjin = [NSString new];
    weikuan = [NSString new];
    youhui = [NSString new];
    quanju = [UIButton buttonWithType:UIButtonTypeCustom];
    
    jiage = 0;
    outPrice1 = 0;
    outPrice2 = 0;
    youhuiJiaGe = 0;
    youHuiType = [NSString string];
    
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    titleLabel.text = @"超跑订单";
    titleLabel.textColor = Color(77, 77, 77);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    [self createFollowView];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createFollowView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    scrollView.backgroundColor = Color(237, 237, 237);
    [self.view addSubview:scrollView];
    scrollView.alwaysBounceVertical = NO;
    scrollView.contentSize = CGSizeMake(0, width*3.65);
    
    UILabel *riqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.03, width, width*0.08)];
    riqiLabel.text = @"选择日期";
    riqiLabel.textColor = Color(107, 107, 107);
    riqiLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    riqiLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:riqiLabel];
    
    xuanze = [UIButton buttonWithType:UIButtonTypeCustom];
    xuanze.frame = CGRectMake(width/2-width*0.45, CGRectGetMaxY(riqiLabel.frame)+width*0.03, width*0.9, width*0.13);
    [xuanze setBackgroundColor:[UIColor whiteColor]];
    [xuanze setTitle:@"请设置日期" forState:UIControlStateNormal];
    UIColor *zitiColor = Color(127, 127, 127);
    xuanze.layer.cornerRadius = 2.5;
    xuanze.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [xuanze setTitleColor:zitiColor forState:UIControlStateNormal];
    [xuanze addTarget:self action:@selector(xuanzeTime) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:xuanze];
    
    // 详细信息
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(xuanze.frame) + width*0.03, width, width*0.08)];
    detailLabel.text = @"详细信息";
    detailLabel.textColor = Color(107, 107, 107);
    detailLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:detailLabel];
    
    UIView *xinxi = [[UIView alloc] initWithFrame:CGRectMake(width/2- width*0.45, CGRectGetMaxY(detailLabel.frame)+width*0.04, width*0.9, width*0.41)];
    xinxi.backgroundColor = [UIColor whiteColor];
    xinxi.layer.cornerRadius = 2.5;
    xinxi.userInteractionEnabled = YES;
    [scrollView addSubview:xinxi];
    
    UILabel *lianxi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, width*0.025, width*0.3, width*0.08)];
    lianxi.text = @"联系人";
    lianxi.textAlignment = NSTextAlignmentLeft;
    lianxi.textColor = Color(157, 157, 157);
    lianxi.font = [UIFont fontWithName:@"ArialMT" size:17];
    lianxi.adjustsFontSizeToFitWidth = YES;
    [xinxi addSubview:lianxi];
    
    userName = [[UITextField alloc] initWithFrame:CGRectMake(width*0.27, width*0.03, width*0.6, width*0.08)];
    userName.placeholder = @"姓名";
    //    name.backgroundColor = [UIColor redColor];
    [userName setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    userName.font = [UIFont fontWithName:@"ArialMT" size:17];
    userName.textColor = Color(77, 77, 77);
    userName.textAlignment = NSTextAlignmentRight;
    [xinxi addSubview:userName];
    name = userName.text;
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(userName.frame)+width*0.025, width*0.865, 0.5)];
    xian1.backgroundColor = Color(217, 217, 217);
    [xinxi addSubview:xian1];
    
    UILabel *typeC = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(lianxi.frame)+width*0.055, width*0.3, width*0.08)];
    typeC.text = @"联系方式";
    typeC.adjustsFontSizeToFitWidth = YES;
    typeC.font = [UIFont fontWithName:@"ArialMT" size:17];
    typeC.textAlignment = NSTextAlignmentLeft;
    typeC.textColor = Color(157, 157, 157);
    [xinxi addSubview:typeC];
    
    phoneNUM = [[UITextField alloc] initWithFrame:CGRectMake(width*0.27, CGRectGetMaxY(userName.frame)+width*0.055, width*0.6, width*0.08)];
    phoneNUM.placeholder = @"手机号";
    phoneNUM.textColor = Color(77, 77, 77);
    phoneNUM.keyboardType = UIKeyboardTypeNumberPad;
    [phoneNUM setValue:[UIFont fontWithName:@"ArialMT" size:17] forKeyPath:@"_placeholderLabel.font"];
    phoneNUM.textAlignment = NSTextAlignmentRight;
    [xinxi addSubview:phoneNUM];
    telPhone = phoneNUM.text;
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(phoneNUM.frame)+width*0.025, width*0.865, 0.5)];
    xian2.backgroundColor = Color(217, 217, 217);
    [xinxi addSubview:xian2];
    
    UILabel *dizhi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(typeC.frame)+width*0.055, width*0.3, width*0.08)];
    dizhi.textAlignment = NSTextAlignmentLeft;
    dizhi.text = @"集合地址";
    dizhi.adjustsFontSizeToFitWidth = YES;
    dizhi.font = [UIFont fontWithName:@"ArialMT" size:17];
    dizhi.textColor = Color(157, 157, 157);
    [xinxi addSubview:dizhi];
    
    NSLog(@"%f",width*0.6);
    
    address1 = [[UILabel alloc] initWithFrame:CGRectMake( width*0.27, CGRectGetMaxY(phoneNUM.frame)+width*0.055, width*0.6, width*0.08)];
    address1.text = @"请点击添加";
    address1.tag = 12000;
    address1.adjustsFontSizeToFitWidth = YES;
    address1.font = [UIFont fontWithName:@"ArialMT" size:17];
    address1.textColor = Color(187, 187, 187);
    address1.userInteractionEnabled = YES;
    address1.textAlignment = NSTextAlignmentRight;
    address1.userInteractionEnabled = YES;
    [xinxi addSubview:address1];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dizhi:)];
    [address1 addGestureRecognizer:tap1];
    
    // 车辆详情
    UILabel *carInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2- width*0.2, CGRectGetMaxY(xinxi.frame)+width*0.03, width*0.4, width*0.08)];
    carInfoLabel.text = @"车辆信息";
    carInfoLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    carInfoLabel.textAlignment = NSTextAlignmentCenter;
    carInfoLabel.textColor = Color(107, 107, 107);
    [scrollView addSubview:carInfoLabel];
    
    UIView *carInfoMation = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(carInfoLabel.frame)+width*0.03, width*0.9, width*0.39)];
    carInfoMation.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:carInfoMation];
    carInfoMation.userInteractionEnabled = YES;
    
    UILabel *chexingLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, width*0.025, width*0.25, width*0.08)];
    chexingLabel.text = @"车辆信息";
    chexingLabel.textAlignment = NSTextAlignmentLeft;
    chexingLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    chexingLabel.textColor = Color(157, 157, 157);
    [carInfoMation addSubview:chexingLabel];
    
    UILabel *Type = [[UILabel alloc] initWithFrame:CGRectMake(width*0.265, width*0.025, width*0.6, width*0.08)];
    Type.textAlignment = NSTextAlignmentRight;
    Type.textColor = Color(77, 77, 77);
    Type.text = self.cartype;
    //    cartype1 = zhucheCheXing.text;
    Type.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:Type];
    carType = Type.text;
    
    UILabel *xian101 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(chexingLabel.frame)+width*0.025, width*0.865, 0.5)];
    xian101.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian101];
    
    UILabel *FanweiLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian101.frame)+width*0.025, width*0.2, width*0.08)];
    FanweiLabel.text = @"使用范围";
    FanweiLabel.textColor = Color(157, 157, 157);
    FanweiLabel.adjustsFontSizeToFitWidth = YES;
    FanweiLabel.textAlignment = NSTextAlignmentLeft;
    FanweiLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:FanweiLabel];
    
    cheFanwei = [[UILabel alloc] initWithFrame:CGRectMake(width*0.265, CGRectGetMaxY(xian101.frame)+width*0.025, width*0.6, width*0.08)];
    cheFanwei.textAlignment = NSTextAlignmentRight;
    cheFanwei.textColor = Color(77, 77, 77);
    cheFanwei.text = @"1天";
    //    chaoshi1 = zhucheFanwei.text;
    cheFanwei.userInteractionEnabled = YES;
    cheFanwei.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:cheFanwei];
//    UITapGestureRecognizer *fanweiXuanze = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xuanzeFanwei)];
//    [cheFanwei addGestureRecognizer:fanweiXuanze];
    
    UIButton *wenhao1 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao1.frame = CGRectMake(CGRectGetMaxX(FanweiLabel.frame), CGRectGetMaxY(xian101.frame)+width*0.027, width*0.077, width*0.077);
    [wenhao1 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao1 addTarget:self action:@selector(wenhao1) forControlEvents:UIControlEventTouchUpInside];
    [carInfoMation addSubview:wenhao1];
    
//    UIButton *youJinatou2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    youJinatou2.frame = CGRectMake(width*0.835, CGRectGetMaxY(xian101.frame)+width*0.045, width*0.04, width*0.04);
//    [youJinatou2 setBackgroundImage:[UIImage imageNamed:@"右居中.png"] forState:UIControlStateNormal];
//    [carInfoMation addSubview:youJinatou2];
    
    UILabel *xian102 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(FanweiLabel.frame)+width*0.025, width*0.865, 0.5)];
    xian102.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian102];
    
    UILabel *ChaochuLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian102.frame)+width*0.025, width*0.1, width*0.08)];
    ChaochuLabel.text = @"超出";
    ChaochuLabel.textColor = Color(157, 157, 157);
    ChaochuLabel.textAlignment = NSTextAlignmentLeft;
    ChaochuLabel.adjustsFontSizeToFitWidth = YES;
    ChaochuLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:ChaochuLabel];
    
    UIButton *wenhao2 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao2.frame = CGRectMake(CGRectGetMaxX(ChaochuLabel.frame), CGRectGetMaxY(xian102.frame)+width*0.027, width*0.077, width*0.077);
    wenhao2.tag = 10045;
    [wenhao2 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao2 addTarget:self action:@selector(wenhao2) forControlEvents:UIControlEventTouchUpInside];
    [carInfoMation addSubview:wenhao2];
    
    UILabel *cheChaochu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.565, CGRectGetMaxY(xian102.frame)+width*0.025, width*0.3, width*0.08)];
    cheChaochu.textAlignment = NSTextAlignmentRight;
    cheChaochu.textColor = Color(77, 77, 77);
    cheChaochu.text = [NSString stringWithFormat:@"%@",self.outPrice];
    cheChaochu.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:cheChaochu];
    
    carChaochu1 = cheChaochu.text;
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(carInfoMation.frame)+width*0.03, width, width*0.08)];
    numLabel.text = @"数量";
    numLabel.textColor = Color(107, 107, 107);
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    numLabel.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:numLabel];
    
    UIView *numberView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(numLabel.frame)+width*0.03, width*0.9, width*0.12)];
    numberView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:numberView];
    numberView.userInteractionEnabled = YES;
    
    UIButton *jianhao = [UIButton buttonWithType:UIButtonTypeCustom];
    jianhao.frame = CGRectMake(width*0.01, 0, width*0.12, width*0.12);
    [jianhao setBackgroundImage:[UIImage imageNamed:@"减号(1).png"] forState:UIControlStateNormal];
    [jianhao addTarget:self action:@selector(jianqu) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview:jianhao];
    
    UILabel *line001 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jianhao.frame)+width*0.01, width*0.02, 0.5, width*0.08)];
    line001.backgroundColor = Color(217, 217, 217);
    [numberView addSubview:line001];
    
    shuliang = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line001.frame)+width*0.02, 0, width*0.58, width*0.12)];
    shuliang.text = @"1";
    shuliang.textColor = Color(7, 187, 177);
    shuliang.textAlignment = NSTextAlignmentCenter;
    shuliang.font = [UIFont fontWithName:@"ArialMT" size:17];
    [numberView addSubview:shuliang];
    carNum = shuliang.text;
    
    UILabel *line002 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shuliang.frame)+width*0.02, width*0.02, 0.5, width*0.08)];
    line002.backgroundColor = Color(217, 217, 217);
    [numberView addSubview:line002];
    
    UIButton *jiahao = [UIButton buttonWithType:UIButtonTypeCustom];
    jiahao.frame = CGRectMake(CGRectGetMaxX(line002.frame)+width*0.01, 0, width*0.12, width*0.12);
    [jiahao setBackgroundImage:[UIImage imageNamed:@"加号(1).png"] forState:UIControlStateNormal];
    [jiahao addTarget:self action:@selector(jiahao) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview:jiahao];
    
    
    UILabel *fuwuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numberView.frame)+width*0.03, width, width*0.08)];
    fuwuLabel.text = @"备注";
    fuwuLabel.textColor = Color(107, 107, 107);
    fuwuLabel.textAlignment = NSTextAlignmentCenter;
    fuwuLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    fuwuLabel.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:fuwuLabel];
    
    fuwuText = [[UITextView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(fuwuLabel.frame)+width*0.03, width*0.9, width*0.3)];
    fuwuText.backgroundColor = [UIColor whiteColor];
    fuwuText.tintColor = Color(7, 187, 177);
    fuwuText.textColor = Color(77, 77, 77);
    [scrollView addSubview:fuwuText];
    
    UILabel *youhuiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fuwuText.frame)+width*0.03, width, width*0.08)];
    youhuiLabel.text = @"优惠券";
    youhuiLabel.textColor = Color(107, 107, 107);
    youhuiLabel.textAlignment = NSTextAlignmentCenter;
    youhuiLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    youhuiLabel.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:youhuiLabel];
    
    UIView *youhuiView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(youhuiLabel.frame)+width*0.05, width*0.9, width*0.12)];
    youhuiView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:youhuiView];
    UITapGestureRecognizer *youhuiClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(youhuiClick)];
    [youhuiView addGestureRecognizer:youhuiClick];
    
    UILabel *yhLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, width*0.15, width*0.08)];
    yhLabel.text = @"优惠券";
    yhLabel.textColor = Color(107, 107, 107);
    yhLabel.textAlignment = NSTextAlignmentLeft;
    yhLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    yhLabel.adjustsFontSizeToFitWidth = YES;
    [youhuiView addSubview:yhLabel];
    
    UIButton *wenhao6 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao6.frame = CGRectMake(CGRectGetMaxX(yhLabel.frame), width*0.027, width*0.077, width*0.077);
    [wenhao6 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao6 addTarget:self action:@selector(wenhao6) forControlEvents:UIControlEventTouchUpInside];
    [youhuiView addSubview:wenhao6];
    
    UILabel *youhuiPrice = [[UILabel alloc] initWithFrame:CGRectMake(width*0.58, width*0.02, width*0.25, width*0.08)];
    youhuiPrice.text = @"0张";
    youhuiPrice.textColor = Color(7, 187, 177);
    youhuiPrice.textAlignment = NSTextAlignmentRight;
    youhuiPrice.font = [UIFont fontWithName:@"ArialMT" size:17];
    youhuiPrice.adjustsFontSizeToFitWidth = YES;
    [youhuiView addSubview:youhuiPrice];
    
    UIImageView *youjiantou3 = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.835, width*0.04, width*0.04, width*0.04)];
    youjiantou3.image = [UIImage imageNamed:@"右居中.png"];
    [youhuiView addSubview:youjiantou3];
    // 价格信息
    UILabel *jiageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(youhuiView.frame)+width*0.05, width, width*0.08)];
    jiageLabel.text = @"价格信息";
    jiageLabel.textColor = Color(107, 107, 107);
    jiageLabel.textAlignment = NSTextAlignmentCenter;
    jiageLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    jiageLabel.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:jiageLabel];
    
    UIView *jiageView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(jiageLabel.frame)+width*0.03, width*0.9, width*0.52)];
    jiageView.backgroundColor = [UIColor whiteColor];;
    [scrollView addSubview:jiageView];
    
    UILabel *zjLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, width*0.1, width*0.08)];
    zjLabel.text = @"总价";
    zjLabel.textColor = Color(157, 157, 157);
    zjLabel.textAlignment = NSTextAlignmentLeft;
    zjLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    zjLabel.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:zjLabel];
    
    UIButton *wenhao3 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao3.frame = CGRectMake(CGRectGetMaxX(zjLabel.frame), width*0.027, width*0.077, width*0.077);
    [wenhao3 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao3 addTarget:self action:@selector(wenhao3) forControlEvents:UIControlEventTouchUpInside];
    [jiageView addSubview:wenhao3];
    
    zPrice = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, width*0.025, width*0.25, width*0.08)];
    zPrice.text = [NSString stringWithFormat:@"¥ %@",self.price];
    zPrice.textColor = Color(255, 97, 57);
    zPrice.textAlignment = NSTextAlignmentRight;
    zPrice.font = [UIFont fontWithName:@"Arial-boldMT" size:17];
    zPrice.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:zPrice];
    
    jiage = [self.price intValue];
    
    zongjia = zPrice.text;
    
    UILabel *xianPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(zjLabel.frame)+width*0.025, width*0.8, 0.5)];
    xianPrice1.backgroundColor = Color(217, 217, 217);
    [jiageView addSubview:xianPrice1];
    
    UILabel *djLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xianPrice1.frame)+width*0.025, width*0.1, width*0.08)];
    djLabel.text = @"定金";
    djLabel.textColor = Color(157, 157, 157);
    djLabel.textAlignment = NSTextAlignmentLeft;
    djLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    djLabel.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:djLabel];
    
    dPrice = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, CGRectGetMaxY(xianPrice1.frame)+width*0.025, width*0.25, width*0.08)];
    dPrice.text = [NSString stringWithFormat:@"¥ %d",jiage/100/3*100];
    dPrice.textColor = Color(255, 97, 57);
    dPrice.textAlignment = NSTextAlignmentRight;
    dPrice.font = [UIFont fontWithName:@"Arial-boldMT" size:17];
    dPrice.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:dPrice];
    
    dingjin = dPrice.text;
    
    UIButton *wenhao4 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao4.frame = CGRectMake(CGRectGetMaxX(djLabel.frame), CGRectGetMaxY(xianPrice1.frame)+width*0.027, width*0.077, width*0.077);
    [wenhao4 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao4 addTarget:self action:@selector(wenhao4) forControlEvents:UIControlEventTouchUpInside];
    [jiageView addSubview:wenhao4];
    
    UILabel *xianPrice2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(djLabel.frame)+width*0.025, width*0.8, 0.5)];
    xianPrice2.backgroundColor = Color(217, 217, 217);
    [jiageView addSubview:xianPrice2];
    
    UILabel *yhPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xianPrice2.frame)+width*0.025, width*0.1, width*0.08)];
    yhPriceLabel.text = @"优惠";
    yhPriceLabel.textColor = Color(157, 157, 157);
    yhPriceLabel.textAlignment = NSTextAlignmentLeft;
    yhPriceLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    yhPriceLabel.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:yhPriceLabel];
    
    UIButton *wenhao8 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao8.frame = CGRectMake(CGRectGetMaxX(yhPriceLabel.frame), CGRectGetMaxY(xianPrice2.frame)+width*0.027, width*0.077, width*0.077);
    [wenhao8 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao8 addTarget:self action:@selector(wenhao8) forControlEvents:UIControlEventTouchUpInside];
    [jiageView addSubview:wenhao8];
    
    yPrice = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, CGRectGetMaxY(xianPrice2.frame)+width*0.025, width*0.25, width*0.08)];
    yPrice.text = @"¥ 0";
    yPrice.textColor = Color(255, 97, 57);
    yPrice.textAlignment = NSTextAlignmentRight;
    yPrice.font = [UIFont fontWithName:@"Arial-boldMT" size:17];
    yPrice.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:yPrice];
    
    youhui = yPrice.text;
    
    UILabel *xianPrice3 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(yhPriceLabel.frame)+width*0.025, width*0.8, 0.5)];
    xianPrice3.backgroundColor = Color(217, 217, 217);
    [jiageView addSubview:xianPrice3];
    
    UILabel *wkLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xianPrice3.frame)+width*0.025, width*0.1, width*0.08)];
    wkLabel.text = @"尾款";
    wkLabel.textColor = Color(157, 157, 157);
    wkLabel.textAlignment = NSTextAlignmentLeft;
    wkLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    wkLabel.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:wkLabel];
    
    UIButton *wenhao5 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao5.frame = CGRectMake(CGRectGetMaxX(wkLabel.frame), CGRectGetMaxY(xianPrice3.frame)+width*0.027, width*0.077, width*0.077);
    [wenhao5 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao5 addTarget:self action:@selector(wenhao5) forControlEvents:UIControlEventTouchUpInside];
    [jiageView addSubview:wenhao5];
    
    wPrice = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, CGRectGetMaxY(xianPrice3.frame)+width*0.025, width*0.25, width*0.08)];
    wPrice.text = [NSString stringWithFormat:@"¥ %d",jiage - jiage/100/3*100];
    wPrice.textColor = Color(255, 97, 57);
    wPrice.textAlignment = NSTextAlignmentRight;
    wPrice.font = [UIFont fontWithName:@"Arial-boldMT" size:17];
    wPrice.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:wPrice];
    
    weikuan = wPrice.text;
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.075, CGRectGetMaxY(jiageView.frame)+width*0.1, width*0.15, width*0.15)];
    logo.image = [UIImage imageNamed:@"logo浅.png"];
    [scrollView addSubview:logo];
    
    UIButton *tijaio = [UIButton buttonWithType:UIButtonTypeCustom];
    tijaio.frame = CGRectMake(width*0.2, CGRectGetMaxY(logo.frame)+width*0.1, width*0.6, width*0.1);
    tijaio.backgroundColor = Color(7, 187, 177);
    [tijaio setTitle:@"提交订单" forState:UIControlStateNormal];
    [tijaio addTarget:self action:@selector(tijiaoINFO) forControlEvents:UIControlEventTouchUpInside];
    [tijaio setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scrollView addSubview:tijaio];
}
#pragma mark - 提交订单
- (void)tijiaoINFO{
    
    if ([time isEqualToString:@"请设置日期"]) {
        
        [self createPNMERROR:@"请设置日期"];
    }else if ([userName.text isEqualToString:@"姓名"]|| [userName.text isEqualToString:@""]){
        
        [self createPNMERROR:@"请填写姓名"];
    }else if ([phoneNUM.text isEqualToString:@"手机号"]|| [phoneNUM.text isEqualToString:@""] || phoneNUM.text.length != 11){
        
        [self createPNMERROR:@"请检查手机号是否正确"];
    }
    else if([address1.text isEqualToString:@"请点击添加"] || [address2.text isEqualToString:@"请点击添加"]){
        
        [self createPNMERROR:@"请检查地址是否完整"];
    }else{
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:time,@"starttime",shuliang.text,@"carnum",carType,@"cartype",[ZCUserData share].userId,@"userid",phoneNUM.text,@"tel",userName.text,@"username",[zPrice.text componentsSeparatedByString:@" "][1],@"zongjia",[dPrice.text componentsSeparatedByString:@" "][1],@"dingjin",[wPrice.text componentsSeparatedByString:@" "][1],@"weikuan",[yPrice.text componentsSeparatedByString:@" "][1],@"youhui",self.fangshi,@"yongtu",fuwuText.text,@"beizhu",address1.text,@"startaddress", nil];
        
        [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_tjcpindent" success:^(NSDictionary *fanhuicanshu) {
            
            PayView *view = [[PayView alloc] init];
            
            view.Dingdan = fanhuicanshu[@"orderid"];
            view.jiage = [yPrice.text componentsSeparatedByString:@" "][1];
            
            [self.navigationController pushViewController:view animated:YES];
            
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }
}
#pragma mark - 选择日期
- (void)xuanzeTime{
    
    CCDatePickerView *dateView = [[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view.window addSubview:dateView];
    
    dateView.blcok = ^(NSDate *dateString){
        
        NSLog(@"年 = %ld  月 = %.2ld  日 = %.2ld  时 = %.2ld  分 = %.2ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute);
        
        NSString *datestr = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,(long)dateString.hour,(long)dateString.minute];
        [xuanze setTitle:datestr forState:UIControlStateNormal];
        UIColor *color = Color(77, 77, 77);
        [xuanze setTitleColor:color forState:UIControlStateNormal];
        time = datestr;
    };
    dateView.chooseTimeLabel.text = @"选择时间";
    [dateView fadeIn];
}
#pragma mark - 地图选择地址
- (void)dizhi:(NSString *)str{
    
    ChaoPaoMapController *view = [[ChaoPaoMapController alloc] init];
    view.delegate = self;
    [self.navigationController pushViewController:view animated:YES];
}
- (void)dituSendMessage:(NSString *)sender{
    
    if ([self.fangshi isEqualToString:@"jie"]) {
        
        address2.text = [NSString stringWithFormat:@"%@",[sender componentsSeparatedByString:@"/"][0]];
        address2.textColor = Color(77, 77, 77);
    }else{
        
        address1.text = [NSString stringWithFormat:@"%@",[sender componentsSeparatedByString:@"/"][0]];
        address1.textColor = Color(77, 77, 77);
    }
}
#pragma mark - 加减号
- (void)jiahao{
    
    
    int a = [shuliang.text intValue];
    a = a+1;
    shuliang.text = [NSString stringWithFormat:@"%d",a];
    
    jiage = [self.price intValue]*a;
    
    zPrice.text = [NSString stringWithFormat:@"¥ %d",jiage];
    dPrice.text = [NSString stringWithFormat:@"¥ %d",jiage/100/3*100];
    wPrice.text = [NSString stringWithFormat:@"¥ %d",jiage - jiage/100/3*100];
}
// 减号
- (void)jianqu{
    
    int a = [shuliang.text intValue];
    a = a-1;
    if (a <= 1) {
        
        a = 1;
    }
    shuliang.text = [NSString stringWithFormat:@"%d",a];
    jiage = a * [self.price intValue];
    
    zPrice.text = [NSString stringWithFormat:@"¥ %d",jiage];
    dPrice.text = [NSString stringWithFormat:@"¥ %d",jiage/100/3*100];
    wPrice.text = [NSString stringWithFormat:@"¥ %d",jiage - jiage/100/3*100];
}
#pragma mark - 使用类型
- (void)buttonClick:(UIButton *)button{
    
    carUseType = button.titleLabel.text;
    UIColor *pinkColor = Color(234, 68, 115);
    [button setTitleColor:pinkColor forState:UIControlStateNormal];
    button.layer.borderColor = [pinkColor CGColor];
    if (quanju != button) {
        
        UIColor *itemColor = Color(7, 187, 177);
        [quanju setTitleColor:itemColor forState:UIControlStateNormal];
        quanju.layer.borderColor = [[UIColor whiteColor] CGColor];
    }
    quanju = button;
    NSLog(@"str === %@",carUseType);
}

#pragma mark - 超出范围
- (void)xuanzeFanwei{
    
    self.view3 = [TimeSelectView makeViewWithMaskDatePicker3:self.view.window.frame setTitle3:@"选择超时超公里" Arr3:self.timeArray Arr4:self.kmArray];
    self.view3.delegate = self;
}
- (void)getColorChoiceValues333:(NSString *)values{
    
    if ([values isEqualToString:@""]||values == nil) {
        
        cheFanwei.text = @"5小时/50公里";
    }else{
        
        cheFanwei.text = values;
    }
    
    carFanwei1 = values;
}

#pragma mark - 优惠券点击
- (void)youhuiClick{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.2, width*0.9, width*0.99)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.center = self.view.window.center;
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
    
    UILabel *youhuiquan = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, view2.frame.size.width*0.04, view2.frame.size.width*0.9, width*0.1)];
    youhuiquan.textColor = Color(107, 107, 107);
    youhuiquan.textAlignment = NSTextAlignmentCenter;
    youhuiquan.text = @"优惠券";
    youhuiquan.font = [UIFont systemFontOfSize:20];
    [view2 addSubview:youhuiquan];
    
    
    int x = [shuliang.text intValue];
    
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
        
        //        _tableView.cellLayoutMarginsFollowReadableWidth = NO;
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
        
        if ([shuliang.text intValue] >= 4) {
            
            //            youhuiLabel.text = [NSString stringWithFormat:@"- %@",_youhuiArray[indexPath.row][@"total"]];
            //            jianqu.text = [NSString stringWithFormat:@"(已减去%@)",_youhuiArray[indexPath.row][@"total"]];
            //
            //            youhuiP = [_youhuiArray[indexPath.row][@"total"] intValue];
            //            yesOrNO = 1;
            //            //    NSString *a = [zong.text componentsSeparatedByString:@"¥"][1];
            //            int b = price + price2*aCount + price3*bCount+ (dCount+dCount2)*bCount+(cCount+cCount2)*aCount;
            //            int c = b/100/3*100;
            //            int d = b - c - youhuiP;
            //            zong.text = [NSString stringWithFormat:@"¥%d",b];
            //            ding.text = [NSString stringWithFormat:@"¥%d",c];
            //            yu.text = [NSString stringWithFormat:@"¥%d",d];
            //            youhuiPrice.text = [NSString stringWithFormat:@"¥%d",youhuiP];
            //
            //            youhuiNumber = _youhuiArray[indexPath.row][@"number"];
            
            youHuiType = _youhuiArray[indexPath.row][@"name"];
        }else{
            
            //            youhuiLabel.text = @"";
            //            jianqu.text = @"";
            //            youhuiP = 0;
            //            yesOrNO = 0;
            //
            //            int b = price + price2*aCount + price3*bCount+ (dCount+dCount2)*bCount+(cCount+cCount2)*aCount;
            //            int c = b/100/3*100;
            //            int d = b - c;
            //            zong.text = [NSString stringWithFormat:@"¥%d",b];
            //            ding.text = [NSString stringWithFormat:@"¥%d",c];
            //            yu.text = [NSString stringWithFormat:@"¥%d",d];
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
    
    UILabel *youhuiquan = [[UILabel alloc] initWithFrame:CGRectMake(headVCiew.frame.size.width*0.02, headVCiew.frame.size.width*0.04, headVCiew.frame.size.width*0.85, width*0.1)];
    youhuiquan.textColor = Color(107, 107, 107);
    youhuiquan.textAlignment = NSTextAlignmentCenter;
    youhuiquan.text = @"优惠券";
    youhuiquan.font = [UIFont systemFontOfSize:20];
    [headVCiew addSubview:youhuiquan];
    
    return headVCiew;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return width*0.14;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, width*0.12)];
    footView.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *youhuiPrice = [[UIImageView alloc] initWithFrame:CGRectMake(footView.frame.size.width/2-footView.frame.size.width*0.125, CGRectGetMaxY(footView.frame)+footView.frame.size.width*0.1, footView.frame.size.width*0.15, footView.frame.size.width*0.15)];
    youhuiPrice.image = [UIImage imageNamed:@"logo浅.png"];
    [footView addSubview:youhuiPrice];
    
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return width*0.12;
}
- (void)cuowuDianji{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
    [view removeFromSuperview];
}
#pragma mark - 范围问号 说明
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
    image.image = [UIImage imageNamed:@"超跑说明图.png"];
    [view2 addSubview:image];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
}
#pragma mark - 超出的价格 说明
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
    
    NSString *string = [[NSString alloc] init];
    
    NSArray *array = @[@"超出8小时80公里收费标准;",@"时间与公里叠加计费;",@"不足一小时按一小时计费;",@"超出费用与驾驶员现场结算;"];
    
    for (int i = 0; i < 4; i++) {
        
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
- (void)wenhao3{
    
    
}
#pragma mark - 定金说明
- (void)wenhao4{
    
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
- (void)wenhao5{
    
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
#pragma mark - 优惠券说明
- (void)wenhao6{
    
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
#pragma mark - 优惠券后边问号
- (void)wenhao8{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.4, width*0.9, width*0.64)];
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
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(cuowu.frame), view2.frame.size.width*0.9, width*0.15)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = Color(77, 77, 77);
    label1.text = @"优惠名称";
    label1.font = [UIFont boldSystemFontOfSize:20];
    [view2 addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label1.frame)+view2.frame.size.width*0.05, view2.frame.size.width*0.9, width*0.15)];
    label2.textAlignment = NSTextAlignmentCenter;
    
    if([youHuiType isKindOfClass:[NSNull class]]) {
        
        label2.text = @"暂无优惠";
    }else{
        label2.text = youHuiType;
    }
    
    label2.font = [UIFont boldSystemFontOfSize:20];
    label2.textColor = Color(255, 97, 57);
    [view2 addSubview:label2];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
}

- (void)removeAll{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
    [view removeFromSuperview];
}
- (void)createPNMERROR:(NSString *)str{
    
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
