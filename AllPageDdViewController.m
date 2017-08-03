//
//  XiangqingController.m
//  ZuChe
//
//  Created by apple  on 16/12/21.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "AllPageDdViewController.h"
#import "Header.h"
#import "WB_Stopwatch.h"
#import "DetailsCarXclTableViewCell.h"
#import "CommentTableViewCell.h"
#import "HttpManager.h"
#import "ZCUserData.h"
#import "NoPayTableViewCell.h"

#import <MapKit/MapKit.h>
#import<CoreLocation/CoreLocation.h>
#import "MBSliderView.h"

//#import "WSStarRatingView.h"
#define JXZPATH_URL @"http://wx.leisurecarlease.com/api.php?op=api_xcxqjxz"

@interface AllPageDdViewController()<WB_StopWatchDelegate,MKMapViewDelegate,CLLocationManagerDelegate,MBSliderViewDelegate>{
    
    CGFloat width;
    
    UIScrollView *_scrollerView;
    
    UITableView *_tableView;
    
    WB_Stopwatch *stopLabel;
    
    CGFloat _scrollerContenHeight;
    
    // NSMutableArray *_dataArray;
    
    NSMutableDictionary *_detailsDict;

    NSString *_dayCha;
    
    //
}
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CLLocationManager *localManager;
//地图
@property (nonatomic, strong) MKMapView *mapView;
//存放用户位置的数组
@property (nonatomic, strong) NSMutableArray *locationMutableArray;
//滑块带边框
@property (strong, nonatomic) MBSliderView *MBSlider;



@end



@implementation AllPageDdViewController



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.mapView.delegate = nil;
    self.localManager.delegate = nil;
    [self.mapView removeFromSuperview];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
    // _dataArray = [NSMutableArray new];
    _detailsDict = [NSMutableDictionary new];
    self.view.backgroundColor = [UIColor whiteColor];
    width = self.view.frame.size.width;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(gobackTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    
    //    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    //    right.frame = CGRectMake(0, 0, 30, 30);
    //    [right setBackgroundImage:[UIImage imageNamed:@"Hi聊天.png"] forState:UIControlStateNormal];
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    //
    [self initArrayData];
      // [self createTableView];
}



/**
 返回主视图
 */
- (void)gobackTo{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initArrayData {
    
    
    
    NSDictionary *dicr = @{@"id":_postIdString,@"userid": [ZCUserData share].userId};
    
    [HttpManager postData:dicr andUrl:JXZPATH_URL success:^(NSDictionary *fanhuicanshu) {
    
    [_detailsDict addEntriesFromDictionary:fanhuicanshu];
        
    NSLog(@"%@",_detailsDict);

    NSString *status = _detailsDict[@"xcxq"][@"state"];
        
        NSLog(@"%@",status);
        
//        if ([status isEqualToString:@"未到达"]) {
//            [self creatfirstView];
//            [self creatzfdjthirdView];
//            [self creatwddfourView];
//              _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
//        }
        if ([status isEqualToString:@"待处理"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatdclfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
        }
        if ([status isEqualToString:@"待支付定金"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatzfdjfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
        }
        if ([status isEqualToString:@"未开始"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
          //  [self creatDzfwkfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
        }
        if ([status isEqualToString:@"未到达"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatwddfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
        }
        if ([status isEqualToString:@"已到达"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatyddfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
        }
        if ([status isEqualToString:@"待支付尾款"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatydzfwkfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight+64);
        }
        if ([status isEqualToString:@"服务中"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatfwzFourTwoView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight+64);
        }
        if ([status isEqualToString:@"未评价"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
            [self creatWpjFourTwoView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight+64);
        }
        if ([status isEqualToString:@"已评价"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
          //  [self creatwddfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
        }
        if ([status isEqualToString:@"已拒绝"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
         //   [self creatwddfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
        }
        if ([status isEqualToString:@"已取消"]) {
            [self creatfirstView];
            [self creatzfdjthirdView];
          //  [self creatwddfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
        }
        

        } Error:^(NSString *cuowuxingxi) {
            NSLog(@"%@<<<<<<<<<<<<",cuowuxingxi);
        }];
    
}
-(void)creatScrollerView {
    _scrollerContenHeight = 0;
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _scrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollerView];
    
    _scrollerView.contentOffset = CGPointMake(0, 0);
    
}
-(void)creatydzfwkfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.3*ScreenHeight)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.3*ScreenHeight+width*0.08;
    [_scrollerView addSubview:fourView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(width/2-width*0.1-0.05*width, width*0.08, width*0.2, width*0.2);
    
    [button setBackgroundImage:[UIImage imageNamed:@"计时框.png"] forState:UIControlStateNormal];
    [fourView addSubview:button];
    
    stopLabel = [[WB_Stopwatch alloc] initWithLabel:stopLabel andTimerType:WBTypeTimer];
    stopLabel.frame = CGRectMake(width/2-width*0.1-0.05*width, width*0.08, width*0.2, width*0.2);
    stopLabel.delegate = self;
    stopLabel.textColor = Color(255, 97, 57);
    stopLabel.font =[UIFont fontWithName:@"Helvetica-Bold" size:15];
    stopLabel.textAlignment = NSTextAlignmentCenter;
    [stopLabel setTimeFormat:@"mm:ss"];
    // ************************ 时间是后台获取的 ***********************************
    [stopLabel setCountDownTime:1800];
    [stopLabel start];
    [fourView addSubview:stopLabel];
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width, CGRectGetMaxY(stopLabel.frame)+width*0.05, width*0.6, width*0.08)];
    duan.textColor = Color(255, 97, 57);
    duan.text = @"请给租客半小时支付时间";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    
    UILabel *duan1= [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-0.05*width, CGRectGetMaxY(duan.frame), width*0.8, width*0.08)];
    duan1.textColor = Color(255, 97, 57);
    duan1.text = @"请告知租客，支付尾款后开始服务";
    duan1.textAlignment = NSTextAlignmentCenter;
    duan1.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(width/2-width*0.3-0.05*width, CGRectGetMaxY(duan1.frame)+width*0.04, width*0.6, width*0.1);
    [button2 setTitle:@"待支付尾款" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonZfwkjClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.tintColor = [UIColor whiteColor];
    button2.backgroundColor = Color(7, 187, 177);
    [fourView addSubview:button2];
}
-(void)buttonZfwkjClick: (UIButton *)zfwkButton {
    NSLog(@"待支付尾款");
}

-(void)creatfirstView {
    
    [self creatScrollerView];
    UIView *fisrView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, 0.9*width, 0.77*width+66)];
    // fisrView.backgroundColor = [UIColor yellowColor];
    _scrollerContenHeight+= 0.77*width+66;
    [_scrollerView addSubview:fisrView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, 0.9*width, 1)];
    [topView setBackgroundColor:[UIColor grayColor]];
    [_scrollerView
     addSubview:topView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.02, width*0.3, width*0.1)];
    label.text = @"日期";
    label.textColor = Color(87, 87, 87);
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    //label.font = [UIFont systemFontOfSize:20];
    // label.textColor = [UIColor blackColor];
    [fisrView addSubview:label];
    
    UILabel *zhou = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), width*0.02, fisrView.frame.size.width*0.5-0.05*width, width*0.08)];
    
    zhou.text = [NSString stringWithFormat:@"%@,%@",_detailsDict[@"xcxq"][@"zhou"],_detailsDict[@"xcxq"][@"yueri"]];
    zhou.textColor = Color(140, 140, 140);
    zhou.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    zhou.textAlignment = NSTextAlignmentRight;
    [fisrView addSubview:zhou];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+20, 0.9*width, 1)];
    //    [grayView setBackgroundColor:[UIColor colorWithDisplayP3Red:242 green:242 blue:242 alpha:1]];
    grayView.backgroundColor = Color(170, 170, 170);
    [fisrView addSubview:grayView];
    
    UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(grayView.frame)+10,width*0.3, width*0.1)];
    label11.text = @"联系";
    //    CGColorRef *color =Color(<#a#>, <#b#>, <#c#>);
    //    label11.textColor = [UIColor ];
    label11.textColor = Color(87, 87, 87);
    label11.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    label11.textAlignment = NSTextAlignmentLeft;
    [fisrView addSubview:label11];
    
    UILabel *lainxi = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), CGRectGetMaxY(zhou.frame), fisrView.frame.size.width*0.5-0.05*width, width*0.05)];
    //    lainxi.text = [self SystomTime];
    lainxi.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"shijian"]];
    lainxi.textColor = Color(170, 170, 170);
    lainxi.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    lainxi.textAlignment = NSTextAlignmentRight;
    
    [fisrView addSubview:lainxi];
    
    UILabel *zhou11 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), CGRectGetMaxY(grayView.frame)+10, fisrView.frame.size.width*0.5-0.05*width, width*0.08)];
    //    zhou11.text = @"15138841681";
    zhou11.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"tel"]];
    zhou11.textColor = Color(140, 140, 140);
    zhou11.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    zhou11.textAlignment = NSTextAlignmentRight;
    [fisrView addSubview:zhou11];
    
    UILabel *shi11 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), CGRectGetMaxY(zhou11.frame), fisrView.frame.size.width*0.5-0.05*width, width*0.05)];
    //    shi11.text = @"徐吊样";
    shi11.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"username"]];
    shi11.textColor = Color(170, 170, 170);
    shi11.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    //    shi11.textColor = [UIColor grayColor];
    shi11.textAlignment = NSTextAlignmentRight;
    [fisrView addSubview:shi11];
    
    UIView *grayView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shi11.frame)+10, 0.9*width, 1)];
    grayView1.backgroundColor =  Color(170, 170, 170);
    [fisrView addSubview:grayView1];
    
    UIView *image = [[UIView alloc] initWithFrame:CGRectMake(-width*0.05, CGRectGetMaxY(grayView1.frame)+8, width, width*0.4)];
    [fisrView addSubview:image];
   
    
    //地图设置
    _mapView = [[MKMapView alloc] initWithFrame:image.frame];
    _mapView.delegate = self;
    _mapView.zoomEnabled = YES;
    _mapView.showsUserLocation = YES;
    _mapView.scrollEnabled = YES;
     [fisrView addSubview:_mapView];
    
    
    
    //是否启用定位服务
    if ([CLLocationManager locationServicesEnabled]){
        NSLog(@"开始定位");
        
          [self.localManager startUpdatingLocation];

    }
    else{
        
        NSLog(@"定位服务为关闭状态,无法使用定位服务");
    }
    
//    //用户位置追踪
  //  _mapView.userTrackingMode = MKUserTrackingModeFollow;
    /**
     地图的样式:
     MKMapTypeStandard, 标准地图
     MKMapTypeSatellite, 卫星地图
     MKMapTypeHybrid, 混合地图
     MKMapTypeSatelliteFlyover, 卫星立体地图
     MKMapTypeHybridFlyover, 混合立体地图
     */
//    _mapView.mapType = MKMapTypeStandard;
    
 
    
    
    
    
    UILabel *dizhi = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame)+10, width*0.9, width*0.08)];
    dizhi.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"address"]];
    dizhi.textColor = [UIColor grayColor];
    dizhi.textAlignment = NSTextAlignmentLeft;
    dizhi.font = [UIFont systemFontOfSize:13];
    [fisrView addSubview:dizhi];
    
    UIView *grayView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dizhi.frame)+10, 0.9*width, 1)];
    grayView11.backgroundColor =  Color(170, 170, 170);
    [fisrView addSubview:grayView11];
    
}

//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//    
//    [self.mapView removeFromSuperview];
//    [_scrollerView addSubview:_mapView];
//}
-(void)creatzfdjthirdView {
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.1*ScreenHeight)];
    //thirdView.backgroundColor = [UIColor greenColor];
    _scrollerContenHeight+= 0.1*ScreenHeight;
    [_scrollerView addSubview:thirdView];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.1*ScreenHeight, 0.9*width, 1)];
    grayView.backgroundColor = Color(170, 170, 170);
    [thirdView addSubview:grayView];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0.03*ScreenHeight, 0.08*ScreenHeight, 0.04*ScreenHeight)];
    leftLabel.text = @"收益";
    leftLabel.textAlignment = NSTextAlignmentLeft;
    //
    leftLabel.textColor = Color(87, 87, 87);
    leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [thirdView addSubview:leftLabel];
    
    
    
    
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.9*width-0.2*ScreenHeight,0.03*ScreenHeight, 0.2*ScreenHeight, 0.04*ScreenHeight)];
    NSInteger shouyi = [_detailsDict[@"xcxq"][@"shouyi"] integerValue];
    rightLabel.text = [NSString stringWithFormat:@"%@ %ld",@"¥",shouyi];
    rightLabel.textColor = [UIColor redColor];
    rightLabel.textColor = Color(255, 97, 57);
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [thirdView addSubview:rightLabel];
    
}

/**
 待支付定金
 */
-(void)creatzfdjfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.4*ScreenHeight)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.4*ScreenHeight;
    [_scrollerView addSubview:fourView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(width/2-width*0.1-0.05*width, width*0.08, width*0.2, width*0.2);
    [button setBackgroundImage:[UIImage imageNamed:@"计时框.png"] forState:UIControlStateNormal];
    [fourView addSubview:button];
    
    stopLabel = [[WB_Stopwatch alloc] initWithLabel:stopLabel andTimerType:WBTypeTimer];
    stopLabel.frame = CGRectMake(width/2-width*0.1-0.05*width, width*0.08, width*0.2, width*0.2);
    stopLabel.delegate = self;
    stopLabel.textColor = Color(255, 97, 57);
    stopLabel.font =[UIFont fontWithName:@"Helvetica-Bold" size:15];
    stopLabel.textAlignment = NSTextAlignmentCenter;
    [stopLabel setTimeFormat:@"mm:ss"];
    // ************************ 时间是后台获取的 ***********************************
    [stopLabel setCountDownTime:3599];
    [stopLabel start];
    [fourView addSubview:stopLabel];
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stopLabel.frame)+width*0.05, width*0.9, width*0.08)];
    duan.textColor = Color(255, 97, 57);
    duan.text = @"请给租客1小时的支付定金";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(duan.frame)+width*0.02, width*0.9, width*0.08)];
    chang.textColor = Color(255, 97, 57);
    chang.text = @"逾期未支付系统将自动取消订单";
    chang.textAlignment = NSTextAlignmentCenter;
    chang.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:chang];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(width/2-width*0.3-0.05*width, CGRectGetMaxY(chang.frame)+width*0.02, width*0.6, width*0.1);
    [button2 setTitle:@"待支付定金" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonZfdjClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.tintColor = [UIColor whiteColor];
    button2.backgroundColor = Color(7, 187, 177);
    [fourView addSubview:button2];
    
}
// 待支付定金的点击支付定金
-(void)buttonZfdjClick:(UIButton *)Zfbutton {
    NSLog(@"点击了支付定金");
}


-(void)timerLabel:(WB_Stopwatch*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    NSLog(@"时间结束");
}
-(void)timerLabel:(WB_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WB_StopwatchLabelType)timerType{
    
    //    NSLog(@"开始计时");
    
}


/**
 待支付尾款
 */

-(void)creatDzfwkfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.4*ScreenHeight)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.4*ScreenHeight;
    [_scrollerView addSubview:fourView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(width/2-width*0.1-0.05*width, width*0.08, width*0.2, width*0.2);
    [button setBackgroundImage:[UIImage imageNamed:@"计时框.png"] forState:UIControlStateNormal];
    [fourView addSubview:button];
    
    stopLabel = [[WB_Stopwatch alloc] initWithLabel:stopLabel andTimerType:WBTypeTimer];
    stopLabel.frame = CGRectMake(width/2-width*0.1-0.05*width, width*0.08, width*0.2, width*0.2);
    stopLabel.delegate = self;
    stopLabel.textColor = Color(255, 97, 57);
    stopLabel.font =[UIFont fontWithName:@"Helvetica-Bold" size:15];
    stopLabel.textAlignment = NSTextAlignmentCenter;
    [stopLabel setTimeFormat:@"mm:ss"];
    // ************************ 时间是后台获取的 ***********************************
    [stopLabel setCountDownTime:3599/2];
    [stopLabel start];
    [fourView addSubview:stopLabel];
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stopLabel.frame)+width*0.05, width*0.9, width*0.08)];
    duan.textColor = Color(255, 97, 57);
    duan.text = @"请给租客半小时的支付时间";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(duan.frame)+width*0.02, width*0.9, width*0.08)];
    chang.textColor = Color(255, 97, 57);
    chang.text = @"请告知租客需支付尾款后开始服务";
    chang.textAlignment = NSTextAlignmentCenter;
    chang.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:chang];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(width/2-width*0.3-0.05*width, CGRectGetMaxY(chang.frame)+width*0.02, width*0.6, width*0.1);
    [button2 setTitle:@"待支付尾款" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonDzfwkjClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.tintColor = [UIColor whiteColor];
    button2.backgroundColor = Color(7, 187, 177);
    [fourView addSubview:button2];
    
}

/**
 buttonClick
 
 @param buton 待支付尾款
 */
-(void)buttonDzfwkjClick:(UIButton *)buton {
    NSLog(@"待支付尾款");
}



/**
 
 服务中订单
 */

-(void)creatfwzFourTwoView {
    
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.96*ScreenWidth)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.86*ScreenWidth+20;
    [_scrollerView addSubview:fourView];
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - width*0.38, width*0.05, width*0.35, width*0.35)];
    //            image1.backgroundColor = [UIColor purpleColor];
    image1.image = [UIImage imageNamed:@"找车@3x.png"];
    [fourView addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2+width*0.03-0.1*width, width*0.05, width*0.35, width*0.35)];
    //image2.backgroundColor = [UIColor purpleColor];
    image2.image = [UIImage imageNamed:@"找车@3x.png"];
    [fourView addSubview:image2];
    
    stopLabel = [[WB_Stopwatch alloc] initWithLabel:stopLabel andTimerType:WBTypeTimer];
    stopLabel.frame = CGRectMake(width/2 - width*0.38+width*0.175/2, width*0.05+width*0.175/2, width*0.175, width*0.175);
    stopLabel.delegate = self;
    //_stopWatch.backgroundColor = [UIColor greenColor];
    stopLabel.textColor = Color(255, 97, 57);
    stopLabel.textAlignment = NSTextAlignmentCenter;
    [stopLabel setTimeFormat:@"mm:ss"];
    // ************************ 时间是后台获取的 ***********************************
    [stopLabel setCountDownTime:900];
    [stopLabel start];
    [fourView addSubview:stopLabel];
    
    UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake(width/2+width*0.03+width*0.175/2-0.1*width, width*0.05+width*0.175/2, width*0.175, width*0.175)];
    timeLable.text = [NSString stringWithFormat:@"%@",@"45.5"];
    // timeLable .backgroundColor = [UIColor greenColor];
    timeLable.textColor = Color(255, 97, 57);
    timeLable.textAlignment = NSTextAlignmentCenter;
    timeLable.font = [UIFont systemFontOfSize:18];
    [fourView addSubview:timeLable];
    
    UILabel *sJcheng = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.38+width*0.35/2, width*0.05+width*0.35*2/3, width*0.175, width*0.175)];
    sJcheng.text = @"时间";
    //licheng .backgroundColor = [UIColor greenColor];
    sJcheng.textColor = Color(255, 97, 57);
    sJcheng.textAlignment = NSTextAlignmentCenter;
    sJcheng.font = [UIFont systemFontOfSize:14];
    [fourView addSubview:sJcheng];
    
    
    UILabel *licheng = [[UILabel alloc] initWithFrame:CGRectMake(width/2+width*0.03+width*0.35/2-0.1*width, width*0.05+width*0.35*2/3, width*0.175, width*0.175)];
    licheng.text = @"里程";
    //licheng .backgroundColor = [UIColor greenColor];
    licheng.textColor = Color(255, 97, 57);
    licheng.textAlignment = NSTextAlignmentCenter;
    licheng.font = [UIFont systemFontOfSize:14];
    [fourView addSubview:licheng];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image1.frame)+width*0.08, width*0.9, width*0.08)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = Color(255, 97, 57);
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"以实际车辆记录里程为准";
    [fourView addSubview:label1];
    
    
    UILabel *label12 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), width*0.9, width*0.1)];
    label12.textAlignment = NSTextAlignmentCenter;
    label12.textColor = Color(255, 97, 57);
    label12.font = [UIFont systemFontOfSize:14];
    label12.text = @"请在服务结束时扫描租客二维码";
    [fourView addSubview:label12];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label12.frame), width*0.9, width*0.1)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = Color(255, 97, 57);
    label2.font = [UIFont systemFontOfSize:14];
    label2.text = @"超时超公里费用请与租客现场结算";
    [fourView addSubview:label2];
    
    
    UIButton *jieshu = [UIButton buttonWithType:UIButtonTypeCustom];
    jieshu.frame = CGRectMake(width*0.2-0.05*width, CGRectGetMaxY(label2.frame)+width*0.025, width*0.6, width*0.08);
    jieshu.backgroundColor = Color(7, 187, 177);
    [jieshu setTitle:@"扫码并结束" forState:UIControlStateNormal];
    [jieshu setTintColor:[UIColor whiteColor]];
    [jieshu addTarget:self action:@selector(saomaEnd:) forControlEvents:UIControlEventTouchUpInside];
    [fourView addSubview:jieshu];
}

-(void)saomaEnd:(UIButton *)saoMaButton {
    
    NSLog(@"扫码并结束");
}
//待处理
-(void)creatdclfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.4*ScreenHeight)];
   // fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.4*ScreenHeight;
    [_scrollerView addSubview:fourView];
    
    
    
    UIImageView *bottonImageView = [UIImageView new];
    bottonImageView.image = [UIImage imageNamed:@"logo浅.png"];
    bottonImageView.alpha = 0.6;
    bottonImageView.frame = CGRectMake(0.9*width/2-width*0.075, width*0.13, width*0.15, width*0.15);
    //bottonImageView.backgroundColor = [UIColor redColor];
    [fourView addSubview:bottonImageView];
    
    UIButton *jieButton = [UIButton buttonWithType:UIButtonTypeCustom];
    jieButton.frame = CGRectMake(0.05*width, CGRectGetMaxY(bottonImageView.frame)+20, 0.35*width,  0.05*ScreenHeight);
    jieButton.tag = 123;
    jieButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [jieButton setTitle:@"拒" forState:UIControlStateNormal];
    [jieButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //jieButton.backgroundColor = [UIColor redColor];
     jieButton.layer.borderWidth = 1;
    jieButton.layer.borderColor = [UIColor grayColor].CGColor;
    [jieButton addTarget:self action:@selector(jieju:) forControlEvents:UIControlEventTouchUpInside];
   // [jieButton setBackgroundImage:[UIImage imageNamed:@"拒.png"] forState:UIControlStateNormal];
    [fourView addSubview:jieButton];
    
    UIButton *juButton = [UIButton buttonWithType:UIButtonTypeCustom];
    juButton.frame = CGRectMake(width*0.5, 20 + CGRectGetMaxY(bottonImageView.frame), 0.35*width, 0.05*ScreenHeight);
    juButton.tag = 124;
    juButton.layer.borderWidth = 1;
    juButton.layer.borderColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1].CGColor;
    juButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [juButton setTitle:@"接" forState:UIControlStateNormal];
    [juButton setTitleColor:[UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1]forState:UIControlStateNormal];
    [juButton addTarget:self action:@selector(jieju:) forControlEvents:UIControlEventTouchUpInside];
    //[juButton setBackgroundImage:[UIImage imageNamed:@"接.png"] forState:UIControlStateNormal];
    [fourView addSubview:juButton];
    
}
-(void)jieju:(UIButton *)button {
    
    NSInteger btnTag = button.tag-123;
    if (btnTag == 0) {
        NSLog(@"ju单");
    }else {
        NSLog(@"jie单");
    }
}

/**
 未到达  修改了底层的view高度 以前为0.4*ScreenHeight
 */

 -(void)creatwddfourView {
   UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.4*ScreenHeight)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.4*ScreenHeight+64;
    [_scrollerView addSubview:fourView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(width/2-width*0.1-0.05*width, width*0.08, width*0.2, width*0.2);
    [button setBackgroundImage:[UIImage imageNamed:@"计时框.png"] forState:UIControlStateNormal];
    [fourView addSubview:button];
    
     
     
     NSDate *currentDate = [NSDate date];//获取当前时间，日期
     
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
     
     NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
     
     [calendar setTimeZone: timeZone];
     
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     
     [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
     
     NSString *starString = [dateFormatter stringFromDate:currentDate];
     
     NSArray *array = [_timeString componentsSeparatedByString:@"月"];
     NSString *endString = [[[array componentsJoinedByString:@"-"] componentsSeparatedByString:@"."] componentsJoinedByString:@" "];
     
     
     _dayCha = [self dateTimeDifferenceWithStartTime:starString endTime:endString];
     
     
     
     UILabel  *newLabel= [UILabel new];
     newLabel.frame = CGRectMake(width/2-width*0.1-0.05*width, width*0.08, width*0.2, width*0.2);
     newLabel.textColor = Color(255, 97, 57);
     newLabel.font =[UIFont fontWithName:@"Helvetica-Bold" size:15];
     newLabel.text= [NSString stringWithFormat:@"%@天",[_dayCha componentsSeparatedByString:@"-"][0]];
     newLabel.textAlignment = NSTextAlignmentCenter;
     [fourView addSubview:newLabel];

    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(newLabel.frame)+width*0.05, width*0.9, width*0.08)];
    duan.textColor = Color(255, 97, 57);
    duan.text = @"提前到达有助您获得更多的订单";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(duan.frame)+width*0.02, width*0.9, width*0.08)];
    chang.textColor = Color(255, 97, 57);
    chang.text = @"距离约定地点1公里内确认到达";
    chang.textAlignment = NSTextAlignmentCenter;
    chang.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:chang];
   
     
     _MBSlider = [[MBSliderView alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width, CGRectGetMaxY(chang.frame)+width*0.02, width*0.6, width*0.1)];
     _MBSlider.layer.borderWidth = 1.0;
     UIColor *itemColor = Color(7, 187, 177);
     _MBSlider.layer.borderColor = [itemColor CGColor];
     _MBSlider.backgroundColor = [UIColor whiteColor];
     _MBSlider.layer.cornerRadius = 5.0;
     [_MBSlider setText:@"滑动确认到达"];
     UIColor *itemColor2 = Color(0, 215, 200);
     [_MBSlider setThumbColor:itemColor];
     [_MBSlider setLabelColor:itemColor2];
     [_MBSlider setDelegate:self];
     [fourView addSubview:_MBSlider];
     
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = CGRectMake(width/2-width*0.3-0.05*width, CGRectGetMaxY(chang.frame)+width*0.02, width*0.6, width*0.1);
//    [button2 setTitle:@"确认到达" forState:UIControlStateNormal];
//    
//    [button2 addTarget:self action:@selector(buttonQrDdClick:) forControlEvents:UIControlEventTouchUpInside];
//    button2.tintColor = [UIColor whiteColor];
//    button2.backgroundColor = Color(7, 187, 177);
//    [fourView addSubview:button2];
    
}
- (void)sliderDidSlide:(MBSliderView *)slideView{
    
    NSArray *timeArray = [_dayCha componentsSeparatedByString:@"-"];
    
    int d = 0;
    int m = 0;
    int s = 0;
    
    d = [timeArray[0] intValue];
    m = [timeArray[1] intValue];
    s = [timeArray[2] intValue];
    
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    //地图精确到10以内
    
    // _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [myGeocoder geocodeAddressString:[NSString stringWithFormat:@"上海市%@",_detailsDict[@"xcxq"][@"address"]] completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            NSLog(@"%f",firstPlacemark.location.coordinate.latitude);
            NSLog(@"%f",firstPlacemark.location.coordinate.longitude);
            NSLog(@"这个东西到底是啥 = %@", firstPlacemark);
            
            NSString *locationStr = _locationMutableArray.lastObject;
            NSArray *temp = [locationStr componentsSeparatedByString:@","];
            NSString *latitudeStr = temp[0];
            NSString *longitudeStr = temp[1];
            CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake([latitudeStr doubleValue], [longitudeStr doubleValue]);
            
            float la = firstPlacemark.location.coordinate.latitude;
            float lo = firstPlacemark.location.coordinate.longitude;
            CLLocationCoordinate2D endCoordinate = CLLocationCoordinate2DMake(la,lo);
            CLLocationDistance distance = [self calculateDistanceWithStart:startCoordinate end:endCoordinate];
            NSLog(@"我曹了哦 这个距离有点吊啊啊%f",distance);
            
            if (distance<= 1000.0) {
                
                if (m <= 0 && s <=0 && d <= 0) {
                    //迟到
                    [HttpManager postData:@{@"orderid":_detailsDict[@"state"][@"id"],@"carid":_detailsDict[@"xcxq"][@"carid"],@"type":@"2"} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_qrdd" success:^(NSDictionary *fanhuicanshu) {
                        
                        NSLog(@"%@",fanhuicanshu);
                        
                    } Error:^(NSString *cuowuxingxi) {
                        
                        NSLog(@"%@",cuowuxingxi);
                        
                    }];
                }else {
                    //到达
                    [HttpManager postData:@{@"orderid":_detailsDict[@"state"][@"id"],@"carid":_detailsDict[@"xcxq"][@"carid"],@"type":@"1"} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_qrdd" success:^(NSDictionary *fanhuicanshu) {
                        
                        NSLog(@"%@",fanhuicanshu);
                        
                    } Error:^(NSString *cuowuxingxi) {
                        
                        NSLog(@"%@",cuowuxingxi);
                        
                    }];
                }
            }else {
                //未到达
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未到达指定日期或者车辆距离集合地点超过1公里!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
            
            
            
        }
        else if ([placemarks count] == 0 && error == nil) {
            NSLog(@"Found no placemarks.");
        }
        else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }
     ];
}

- (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;

    int minute = (int)value /60%60;
    //
    int house = (int)value / (24 * 3600)%3600;
    
    int day = (int)value / (24 * 3600);
    
    NSString *dStr;
    NSString *hStr;
    NSString *mStr;
    
    if (day != 0) {
        
        dStr = [NSString stringWithFormat:@"%d",day];
        
    }else {
          dStr = [NSString stringWithFormat:@"%d",[@"0" intValue]];
    }
    
    
    if (house != 0) {
        
        hStr = [NSString stringWithFormat:@"%d",house];
        
    }else {
        hStr = [NSString stringWithFormat:@"%d",[@"0" intValue]];
    }
    
    
    if (minute != 0) {
        
        mStr = [NSString stringWithFormat:@"%d",minute];
        
    }else {
          mStr = [NSString stringWithFormat:@"%d",[@"0" intValue]];
    }
    return [NSString stringWithFormat:@"%@-%@-%@",dStr,hStr,mStr];
    
}

-(void)buttonQrDdClick:(UIButton *)qrDdButton {
    
    NSArray *timeArray = [_dayCha componentsSeparatedByString:@"-"];
    
    int d = 0;
    int m = 0;
    int s = 0;
    
    d = [timeArray[0] intValue];
    m = [timeArray[1] intValue];
    s = [timeArray[2] intValue];
    
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    //地图精确到10以内
    
    // _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [myGeocoder geocodeAddressString:[NSString stringWithFormat:@"上海市%@",_detailsDict[@"xcxq"][@"address"]] completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            NSLog(@"%f",firstPlacemark.location.coordinate.latitude);
            NSLog(@"%f",firstPlacemark.location.coordinate.longitude);
            NSLog(@"这个东西到底是啥 = %@", firstPlacemark);
            
            NSString *locationStr = _locationMutableArray.lastObject;
            NSArray *temp = [locationStr componentsSeparatedByString:@","];
            NSString *latitudeStr = temp[0];
            NSString *longitudeStr = temp[1];
            CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake([latitudeStr doubleValue], [longitudeStr doubleValue]);
            
            float la = firstPlacemark.location.coordinate.latitude;
            float lo = firstPlacemark.location.coordinate.longitude;
            CLLocationCoordinate2D endCoordinate = CLLocationCoordinate2DMake(la,lo);
            CLLocationDistance distance = [self calculateDistanceWithStart:startCoordinate end:endCoordinate];
            NSLog(@"我曹了哦 这个距离有点吊啊啊%f",distance);
            
            if (distance<= 1000.0) {
                
                if (m <= 0 && s <=0 && d <= 0) {
                    //迟到
                    [HttpManager postData:@{@"orderid":_detailsDict[@"state"][@"id"],@"carid":_detailsDict[@"xcxq"][@"carid"],@"type":@"2"} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_qrdd" success:^(NSDictionary *fanhuicanshu) {
                        
                        NSLog(@"%@",fanhuicanshu);
                        
                    } Error:^(NSString *cuowuxingxi) {
                        
                        NSLog(@"%@",cuowuxingxi);
                        
                    }];
                }else {
                    //到达
                    [HttpManager postData:@{@"orderid":_detailsDict[@"state"][@"id"],@"carid":_detailsDict[@"xcxq"][@"carid"],@"type":@"1"} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_qrdd" success:^(NSDictionary *fanhuicanshu) {
                        
                        NSLog(@"%@",fanhuicanshu);
                        
                    } Error:^(NSString *cuowuxingxi) {
                        
                        NSLog(@"%@",cuowuxingxi);
                        
                    }];
                }
            }else {
                //未到达
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未到达指定日期或者车辆距离集合地点超过1公里!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
            
        }
        else if ([placemarks count] == 0 && error == nil) {
            NSLog(@"Found no placemarks.");
        }
        else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }
     ];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}


/**
 
 未评价订单
 */

-(void)creatWpjFourTwoView {
    
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.86*ScreenWidth)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.86*ScreenWidth+20;
    [_scrollerView addSubview:fourView];
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - width*0.38, width*0.05, width*0.35, width*0.35)];
    //            image1.backgroundColor = [UIColor purpleColor];
    image1.image = [UIImage imageNamed:@"找车@3x.png"];
    [fourView addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2+width*0.03-0.1*width, width*0.05, width*0.35, width*0.35)];
    //image2.backgroundColor = [UIColor purpleColor];
    image2.image = [UIImage imageNamed:@"找车@3x.png"];
    [fourView addSubview:image2];
    
    stopLabel = [[WB_Stopwatch alloc] initWithLabel:stopLabel andTimerType:WBTypeTimer];
    stopLabel.frame = CGRectMake(width/2 - width*0.38+width*0.175/2, width*0.05+width*0.175/2, width*0.175, width*0.175);
    stopLabel.delegate = self;
    //_stopWatch.backgroundColor = [UIColor greenColor];
    stopLabel.textColor = Color(255, 97, 57);
    stopLabel.textAlignment = NSTextAlignmentCenter;
    [stopLabel setTimeFormat:@"mm:ss"];
    // ************************ 时间是后台获取的 ***********************************
    [stopLabel setCountDownTime:900];
    [stopLabel start];
    [fourView addSubview:stopLabel];
    
    UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake(width/2+width*0.03+width*0.175/2-0.1*width, width*0.05+width*0.175/2, width*0.175, width*0.175)];
    timeLable.text = [NSString stringWithFormat:@"%@",@"45.5"];
    // timeLable .backgroundColor = [UIColor greenColor];
    timeLable.textColor = Color(255, 97, 57);
    timeLable.textAlignment = NSTextAlignmentCenter;
    timeLable.font = [UIFont systemFontOfSize:18];
    [fourView addSubview:timeLable];
    
    UILabel *sJcheng = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.38+width*0.35/2, width*0.05+width*0.35*2/3, width*0.175, width*0.175)];
    sJcheng.text = @"时间";
    //licheng .backgroundColor = [UIColor greenColor];
    sJcheng.textColor = Color(255, 97, 57);
    sJcheng.textAlignment = NSTextAlignmentCenter;
    sJcheng.font = [UIFont systemFontOfSize:14];
    [fourView addSubview:sJcheng];
    
    
    UILabel *licheng = [[UILabel alloc] initWithFrame:CGRectMake(width/2+width*0.03+width*0.35/2-0.1*width, width*0.05+width*0.35*2/3, width*0.175, width*0.175)];
    licheng.text = @"里程";
    //licheng .backgroundColor = [UIColor greenColor];
    licheng.textColor = Color(255, 97, 57);
    licheng.textAlignment = NSTextAlignmentCenter;
    licheng.font = [UIFont systemFontOfSize:14];
    [fourView addSubview:licheng];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image1.frame)+width*0.08, width*0.9, width*0.08)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = Color(255, 97, 57);
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"以实际车辆记录里程为准";
    [fourView addSubview:label1];
    
    //    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), width*0.9, width*0.1)];
    //    label2.textAlignment = NSTextAlignmentCenter;
    //    label2.textColor = Color(255, 97, 57);
    //    label2.font = [UIFont systemFontOfSize:14];
    //    label2.text = @"超时超公里费用请与租客现场结算";
    //    [fourView addSubview:label2];
    //
    
    UIButton *jieshu = [UIButton buttonWithType:UIButtonTypeCustom];
    jieshu.frame = CGRectMake(width*0.2-0.05*width, CGRectGetMaxY(label1.frame)+width*0.025, width*0.6, width*0.08);
    jieshu.backgroundColor = Color(7, 187, 177);
    [jieshu setTitle:@"未评价" forState:UIControlStateNormal];
    [jieshu setTintColor:[UIColor whiteColor]];
    [jieshu addTarget:self action:@selector(wpjButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [fourView addSubview:jieshu];
}

-(void)wpjButtonClick:(UIButton *)wpjButton {
    
    NSLog(@"未评价");
}



/**
 已到达
 */

-(void)creatyddfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.4*ScreenHeight)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.4*ScreenHeight;
    [_scrollerView addSubview:fourView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(width/2-width*0.1-0.05*width, width*0.08, width*0.2, width*0.2);
    [button setBackgroundImage:[UIImage imageNamed:@"计时框.png"] forState:UIControlStateNormal];
    [fourView addSubview:button];
    
    stopLabel = [[WB_Stopwatch alloc] initWithLabel:stopLabel andTimerType:WBTypeTimer];
    stopLabel.frame = CGRectMake(width/2-width*0.1-0.05*width, width*0.08, width*0.2, width*0.2);
    stopLabel.delegate = self;
    stopLabel.textColor = Color(255, 97, 57);
    stopLabel.font =[UIFont fontWithName:@"Helvetica-Bold" size:15];
    stopLabel.textAlignment = NSTextAlignmentCenter;
    [stopLabel setTimeFormat:@"mm:ss"];
    // ************************ 时间是后台获取的 ***********************************
    [stopLabel setCountDownTime:600];
    [stopLabel start];
    [fourView addSubview:stopLabel];
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stopLabel.frame)+width*0.05, width*0.9, width*0.08)];
    duan.textColor = Color(255, 97, 57);
    duan.text = @"请联系租客确认到达约定地点";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    //    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-0.05*width, CGRectGetMaxY(duan.frame)+width*0.02, width*0.8, width*0.08)];
    //    chang.textColor = Color(255, 97, 57);
    //    chang.text = @"";
    //    chang.textAlignment = NSTextAlignmentCenter;
    //    chang.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    //  [fourView addSubview:chang];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(width/2-width*0.3-0.05*width, CGRectGetMaxY(duan.frame)+width*0.02, width*0.6, width*0.1);
    [button2 setTitle:@"已到达" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonYddClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.tintColor = [UIColor whiteColor];
    button2.backgroundColor = Color(7, 187, 177);
    [fourView addSubview:button2];
    
}

-(void)buttonYddClick:(UIButton *)yDdButton {
    
    NSLog(@"已到达");
}

#pragma mark - 位置管理者懒加载
- (CLLocationManager *)localManager
{
    if (_localManager == nil)
    {
        _localManager = [[CLLocationManager alloc]init];
        
        //设置定位的精度
        [_localManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        //位置信息更新最小距离
        _localManager.distanceFilter = 10;
        
        //设置代理
        _localManager.delegate = self;
        
        //如果没有授权则请求用户授权,
        //因为 requestAlwaysAuthorization 是 iOS8 后提出的,需要添加一个是否能响应的条件判断,防止崩溃
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined && [_localManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_localManager requestAlwaysAuthorization];
        }
        
        //创建存放位置的数组
        _locationMutableArray = [[NSMutableArray alloc] init];
    }
    return _localManager;
}

#pragma mark - MKMapViewDelegate
/**
 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）
 第一种画轨迹的方法:我们使用在地图上的变化来描绘轨迹,这种方式不用考虑从 CLLocationManager 取出的经纬度在 mapView 上显示有偏差的问题
 */
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSString *latitude = [NSString stringWithFormat:@"%3.5f",userLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%3.5f",userLocation.coordinate.longitude];
    NSLog(@"更新的用户位置:纬度:%@, 经度:%@",latitude,longitude);
    
    //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [_mapView setRegion:region animated:true];
    
    if (_locationMutableArray.count != 0) {
        
        //从位置数组中取出最新的位置数据
        NSString *locationStr = _locationMutableArray.lastObject;
        NSArray *temp = [locationStr componentsSeparatedByString:@","];
        NSString *latitudeStr = temp[0];
        NSString *longitudeStr = temp[1];
        CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake([latitudeStr doubleValue], [longitudeStr doubleValue]);
        
        //当前确定到的位置数据
        CLLocationCoordinate2D endCoordinate;
        endCoordinate.latitude = userLocation.coordinate.latitude;
        endCoordinate.longitude = userLocation.coordinate.longitude;
        
        //移动距离的计算
        double meters = [self calculateDistanceWithStart:startCoordinate end:endCoordinate];
        NSLog(@"移动的距离为%f米",meters);
        //为了美化移动的轨迹,移动的位置超过10米,方可添加进位置的数组
        if (meters >= 0){
            
            NSLog(@"添加进位置数组");
            NSString *locationString = [NSString stringWithFormat:@"%f,%f",userLocation.coordinate.latitude, userLocation.coordinate.longitude];
            [_locationMutableArray addObject:locationString];
            
            //开始绘制轨迹
            CLLocationCoordinate2D pointsToUse[2];
            pointsToUse[0] = startCoordinate;
            pointsToUse[1] = endCoordinate;
            //调用 addOverlay 方法后,会进入 rendererForOverlay 方法,完成轨迹的绘制
            MKPolyline *lineOne = [MKPolyline polylineWithCoordinates:pointsToUse count:2];
            [_mapView addOverlay:lineOne];
            
        }else{
            
            NSLog(@"不添加进位置数组");
        }
    }else{
        
        //存放位置的数组,如果数组包含的对象个数为0,那么说明是第一次进入,将当前的位置添加到位置数组
        NSString *locationString = [NSString stringWithFormat:@"%f,%f",userLocation.coordinate.latitude, userLocation.coordinate.longitude];
        [_locationMutableArray addObject:locationString];
    }
}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id)overlay{
    
    if ([overlay isKindOfClass:[MKPolyline class]]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        MKPolylineView *polyLineView = [[MKPolylineView alloc] initWithPolyline:overlay];
        polyLineView.lineWidth = 10; //折线宽度
        polyLineView.strokeColor = [UIColor blueColor]; //折线颜色
        return (MKOverlayRenderer *)polyLineView;
#pragma clang diagnostic pop
    }
    return nil;
}


#pragma mark - CLLocationManagerDelegate
/**
 *  当前定位授权状态发生改变时调用
 *
 *  @param manager 位置管理者
 *  @param status  授权的状态
 */
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:{
            NSLog(@"用户还未进行授权");
            break;
        }
        case kCLAuthorizationStatusDenied:{
            // 判断当前设备是否支持定位和定位服务是否开启
            if([CLLocationManager locationServicesEnabled]){
                
                NSLog(@"用户不允许程序访问位置信息或者手动关闭了位置信息的访问，帮助跳转到设置界面");
                
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL: url];
                }
            }else{
                NSLog(@"定位服务关闭,弹出系统的提示框,点击设置可以跳转到定位服务界面进行定位服务的开启");
            }
            break;
        }
        case kCLAuthorizationStatusRestricted:{
            NSLog(@"受限制的");
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:{
            NSLog(@"授权允许在前台和后台均可使用定位服务");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            NSLog(@"授权允许在前台可使用定位服务");
            break;
        }
            
        default:
            break;
    }
}
/**
 我们并没有把从 CLLocationManager 取出来的经纬度放到 mapView 上显示
 原因:
 我们在此方法中取到的经纬度依据的标准是地球坐标,但是国内的地图显示按照的标准是火星坐标
 MKMapView 不用在做任何的处理,是因为 MKMapView 是已经经过处理的
 也就导致此方法中获取的坐标在 mapView 上显示是有偏差的
 解决的办法有很多种,可以上网就行查询,这里就不再多做赘述
 */

#pragma mark-CLLocationManagerDelegate  位置更新后的回调

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 设备的当前位置
    CLLocation *currLocation = [locations lastObject];
    
    NSString *latitude = [NSString stringWithFormat:@"纬度:%3.5f",currLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"经度:%3.5f",currLocation.coordinate.longitude];
    NSString *altitude = [NSString stringWithFormat:@"高度值:%3.5f",currLocation.altitude];
    
    NSLog(@"位置发生改变:纬度:%@,经度:%@,高度:%@",latitude,longitude,altitude);
    
    [manager stopUpdatingLocation];
}

//定位失败的回调方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"无法获取当前位置 error : %@",error.localizedDescription);
}


#pragma mark - 距离测算
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
    return meter;
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
