//
//  XiangqingController.m
//  ZuChe
//
//  Created by apple  on 16/12/21.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "DetailsCarXclViewController.h"
#import "Header.h"
#import "WB_Stopwatch.h"
#import "DetailsCarXclTableViewCell.h"
#import "CommentTableViewCell.h"
#import "HttpManager.h"
#import "AFNetworking.h"
//#import "WSStarRatingView.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>





#define PATH_URLPOST @"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks"
#define WKSPATH_URL @"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks"
#define JXZPATH_URL @"http://wx.leisurecarlease.com/api.php?op=api_xcxqjxz"

@interface DetailsCarXclViewController()<UITableViewDataSource,UITableViewDelegate,WB_StopWatchDelegate,UIAlertViewDelegate,MAMapViewDelegate,AMapLocationManagerDelegate>{
    
    CGFloat width;
    
    UIScrollView *_scrollerView;
    
    UITableView *_tableView;
    
    WB_Stopwatch *stopLabel;
    
    CGFloat _scrollerContenHeight;
    
    NSMutableArray *_dataArray;
    
    NSMutableDictionary *_detailsDict;
    //
    //    UILabel *_scoreLabel;
    //    WSStarRatingView *_starRatingView;
    //
}
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapLocationManager *locationManager;

@end

@implementation DetailsCarXclViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad{

    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
    _dataArray = [NSMutableArray new];
    _detailsDict = [NSMutableDictionary new];
    self.view.backgroundColor = [UIColor whiteColor];
    width = self.view.frame.size.width;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
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

-(void)initArrayData {
    
    if ([_poststates isEqualToString:@"待支付定金"]) {
        
        [HttpManager postData:@{@"id":_postIdString} andUrl:PATH_URLPOST success:^(NSDictionary *fanhuicanshu) {
            
            NSLog(@"%@支付定金>>>>>>>>>>>>>>>>>>>>" ,fanhuicanshu);
            [_detailsDict addEntriesFromDictionary:fanhuicanshu];
            NSArray *gencheArray = _detailsDict[@"xcxq"][@"genche"];
            [_dataArray addObjectsFromArray:gencheArray];
                [self creatfirstView];
                [self creatzfdjSecondView];
                [self creatzfdjthirdView];
                [self creatzfdjfourView];
       
            
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
            
        } Error:^(NSString *cuowuxingxi) {
            NSLog(@"%@<<<<<<<<<<<<",cuowuxingxi);
        }];
        
    }else if([_poststates isEqualToString:@"未开始"]) {
        
        [HttpManager postData:@{@"id":_postIdString} andUrl:WKSPATH_URL success:^(NSDictionary *fanhuicanshu) {
            
            NSLog(@"%@未开始>>>>>>>>>>>>>>>>>>>>" ,fanhuicanshu);
            NSDictionary *dict = fanhuicanshu;
            [_detailsDict addEntriesFromDictionary:dict];
            NSArray *gencheArray = _detailsDict[@"xcxq"][@"genche"];
            [_dataArray addObjectsFromArray:gencheArray];
            [self creatfirstView];
            [self creatzfdjSecondView];
        
            [self creatzfdjthirdView];
            [self creatwksfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);

        } Error:^(NSString *cuowuxingxi) {
            NSLog(@"%@<<<<<<<<<<<<",cuowuxingxi);
        }];
        
    }else if([_poststates isEqualToString:@"服务中"]) {
        
        [HttpManager postData:@{@"id":_postIdString} andUrl:JXZPATH_URL success:^(NSDictionary *fanhuicanshu) {
            
            NSLog(@"%@服务中>>>>>>>>>>>>>>>>>>>>" ,fanhuicanshu);
            NSDictionary *dict = fanhuicanshu;
            [_detailsDict addEntriesFromDictionary:dict];
            NSArray *gencheArray = _detailsDict[@"xcxq"][@"genche"];
            [_dataArray addObjectsFromArray:gencheArray];
                [self creatfirstView];
                [self creatzfdjSecondView];
                [self creatzfdjthirdView];
                [self creatfwzfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
            
        } Error:^(NSString *cuowuxingxi) {
            NSLog(@"%@<<<<<<<<<<<<",cuowuxingxi);
        }];
        
    }else if([_poststates isEqualToString:@"已到达"]) {
        [self creatfirstView];
        [self creatzfdjSecondView];
        [self creatzfdjthirdView];
        [self creatyddfourView];

            _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
//            
//        } Error:^(NSString *cuowuxingxi) {
//            NSLog(@"%@<<<<<<<<<<<<",cuowuxingxi);
//        }];
//        
    }else {
            NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
            [_dataArray addObjectsFromArray:array];
            [self creatfirstView];

            [self creatwpjsecondView];
            // [self creatthirdView];
            //[self creatfourView];
            [self creatwpjFourTwoView];
        _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
    }
   
}
-(void)creatScrollerView {
    _scrollerContenHeight = 0;
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _scrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollerView];
    
    _scrollerView.contentOffset = CGPointMake(0, 0);
    
}
-(void)creatfirstView {
    
    [self creatScrollerView];
    UIView *fisrView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, 0.9*width, 0.77*width+66)];
    // fisrView.backgroundColor = [UIColor yellowColor];
    _scrollerContenHeight+= 0.77*width+66;
    [_scrollerView addSubview:fisrView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, 0.9*width, 1)];
    topView.backgroundColor = Color(233, 233, 233);
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
    grayView.backgroundColor = Color(233, 233, 233);
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
    grayView1.backgroundColor =  Color(233, 233, 233);
    [fisrView addSubview:grayView1];
    
    UIView *image = [[UIView alloc] initWithFrame:CGRectMake(-width*0.05, CGRectGetMaxY(grayView1.frame)+8, width, width*0.4)];
    [fisrView addSubview:image];
    //初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:image.frame];
    self.mapView.delegate = self;
    self.mapView.compassOrigin = CGPointMake(self.mapView.compassOrigin.x, 22);
    self.mapView.scaleOrigin = CGPointMake(self.mapView.scaleOrigin.x, 22);
    self.mapView.showsCompass = YES;
    self.mapView.zoomLevel = 13.1;
    //添加到view上
    [fisrView addSubview:self.mapView];
    
    [self.locationManager startUpdatingLocation];
    
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    
     UIImageView *middleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(width*0.9/2-13,width*0.2-30, 26, 30)];
    middleImageView.image = [UIImage  imageNamed:@"停车地点.png"];
    [self.mapView addSubview:middleImageView];
    
    
    UILabel *dizhi = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame)+10, width*0.9, width*0.08)];
    dizhi.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"address"]];
    dizhi.textColor = [UIColor grayColor];
    dizhi.textAlignment = NSTextAlignmentLeft;
    dizhi.font = [UIFont systemFontOfSize:13];
    [fisrView addSubview:dizhi];
    
    UIView *grayView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dizhi.frame)+10, 0.9*width, 1)];
    grayView11.backgroundColor =  Color(233, 233, 233);
    [fisrView addSubview:grayView11];
    
    [self onClick:@"上海市" AndaddText:[NSString stringWithFormat:@"%@",dizhi.text]];
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
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    
}
/**
 支付定金状态
 @return 支付定金状态的控件
 */

-(void)creatzfdjSecondView {
    
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, _dataArray.count*0.13*ScreenHeight)];
    // secondView.backgroundColor = [UIColor orangeColor];
    _scrollerContenHeight+= 0.13*ScreenHeight*_dataArray.count+ 2*_dataArray.count;
    [_scrollerView addSubview:secondView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(secondView.frame), _dataArray.count*0.13*ScreenHeight+ 2*_dataArray.count) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource =self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor redColor];
    [secondView addSubview:_tableView];
    
}
-(void)creatzfdjthirdView {
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.3*ScreenHeight)];
    //thirdView.backgroundColor = [UIColor greenColor];
    _scrollerContenHeight+= 0.3*ScreenHeight;
    [_scrollerView addSubview:thirdView];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.3*ScreenHeight, 0.9*width, 1)];
    grayView.backgroundColor = Color(170, 170, 170);
    [thirdView addSubview:grayView];
   
    NSArray *array = @[@"总价",@"定金",@"尾款"];
    NSArray *priceArray = @[@"¥ 19800",@"¥ 9800",@"¥ 10000"];
    for (int i = 0; i<3; i++) {
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.1*ScreenHeight*i+0.03*ScreenHeight, 0.08*ScreenHeight, 0.04*ScreenHeight)];
        leftLabel.text = array[i];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        //
        leftLabel.textColor = Color(87, 87, 87);
        leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        //    shi11.teleftLabel.font = [UIFont systemFontOfSize:20];
        [thirdView addSubview:leftLabel];
        if (i==0) {
            
        }else {
            UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.1*i*ScreenHeight, 0.9*width, 1)];
            //        [grayView setBackgroundColor:[UIColor colorWithDisplayP3Red:242 green:242 blue:242 alpha:1]];
            grayView.backgroundColor = Color(170, 170, 170);
            
            [thirdView addSubview:grayView];
            
        }
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.9*width-0.2*ScreenHeight, 0.1*ScreenHeight*i+0.03*ScreenHeight, 0.2*ScreenHeight, 0.04*ScreenHeight)];
        rightLabel.text = priceArray[i];
        rightLabel.textColor = [UIColor redColor];
        rightLabel.textColor = Color(255, 97, 57);
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [thirdView addSubview:rightLabel];
        
    }
}
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
    duan.text = @"请在一小时内支付定金";
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
    [button2 setTitle:@"支付定金" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonZfdjClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.tintColor = [UIColor whiteColor];
    button2.backgroundColor = Color(7, 187, 177);
    [fourView addSubview:button2];
    
    UIButton *cuo = [UIButton buttonWithType:UIButtonTypeCustom];
    cuo.frame = CGRectMake(8, CGRectGetMaxY(fourView.frame), width*0.03, width*0.03);
    [cuo setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
    [cuo addTarget:self action:@selector(cuo:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollerView addSubview:cuo];

}
/**
 未开始状态
 @return nil
 */
-(void)creatwksfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.3*ScreenHeight)];
    //fourView.backgroundColor = [UIColor purpleColor];
   _scrollerContenHeight+= 0.3*ScreenHeight+64;

    [_scrollerView addSubview:fourView];
    
    
    UIImageView *bottonImageView = [UIImageView new];
    bottonImageView.image = [UIImage imageNamed:@"logo浅.png"];
    bottonImageView.alpha = 0.6;
    bottonImageView.frame = CGRectMake(0.9*width/2-width*0.13, width*0.13, width*0.26, width*0.26);
    //bottonImageView.backgroundColor = [UIColor redColor];
    [fourView addSubview:bottonImageView];
    
    UIButton *cuo = [UIButton buttonWithType:UIButtonTypeCustom];
    cuo.frame = CGRectMake(8, CGRectGetMaxY(fourView.frame), width*0.03, width*0.03);
    [cuo setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
    [cuo addTarget:self action:@selector(cuo:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollerView addSubview:cuo];
}
/**
服务中状态
 @return nil
 */
-(void)creatfwzfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.4*ScreenHeight)];
   // fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.4*ScreenHeight+64;
    [_scrollerView addSubview:fourView];
    
    
    UIImageView *bottonImageView = [UIImageView new];
    bottonImageView.frame = CGRectMake(0.9*width/2-width*0.25, width*0.13, width*0.5, width*0.5);
    bottonImageView.alpha = 0.6;
    //bottonImageView.backgroundColor = [UIColor redColor];
   
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    //将字符串转换成NSData
    NSString  *url = @"www.baidu.com";
    NSData *data=[url dataUsingEncoding:NSUTF8StringEncoding];
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //获得滤镜输出的图像
    CIImage *outputImage=[filter outputImage];
    bottonImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    [fourView addSubview:bottonImageView];
    
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bottonImageView.frame)+0.02*width, 0.9*width, 0.03*ScreenHeight)];
    bottomLabel.text = @"司机扫描此二维码后结束服务";
    bottomLabel.textColor = Color(255, 97, 57);
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:bottomLabel];
    
 }
#pragma mark - 二维码
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width11 = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width11, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}
/**
已到达状态
 @return nil
 */
-(void)creatyddfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.3*ScreenHeight)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.3*ScreenHeight;
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
    duan.text = @"你需要在此时间内支付尾款";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(width/2-width*0.3-0.05*width, CGRectGetMaxY(duan.frame)+width*0.04, width*0.6, width*0.1);
    [button2 setTitle:@"支付尾款" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonZfwkjClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.tintColor = [UIColor whiteColor];
    button2.backgroundColor = Color(7, 187, 177);
    [fourView addSubview:button2];
}
-(void)buttonZfwkjClick: (UIButton *)zfwkButton {
    NSLog(@"支付尾款");
}
// 点击支付定金
-(void)buttonZfdjClick:(UIButton *)Zfbutton {
    NSLog(@"点击了支付定金");
}

//点击了✘号取消支付
- (void)cuo:(UIButton *)sender{
    
    //    NSLog(@"cuowu cuowu");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消订单将扣除您支付的全额定金 取消之后将无法在行程中查看订单 取消之后将无法恢复订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}



 /**
  未评价状态
  @return 未评价状态的控件
  */

-(void)creatwpjsecondView {
    
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, _dataArray.count*0.15*ScreenHeight)];
    // secondView.backgroundColor = [UIColor orangeColor];
    _scrollerContenHeight+= 0.15*ScreenHeight*_dataArray.count+ 2*_dataArray.count;
    [_scrollerView addSubview:secondView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(secondView.frame), _dataArray.count*0.15*ScreenHeight+ 2*_dataArray.count) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource =self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor redColor];
    [secondView addSubview:_tableView];
    
}
-(void)creatwpjFourTwoView {
    
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.86*ScreenWidth)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.86*ScreenWidth;
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
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(00, CGRectGetMaxY(image1.frame)+width*0.08, width*0.9, width*0.08)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = Color(255, 97, 57);
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"以实际车辆记录里程为准";
    [fourView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), width*0.9, width*0.1)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = Color(255, 97, 57);
    label2.font = [UIFont systemFontOfSize:14];
    label2.text = @"超时超公里费用请与租客现场结算";
    [fourView addSubview:label2];

    
    UIButton *jieshu = [UIButton buttonWithType:UIButtonTypeCustom];
    jieshu.frame = CGRectMake(width*0.2-0.05*width, CGRectGetMaxY(label2.frame)+width*0.025, width*0.6, width*0.08);
    jieshu.backgroundColor = Color(7, 187, 177);
    [jieshu setTitle:@"提交评价" forState:UIControlStateNormal];
    [jieshu setTintColor:[UIColor whiteColor]];
    [jieshu addTarget:self action:@selector(saomaEnd:) forControlEvents:UIControlEventTouchUpInside];
    [fourView addSubview:jieshu];
}

-(void)saomaEnd:(UIButton *) button {
    NSLog(@"提交评价");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_tableView == tableView){
        return _dataArray.count;
    }
    return  0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_tableView == tableView){
        return 1;
    }
    return  0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_tableView == tableView){
        //details
             if ([_poststates isEqualToString:@"支付定金"] || [_poststates isEqualToString:@"未开始"] || [_poststates isEqualToString:@"服务中"] || [_poststates isEqualToString:@"已到达"]){
             return 0.13*ScreenHeight+2;
        }
       
        //comment
        return 0.15*ScreenHeight+2;
    }
    return  0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_tableView ==tableView) {
        
        static NSString *strc = @"stack";
      
        DetailsCarXclTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
            if (!cell) {
                
                //  cell = [[DetailsCarXclTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
                cell = [[DetailsCarXclTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
                
            }
            cell.dict = _detailsDict;
            cell.plane_name = _dataArray[indexPath.row];
            

            NSLog(@"1111111111111111111111111111%@",_detailsDict);
            return cell;
    }
    return nil;
}

-(id)SystomTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setDateFormat:@"a h:mm"];
    NSString *dataString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *aPmString = [dataString substringWithRange:NSMakeRange(0, 2)];
    if ([aPmString isEqualToString:@"AM"]) {
        aPmString = @"上午";
    }else {
        aPmString = @"下午";
    }
    if(dataString.length == 7) {
        dataString = [dataString substringWithRange:NSMakeRange(3, 4)];
    }else {
        dataString = [dataString substringWithRange:NSMakeRange(3, 5)];
    }
    
    return [NSString stringWithFormat:@"%@ %@",aPmString,dataString];
    
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)timerLabel:(WB_Stopwatch*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    NSLog(@"时间结束");
}
-(void)timerLabel:(WB_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WB_StopwatchLabelType)timerType{
    
    //    NSLog(@"开始计时");
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        NSLog(@"点击了取消按钮");
        
        return;
    }else
        return ;
}
@end
