//
//  ChangzuView.m
//  ZuChe
//
//  Created by apple  on 2017/7/2.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ChangzuView.h"
#import "Header.h"
#import "HttpManager.h"
#import "CCDatePickerView.h"
#import "DituViewController.h"
#import "ZCUserData.h"
#import "PayView.h"

@interface ChangzuView ()<addressDelgate>{
    
    CGFloat width;
    CGFloat height;
    
    UIButton *xuanze;
    UITextField *userName;
    UITextField *phoneNUM;
    UILabel *address1;
    UILabel *cheFanwei;
    UILabel *shuliang;
    UILabel *dPrice;
    UILabel *zPrice;
    UILabel *yPrice;
    
    NSString *time;
}

@end

@implementation ChangzuView

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    self.view.backgroundColor = [UIColor whiteColor];
    time = [[NSString alloc] init];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    titleLabel.text = @"长包订单";
    titleLabel.textColor = Color(77, 77, 77);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    [self createChangbao];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createChangbao{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    scrollView.backgroundColor = Color(237, 237, 237);
    [self.view addSubview:scrollView];
    scrollView.alwaysBounceVertical = NO;
    scrollView.contentSize = CGSizeMake(0, width*3.28);
    
    UILabel *riqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.03, width, width*0.08)];
    riqiLabel.text = @"取车日期";
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
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(phoneNUM.frame)+width*0.025, width*0.865, 0.5)];
    xian2.backgroundColor = Color(217, 217, 217);
    [xinxi addSubview:xian2];
    
    UILabel *dizhi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(typeC.frame)+width*0.055, width*0.3, width*0.08)];
    dizhi.textAlignment = NSTextAlignmentLeft;
    dizhi.text = @"交车地址";
    dizhi.adjustsFontSizeToFitWidth = YES;
    dizhi.font = [UIFont fontWithName:@"ArialMT" size:17];
    dizhi.textColor = Color(157, 157, 157);
    [xinxi addSubview:dizhi];
    
    
    address1 = [[UILabel alloc] initWithFrame:CGRectMake( width*0.27, CGRectGetMaxY(phoneNUM.frame)+width*0.055, width*0.6, width*0.08)];
    address1.text = @"请点击添加";
    address1.tag = 12000;
    address1.adjustsFontSizeToFitWidth = YES;
    address1.font = [UIFont fontWithName:@"ArialMT" size:17];
    address1.textColor = Color(187, 187, 187);
    address1.textAlignment = NSTextAlignmentRight;
    address1.userInteractionEnabled = YES;
    [xinxi addSubview:address1];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dizhi:)];
    [address1 addGestureRecognizer:tapGesture];
    
    UILabel *carInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2- width*0.2, CGRectGetMaxY(xinxi.frame)+width*0.03, width*0.4, width*0.08)];
    carInfoLabel.text = @"车辆信息";
    carInfoLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    carInfoLabel.textAlignment = NSTextAlignmentCenter;
    carInfoLabel.textColor = Color(107, 107, 107);
    [scrollView addSubview:carInfoLabel];
    
    UIView *carInfoMation = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(carInfoLabel.frame)+width*0.03, width*0.9, width*0.65)];
    carInfoMation.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:carInfoMation];
    carInfoMation.userInteractionEnabled = YES;
    
    UILabel *chexingLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, width*0.025, width*0.25, width*0.08)];
    chexingLabel.text = @"车型";
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
    
    UILabel *xian101 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(chexingLabel.frame)+width*0.025, width*0.865, 0.5)];
    xian101.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian101];
    
    UILabel *FanweiLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian101.frame)+width*0.025, width*0.2, width*0.08)];
    FanweiLabel.text = @"限制里程";
    FanweiLabel.textColor = Color(157, 157, 157);
    FanweiLabel.adjustsFontSizeToFitWidth = YES;
    FanweiLabel.textAlignment = NSTextAlignmentLeft;
    FanweiLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:FanweiLabel];
    
    cheFanwei = [[UILabel alloc] initWithFrame:CGRectMake(width*0.265, CGRectGetMaxY(xian101.frame)+width*0.025, width*0.6, width*0.08)];
    cheFanwei.textAlignment = NSTextAlignmentRight;
    cheFanwei.textColor = Color(187, 187, 187);
    cheFanwei.text = @"3000km/月";
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
    cheChaochu.textColor = Color(187, 187, 187);
    cheChaochu.text = [NSString stringWithFormat:@"%@/km",self.chaochu1];
    cheChaochu.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:cheChaochu];
    
    UILabel *xian103 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(ChaochuLabel.frame)+width*0.025, width*0.865, 0.5)];
    xian103.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian103];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian103.frame)+width*0.025, width*0.2, width*0.08)];
    timeLabel.text = @"工作时间";
    timeLabel.textColor = Color(157, 157, 157);
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.adjustsFontSizeToFitWidth = YES;
    timeLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:timeLabel];
    
    UILabel *workTime = [[UILabel alloc] initWithFrame:CGRectMake(width*0.565, CGRectGetMaxY(xian103.frame)+width*0.025, width*0.3, width*0.08)];
    workTime.text = @"10h/日";
    workTime.textAlignment = NSTextAlignmentRight;
    workTime.textColor = Color(187, 187, 187);
    workTime.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:workTime];
    
    UIButton *wenhao5 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao5.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame), CGRectGetMaxY(xian103.frame)+width*0.027, width*0.077, width*0.077);
    wenhao5.tag = 10045;
    [wenhao5 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao5 addTarget:self action:@selector(wenhao5) forControlEvents:UIControlEventTouchUpInside];
    [carInfoMation addSubview:wenhao5];
    
    UILabel *xian104 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(timeLabel.frame)+width*0.025, width*0.865, 0.5)];
    xian104.backgroundColor = Color(217, 217, 217);
    [carInfoMation addSubview:xian104];
    
    UILabel *ChaoChuTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(xian104.frame)+width*0.025, width*0.1, width*0.08)];
    ChaoChuTimeLabel.text = @"超出";
    ChaoChuTimeLabel.textColor = Color(157, 157, 157);
    ChaoChuTimeLabel.textAlignment = NSTextAlignmentLeft;
    ChaoChuTimeLabel.adjustsFontSizeToFitWidth = YES;
    ChaoChuTimeLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:ChaoChuTimeLabel];
    
    UIButton *wenhao6 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao6.frame = CGRectMake(CGRectGetMaxX(ChaochuLabel.frame), CGRectGetMaxY(xian104.frame)+width*0.027, width*0.077, width*0.077);
    wenhao6.tag = 10045;
    [wenhao6 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao6 addTarget:self action:@selector(wenhao6) forControlEvents:UIControlEventTouchUpInside];
    [carInfoMation addSubview:wenhao6];
    
    UILabel *ChaochuTime = [[UILabel alloc] initWithFrame:CGRectMake(width*0.565, CGRectGetMaxY(xian104.frame)+width*0.025, width*0.3, width*0.08)];
    ChaochuTime.textAlignment = NSTextAlignmentRight;
    ChaochuTime.textColor = Color(187, 187, 187);
    ChaochuTime.text = [NSString stringWithFormat:@"%@/h",self.chaochu2];
    ChaochuTime.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfoMation addSubview:ChaochuTime];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(carInfoMation.frame)+width*0.03, width, width*0.08)];
    numLabel.text = @"租期（月）";
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
    
    UILabel *line002 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shuliang.frame)+width*0.02, width*0.02, 0.5, width*0.08)];
    line002.backgroundColor = Color(217, 217, 217);
    [numberView addSubview:line002];
    
    UIButton *jiahao = [UIButton buttonWithType:UIButtonTypeCustom];
    jiahao.frame = CGRectMake(CGRectGetMaxX(line002.frame)+width*0.01, 0, width*0.12, width*0.12);
    [jiahao setBackgroundImage:[UIImage imageNamed:@"加号(1).png"] forState:UIControlStateNormal];
    [jiahao addTarget:self action:@selector(jiahao) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview:jiahao];
    
    UILabel *jiageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numberView.frame)+width*0.05, width, width*0.08)];
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
    zjLabel.text = @"定金";
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
    
    dPrice = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, width*0.025, width*0.25, width*0.08)];
    dPrice.text = [NSString stringWithFormat:@"¥ %d",[self.carprice intValue]/2];
    dPrice.textColor = Color(255, 97, 57);
    dPrice.textAlignment = NSTextAlignmentRight;
    dPrice.font = [UIFont fontWithName:@"Arial-boldMT" size:17];
    dPrice.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:dPrice];
    
    
    UILabel *xianPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(zjLabel.frame)+width*0.025, width*0.8, 0.5)];
    xianPrice1.backgroundColor = Color(217, 217, 217);
    [jiageView addSubview:xianPrice1];
    
    UILabel *djLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xianPrice1.frame)+width*0.025, width*0.2, width*0.08)];
    djLabel.text = @"租金结算";
    djLabel.textColor = Color(157, 157, 157);
    djLabel.textAlignment = NSTextAlignmentLeft;
    djLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    djLabel.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:djLabel];
    
    UILabel *jiesuan = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, CGRectGetMaxY(xianPrice1.frame)+width*0.025, width*0.25, width*0.08)];
    jiesuan.text = @"每月21日";
    jiesuan.textColor = Color(255, 97, 57);
    jiesuan.textAlignment = NSTextAlignmentRight;
    jiesuan.font = [UIFont fontWithName:@"Arial-boldMT" size:17];
    jiesuan.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:jiesuan];
    
    UIButton *wenhao4 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao4.frame = CGRectMake(CGRectGetMaxX(djLabel.frame), CGRectGetMaxY(xianPrice1.frame)+width*0.027, width*0.077, width*0.077);
    [wenhao4 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao4 addTarget:self action:@selector(wenhao4) forControlEvents:UIControlEventTouchUpInside];
    [jiageView addSubview:wenhao4];
    
    UILabel *xianPrice2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(djLabel.frame)+width*0.025, width*0.8, 0.5)];
    xianPrice2.backgroundColor = Color(217, 217, 217);
    [jiageView addSubview:xianPrice2];
    
    UILabel *yhPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xianPrice2.frame)+width*0.025, width*0.25, width*0.08)];
    yhPriceLabel.text = @"租金（月）";
    yhPriceLabel.textColor = Color(157, 157, 157);
    yhPriceLabel.textAlignment = NSTextAlignmentLeft;
    yhPriceLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    yhPriceLabel.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:yhPriceLabel];
    
    zPrice = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, CGRectGetMaxY(xianPrice2.frame)+width*0.025, width*0.25, width*0.08)];
    zPrice.text = [NSString stringWithFormat:@"¥ %@",self.carprice];
    zPrice.textColor = Color(255, 97, 57);
    zPrice.textAlignment = NSTextAlignmentRight;
    zPrice.font = [UIFont fontWithName:@"Arial-boldMT" size:17];
    zPrice.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:zPrice];
    
    
    UILabel *xianPrice3 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(yhPriceLabel.frame)+width*0.025, width*0.8, 0.5)];
    xianPrice3.backgroundColor = Color(217, 217, 217);
    [jiageView addSubview:xianPrice3];
    
    UILabel *wkLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xianPrice3.frame)+width*0.025, width*0.1, width*0.08)];
    wkLabel.text = @"押金";
    wkLabel.textColor = Color(157, 157, 157);
    wkLabel.textAlignment = NSTextAlignmentLeft;
    wkLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    wkLabel.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:wkLabel];
    
    UIButton *wenhao7 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao7.frame = CGRectMake(CGRectGetMaxX(wkLabel.frame), CGRectGetMaxY(xianPrice3.frame)+width*0.027, width*0.077, width*0.077);
    [wenhao7 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao7 addTarget:self action:@selector(wenhao7) forControlEvents:UIControlEventTouchUpInside];
    [jiageView addSubview:wenhao7];
    
    yPrice = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, CGRectGetMaxY(xianPrice3.frame)+width*0.025, width*0.25, width*0.08)];
    yPrice.text = @"¥ 30000";
    yPrice.textColor = Color(255, 97, 57);
    yPrice.textAlignment = NSTextAlignmentRight;
    yPrice.font = [UIFont fontWithName:@"Arial-boldMT" size:17];
    yPrice.adjustsFontSizeToFitWidth = YES;
    [jiageView addSubview:yPrice];
    
    
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
    
    if ([time isEqualToString:@"请设置日期"] || [time isEqualToString:@""]) {
        
        [self createPNMERROR:@"请设置日期"];
    }else if ([userName.text isEqualToString:@"姓名"]|| [userName.text isEqualToString:@""]){
        
        [self createPNMERROR:@"请填写姓名"];
    }else if ([phoneNUM.text isEqualToString:@"手机号"]|| [phoneNUM.text isEqualToString:@""]){
        
        [self createPNMERROR:@"请检查手机号是否正确"];
    }
    else if([address1.text isEqualToString:@"请点击添加"]){
        
        [self createPNMERROR:@"请检查地址是否完整"];
    }
    else{
    
        NSDictionary *dict1 = @{@"userid":[ZCUserData share].userId,@"quchetime":time,@"address":address1.text,@"carid":self.carid,@"username":userName.text,@"tel":phoneNUM.text,@"zujin":self.carprice,@"dingjin":[NSString stringWithFormat:@"%d",[self.carprice intValue]/2],@"zuqi":shuliang.text,@"yajin":@"30000",@"cartype":self.cartype};
        [HttpManager postData:dict1 andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_tjcbindent" success:^(NSDictionary *fanhuicanshu) {
            
//            NSLog(@"fanhuicanshu === %@",fanhuicanshu);
            if ([self.jiedan intValue] == 0) {
                
                self.tabBarController.selectedViewController =  self.tabBarController.childViewControllers[3];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else if ([self.jiedan intValue] == 1){
                
                PayView *view = [[PayView alloc] init];
                
                view.Dingdan = fanhuicanshu[@"orderid"];
                [self.navigationController pushViewController:view animated:YES];
            }
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }
}
#pragma mark - 选择时间
- (void)xuanzeTime{
    
    CCDatePickerView *dateView = [[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view.window addSubview:dateView];
    
    dateView.blcok = ^(NSDate *dateString){
    
//        NSLog(@"年 = %ld  月 = %.2ld  日 = %.2ld  时 = %.2ld  分 = %.2ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute);
        
        NSString *datestr = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,(long)dateString.hour,(long)dateString.minute];
        [xuanze setTitle:datestr forState:UIControlStateNormal];
        UIColor *color = Color(77, 77, 77);
        [xuanze setTitleColor:color forState:UIControlStateNormal];
        time = datestr;
    };
    dateView.chooseTimeLabel.text = @"选择时间";
    [dateView fadeIn];
}
#pragma mark - 地图添加地址
- (void)dizhi:(NSString *)str{
    
    DituViewController *view = [[DituViewController alloc] init];
    view.delegate = self;
    [self.navigationController pushViewController:view animated:YES];
}
- (void)postAddressString:(NSString *)addressString priceTag:(float)priceTag{
    
    address1.text = addressString;
    address1.textColor = Color(77, 77, 77);
}
#pragma mark - 加减号
- (void)jiahao{
    
    int a = [shuliang.text intValue];
    a = a+1;
    shuliang.text = [NSString stringWithFormat:@"%d",a];
}
// 减号
- (void)jianqu{
    
    int a = [shuliang.text intValue];
    a = a-1;
    if (a <= 1) {
        
        a = 1;
    }
    shuliang.text = [NSString stringWithFormat:@"%d",a];
}
#pragma mark - 限制里程
- (void)wenhao1{
    
    
}
#pragma mark - 超出里程计费
- (void)wenhao2{
    
    
}
#pragma mark - 定金说明
- (void)wenhao3{
    
    
}
#pragma mark - 租金结算说明
- (void)wenhao4{
    
    
}
#pragma mark - 工作时间
- (void)wenhao5{
    
    
}
#pragma mark - 超出时间计费
- (void)wenhao6{
    
    
}
#pragma mark - 押金说明
- (void)wenhao7{
    
    
}
#pragma mark - 提交订单提示信息
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
- (void)removeAll{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
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

@end
