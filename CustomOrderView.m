//
//  CustomOrderView.m
//  ZuChe
//
//  Created by apple  on 2017/4/19.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "CustomOrderView.h"
#import "Header.h"
#import "CCDatePickerView.h"
#import "DituViewController.h"
#import "TimeSelectView.h"
#import "UIImageView+WebCache.h"
#import "ZCUserData.h"
#import "HttpManager.h"
#import "PayView.h"

#import "YouhuiCell.h"
#import "BKYYouhuiCell.h"
#import "WSStarRatingView.h"

#define PaiSheURL @"http://wx.leisurecarlease.com/api.php?op=api_tjpsindent"

@interface CustomOrderView ()<LXKColorChoiceDelegate3,addressDelgate,UITableViewDelegate,UITableViewDataSource,StarRatingViewDelegate>{
    
    CGFloat width;
    CGFloat height;
    
    UIButton *xuanze;
    UISwitch *kaiguan;
    UITextField *name;
    UITextField *phoneNUM111;
    UILabel *address;
    UILabel *zong;
    UILabel *yu;
    UILabel *ding;
    int price;
    
    UILabel *fanwei1;
    UILabel *kongshi;
    UILabel *youhui;
    int youhuiP;
    int chaoshi1;
    int chaogongli1;
    int kongshi1;
    UITextView *textField;
    
    NSString *youHuiType;

    UITableView *_tableView;
    NSMutableArray *_youhuiArray;
    
    WSStarRatingView *_wsStar;
}
@property (nonatomic , retain)NSArray *kmsArray;
@property (nonatomic , retain)NSArray *timesArray;
@property (nonatomic , strong)TimeSelectView *view1;

@end

@implementation CustomOrderView

- (NSArray *)kmArray{
    
    if (!_kmsArray) {
        
        _kmsArray = @[@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",@"105",@"110",@"115",@"120",@"125",@"130",@"135",@"140",@"145",@"150",@"155",@"160",@"165",@"170",@"175",@"180",@"185",@"190",@"195",@"200",@"205",@"210",@"215",@"220",@"225",@"230",@"235",@"240",@"245",@"250",@"255",@"260",@"265",@"270",@"275",@"280",@"285",@"290",@"295",@"300"];
    }
    return _kmsArray;
}
- (NSArray *)timeArray{
    
    if (!_timesArray) {
        
        _timesArray = @[@"5",@"6",@"7",@"8",@"9",@"10"];
    }
    return _timesArray;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    chaoshi1 = 0;
    chaogongli1 = 0;
    price = 0;
    youhuiP = 0;
    kongshi1 = 0;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];;
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    self.title = @"拍摄订单";
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    [self createView];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createView{
    
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.alwaysBounceVertical   = YES;
    view.userInteractionEnabled = YES;
    view.showsVerticalScrollIndicator = NO;
    view.backgroundColor = Color(237, 237, 237);
    [self.view addSubview:view];
    
    view.contentSize = CGSizeMake(0, width*3.9);
    // 选择日期
    UILabel *riqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.03, width, width*0.08)];
    riqiLabel.text = @"选择日期";
    riqiLabel.textColor = Color(107, 107, 107);
    riqiLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    riqiLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:riqiLabel];
    
    xuanze = [UIButton buttonWithType:UIButtonTypeCustom];
    xuanze.frame = CGRectMake(width/2-width*0.45, CGRectGetMaxY(riqiLabel.frame)+width*0.03, width*0.9, width*0.13);
    [xuanze setBackgroundColor:[UIColor whiteColor]];
    [xuanze setTitle:@"请设置日期" forState:UIControlStateNormal];
    UIColor *zitiColor = Color(127, 127, 127);
    xuanze.layer.cornerRadius = 2.5;
    xuanze.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [xuanze setTitleColor:zitiColor forState:UIControlStateNormal];
    [xuanze addTarget:self action:@selector(xuanzeTime) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:xuanze];
    // 详细信息
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.2, CGRectGetMaxY(xuanze.frame)+width*0.03, width*0.4, width*0.08)];
    detail.text = @"详细信息";
    detail.textColor = Color(108, 108, 108);
    detail.textAlignment = NSTextAlignmentCenter;
    [view addSubview:detail];
    
    UIView *xinxi = [[UIView alloc] initWithFrame:CGRectMake(width/2- width*0.45, CGRectGetMaxY(detail.frame)+width*0.03, width*0.9, width*0.54)];
    xinxi.backgroundColor = [UIColor whiteColor];
    [view addSubview:xinxi];
    
    UILabel *lianxi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, width*0.025, width*0.3, width*0.08)];
    lianxi.text = @"联系人";
    lianxi.textAlignment = NSTextAlignmentLeft;
    lianxi.textColor = Color(157, 157, 157);
    lianxi.font = [UIFont fontWithName:@"ArialMT" size:17];
    [xinxi addSubview:lianxi];
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(width*0.27, width*0.03, width*0.6, width*0.08)];
    name.placeholder = @"姓名";
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
    
    phoneNUM111 = [[UITextField alloc] initWithFrame:CGRectMake(width*0.27, CGRectGetMaxY(name.frame)+width*0.055, width*0.6, width*0.08)];
    phoneNUM111.placeholder = @"手机号";
    phoneNUM111.textColor = Color(77, 77, 77);
    phoneNUM111.keyboardType = UIKeyboardTypeNumberPad;
    [phoneNUM111 setValue:[UIFont fontWithName:@"ArialMT" size:17] forKeyPath:@"_placeholderLabel.font"];
    phoneNUM111.textAlignment = NSTextAlignmentRight;
    [xinxi addSubview:phoneNUM111];
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(phoneNUM111.frame)+width*0.025, width*0.865, 0.5)];
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
    address = [[UILabel alloc] initWithFrame:CGRectMake( width*0.27, CGRectGetMaxY(phoneNUM111.frame)+width*0.055, width*0.6, width*0.08)];
    //    address.backgroundColor = [UIColor redColor];
    address.text = @"预设集合点，可修改一次";
    //    [address sizeToFit];
    //    address.adjustsFontSizeToFitWidth = YES;
    address.tag = 12000;
    //    [address layoutIfNeeded];
    address.font = [UIFont fontWithName:@"ArialMT" size:17];
    address.textColor = Color(187, 187, 187);
    address.textAlignment = NSTextAlignmentRight;
    address.adjustsFontSizeToFitWidth = YES;
    address.userInteractionEnabled = YES;
    [xinxi addSubview:address];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dizhi:)];
    [address addGestureRecognizer:tapGesture];
    
    UILabel *xian3 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(address.frame)+width*0.025, width*0.865, 0.5)];
    xian3.backgroundColor = Color(217, 217, 217);
    [xinxi addSubview:xian3];
    
    UILabel *kongshiLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.035, CGRectGetMaxY(dizhi.frame)+width*0.055, width*0.15, width*0.08)];
    kongshiLabel.text = @"空驶费";
    kongshiLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    kongshiLabel.textAlignment = NSTextAlignmentLeft;
    kongshiLabel.adjustsFontSizeToFitWidth = YES;
    kongshiLabel.textColor = Color(157, 157, 157);
    [xinxi addSubview:kongshiLabel];
    
    UIButton *wenhao = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao.frame = CGRectMake(CGRectGetMaxX(kongshiLabel.frame)+width*0.02, CGRectGetMaxY(dizhi.frame)+width*0.055, width*0.077, width*0.077);
    [wenhao setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao addTarget:self action:@selector(wenhao1) forControlEvents:UIControlEventTouchUpInside];
    [xinxi addSubview:wenhao];
    
    kongshi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.4, CGRectGetMaxY(dizhi.frame)+width*0.055, width*0.47, width*0.08)];
    //    kong.textColor
    kongshi.text = @"将根据地理位置自动设置";
    kongshi.adjustsFontSizeToFitWidth = YES;
    kongshi.textColor = Color(187, 187, 187);
    kongshi.textAlignment = NSTextAlignmentRight;
    kongshi.font = [UIFont fontWithName:@"ArialMT" size:17];
    [xinxi addSubview:kongshi];
    
    // 车辆信息
    UILabel *carInfo = [[UILabel alloc] initWithFrame:CGRectMake(width/2- width*0.2, CGRectGetMaxY(xinxi.frame)+width*0.03, width*0.4, width*0.08)];
    carInfo.text = @"车辆信息";
    carInfo.textAlignment = NSTextAlignmentCenter;
    carInfo.textColor = Color(108, 108, 108);
    [view addSubview:carInfo];
    
    UIView *carInfomation = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(carInfo.frame)+width*0.03, width*0.9, width*0.72)];
    carInfomation.backgroundColor = [UIColor whiteColor];
    carInfomation.userInteractionEnabled = YES;
    [view addSubview:carInfomation];
    
    UILabel *yuCar = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, width*0.3, width*0.08)];
    yuCar.text = @"预定车型";
    yuCar.textColor = Color(157, 157, 157);
    yuCar.textAlignment = NSTextAlignmentLeft;
    yuCar.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfomation addSubview:yuCar];
    
    UILabel *yuding1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.45, width*0.02, width*0.4, width*0.08)];
//    self.carType
    yuding1.text = self.carType;
    yuding1.textColor = Color(127, 127, 127);
    yuding1.textAlignment = NSTextAlignmentRight;
    yuding1.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfomation addSubview:yuding1];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(yuCar.frame)+width*0.02, width*0.8, 1)];
    line1.backgroundColor = Color(237, 237, 237);
    [carInfomation addSubview:line1];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(line1.frame)+width*0.025, width*0.25, width*0.25*2/3)];
    [image sd_setImageWithURL:[NSURL URLWithString:self.carURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [carInfomation addSubview:image];
    
    // 就是在这里少了几个信息
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+width*0.02, CGRectGetMaxY(line1.frame)+width*0.02, width*0.3, width*0.08)];
    NSString *str = [self.userName substringWithRange:NSMakeRange(0, 1)];
    nameLabel.text = [NSString stringWithFormat:@"%@师傅 · %@",str ,self.carPaizhao];
    nameLabel.textColor = Color(87, 87, 87);
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfomation addSubview:nameLabel];
    
//    for (int i = 0; i < 5; i++) {
//        
//        UIImageView *starImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+width*0.02+i*width*0.04, CGRectGetMaxY(nameLabel.frame)+width*0.03, width*0.04, width*0.04)];
//        starImage.image = [UIImage imageNamed:@"五角星.png"];
//        [carInfomation addSubview:starImage];
//    }
    
    
    
    UILabel *level = [[UILabel alloc] initWithFrame:CGRectMake(width*0.55, CGRectGetMaxY(nameLabel.frame)+width*0.015, width*0.1, width*0.08)];
    level.text = @"5.0";
    level.textColor = Color(87, 87, 87);
    level.textAlignment = NSTextAlignmentLeft;
    level.font = [UIFont systemFontOfSize:15];
    [carInfomation addSubview:level];
    
    UILabel *daijiedan = [[UILabel alloc] initWithFrame:CGRectMake(width*0.7, CGRectGetMaxY(line1.frame)+width*0.01, width*0.15, width*0.08)];
    daijiedan.text = @"待接单";
    daijiedan.textColor = Color(7, 187, 177);
    daijiedan.textAlignment = NSTextAlignmentCenter;
    daijiedan.adjustsFontSizeToFitWidth = YES;
    daijiedan.font = [UIFont fontWithName:@"ArialMT" size:16];
    [carInfomation addSubview:daijiedan];
    
    UIButton *jiedianhua = [UIButton buttonWithType:UIButtonTypeCustom];
    jiedianhua.frame = CGRectMake(width*0.725, CGRectGetMaxY(daijiedan.frame)+width*0.01, width*0.1, width*0.1);
    [jiedianhua setBackgroundImage:[UIImage imageNamed:@"电话222.png"] forState:UIControlStateNormal];
    [jiedianhua addTarget:self action:@selector(callCarHost:) forControlEvents:UIControlEventTouchUpInside];
    [carInfomation addSubview:jiedianhua];
    
    // 结束
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(image.frame)+width*0.02, width*0.8, 1)];
    line2.backgroundColor = Color(237, 237, 237);
    [carInfomation addSubview:line2];
    
    UILabel *yanse = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(line2.frame)+width*0.02, width*0.3, width*0.08)];
    yanse.text = @"颜色";
    yanse.textColor = Color(157, 157, 157);
    yanse.textAlignment = NSTextAlignmentLeft;
    yanse.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfomation addSubview:yanse];
    
    UILabel *yanse1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.55, CGRectGetMaxY(line2.frame)+width*0.02, width*0.3, width*0.08)];
    yanse1.text = self.carColor;
    yanse1.textColor = Color(127, 127, 127);
    yanse1.textAlignment = NSTextAlignmentRight;
    yanse1.adjustsFontSizeToFitWidth = YES;
    yanse1.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfomation addSubview:yanse1];
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(yanse.frame)+width*0.02, width*0.8, 1)];
    line3.backgroundColor = Color(237, 237, 237);
    [carInfomation addSubview:line3];
    
    UILabel *fanwei = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(line3.frame)+width*0.02, width*0.2, width*0.08)];
    fanwei.text = @"使用范围";
    fanwei.textColor = Color(157, 157, 157);
    fanwei.textAlignment = NSTextAlignmentLeft;
    fanwei.adjustsFontSizeToFitWidth = YES;
    fanwei.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfomation addSubview:fanwei];
    
    UIButton *wenhao2 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao2.frame = CGRectMake(CGRectGetMaxX(fanwei.frame)+width*0.02, CGRectGetMaxY(yanse.frame)+width*0.04, width*0.08, width*0.08);
    [wenhao2 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao2 addTarget:self action:@selector(wenhao2) forControlEvents:UIControlEventTouchUpInside];
    [carInfomation addSubview:wenhao2];
    
    fanwei1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.5, CGRectGetMaxY(line3.frame)+width*0.02, width*0.35, width*0.08)];
    fanwei1.text = @"天";
    fanwei1.textAlignment = NSTextAlignmentRight;
    fanwei1.textColor = Color(127, 127, 127);
    fanwei1.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfomation addSubview:fanwei1];
    fanwei1.userInteractionEnabled = YES;
    
    chaoshi1 = 5;
    chaogongli1 = 50;
    
    UITapGestureRecognizer *labelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choose)];
    [fanwei1 addGestureRecognizer:labelGesture];
    
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(fanwei.frame)+width*0.02, width*0.8, 1)];
    line4.backgroundColor = Color(237, 237, 237);
    [carInfomation addSubview:line4];
    
    UILabel *chaochu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(line4.frame)+width*0.02, width*0.1, width*0.08)];
    chaochu.text = @"超出";
    chaochu.textColor = Color(157, 157, 157);
    chaochu.textAlignment = NSTextAlignmentLeft;
    chaochu.adjustsFontSizeToFitWidth = YES;
    chaochu.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfomation addSubview:chaochu];
    
    UIButton *wenhao3 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao3.frame = CGRectMake(CGRectGetMaxX(chaochu.frame)+width*0.02, CGRectGetMaxY(fanwei.frame)+width*0.04, width*0.08, width*0.08);
    [wenhao3 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao3 addTarget:self action:@selector(wenhao3) forControlEvents:UIControlEventTouchUpInside];
    [carInfomation addSubview:wenhao3];
    
    UILabel *chaochu1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.65, CGRectGetMaxY(line4.frame)+width*0.02, width*0.2, width*0.08)];
    chaochu1.text = [NSString stringWithFormat:@"%@/%@",self.chao1,self.chao2];
    chaochu1.textColor = Color(127, 127, 127);
    chaochu1.textAlignment = NSTextAlignmentRight;
    chaochu1.font = [UIFont fontWithName:@"ArialMT" size:17];
    [carInfomation addSubview:chaochu1];
    
    // 优惠券
    
    UILabel *youhuiLabel11 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(carInfomation.frame)+width*0.03, width, width*0.08)];
    youhuiLabel11.text = @"优惠券";
    youhuiLabel11.textColor = Color(107, 107, 107);
    youhuiLabel11.textAlignment = NSTextAlignmentCenter;
    youhuiLabel11.font = [UIFont fontWithName:@"ArialMT" size:17];
    youhuiLabel11.adjustsFontSizeToFitWidth = YES;
    [view addSubview:youhuiLabel11];
    
    UIView *youhuiView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(youhuiLabel11.frame)+width*0.05, width*0.9, width*0.12)];
    youhuiView.backgroundColor = [UIColor whiteColor];
    [view addSubview:youhuiView];
    UITapGestureRecognizer *youhuiClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(youhuiClick)];
    [youhuiView addGestureRecognizer:youhuiClick];
    
    UILabel *yhLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, width*0.15, width*0.08)];
    yhLabel.text = @"优惠券";
    yhLabel.textColor = Color(107, 107, 107);
    yhLabel.textAlignment = NSTextAlignmentLeft;
    yhLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    yhLabel.adjustsFontSizeToFitWidth = YES;
    [youhuiView addSubview:yhLabel];
    
    UIButton *wenhao8 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao8.frame = CGRectMake(CGRectGetMaxX(yhLabel.frame), width*0.027, width*0.077, width*0.077);
    [wenhao8 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao8 addTarget:self action:@selector(wenhao8) forControlEvents:UIControlEventTouchUpInside];
    [youhuiView addSubview:wenhao8];
    
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
    UILabel *jiage = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.2, CGRectGetMaxY(youhuiView.frame)+width*0.03, width*0.4, width*0.08)];
    jiage.text = @"价格信息";
    jiage.textAlignment = NSTextAlignmentCenter;
    jiage.textColor = Color(108, 108, 108);
    [view addSubview:jiage];
    
    UIView *jiageInfo = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(jiage.frame)+width*0.03, width*0.9, width*0.5)];
    jiageInfo.backgroundColor = [UIColor whiteColor];
    [view addSubview:jiageInfo];
    
    UILabel *zongjia = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, width*0.1, width*0.08)];
    zongjia.text = @"总价";
    zongjia.textColor = Color(157, 157, 157);
    zongjia.textAlignment = NSTextAlignmentLeft;
    zongjia.adjustsFontSizeToFitWidth = YES;
    zongjia.font = [UIFont fontWithName:@"ArialMT" size:17];
    [jiageInfo addSubview:zongjia];
    
    UIButton *wenhao4 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao4.frame = CGRectMake(CGRectGetMaxX(zongjia.frame)+width*0.02, width*0.02, width*0.08, width*0.08);
    [wenhao4 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao4 addTarget:self action:@selector(wenhao4) forControlEvents:UIControlEventTouchUpInside];
    [jiageInfo addSubview:wenhao4];
    
    zong = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, width*0.02, width*0.25, width*0.08)];
    zong.tag = 10001;
    price = [self.carPrice intValue];
    zong.text = [NSString stringWithFormat:@"¥ %d",price];
    zong.textColor = Color(255, 97, 57);
    zong.textAlignment = NSTextAlignmentRight;
    zong.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    [jiageInfo addSubview:zong];
    
    UILabel *xian11 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(zong.frame)+width*0.02, width*0.8, 1)];
    xian11.backgroundColor = Color(207, 207, 207);
    [jiageInfo addSubview:xian11];
    
    UILabel *dingjin = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xian11.frame)+width*0.02, width*0.1, width*0.08)];
    dingjin.text = @"定金";
    dingjin.textColor = Color(157, 157, 157);
    dingjin.textAlignment = NSTextAlignmentLeft;
    dingjin.adjustsFontSizeToFitWidth = YES;
    dingjin.font = [UIFont fontWithName:@"ArialMT" size:17];
    [jiageInfo addSubview:dingjin];
    
    UIButton *wenhao5 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao5.frame = CGRectMake(CGRectGetMaxX(dingjin.frame)+width*0.02, CGRectGetMaxY(zongjia.frame)+width*0.04, width*0.08, width*0.08);
    [wenhao5 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao5 addTarget:self action:@selector(wenhao5) forControlEvents:UIControlEventTouchUpInside];
    [jiageInfo addSubview:wenhao5];
    
    ding = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, CGRectGetMaxY(xian11.frame)+width*0.02, width*0.25, width*0.08)];
    ding.tag = 10002;
    ding.text = [NSString stringWithFormat:@"¥ %d",price/100/3*100];
    ding.textColor = Color(255, 97, 57);
    ding.textAlignment = NSTextAlignmentRight;
    ding.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    [jiageInfo addSubview:ding];
    
    UILabel *xian22 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(ding.frame)+width*0.02, width*0.8, 1)];
    xian22.backgroundColor = Color(207, 207, 207);
    [jiageInfo addSubview:xian22];
    
    UILabel *youhuiLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xian22.frame)+width*0.02, width*0.1, width*0.08)];
    youhuiLabel.text = @"优惠";
    youhuiLabel.textColor = Color(157, 157, 157);
    youhuiLabel.textAlignment = NSTextAlignmentLeft;
    youhuiLabel.adjustsFontSizeToFitWidth = YES;
    youhuiLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [jiageInfo addSubview:youhuiLabel];
    
    UIButton *wenhao7 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao7.frame = CGRectMake(CGRectGetMaxX(youhuiLabel.frame)+width*0.02, CGRectGetMaxY(xian22.frame)+width*0.027, width*0.077, width*0.077);
    [wenhao7 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao7 addTarget:self action:@selector(wenhao7) forControlEvents:UIControlEventTouchUpInside];
    [jiageInfo addSubview:wenhao7];
    
    youhui = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, CGRectGetMaxY(xian22.frame)+width*0.02, width*0.25, width*0.08)];
    youhui.text = [NSString stringWithFormat:@"¥ %d",youhuiP];
    youhui.textColor = Color(255, 97, 57);
    youhui.textAlignment = NSTextAlignmentRight;
    youhui.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    youhui.adjustsFontSizeToFitWidth = YES;
    [jiageInfo addSubview:youhui];
    
    UILabel *xain33 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(youhuiLabel.frame)+width*0.02, width*0.8, 1)];
    xain33.backgroundColor = Color(207, 207, 207);
    [jiageInfo addSubview:xain33];
    
    UILabel *yukuan = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xain33.frame)+width*0.02, width*0.1, width*0.08)];
    yukuan.text = @"尾款";
    yukuan.textColor = Color(157, 157, 157);
    yukuan.textAlignment = NSTextAlignmentLeft;
    yukuan.adjustsFontSizeToFitWidth = YES;
    yukuan.font = [UIFont fontWithName:@"ArialMT" size:17];
    [jiageInfo addSubview:yukuan];
    
    UIButton *wenhao6 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao6.frame = CGRectMake(CGRectGetMaxX(yukuan.frame)+width*0.02, CGRectGetMaxY(youhuiLabel.frame)+width*0.04, width*0.08, width*0.08);
    [wenhao6 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [wenhao6 addTarget:self action:@selector(wenhao6) forControlEvents:UIControlEventTouchUpInside];
    [jiageInfo addSubview:wenhao6];
    
    yu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.6, CGRectGetMaxY(xain33.frame)+width*0.02, width*0.25, width*0.08)];
    yu.tag = 10003;
    yu.text = [NSString stringWithFormat:@"¥ %d",price-price/100/3*100];
    yu.textColor = Color(255, 97, 57);
    yu.textAlignment = NSTextAlignmentRight;
    yu.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    [jiageInfo addSubview:yu];
    
    UILabel *liuyan = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(jiageInfo.frame)+width*0.04, width*0.9, width*0.08)];
    liuyan.text = @"备注";
    liuyan.font = [UIFont fontWithName:@"ArialMT" size:18];
    liuyan.textAlignment = NSTextAlignmentCenter;
    liuyan.textColor = Color(108, 108, 108);
    [view addSubview:liuyan];
    
    textField = [[UITextView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(liuyan.frame)+width*0.04, width*0.875, width*0.3)];
    textField.tag = 2016;
    textField.userInteractionEnabled = YES;
    textField.backgroundColor = [UIColor whiteColor];
    textField.textColor = Color(157, 157, 157);
    textField.tintColor = Color(7, 187, 177);
    textField.contentInset = UIEdgeInsetsMake(0, width*0.025f, 0, -width*0.025f);
    textField.font = [UIFont fontWithName:@"ArialMT" size:17];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [view addSubview:textField];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.075, CGRectGetMaxY(textField.frame)+width*0.1, width*0.15, width*0.15)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view addSubview:iconImage];
    
    UIButton *tijiao = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiao.frame = CGRectMake(width/2-width*0.3, CGRectGetMaxY(iconImage.frame)+width*0.1, width*0.6, width*0.1);
    [tijiao setTitle:@"提交订单" forState:UIControlStateNormal];
    UIColor *color2 = Color(0, 215, 200);
    [tijiao setBackgroundColor:color2];
    [tijiao setTintColor:[UIColor whiteColor]];
    [tijiao addTarget:self action:@selector(tijiaoINFO) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:tijiao];
}
#pragma mark - 选择时间
- (void)xuanzeTime{
    
    CCDatePickerView *dateView = [[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:dateView];
    
    dateView.blcok = ^(NSDate *dateString){
        
        NSLog(@"年 = %ld  月 = %ld  日 = %ld  时 = %ld  分 = %ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute);
        
        NSString *datestr = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute];
        [xuanze setTitle:datestr forState:UIControlStateNormal];
    };
    dateView.chooseTimeLabel.text = @"选择时间";
    [dateView fadeIn];
}
#pragma mark - 地址选择
- (void)dizhi:(UIButton *)sender{
    
    DituViewController *view = [[DituViewController alloc] init];
    view.delegate = self;
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark - 地址选择完成
- (void)postAddressString:(NSString *)addressString priceTag:(float)priceTag{
    
    address.text = addressString;
    address.textColor = Color(77, 77, 77);
    
    kongshi1 = [self.chao1 intValue] * priceTag;
    kongshi.text = [NSString stringWithFormat:@"¥ %d",kongshi1];
    kongshi.textColor = Color(255, 97, 57);
    
    price = price+kongshi1+youhuiP*chaoshi1+chaogongli1;
    zong.text = [NSString stringWithFormat:@"¥ %d",price];
    ding.text = [NSString stringWithFormat:@"¥ %d",price/10/3*10];
    yu.text = [NSString stringWithFormat:@"¥ %d",price - price/10/3*10];
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
        
        _tableView.scrollEnabled = YES;
        _tableView.tag = 12345;
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
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
    [view removeFromSuperview];
    
    youHuiType = _youhuiArray[indexPath.row][@"name"];
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

#pragma mark - 提交订单
- (void)tijiaoINFO{
    
    NSString *zongjia = [NSString stringWithFormat:@"%d",price];
    NSString *dingjin = [NSString stringWithFormat:@"%d",price/10/3*10];
    NSString *weikuan = [NSString stringWithFormat:@"%d",price - price/10/3*10];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:xuanze.titleLabel.text,@"starttime",[NSString stringWithFormat:@"%d",chaoshi1],@"chaoshi",[NSString stringWithFormat:@"%d",chaogongli1],@"chaogongli",self.carType,@"cartype",[ZCUserData share].userId,@"userid",name.text,@"username",phoneNUM111.text,@"tel",[kongshi.text componentsSeparatedByString:@"¥ "][1],@"kongshifei",zongjia,@"zongjia",dingjin,@"dingjin",weikuan,@"weikuan",[NSString stringWithFormat:@"%d",youhuiP],@"youhui",textField.text,@"beizhu",address.text,@"address",[NSString stringWithFormat:@"%@/%@",self.chao1,self.chao2],@"chaochu",self.carid,@"carid", nil];
    
    [HttpManager postData:dictionary andUrl:PaiSheURL success:^(NSDictionary *fanhuicanshu) {
        
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
#pragma mark - 选择超时超公里界面
- (void)choose{
    
    self.view1 = [TimeSelectView makeViewWithMaskDatePicker3:self.view.window.frame setTitle3:@"选择超时超公里" Arr3:self.timeArray Arr4:self.kmArray];
    self.view1.delegate = self;
}
#pragma mark - 选择超时超公里完成后
- (void)getColorChoiceValues333:(NSString *)values{
    
    fanwei1.text = values;
    
    NSArray *array = [values componentsSeparatedByString:@"小时/"];
    NSString *a = array[0];
    chaoshi1 = [a intValue];
    
    NSString *bcount = array[1];
    NSArray *array2 = [bcount componentsSeparatedByString:@"公里"];
    NSString *b = array2[0];
    chaogongli1 = [b intValue];
    
    price = price - youhuiP + kongshi1 + chaoshi1*[self.chao1 intValue]/2 + chaogongli1*[self.chao2 intValue];
    zong.text = [NSString stringWithFormat:@"¥ %d",price];
    ding.text = [NSString stringWithFormat:@"¥ %d",price/10/3*10];
    yu.text = [NSString stringWithFormat:@"¥ %d",price - price/10/3*10];
}

#pragma mark - 电话
- (void)callCarHost:(UIButton *)sender{
    
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.phoneNUM];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

#pragma mark - 空驶费
- (void)wenhao1{
    
    
}
#pragma mark - 范围说明
- (void)wenhao2{
    
    
}
#pragma mark - 超出范围说明
- (void)wenhao3{
    
    
}
#pragma mark - 总价说明
- (void)wenhao4{
    
    
}
#pragma mark - 定金说明
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
#pragma mark - 优惠 说明
- (void)wenhao7{
    
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
#pragma mark - 优惠券说明
- (void)wenhao8{
    
    
}


- (void)removeAll{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
    [view removeFromSuperview];
}
- (void)cuowuDianji{
    
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
