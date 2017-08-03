//
//  XiangqingController.m
//  ZuChe
//
//  Created by apple  on 16/12/21.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "WeidaodaAndFuwzViewController.h"
#import "Header.h"
#import "HttpManager.h"
#import "ZCUserData.h"
#import "HttpManager.h"
#import <AdSupport/ASIdentifierManager.h>
#import "MBProgressHUD.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "ErWeiMaView.h"
#import "RCUserInfo+Addition.h"
#import "WMConversationViewController.h"


#import "MBSliderView.h"
//#import "AllTanchuView.h"

#import "AppDelegate.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height


//#import "WSStarRatingView.h"

#define PATH_URLPOST @"http://wx.leisurecarlease.com/api.php?op=api_xcxqjxz"

@interface WeidaodaAndFuwzViewController()<UIAlertViewDelegate,MAMapViewDelegate,AMapLocationManagerDelegate,MBSliderViewDelegate>{
    
    CGFloat width;
    
    UIScrollView *_scrollerView;
    
    CGFloat _scrollerContenHeight;
    
    NSMutableArray *_dataArray;
    
    NSMutableDictionary *_detailsDict;
    
    UIView *_bigView;
    
    UILabel *_dizhi;
    
    UIView *_lianxiView;
    
    UIRefreshControl *refreshControl;

    NSTimer *_timeWdd;
    
    UILabel *_timeLabel;
    
    UIView *_smallView;
    
    NSMutableDictionary *_wenhaoDict;
    
    UILabel *_daodaLabel;
    
    UILabel *_chidaotext;
    
    NSString *_statusString;
    
    UILabel *timelabel;
    UILabel *gonglilbale;
    
    
    NSTimer *_fuwuTimer;
    
    float wangye;
    
    NSTimer *_wksTimer;
    

}
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,assign)NSInteger timestamp;
@property(nonatomic,strong)AMapLocationManager *locationManager;

@property (nonatomic,retain) NSArray *timesArray;
@property (nonatomic ,retain)NSArray *kmsArray;
@property(nonatomic,strong)MBSliderView *DaoDaSlider;
@property(nonatomic,strong)MBSliderView *ChiDaoSlider;


@property(nonatomic,assign)NSInteger timestampWks;

@property(nonatomic,assign)NSInteger fuwuTimestamp;
@end

@implementation WeidaodaAndFuwzViewController



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    [_timeWdd invalidate];
    _timeWdd = nil;
    [_fuwuTimer invalidate];
    _fuwuTimer = nil;
    [_wksTimer invalidate];
    _wksTimer = nil;
    
  
    [self initIdWenHaoData];
    [self initArrayData];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;
//    [_countDown.timer invalidate];
//    _countDown.timer = nil;
    [_timeWdd invalidate];
    _timeWdd = nil;
    [_fuwuTimer invalidate];
    _fuwuTimer = nil;
    [_wksTimer invalidate];
    _wksTimer = nil;
   
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
    _dataArray = [NSMutableArray new];
    _detailsDict = [NSMutableDictionary new];
    _wenhaoDict = [NSMutableDictionary new];
    self.view.backgroundColor = [UIColor whiteColor];
    width = self.view.frame.size.width;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(gobackTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;

}

-(void)creatHi {
    
    UIButton *fanhui1 = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui1.frame = CGRectMake(0, 0, 26, 26);
    [fanhui1 setTitle:@"hi" forState:UIControlStateNormal];
    [fanhui1 setTitleColor:[UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
    fanhui1.layer.cornerRadius = 13;
    fanhui1.layer.borderColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1].CGColor;
    
    fanhui1.titleLabel.font = [UIFont systemFontOfSize:13];
    fanhui1.layer.borderWidth = 1.3;
    [fanhui1 addTarget:self action:@selector(gobackTo1:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton1 = [[UIBarButtonItem alloc] initWithCustomView:fanhui1];
    
    self.navigationItem.rightBarButtonItem = leftBarbutton1;
}
-(void)gobackTo {
    
}
-(void)gobackTo1:(UIButton *)btn {
    

    WMConversationViewController *_conversationVC = [[WMConversationViewController alloc]init];
    _conversationVC.conversationType = ConversationType_GROUP;
    _conversationVC.targetId = _detailsDict[@"state"][@"id"];
    _conversationVC.title = [NSString stringWithFormat:@"%@",@"LEISURECAR"];
    
    [self.navigationController pushViewController:_conversationVC animated:YES];

    
}
// 下拉刷新触发，在此获取数据
-(void)refreshClick1:(UIRefreshControl *)refreshContro {
    NSLog(@"refreshClick: -- 刷新触发");
    [_fuwuTimer invalidate];
    _fuwuTimer = nil;
    [_timeWdd invalidate];
    _timeWdd = nil;
    [_wksTimer invalidate];
    _wksTimer = nil;
    [_scrollerView removeFromSuperview];
    [self initIdWenHaoData];
    [self initArrayData];
}



-(void)timer11:(NSTimer*)timer{
    
    [_fuwuTimer invalidate];
    _fuwuTimer = nil;
    [_timeWdd invalidate];
    _timeWdd = nil;
    [_wksTimer invalidate];
    _wksTimer = nil;
    [_scrollerView removeFromSuperview];
    [self initIdWenHaoData];
    [self initArrayData];
    
}

//- (void)gobackTo{
//        NSLog(@"1");
//    [self.navigationController popViewControllerAnimated:NO];
//}
-(void)initIdWenHaoData {
    
    [HttpManager postData:@{@"id":_postIdString} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=indent_show" success:^(NSDictionary *fanhuicanshu) {
        
        [_wenhaoDict removeAllObjects];
        [_wenhaoDict addEntriesFromDictionary:fanhuicanshu[@"arr"]];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}
//网络请求数据
-(void)initArrayData {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *dicr = @{@"id":_postIdString,@"userid": [ZCUserData share].userId};
    
    [HttpManager postData:dicr andUrl:PATH_URLPOST success:^(NSDictionary *fanhuicanshu) {
        
        _statusString = _detailsDict[@"xcxq"][@"status"];
        
        [_detailsDict removeAllObjects];
        [_detailsDict addEntriesFromDictionary:fanhuicanshu];
        NSLog(@"%@",_detailsDict);
        NSString *statusString = _detailsDict[@"xcxq"][@"status"];
        
        if ([statusString isEqualToString:@"1"]) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"未开始";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
            [self creatHi];
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatzfdjfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            [refreshControl endRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
        if ([statusString isEqualToString:@"2"]) {
            
            [_wksTimer  invalidate];
            _wksTimer = nil;
            _timeLabel.text = @"";
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"未到达";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
            [self creatHi];
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatweidaodafourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            [refreshControl endRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        else if ([statusString isEqualToString:@"3"]) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"已到达";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
            [self creatHi];
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatyidaodafourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
             [refreshControl endRefreshing];
        }
        else if ([statusString isEqualToString:@"4"]) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"已迟到";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = [UIColor redColor];
            self.navigationItem.titleView = label;
            [self creatHi];
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatchidaoView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
             [refreshControl endRefreshing];
        }
        else if ([statusString isEqualToString:@"5"]) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"待支付尾款";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
            [self creatHi];
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatdaizhifuweikuanfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            [refreshControl endRefreshing];
        }
        else if ([statusString isEqualToString:@"6"]) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"已支付尾款";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            [self creatHi];
            self.navigationItem.titleView = label;
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatyizhifuweikuanfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            [refreshControl endRefreshing];
        }

        else if ([statusString isEqualToString:@"7"]) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"服务中";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            
            self.navigationItem.titleView = label;
            [self creatHi];
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatfuwuzhongFourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            [refreshControl endRefreshing];
        }

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
}






//所有的第一个界面
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
    
    chaoshi.text = [NSString stringWithFormat:@"%@小时",_detailsDict[@"xcxq"][@"zhuche_chaoshi"]];
    chaoshi.textColor = Color(140, 140, 140);
    chaoshi.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    chaoshi.textAlignment = NSTextAlignmentRight;
    [fisrView addSubview:chaoshi];
    
    UILabel *chaogongli = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), CGRectGetMaxY(chaoshi.frame), fisrView.frame.size.width*0.5-0.05*width, width*0.065)];
    chaogongli.text = [NSString stringWithFormat:@"%@公里",_detailsDict[@"xcxq"][@"zhuche_chaogongli"]];
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
    UIImageView *middleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(width*0.9/2-9,width*0.2-30, 17.5, 30)];
    middleImageView.image = [UIImage  imageNamed:@"停车地点.png"];
    [self.mapView addSubview:middleImageView];
    
    _dizhi = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), width*0.7, width*0.1)];
    _dizhi.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"address"]];
    _dizhi.textColor = [UIColor grayColor];
    [fisrView addSubview:_dizhi];
    
    
    UIView *grayView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dizhi.frame),width*0.9 , 1)];
    grayView11.backgroundColor =  Color(233, 233, 233);
    [fisrView addSubview:grayView11];
    
    [self onClick:@"" AndaddText:[NSString stringWithFormat:@"%@",_dizhi.text]];
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

//未开始


//第四个界面
-(void)creatzfdjfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*0.98)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*0.98+width*0.04;
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
    if ([_wenhaoDict[@"beizhu"] isEqualToString:@""]) {
        textView.text = @"暂未备注";
    }else {
        textView.text = _wenhaoDict[@"beizhu"];
    }
    
    textView.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    textView.editable = NO;
    textView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [aplap addSubview:textView];
    
    
    
    
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
    NSString *hours = [self dateTimeDifferenceWithStartTime1:starString endTime:confromTimespStr];
    NSInteger hou = [hours integerValue];
    [self setTimestampWks:hou];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.9/2-width*0.6/2, width*0.3 +width*0.1,width*0.6, width*0.1)];
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    _timeLabel.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    _timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor redColor];
    [fourView addSubview:_timeLabel];
    
    
    
    UIImageView *bottonImageView = [UIImageView new];
    bottonImageView.image = [UIImage imageNamed:@"logo浅.png"];
    bottonImageView.alpha = 1;
    bottonImageView.frame = CGRectMake(0.9*width/2-width*0.075, width*0.6, width*0.15, width*0.15);
    //bottonImageView.backgroundColor = [UIColor redColor];
    [fourView addSubview:bottonImageView];
    
    
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.75+width*0.05, width*0.6, width*0.08)];
    duan.textColor = [UIColor redColor];
    duan.text = @"距离服务开始";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
}

// 拿到外界传来的时间戳
- (void)setTimestampWks:(NSInteger)timestampWks{
    _timestampWks = timestampWks;
    if (_timestampWks != 0) {
        _wksTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer1:) userInfo:nil repeats:YES];
    }
}

-(void)timer1:(NSTimer*)timerr{
    _timestampWks--;
    [self getDetailTimeWithTimestamp1:_timestampWks];
    if (_timestampWks <= 0) {
        [_wksTimer invalidate];
        _wksTimer = nil;
    }
}
- (void)getDetailTimeWithTimestamp1:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    
    NSInteger ss = 1;
    
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
    NSString *q;
    NSString *a;
    NSString *b;
    NSString *c;
    
    
    q = [NSString stringWithFormat:@"%zd",day];
    
    a = [NSString stringWithFormat:@"%zd",hour];
    
    b = [NSString stringWithFormat:@"%zd",minute];
    
    c = [NSString stringWithFormat:@"%zd",second];
    
    
    
    _timeLabel.text = [NSString stringWithFormat:@"%@ : %@ : %@ : %@",q,a,b,c];
}
- (NSString *)dateTimeDifferenceWithStartTime1:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
    
    NSString *str;
    
    str = [NSString stringWithFormat:@"%d",(int)value];
    return str;
    

}


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

//未到达第四个界面
-(void)creatweidaodafourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width,width*1.14+44)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*1.14+width*0.04+44;
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
    if ([_wenhaoDict[@"beizhu"] isEqualToString:@""]) {
        textView.text = @"暂未备注";
    }else {
        textView.text = _wenhaoDict[@"beizhu"];
    }
    
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
    
    
    NSInteger hou = [hours integerValue];
    
    

    
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.9/2-width*0.3/2, width*0.55 +width*0.1,width*0.3, width*0.1)];
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    _timeLabel.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    _timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self setTimestamp:hou];
    _timeLabel.textColor = [UIColor redColor];
    //   _timeLabel.backgroundColor = [UIColor greenCol
    [fourView addSubview:_timeLabel];
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.75+width*0.05, width*0.6, width*0.08)];
    duan.textColor = [UIColor redColor];
    duan.text = @"距离约定时间";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-0.05*width, width*0.88, width*0.8, width*0.08)];
    chang.textColor = [UIColor redColor];
    chang.text = @"提前到达有助于您获得更多的订单";
    chang.textAlignment = NSTextAlignmentCenter;
    chang.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:chang];
    
    UILabel *juli = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-0.05*width, width*0.96, width*0.8, width*0.08)];
    juli.textColor = [UIColor redColor];
    juli.text = @"距离集合地点500米内可确认到达";
    juli.textAlignment = NSTextAlignmentCenter;
    juli.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:juli];
    
    
    
    _DaoDaSlider = [[MBSliderView alloc] initWithFrame:CGRectMake(-width*0.05, width*1.04+width*0.1, width, 44)];
    //    _MBSlider.layer.borderWidth = 1.0;
    UIColor *itemColor = Color(7, 187, 177);
    UIColor *color221 = Color(221, 221, 221);
    
    //    _MBSlider.layer.borderColor = [itemColor CGColor];
    _DaoDaSlider.backgroundColor = color221;
    [_DaoDaSlider setText:@"确认到达"];
    [_DaoDaSlider setThumbColor:itemColor];
    [_DaoDaSlider setLabelColor:[UIColor whiteColor]];
    [_DaoDaSlider setDelegate:self];
    [fourView addSubview:_DaoDaSlider];
}

- (double)calculateDistanceWithStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end {
    
    double meter = 0;
    
    double startLongitude = start.longitude;
    double startLatitude = start.latitude;
    double endLongitude = end.longitude;
    double endLatitude = end.latitude;
    
    double radLatitude1 = startLatitude * M_PI / 180.0;
    double radLatitude2 = endLatitude * M_PI / 180.0;
    double a = fabs(radLatitude1 - radLatitude2);
    double b = fabs(startLongitude * M_PI / 180.0 - endLongitude * M_PI / 180.0);
    
    double s = 2 * asin(sqrt(pow(sin(a/2),2) + cos(radLatitude1) * cos(radLatitude2) * pow(sin(b/2),2)));
    s = s * 6378137;
    
    meter = round(s * 10000) / 10000;
    
    NSLog(@"距离约定地点还有多少%f米",meter);
    return meter;
}

- (void)sliderDidSlide:(MBSliderView *)slideView{
    
//    NSDictionary *dicr = @{@"id":_postIdString,@"userid": [ZCUserData share].userId};
//    
//    
//    [HttpManager postData:dicr andUrl:PATH_URLPOST success:^(NSDictionary *fanhuicanshu) {
//        
//        if ( [fanhuicanshu[@"xcxq"][@"status"] isEqualToString:_statusString ]) {
//         
//            NSString *userid = [ZCUserData share].userId;
//            NSString *idString = _postIdString;
//            NSString *carid = _detailsDict[@"xcxq"][@"carid"];
//            NSMutableArray *array = [NSMutableArray new];
//            
//            
//            [HttpManager postData:@{@"userid":userid,@"id":idString,@"carid":carid} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=maps_list" success:^(NSDictionary *fanhuicanshu) {
//                if ([fanhuicanshu[@"list"] isKindOfClass:[NSNull class]]) {
//                    
//                }else {
//                    [array removeAllObjects];
//                    [array addObjectsFromArray:fanhuicanshu[@"list"]];
//                    
//                    NSDictionary *locationStr = array.lastObject;
//                    if ([locationStr[@"latitude"] isKindOfClass:[NSNull class]] && [locationStr[@"longitude"] isKindOfClass:[NSNull class]]) {
//                        
//                    }else {
//                        float latitudeStr1 = [locationStr[@"latitude"] floatValue];
//                        float longitudeStr1 =[locationStr[@"longitude"] floatValue];
//                        CLLocationCoordinate2D startCenter = CLLocationCoordinate2DMake(latitudeStr1,longitudeStr1);
//                        CLGeocoder *geocoder=[[CLGeocoder alloc]init];
//                        
//                        [geocoder geocodeAddressString:[NSString stringWithFormat:@"%@%@",@"上海市",_detailsDict[@"xcxq"][@"address"]] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//                            if (error!=nil || placemarks.count==0) {
//                                return ;
//                            }
//                            //创建placemark对象
//                            CLPlacemark *placemark=[placemarks firstObject];
//                            NSString * lau = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
//                            NSString * lon = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
//                            CLLocationCoordinate2D endCenter = CLLocationCoordinate2DMake([lau floatValue],[lon floatValue]);
//                            CLLocationDistance distance = [self calculateDistanceWithStart:startCenter end:endCenter];
//                            
//                            if (distance <500) {
//                                [HttpManager postData:@{@"userid":[ZCUserData share].userId,@"id":_detailsDict[@"state"][@"id"]} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=chezhu_yijingdaoda" success:^(NSDictionary *fanhuicanshu) {
//                                    [_timeWdd invalidate];
//                                    _timeWdd = nil;
//                                        [_scrollerView removeFromSuperview];
//                                        [self initIdWenHaoData];
//                                        [self initArrayData];
//                                    
//                                } Error:^(NSString *cuowuxingxi) {
//                                    
//                                }];
//                                
//                            }else {
//                                [self chaoguowubaimi];
//                            }
//                        }];
//                    }
//                    
//                    
//                }
//                
//            } Error:^(NSString *cuowuxingxi) {
//                
//            }];
}
- (void)zhuangtiaengxin{
    
    _smallView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _smallView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    _smallView.tag = 1000;
    [self.view.window addSubview:_smallView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight/2- ScreenWidth*0.3/2, ScreenWidth*0.8, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [_smallView addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame)*0.9, CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"状态已更新，请刷新界面确认到达";
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
    [queding addTarget:self action:@selector(moveAll11) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
-(void)moveAll11 {
    [_smallView removeFromSuperview];
}



// 拿到外界传来的时间戳
- (void)setTimestamp:(NSInteger)timestamp{
    _timestamp = timestamp;
    if (_timestamp != 0) {
        _timeWdd =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    }
}

-(void)timer:(NSTimer*)timerr{
    _timestamp--;
    [self getDetailTimeWithTimestamp:_timestamp];
    if (_timestamp == 0) {
        [_timeWdd invalidate];
        _timeWdd = nil;
    }
}
- (void)getDetailTimeWithTimestamp:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    
    NSInteger ss = 1;
    
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
    NSString *q;
    NSString *a;
    NSString *b;
    NSString *c;
    
    
    q = [NSString stringWithFormat:@"%zd",day];
    
    a = [NSString stringWithFormat:@"%zd",hour];
    
    b = [NSString stringWithFormat:@"%zd",minute];
    
    c = [NSString stringWithFormat:@"%zd",second];
    
    
    
    _timeLabel.text = [NSString stringWithFormat:@"%@ : %@",a,b];
 
}
- (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
    
    NSString *str;
    
    str = [NSString stringWithFormat:@"%d",(int)value];
    return str;
    
}


// 点击支付定金
-(void)buttonZfdjClick:(UIButton *)Zfbutton {
    
}

- (void)chaoguowubaimi{
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 1019;
    [self.view.window addSubview:bigView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight/2- ScreenWidth*0.3/2, ScreenWidth*0.8, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [bigView addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame)*0.9, CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"距离集合地点超过500米";
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
    [queding addTarget:self action:@selector(removeChaoguo) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
-(void)removeChaoguo {
    
    UIView *view = [self.view.window viewWithTag:1019];
    [view removeFromSuperview];
}

//地图定位中心点
-(void)onClick:(NSString *)string AndaddText:(NSString *)addText {
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //判断是否为空
    if (addText.length ==0) {
        return;
    }
    [geocoder geocodeAddressString:addText completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
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
    }];
}
#define mark -- 初始化搜索类
- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        AMapLocationManager *locationManager = [[AMapLocationManager alloc] init];
        _locationManager = locationManager;
        
        locationManager.delegate = self;
        //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager setPausesLocationUpdatesAutomatically:YES];
        //设置允许在后台定位
        [self.locationManager setAllowsBackgroundLocationUpdates:YES];
        //带逆地理信息的一次定位（返回坐标和地址信息）
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //定位超时时间，最低2s，此处设置为2s
        self.locationManager.locationTimeout =2;
        //逆地理请求超时时间，最低2s，此处设置为2s
        self.locationManager.reGeocodeTimeout = 2;
        //带逆地理信息的一次定位（返回坐标和地址信息）
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //定位超时时间，最低2s，此处设置为10s
        self.locationManager.distanceFilter = 50;
        
    }
    return _locationManager;
}


#pragma mark -------BAKLocationServiceDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    
    MAOverlayRenderer *re = [[MAOverlayRenderer alloc] init];
    re.alpha = 0;
    
    return re;
}
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {

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
        
        
           _statusString = _detailsDict[@"xcxq"][@"status"];
        
        if ([_statusString isEqualToString:@"2"] || [_statusString isEqualToString:@"3"]) {
            [self daodaanniu];
        }
        
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"经纬度上传失败--失败");
    }];
    
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    
}


-(void )daodaanniu {
    
    NSString *userid = [ZCUserData share].userId;
    NSString *idString = _postIdString;
    NSString *carid = _detailsDict[@"xcxq"][@"carid"];
    NSMutableArray *array = [NSMutableArray new];
    
    
    [HttpManager postData:@{@"userid":userid,@"id":idString,@"carid":carid} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=maps_list" success:^(NSDictionary *fanhuicanshu) {
        if ([fanhuicanshu[@"list"] isKindOfClass:[NSNull class]]) {
            
        }else {
            [array removeAllObjects];
            [array addObjectsFromArray:fanhuicanshu[@"list"]];
            
            NSDictionary *locationStr = array.lastObject;
            if ([locationStr[@"latitude"] isKindOfClass:[NSNull class]] && [locationStr[@"longitude"] isKindOfClass:[NSNull class]]) {
                
            }else {
                float latitudeStr1 = [locationStr[@"latitude"] floatValue];
                float longitudeStr1 =[locationStr[@"longitude"] floatValue];
                CLLocationCoordinate2D startCenter = CLLocationCoordinate2DMake(latitudeStr1,longitudeStr1);
                CLGeocoder *geocoder=[[CLGeocoder alloc]init];
                
                [geocoder geocodeAddressString:[NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"address"]] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                    if (error!=nil || placemarks.count==0) {
                        return ;
                    }
                    //创建placemark对象
                    CLPlacemark *placemark=[placemarks firstObject];
                    NSString * lau = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
                    NSString * lon = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
                    CLLocationCoordinate2D endCenter = CLLocationCoordinate2DMake([lau floatValue],[lon floatValue]);
                    CLLocationDistance distance = [self calculateDistanceWithStart:startCenter end:endCenter];
                    
                    if (distance <500) {
                        [HttpManager postData:@{@"userid":[ZCUserData share].userId,@"id":_detailsDict[@"state"][@"id"]} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=chezhu_yijingdaoda" success:^(NSDictionary *fanhuicanshu) {
                            [_timeWdd invalidate];
                            _timeWdd = nil;
                            [_scrollerView removeFromSuperview];
                            [self initIdWenHaoData];
                            [self initArrayData];
                            
                        } Error:^(NSString *cuowuxingxi) {
                            
                        }];
                        
                    }else {
                       // [self chaoguowubaimi];
                    }
                }];
            }
            
            
        }
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}


//已到达第四个界面
//第四个界面
-(void)creatyidaodafourView {
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
    if ([_wenhaoDict[@"beizhu"] isEqualToString:@""]) {
        textView.text = @"暂未备注";
    }else {
        textView.text = _wenhaoDict[@"beizhu"];
    }
    
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
    


    _daodaLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.9/2-width*0.3/2, width*0.55 +width*0.1,width*0.3, width*0.1)];
    _daodaLabel.adjustsFontSizeToFitWidth = YES;
    _daodaLabel.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    _daodaLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    _daodaLabel.textAlignment = NSTextAlignmentCenter;
    _daodaLabel.textColor = [UIColor redColor];
    //   _timeLabel.backgroundColor = [UIColor greenCol
    [fourView addSubview:_daodaLabel];
    
    
    if ([_detailsDict[@"xcxq"][@"ddsj"]isKindOfClass:[NSNull class] ]) {
        
    }else {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------集合时间
        NSInteger a = [_detailsDict[@"xcxq"][@"times"] integerValue];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a];
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init] ;
        [formatter1 setDateStyle:NSDateFormatterMediumStyle];
        [formatter1 setTimeStyle:NSDateFormatterShortStyle];
        [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------到达时间
        NSInteger a1 = [_detailsDict[@"xcxq"][@"ddsj"] integerValue];
        NSDate *confromTimesp1 = [NSDate dateWithTimeIntervalSince1970:a1];
        NSString *confromTimespStr1 = [formatter stringFromDate:confromTimesp1];
        
        NSString *hours = [self dateTimeDifferenceWithStartTime:confromTimespStr1 endTime:confromTimespStr];
        
        NSInteger hou = [hours integerValue];
        [self getyidaoda:hou];
        
    }
    

    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.75+width*0.05, width*0.6, width*0.08)];
    duan.textColor = [UIColor redColor];
    duan.text = @"提前到达时间";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-0.05*width, width*0.88, width*0.8, width*0.08)];
    chang.textColor = [UIColor redColor];
    chang.text = @"请联系用户确认到达集合地点";
    chang.textAlignment = NSTextAlignmentCenter;
    chang.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:chang];

    
    UIButton *greenButton = [[UIButton alloc] initWithFrame:CGRectMake(-width*0.05, width*0.98, width, 44)];
    [greenButton setTitle:_detailsDict[@"xcxq"][@"tel"] forState:UIControlStateNormal];
    greenButton.backgroundColor = Color( 7, 187, 177);
    [greenButton addTarget:self action:@selector(greenButton:) forControlEvents:UIControlEventTouchUpInside];
    greenButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    [fourView addSubview:greenButton];
}
-(void)greenButton:(UIButton *)button {
    NSLog(@"green");
    [self callPhone:_detailsDict[@"xcxq"][@"tel"]];
    
}
-(void)callPhone:(NSString *)phoneNum {
    
    if (phoneNum.length == 0) {
        
        return;
    }
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}


- (void)getyidaoda:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    
    NSInteger ss = 1;
    
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
    NSString *q;
    NSString *a;
    NSString *b;
    NSString *c;
    
    
    q = [NSString stringWithFormat:@"%zd",day];
    
    a = [NSString stringWithFormat:@"%zd",hour];
    
    b = [NSString stringWithFormat:@"%zd",minute];
    
    c = [NSString stringWithFormat:@"%zd",second];
    
    
    
    _daodaLabel.text = [NSString stringWithFormat:@"%@ : %@",a,b];
    
}















//迟到第四个界面
-(void)creatchidaoView {
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
    if ([_wenhaoDict[@"beizhu"] isEqualToString:@""]) {
        textView.text = @"暂未备注";
    }else {
        textView.text = _wenhaoDict[@"beizhu"];
    }
    
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
 
    
    _chidaotext = [[UILabel alloc] initWithFrame:CGRectMake(width*0.9/2-width*0.3/2, width*0.55 +width*0.1,width*0.3, width*0.1)];
    _chidaotext.adjustsFontSizeToFitWidth = YES;
    _chidaotext.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    _chidaotext.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    _chidaotext.textAlignment = NSTextAlignmentCenter;
    _chidaotext.textColor = [UIColor redColor];
    //   _timeLabel.backgroundColor = [UIColor greenCol
    [fourView addSubview:_chidaotext];
    
    
    if ([_detailsDict[@"xcxq"][@"ddsj"]isKindOfClass:[NSNull class] ]) {
        
    }else {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------集合时间
        NSInteger a = [_detailsDict[@"xcxq"][@"times"] integerValue];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a];
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init] ;
        [formatter1 setDateStyle:NSDateFormatterMediumStyle];
        [formatter1 setTimeStyle:NSDateFormatterShortStyle];
        [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------到达时间
        NSInteger a1 = [_detailsDict[@"xcxq"][@"ddsj"] integerValue];
        NSDate *confromTimesp1 = [NSDate dateWithTimeIntervalSince1970:a1];
        NSString *confromTimespStr1 = [formatter stringFromDate:confromTimesp1];
        
        NSString *hours = [self dateTimeDifferenceWithStartTime:confromTimespStr1 endTime:confromTimespStr];
        
        NSInteger hou = [hours integerValue];
        [self getchidao:hou];
        
    }

    
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
    
    
    _ChiDaoSlider = [[MBSliderView alloc] initWithFrame:CGRectMake(-width*0.05, width*0.98, width, 44)];
    //    _MBSlider.layer.borderWidth = 1.0;
    UIColor *itemColor = Color(7, 187, 177);
    UIColor *color221 = Color(221, 221, 221);
    //    _MBSlider.layer.borderColor = [itemColor CGColor];
    _ChiDaoSlider.backgroundColor = color221;
    _ChiDaoSlider.delegate =self;
    
    [_ChiDaoSlider setText:@"迟到到达"];
    [_ChiDaoSlider setThumbColor:itemColor];
    [_ChiDaoSlider setLabelColor:[UIColor redColor]];
    [_ChiDaoSlider setDelegate:self];
    [fourView addSubview:_ChiDaoSlider];
}


- (void)getchidao:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    
    NSInteger ss = 1;
    
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
    NSString *q;
    NSString *a;
    NSString *b;
    NSString *c;
    
    q = [NSString stringWithFormat:@"%zd",day];
    
    a = [NSString stringWithFormat:@"%zd",hour];
    
    b = [NSString stringWithFormat:@"%zd",minute];
    
    c = [NSString stringWithFormat:@"%zd",second];
    
    _chidaotext.text = [NSString stringWithFormat:@"%@ : %@",a,b];
    
}


















//待支付尾款第四个界面
-(void)creatdaizhifuweikuanfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*0.85+44)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*0.85+width*0.04+44;
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
    if ([_wenhaoDict[@"beizhu"] isEqualToString:@""]) {
        textView.text = @"暂未备注";
    }else {
        textView.text = _wenhaoDict[@"beizhu"];
    }
    
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
    
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.65, width*0.6, width*0.08)];
    duan.textColor = [UIColor redColor];
    duan.text = @"请告知用户";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-0.05*width, width*0.73, width*0.8, width*0.08)];
    chang.textColor = [UIColor redColor];
    chang.text = @"需支付尾款后开始服务";
    chang.textAlignment = NSTextAlignmentCenter;
    chang.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:chang];
    
    
    UIButton *greenButton = [[UIButton alloc] initWithFrame:CGRectMake(-width*0.05, width*0.85, width, 44)];
    [greenButton setTitle:@"等待支付尾款" forState:UIControlStateNormal];
    greenButton.backgroundColor = Color( 7, 187, 177);
    [greenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    greenButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [fourView addSubview:greenButton];
}

























//已支付尾款

-(void)creatyizhifuweikuanfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*0.85+44)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*0.85+width*0.04+44;
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
    if ([_wenhaoDict[@"beizhu"] isEqualToString:@""]) {
        textView.text = @"暂未备注";
    }else {
        textView.text = _wenhaoDict[@"beizhu"];
    }
    
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
    
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.65, width*0.6, width*0.08)];
    duan.textColor = [UIColor redColor];
    duan.text = @"请告知用户";
    duan.textAlignment = NSTextAlignmentCenter;
    [fourView addSubview:duan];
    
    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-0.05*width, width*0.73, width*0.8, width*0.08)];
    chang.textColor = [UIColor redColor];
    chang.text = @"正在等待服务开始";
    chang.textAlignment = NSTextAlignmentCenter;
    [fourView addSubview:chang];
    

    UILabel *greenButton = [[UILabel alloc] initWithFrame:CGRectMake(-width*0.05, width*0.85, width, 44)];
    greenButton.text = @"已支付尾款";
    greenButton.textColor = [UIColor whiteColor];
     greenButton.textAlignment = NSTextAlignmentCenter;
    greenButton.adjustsFontSizeToFitWidth = YES;
     greenButton.backgroundColor = Color( 7, 187, 177);
     greenButton.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [fourView addSubview:greenButton];
}
























//第四个界面
-(void)creatfuwuzhongFourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*1.34)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*1.34+width*0.04;
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
    if ([_wenhaoDict[@"beizhu"] isEqualToString:@""]) {
        textView.text = @"暂未备注";
    }else {
        textView.text = _wenhaoDict[@"beizhu"];
    }
    
    textView.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    textView.editable = NO;
    textView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [aplap addSubview:textView];
    
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - width*0.38, width*0.3+width*0.1, width*0.35, width*0.35)];
    //            image1.backgroundColor = [UIColor purpleColor];
    image1.image = [UIImage imageNamed:@"找车@3x.png"];
    [fourView addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2+width*0.03-0.1*width, width*0.3+width*0.1, width*0.35, width*0.35)];
    //image2.backgroundColor = [UIColor purpleColor];
    image2.image = [UIImage imageNamed:@"找车@3x.png"];
    [fourView addSubview:image2];
    
    
    
    timelabel = [[UILabel alloc] init];
    // label4.backgroundColor = [UIColor redColor];
    timelabel.frame = CGRectMake(width/2 - width*0.38+width*0.175/2, width*0.4+width*0.175/2, width*0.175, width*0.175);
    timelabel.adjustsFontSizeToFitWidth = YES;
    
    //  label4.text = [NSString stringWithFormat:@"%02i:%02i'%02i",_min,_miao,_haomiao];
    timelabel.textColor = [UIColor redColor];
    timelabel.textAlignment = NSTextAlignmentCenter;
    timelabel.font = [UIFont systemFontOfSize:18];
    
    [fourView addSubview:timelabel];
    
    
    
    gonglilbale = [[UILabel alloc] initWithFrame:CGRectMake(width/2+width*0.03+width*0.175/2-0.1*width, width*0.4+width*0.175/2, width*0.175, width*0.175)];
    
    // timeLable .backgroundColor = [UIColor greenColor];
    gonglilbale.textColor = [UIColor redColor];
    gonglilbale.textAlignment = NSTextAlignmentCenter;
    gonglilbale.font = [UIFont systemFontOfSize:18];
    gonglilbale.adjustsFontSizeToFitWidth = YES;
    [fourView addSubview:gonglilbale];
    
    
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *starString = [dateFormatter stringFromDate:currentDate];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
    
    NSString *a = _detailsDict[@"xcxq"][@"kssj"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[a intValue]];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"1296035591  = %@",confromTimespStr);
    
    NSString *hours = [self dateTimeDifferenceWithStartTime:confromTimespStr endTime:starString];
    
    [self setFuwuTimestamp:[hours intValue]];
    

    UILabel *sJcheng = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.38+width*0.35/2, width*0.4+width*0.35*2/3, width*0.175, width*0.175)];
    sJcheng.text = @"时间";
    //licheng .backgroundColor = [UIColor greenColor];
    sJcheng.textColor = [UIColor redColor];
    sJcheng.textAlignment = NSTextAlignmentCenter;
    sJcheng.font = [UIFont systemFontOfSize:14];
    [fourView addSubview:sJcheng];
    
    
    UILabel *licheng = [[UILabel alloc] initWithFrame:CGRectMake(width/2+width*0.03+width*0.35/2-0.1*width, width*0.4+width*0.35*2/3, width*0.175, width*0.175)];
    licheng.text = @"里程";
    //licheng .backgroundColor = [UIColor greenColor];
    licheng.textColor = [UIColor redColor];
    licheng.textAlignment = NSTextAlignmentCenter;
    licheng.font = [UIFont systemFontOfSize:14];
    [fourView addSubview:licheng];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image1.frame)+width*0.08, width*0.9, width*0.08)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor redColor];
    label1.font = [UIFont systemFontOfSize:18];
    label1.text = @"以实际车辆记录里程为准";
    [fourView addSubview:label1];
    
    
    UILabel *label12 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), width*0.9, width*0.1)];
    label12.textAlignment = NSTextAlignmentCenter;
    label12.textColor = [UIColor redColor];
    label12.font = [UIFont systemFontOfSize:18];
    label12.text = @"请在服务结束时扫描用户二维码";
    [fourView addSubview:label12];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label12.frame), width*0.9, width*0.1)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor redColor];
    label2.font = [UIFont systemFontOfSize:18];
    label2.text = @"超时超公里请告诉用户线上支付";
    [fourView addSubview:label2];
    
    
    UIButton *jieshu = [UIButton buttonWithType:UIButtonTypeCustom];
    jieshu.frame = CGRectMake(-width*0.05, CGRectGetMaxY(label2.frame)+width*0.1, width, width*0.13);
    jieshu.backgroundColor = Color(7, 187, 177);
    [jieshu setTitle:@"点击扫码结束服务" forState:UIControlStateNormal];
    [jieshu setTintColor:[UIColor whiteColor]];
    jieshu.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18
                              ];
    [jieshu addTarget:self action:@selector(saomaEnd:) forControlEvents:UIControlEventTouchUpInside];
    [fourView addSubview:jieshu];
}

// 拿到外界传来的时间戳
-(void)setFuwuTimestamp:(NSInteger)fuwuTimestamp {
    _fuwuTimestamp = fuwuTimestamp;
    if (_fuwuTimestamp != 0) {
        _fuwuTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fuwuTimer:) userInfo:nil repeats:YES];
    }
}



-(void)fuwuTimer:(NSTimer*)timer{
    _fuwuTimestamp++;
    [self getfuwuTimeWithTimestamp:_fuwuTimestamp];
    [self getKmTamp:_fuwuTimestamp];
    if (_fuwuTimestamp <= 0) {
        [_fuwuTimer invalidate];
        _fuwuTimer = nil;
    }
}
-(void)getKmTamp:(NSInteger)timetamp {
    
    wangye = 0.0;
    [HttpManager postData:@{@"userid":[ZCUserData share].userId,@"id":_postIdString,@"carid":_detailsDict[@"xcxq"][@"carid"]} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=maps_list" success:^(NSDictionary *fanhuicanshu) {
        
        NSArray *array = fanhuicanshu[@"list"];
        
        if (array.count >= 2) {
            
            for (int i = 0; i< array.count-1; i++) {
                
                for (int j= i+1; j< i+2; j++) {
                    
                    NSString * s = array[i][@"latitude"];
                    
                    float a = [s floatValue];
                    
                    NSString * s1 = array[i][@"longitude"];
                    
                    float b = [s1 floatValue];
                    
                    
                    NSString * s2 = array[j][@"latitude"];
                    
                    float a1 = [s2 floatValue];
                    
                    NSString * s3 = array[j][@"longitude"];
                    
                    float b1 = [s3 floatValue];
                    
                    
                    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(a,b));
                    
                    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(a1,b1));
                    //2.计算距离
                    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
                    
                    wangye += distance;
                }
            }
        }
        
        NSLog(@"%.2f",wangye);
        gonglilbale.text = [NSString stringWithFormat:@"%.2f",(wangye/1000)];
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
    
}

- (void)getfuwuTimeWithTimestamp:(NSInteger)fuwuTamp{
    NSInteger ms = fuwuTamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
    NSString *q;
    NSString *a;
    NSString *b;
    NSString *c;
    
    
    q = [NSString stringWithFormat:@"%zd",day];
    
    a = [NSString stringWithFormat:@"%zd",hour];
    
    b = [NSString stringWithFormat:@"%zd",minute];
    
    c = [NSString stringWithFormat:@"%zd",second];
    
    timelabel.text = [NSString stringWithFormat:@"%@:%@:%@",a,b,c];
}


-(void)saomaEnd:(UIButton *)saoMaButton {
    
    [_fuwuTimer invalidate];
    _fuwuTimer = nil;
    [_timeWdd invalidate];
    _timeWdd = nil;
    
    ErWeiMaView *erView = [ErWeiMaView new];
    erView.idString = _postIdString;
    erView.gongliString = gonglilbale.text;
    [self.navigationController pushViewController:erView animated:YES];
    
}




@end
