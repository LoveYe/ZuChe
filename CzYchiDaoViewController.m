//
//  XiangqingController.m
//  ZuChe
//
//  Created by apple  on 16/12/21.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "CzYchiDaoViewController.h"
#import "Header.h"
#import "HttpManager.h"

#import "ZCUserData.h"

#import <AdSupport/ASIdentifierManager.h>


#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "CZCountDownView.h"
#import "MBSliderView.h"
#import "JiHeAddressViewController.h"
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height


//#import "WSStarRatingView.h"

#define PATH_URLPOST @"http://wx.leisurecarlease.com/api.php?op=api_xcxqjxz"

@interface CzYchiDaoViewController()<UIAlertViewDelegate,MAMapViewDelegate,AMapLocationManagerDelegate,MBSliderViewDelegate>{
    
    CGFloat width;
    
    UIScrollView *_scrollerView;
    
    CGFloat _scrollerContenHeight;
    
    NSMutableArray *_dataArray;
    
    NSMutableDictionary *_detailsDict;
    
    UIView *_bigView;
    
    UILabel *_dizhi;
    
    UIView *_lianxiView;
    
    CZCountDownView *_countDown;
    
    UIRefreshControl *refreshControl;
}
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapLocationManager *locationManager;

@property (nonatomic,retain) NSArray *timesArray;
@property (nonatomic ,retain)NSArray *kmsArray;
@property(nonatomic,strong)MBSliderView *MBSlider;
@end

@implementation CzYchiDaoViewController




- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    [_countDown.timer invalidate];
    _countDown.timer = nil;
    [self initArrayData];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;
    [_countDown.timer invalidate];
    _countDown.timer = nil;
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
    _dataArray = [NSMutableArray new];
    _detailsDict = [NSMutableDictionary new];
    self.view.backgroundColor = [UIColor whiteColor];
    width = self.view.frame.size.width;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    label.text = @"已迟到";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    label.textColor = [UIColor redColor];
    self.navigationItem.titleView = label;
    
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(gobackTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    
    
    UIButton *touSu = [UIButton buttonWithType:UIButtonTypeCustom];
    touSu.frame = CGRectMake(0, 0, 25, 25);
    touSu.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    [touSu setTitle:@"hi" forState:UIControlStateNormal];
    [touSu setTitleColor:[UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
    touSu.layer.borderColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1].CGColor;
    touSu.layer.borderWidth = 1;
    touSu.layer.cornerRadius = 12.5;
    [touSu addTarget:self action:@selector(tousu:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:touSu];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    
}

// 下拉刷新触发，在此获取数据
-(void)refreshClick1:(UIRefreshControl *)refreshContro {
    NSLog(@"refreshClick: -- 刷新触发");
    
    [refreshContro endRefreshing];
    [_scrollerView reloadInputViews];
    
    // 此处添加刷新tableView数据的代码
    // [self initArrayData];
}

- (void)gobackTo{
    
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)tousu:(UIButton *)tsButton {
    NSLog(@"投诉");
    
    [self AlertView];
}
//投诉未开始
- (void)AlertView{
    
    _bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    _bigView.tag = 1000;
    [self.view.window addSubview:_bigView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight/2- ScreenWidth*0.3/2, ScreenWidth*0.8, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [_bigView addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame)*0.9, CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"订单未匹配，匹配后开启投诉";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.7, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.8, ScreenWidth*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
-(void)moveAll {
    
    [_bigView removeFromSuperview];
}

//网络请求数据
-(void)initArrayData {
    
    
    NSDictionary *dicr = @{@"id":_postIdString,@"userid": [ZCUserData share].userId};
    
    [HttpManager postData:dicr andUrl:PATH_URLPOST success:^(NSDictionary *fanhuicanshu) {
        
        [_detailsDict removeAllObjects];
        [_detailsDict addEntriesFromDictionary:fanhuicanshu];
        
        NSLog(@"%@",_detailsDict);
        
        [self creatfirstView];
        [self creatzfdjthirdView];
        //  [self creatzfdjthirdView];
        [self creatzfdjfourView];
        
        _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
        // [refreshControl endRefreshing];
        
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"%@<<<<<<<<<<<<",cuowuxingxi);
        //  [refreshControl endRefreshing];
    }];
    
}

//总体的底部界面
-(void)creatScrollerView {
    _scrollerContenHeight = 0;
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _scrollerView.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:_scrollerView];
    
    
    _scrollerView.contentOffset = CGPointMake(0, 0);
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick1:) forControlEvents:UIControlEventValueChanged];
    [_scrollerView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick1:refreshControl];
    
}
//第一个界面
-(void)creatfirstView {
    
    [self creatScrollerView];
    
    UIView *fisrView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, 0.9*width, 1.145*width)];
    // fisrView.backgroundColor = [UIColor yellowColor];
    _scrollerContenHeight += 1.145*width;
    [_scrollerView addSubview:fisrView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.9*width, 1)];
    topView.backgroundColor = Color(233, 233, 233);
    [fisrView addSubview:topView];
    UILabel *label02 = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.04, width*0.15, width*0.1)];
    label02.text = @"日期";
    label02.textColor = Color(87, 87, 87);
    // label02.backgroundColor = [UIColor redColor];
    label02.adjustsFontSizeToFitWidth = YES;
    label02.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [fisrView addSubview:label02];
    
    UILabel *zhou = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), width*0.035, fisrView.frame.size.width*0.5-0.05*width, width*0.08)];
    zhou.text = [NSString stringWithFormat:@"%@,%@",_detailsDict[@"xcxq"][@"zhou"],_detailsDict[@"xcxq"][@"yueri"]];
    zhou.textColor = Color(140, 140, 140);
    zhou.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    zhou.textAlignment = NSTextAlignmentRight;
    [fisrView addSubview:zhou];
    
    UILabel *lainxi = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), CGRectGetMaxY(zhou.frame), fisrView.frame.size.width*0.5-0.05*width, width*0.05)];
    lainxi.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"shijian"]];
    lainxi.textColor = Color(170, 170, 170);
    lainxi.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    lainxi.textAlignment = NSTextAlignmentRight;
    
    [fisrView addSubview:lainxi];
    
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.2*width, 0.9*width, 1)];
    //    [grayView setBackgroundColor:[UIColor colorWithDisplayP3Red:242 green:242 blue:242 alpha:1]];
    grayView.backgroundColor = Color(233, 233, 233);
    [fisrView addSubview:grayView];
    
    UILabel *label22 = [[UILabel alloc] initWithFrame:CGRectMake(0,width*0.24,width*0.15, width*0.1)];
    label22.text = @"联系";
    // label22.backgroundColor = [UIColor blueColor];
    label22.textColor = Color(87, 87, 87);
    label22.adjustsFontSizeToFitWidth = YES;
    label22.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    label22.textAlignment = NSTextAlignmentLeft;
    [fisrView addSubview:label22];
    
    UILabel *zhou11 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), width*0.235, fisrView.frame.size.width*0.5-0.05*width, width*0.08)];
    zhou11.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"tel"]];
    zhou11.textColor = Color(140, 140, 140);
    zhou11.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    zhou11.textAlignment = NSTextAlignmentRight;
    [fisrView addSubview:zhou11];
    
    UILabel *shi11 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), CGRectGetMaxY(zhou11.frame), fisrView.frame.size.width*0.5-0.05*width, width*0.05)];
    //    shi11.text = @"徐吊样";
    shi11.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"username"]];
    shi11.textColor = Color(170, 170, 170);
    shi11.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    //    shi11.textColor = [UIColor grayColor];
    shi11.textAlignment = NSTextAlignmentRight;
    [fisrView addSubview:shi11];
    
    UIView *grayView1 = [[UIView alloc] initWithFrame:CGRectMake(0,0.4*width, 0.9*width, 1)];
    grayView1.backgroundColor =  Color(233, 233, 233);
    [fisrView addSubview:grayView1];
    
    UILabel *label42 = [[UILabel alloc] initWithFrame:CGRectMake(0,width*0.44,width*0.15, width*0.1)];
    label42.text = @"范围";
    label42.adjustsFontSizeToFitWidth = YES;
    // label42.backgroundColor = [UIColor blueColor];
    label42.textColor = Color(87, 87, 87);
    label42.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    label42.textAlignment = NSTextAlignmentLeft;
    [fisrView addSubview:label42];
    
    UILabel *chaoshi = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), width*0.435, fisrView.frame.size.width*0.5-0.05*width, width*0.065)];
    chaoshi.text = @"8小时";
    chaoshi.textColor = Color(140, 140, 140);
    chaoshi.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    chaoshi.textAlignment = NSTextAlignmentRight;
    [fisrView addSubview:chaoshi];
    
    UILabel *chaogongli = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), CGRectGetMaxY(chaoshi.frame), fisrView.frame.size.width*0.5-0.05*width, width*0.065)];
    chaogongli.text = @"100公里";
    chaogongli.textColor = Color(140, 140, 140);
    chaogongli.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    chaogongli.textAlignment = NSTextAlignmentRight;
    [fisrView addSubview:chaogongli];
    
    
    
    UIView *grayView6 = [[UIView alloc] initWithFrame:CGRectMake(0,0.6*width, 0.9*width, 1)];
    grayView6.backgroundColor =  Color(233, 233, 233);
    [fisrView addSubview:grayView6];
    
    
    UIView *image = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(grayView6.frame)+width*0.02, width*0.9, width*0.4)];
    [fisrView addSubview:image];
    //初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:image.frame];
    self.mapView.delegate = self;
    self.mapView.compassOrigin = CGPointMake(self.mapView.compassOrigin.x, 22);
    self.mapView.scaleOrigin = CGPointMake(self.mapView.scaleOrigin.x, 22);
    self.mapView.showsCompass = NO;
    self.mapView.zoomLevel = 15;
    self.mapView.scrollEnabled = NO;
    //    self.mapView.isScrollEnabled = NO;
    //添加到view上
    [fisrView addSubview:self.mapView];
    
    [self.locationManager startUpdatingLocation];
    
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    _mapView.userInteractionEnabled = YES;
   UIImageView *middleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(width*0.9/2-13,width*0.2-30, 26, 30)];
    middleImageView.image = [UIImage  imageNamed:@"停车地点.png"];
    [self.mapView addSubview:middleImageView];
    
    
    
    UIButton *dingwei = [UIButton buttonWithType:UIButtonTypeCustom];
    dingwei.frame = CGRectMake(width*0.9-40-width*0.02,width*0.02, 40, 40);
    // [dingwei setTitle:@"修改" forState:UIControlStateNormal];
    dingwei.tag = 104;
    [dingwei setBackgroundImage:[UIImage imageNamed:@"定位.png"] forState:UIControlStateNormal];
    [dingwei addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mapView addSubview:dingwei];
    
    _dizhi = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), width*0.7, width*0.1)];
    _dizhi.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"address"]];
    _dizhi.textColor = [UIColor grayColor];
    [fisrView addSubview:_dizhi];
    
    
    UIView *grayView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dizhi.frame),width*0.9 , 1)];
    grayView11.backgroundColor =  Color(233, 233, 233);
    [fisrView addSubview:grayView11];
    
    [self onClick:@"上海市" AndaddText:[NSString stringWithFormat:@"%@",_dizhi.text]];
}

-(void)updateNeed:(UIButton *)button {
    
    NSInteger btnTag = button.tag - 100;
    switch (btnTag) {
        case 0:{
            NSLog(@"0");
            
            
            break;
        }
        case 1:{
            NSLog(@"1");
            
            break;
        }
        case 2:{
            NSLog(@"2");
            
            break;
        }
        case 3:{
            NSLog(@"3");
            break;
        }
        case 4:{
            NSLog(@"4");
            break;
        }
        case 5:{
            NSLog(@"5");
            break;
        }
        case 6:{
            NSLog(@"6");
            break;
        }
        case 7:{
            NSLog(@"7");
            break;
        }
        case 8:{
            NSLog(@"8");
            break;
        }
        case 9:{
            NSLog(@"9");
            break;
        }
        case 10:{
            NSLog(@"10");
            break;
        }
        default:
            break;
    }
}
//修改联系
- (void)UpdateTelephoneNumber{
    
    _lianxiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _lianxiView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    _lianxiView.tag = 1000;
    [self.view.window addSubview:_lianxiView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1,64, ScreenWidth*0.8, ScreenWidth*0.75)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [_lianxiView addSubview:_alertView];
    
    UIColor *color = Color(7, 187, 177);
    
    
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame)*0.9, CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, 0, ScreenWidth*0.7, ScreenWidth*0.2)];
    label.text = @"请重新输入联系方式和联系人";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *teLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, ScreenWidth*0.25, ScreenWidth*0.2, ScreenWidth*0.1)];
    teLabel.text = @"联系方式 :";
    teLabel.textColor = Color(107, 107, 107);
    teLabel.textAlignment = NSTextAlignmentLeft;
    teLabel.adjustsFontSizeToFitWidth = YES;
    teLabel.font = [UIFont fontWithName:@"ArialMT" size:15];
    [image addSubview:teLabel];
    
    UITextField *tefield = [[UITextField alloc] initWithFrame:CGRectMake(width*0.25, ScreenWidth*0.25, ScreenWidth*0.5, ScreenWidth*0.1)];
    tefield.layer.borderColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1].CGColor;
    tefield.layer.borderWidth = 1.0;
    
    tefield.tintColor = color;
    
    tefield.layer.cornerRadius = ScreenWidth*0.1 /4;
    
    [image addSubview:tefield];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.375, ScreenWidth*0.7, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    
    UILabel *naLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, ScreenWidth*0.4, ScreenWidth*0.2, ScreenWidth*0.1)];
    naLabel.text = @"联系人 :";
    naLabel.textColor = Color(107, 107, 107);
    naLabel.textAlignment = NSTextAlignmentLeft;
    naLabel.adjustsFontSizeToFitWidth = YES;
    naLabel.font = [UIFont fontWithName:@"ArialMT" size:15];
    [image addSubview:naLabel];
    
    
    UITextField *nafield = [[UITextField alloc] initWithFrame:CGRectMake(width*0.25, ScreenWidth*0.4, ScreenWidth*0.5, ScreenWidth*0.1)];
    nafield.layer.borderColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1].CGColor;
    nafield.layer.borderWidth = 1.0;
    
    nafield.tintColor = color;
    
    nafield.layer.cornerRadius = ScreenWidth*0.1 /4;
    
    [image addSubview:nafield];
    
    
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.55, ScreenWidth*0.7, 0.5)];
    xian2.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian2];
    
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.7, 0.5)];
    xian1.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian1];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(width*0.425, ScreenWidth*0.6, ScreenWidth*0.325, ScreenWidth*0.1);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queding.backgroundColor = color;
    [queding addTarget:self action:@selector(moveLianx) forControlEvents:UIControlEventTouchUpInside];
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:queding];
    
    UIButton *quxiao = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiao.frame = CGRectMake(width*0.05, ScreenWidth*0.6, ScreenWidth*0.325, ScreenWidth*0.1);
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(moveLianx) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color1 = Color(177, 177, 177);
    quxiao.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    quxiao.backgroundColor = color1;
    [image addSubview:quxiao];
    
}
-(void)moveLianx {
    
    [_lianxiView removeFromSuperview];
}


-(void)onClick:(NSString *)string AndaddText:(NSString *)addText {
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //判断是否为空
    if (addText.length ==0) {
        return;
    }
    [geocoder geocodeAddressString:[NSString stringWithFormat:@"%@%@",string,addText] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error!=nil || placemarks.count==0) {
            return ;
        }
        //创建placemark对象
        CLPlacemark *placemark=[placemarks firstObject];
        MACoordinateRegion region;
        CLLocationCoordinate2D centerCoordinate ;
        NSString * lau = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
        NSString * lon = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
        centerCoordinate.latitude = [lau floatValue];
        centerCoordinate.longitude = [lon floatValue];
        region.center = centerCoordinate;
        _mapView.centerCoordinate = centerCoordinate;
        
        
        //  [self initDatas:centerCoordinate];
    }];
}
#define mark -- 初始化搜索类
- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        AMapLocationManager *locationManager = [[AMapLocationManager alloc] init];
        _locationManager = locationManager;
        locationManager.delegate = self;
        //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
        locationManager.pausesLocationUpdatesAutomatically = NO;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.allowsBackgroundLocationUpdates = NO;
        //带逆地理信息的一次定位（返回坐标和地址信息）
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //定位超时时间，最低2s，此处设置为2s
        self.locationManager.locationTimeout =2;
        //逆地理请求超时时间，最低2s，此处设置为2s
        self.locationManager.reGeocodeTimeout = 2;
        //带逆地理信息的一次定位（返回坐标和地址信息）
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //定位超时时间，最低2s，此处设置为10s
        self.locationManager.locationTimeout =10;
        //逆地理请求超时时间，最低2s，此处设置为10s
        self.locationManager.reGeocodeTimeout = 10;
        
        self.locationManager.distanceFilter = 50;
    }
    return _locationManager;
}


#pragma mark -------BMKLocationServiceDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    
    MAOverlayRenderer *re = [[MAOverlayRenderer alloc] init];
    re.alpha = 0;
    
    return re;
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    
    
    NSString *identifierForAdvertising = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"identifierForAdvertising == %@",identifierForAdvertising);
    
    NSString *userid = [ZCUserData share].userId;
    NSString *carid = _detailsDict[@"xcxq"][@"carid"];
    NSString *idname = _postIdString;
    CLLocationDegrees longitude =  location.coordinate.longitude;
    CLLocationDegrees latitude =  location.coordinate.latitude;
    
    NSDictionary *dict =  @{@"userid":userid,@"carid":carid,@"id":idname,@"longitude":[NSString stringWithFormat:@"%f",longitude],@"latitude":[NSString stringWithFormat:@"%f",latitude],@"mac":identifierForAdvertising};
    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/tc.php?op=maps_add" success:^(NSDictionary *fanhuicanshu) {
        NSLog(@"%@",fanhuicanshu);
        NSLog(@"我一直在想服务器传经纬度--成功");
        
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"经纬度上传失败--失败");
    }];
    
}
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
//    
//    NSString *identifierForAdvertising = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    NSLog(@"identifierForAdvertising == %@",identifierForAdvertising);
//    
//    NSString *userid = [ZCUserData share].userId;
//    NSString *carid = _detailsDict[@"xcxq"][@"carid"];
//    NSString *idname = _postIdString;
//    CLLocationDegrees longitude = userLocation.location.coordinate.longitude;
//    CLLocationDegrees latitude = userLocation.location.coordinate.latitude;
//    
//   NSDictionary *dict =  @{@"userid":userid,@"carid":carid,@"id":idname,@"longitude":[NSString stringWithFormat:@"%f",longitude],@"latitude":[NSString stringWithFormat:@"%f",latitude],@"mac":identifierForAdvertising};
//    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/tc.php?op=maps_add" success:^(NSDictionary *fanhuicanshu) {
//        NSLog(@"%@",fanhuicanshu);
//        NSLog(@"我一直在想服务器传经纬度--成功");
//        
//    } Error:^(NSString *cuowuxingxi) {
//        NSLog(@"经纬度上传失败--失败");
//    }];
    
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    
}

//第2个界面
-(void)creatzfdjthirdView {
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.1*ScreenHeight)];
    //thirdView.backgroundColor = [UIColor greenColor];
    _scrollerContenHeight+= 0.1*ScreenHeight;
    [_scrollerView addSubview:thirdView];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.1*ScreenHeight-1, 0.9*width, 1)];
    grayView.backgroundColor = Color(233, 233, 233);
    [thirdView addSubview:grayView];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.03*ScreenHeight, width*0.15, 0.04*ScreenHeight)];
    leftLabel.text = @"收益";
    leftLabel.textAlignment = NSTextAlignmentLeft;
    //
    leftLabel.textColor = Color(87, 87, 87);
    leftLabel.adjustsFontSizeToFitWidth = YES;
    leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    //    shi11.teleftLabel.font = [UIFont systemFontOfSize:20];
    [thirdView addSubview:leftLabel];
    
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*ScreenWidth,0.03*ScreenHeight, 0.2*ScreenWidth, 0.04*ScreenHeight)];
    NSString *s = _detailsDict[@"xcxq"][@"shouyi"];
    rightLabel.text = [NSString stringWithFormat:@"%@%@",@"¥ ",s];
    rightLabel.adjustsFontSizeToFitWidth = YES;
    rightLabel.textColor = [UIColor redColor];
    rightLabel.textColor = Color(255, 97, 57);
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 ];
    [thirdView addSubview:rightLabel];
    
}

//第四个界面
-(void)creatzfdjfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*0.98+44)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*0.98+width*0.04+44;
    [_scrollerView addSubview:fourView];
    
    
    
    UIView *aplap = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width*0.9, width*0.3)];
    aplap.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [fourView addSubview:aplap];
    
    UILabel *beizhu = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width*0.9, width*0.1)];
    beizhu.text = @"备注";
    beizhu.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
    beizhu.textAlignment = NSTextAlignmentCenter;
    beizhu.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    
    [aplap addSubview:beizhu];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(width*0.05, width*0.1, width*0.8, width*0.2)];
    textView.textColor = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1];
    textView.text = @"我想要最新款的车型,车牌不带4,车要洗干净,时间要准时";
    textView.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    textView.editable = NO;
    textView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [aplap addSubview:textView];
    
    
    
    UIImageView *bottonImageView = [UIImageView new];
    bottonImageView.image = [UIImage imageNamed:@"logo浅.png"];
    bottonImageView.alpha = 1;
    bottonImageView.frame = CGRectMake(0.9*width/2-width*0.075, width*0.4, width*0.15, width*0.15);
    //bottonImageView.backgroundColor = [UIColor redColor];
    [fourView addSubview:bottonImageView];
    
    
    
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *starString = [dateFormatter stringFromDate:currentDate];
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
    
    NSInteger a = [_detailsDict[@"xcxq"][@"times"] integerValue];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"1296035591  = %@",confromTimespStr);
    
    
    NSString *hours = [self dateTimeDifferenceWithStartTime:starString endTime:confromTimespStr];
    NSLog(@"%@",hours);
//    NSInteger add = 0;
//    NSMutableArray *hoursArray = [NSMutableArray arrayWithArray: [hours componentsSeparatedByString:@"-"]];
//    for ( int i = 0; i<hoursArray.count; i++) {
//        if ([hoursArray[i] isEqualToString:@""]) {
//            [hoursArray removeObjectAtIndex:i];
//        }
//        if (i == 0) {
//            add += [hoursArray[i] integerValue] *3600*24;
//        }
//        if (i == 1) {
//            add += [hoursArray[i] integerValue] *3600;
//        }
//        if (i == 2) {
//            add += [hoursArray[i] integerValue] *60;
//        }
//        if (i == 3) {
//            add += [hoursArray[i] integerValue] *1;
//        }
//        
//    }
    // 封装后
    _countDown = [CZCountDownView shareCountDown];
    _countDown.frame = CGRectMake(width*0.9/2-75, width*0.55 +width*0.1, 150, width*0.1);
    _countDown.timestamp = [hours intValue];
    //countDown.backgroundImageName = @"search_k";
    _countDown.timerStopBlock = ^{
        NSLog(@"时间停止");
        
    };
    [fourView addSubview:_countDown];
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.75+width*0.05, width*0.6, width*0.08)];
    duan.textColor = [UIColor redColor];
    duan.text = @"已经迟到";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-0.05*width, width*0.88, width*0.8, width*0.08)];
    chang.textColor = [UIColor redColor];
    chang.text = @"请联系用户";
    chang.textAlignment = NSTextAlignmentCenter;
    chang.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:chang];
    
//    UILabel *juli = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-0.05*width, width*0.96, width*0.8, width*0.08)];
//    juli.textColor = [UIColor redColor];
//    juli.text = @"提前到达有助于您获得更多的订单";
//    juli.textAlignment = NSTextAlignmentCenter;
//    juli.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
//    [fourView addSubview:juli];
//    
//    
    
    _MBSlider = [[MBSliderView alloc] initWithFrame:CGRectMake(-width*0.05, width*0.98, width, 44)];
    //    _MBSlider.layer.borderWidth = 1.0;
    UIColor *itemColor = Color(7, 187, 177);
    UIColor *color221 = Color(221, 221, 221);
    //    _MBSlider.layer.borderColor = [itemColor CGColor];
    _MBSlider.backgroundColor = color221;
    _MBSlider.delegate =self;
    [_MBSlider setText:@"迟到到达"];
    [_MBSlider setThumbColor:itemColor];
    [_MBSlider setLabelColor:[UIColor redColor]];
    [_MBSlider setDelegate:self];
    [fourView addSubview:_MBSlider];
}
- (void)sliderDidSlide:(MBSliderView *)slideView{
    
//    [HttpManager postData:@{@"userid":[ZCUserData share].userId,@"id":_detailsDict[@"state"][@"id"]} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=chezhu_yijingdaoda" success:^(NSDictionary *fanhuicanshu) {
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    } Error:^(NSString *cuowuxingxi) {
//        
//    }];
}
- (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
//    int second = (int)value %60;//秒
//    
//    int minute = (int)value /60%60;
//    
//    int house = (int)value / (24 * 3600)%3600;
//    
//    int day = (int)value / (24 * 3600);
//    
    NSString *str = [NSString stringWithFormat:@"%d",(int)value];

    return str;
    
}


// 点击支付定金
-(void)buttonZfdjClick:(UIButton *)Zfbutton {
    
}

@end
