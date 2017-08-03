//
//  XiangqingController.m
//  ZuChe
//
//  Created by apple  on 16/12/21.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "XcHistoryDetailsViewController.h"
#import "Header.h"
#import "WB_Stopwatch.h"
#import "XcHistoryDetailsTableViewCell.h"
#import "CommentTableViewCell.h"
#import "HttpManager.h"
#import "NoPayTableViewCell.h"
#import "ZCUserData.h"
//#import "WSStarRatingView.h"


#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


#define PATH_URLPOST @"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks"
#define WKSPATH_URL @"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks"
#define JXZPATH_URL @"http://wx.leisurecarlease.com/api.php?op=api_xcxqjxz"

@interface XcHistoryDetailsViewController()<UITableViewDataSource,UITableViewDelegate,WB_StopWatchDelegate,UIAlertViewDelegate,MAMapViewDelegate,AMapLocationManagerDelegate>{
    
    CGFloat width;
    
    UIScrollView *_scrollerView;
    
    UITableView *_tableView;
    
    WB_Stopwatch *stopLabel;
    
    CGFloat _scrollerContenHeight;
    
    NSMutableArray *_dataArray;
    
    NSMutableDictionary *_detailsDict;
    
      //    UILabel *_scoreLabel;
    //    WSStarRatingView *_starRatingView;
    //
}
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapLocationManager *locationManager;

@end

@implementation XcHistoryDetailsViewController

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
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initArrayData {
    
    [HttpManager postData:@{@"id":_postIdString} andUrl:PATH_URLPOST success:^(NSDictionary *fanhuicanshu) {
        
        [_detailsDict addEntriesFromDictionary:fanhuicanshu];
        NSArray *gencheArray = _detailsDict[@"xcxq"][@"genche"];
        NSArray *zhucheArray = _detailsDict[@"xcxq"][@"zhuche"];
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (int j = 0; j < zhucheArray.count; j++) {
            [arr addObject:zhucheArray[j]];
            
        }
        for (int j = 0; j < gencheArray.count; j++) {
            [arr addObject:gencheArray[j]];
            
        }
        [_dataArray addObjectsFromArray:arr];
        [self creatfirstView];
        [self creatzfdjSecondView];
        [self creatzfdjthirdView];
        [self creafour];
        
        _scrollerView.contentSize = CGSizeMake(ScreenWidth, _scrollerContenHeight+0.05*ScreenHeight);
        
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
    self.mapView.zoomLevel = 15;
    //添加到view上
    [fisrView addSubview:self.mapView];
    
    [self.locationManager startUpdatingLocation];
    
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    
    UIImageView *middleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(width*0.9/2-17.5/2,width*0.2-15, 17.5, 30)];
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
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.4*ScreenHeight)];
    //thirdView.backgroundColor = [UIColor greenColor];
    _scrollerContenHeight+= 0.4*ScreenHeight;
    [_scrollerView addSubview:thirdView];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.4*ScreenHeight-1, 0.9*width, 1)];
    grayView.backgroundColor = Color(233, 233, 233);
    [thirdView addSubview:grayView];
    
    NSArray *array = @[@"总价",@"定金",@"优惠",@"尾款"];
    
    NSInteger jiage  = [_detailsDict[@"xcxq"][@"jiage"] integerValue];
    NSInteger yufukuan  = [_detailsDict[@"xcxq"][@"dingjin"] integerValue];
    NSInteger youhui = [_detailsDict[@"xcxq"][@"youhui"] integerValue];
    NSInteger weikuan  = [_detailsDict[@"xcxq"][@"yue"] integerValue];
    
    // NSLog(@"%@",_detailsDict[@"xcxq"][@"jiage"]);
    NSMutableArray *priceArray = [NSMutableArray new];
    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",jiage]];
    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",yufukuan]];
    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"-¥",youhui]];
    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",weikuan]];
    //  NSArray *priceArray = @[@jiage,@yufukuan,@weikuan];
    
    for (int i = 0; i<priceArray.count; i++) {
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.1*ScreenHeight*i+0.03*ScreenHeight, 0.08*ScreenHeight, 0.04*ScreenHeight)];
        leftLabel.text = array[i];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        //
        leftLabel.textColor = Color(87, 87, 87);
        leftLabel.adjustsFontSizeToFitWidth = YES;
        leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        //    shi11.teleftLabel.font = [UIFont systemFontOfSize:20];
        [thirdView addSubview:leftLabel];
        if (i==0) {
            
        }else {
            UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.1*i*ScreenHeight, 0.9*width, 1)];
            //        [grayView setBackgroundColor:[UIColor colorWithDisplayP3Red:242 green:242 blue:242 alpha:1]];
            grayView.backgroundColor = Color(233, 233, 233);
            
            [thirdView addSubview:grayView];
            
        }
        if (i  == 2) {
            UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*ScreenWidth, 0.1*ScreenHeight*i+0.03*ScreenHeight, 0.2*ScreenWidth, 0.04*ScreenHeight)];
            rightLabel.text = priceArray[i];
            rightLabel.textColor = [UIColor redColor];
            rightLabel.textColor = Color(7, 187, 177);
            rightLabel.textAlignment = NSTextAlignmentCenter;
            rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 ];
            [thirdView addSubview:rightLabel];
        }else {
            UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*ScreenWidth, 0.1*ScreenHeight*i+0.03*ScreenHeight, 0.2*ScreenWidth, 0.04*ScreenHeight)];
            rightLabel.text = priceArray[i];
            rightLabel.textColor = [UIColor redColor];
            rightLabel.textColor = Color(255, 97, 57);
            rightLabel.textAlignment = NSTextAlignmentCenter;
            rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 ];
            [thirdView addSubview:rightLabel];
        }
    }
}

-(void)creafour {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.3*ScreenHeight)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.3*ScreenHeight;
    
    [_scrollerView addSubview:fourView];
    
    
    UIImageView *bottonImageView = [UIImageView new];
    bottonImageView.image = [UIImage imageNamed:@"logo浅.png"];
    bottonImageView.alpha = 0.6;
    bottonImageView.frame = CGRectMake(0.9*width/2-width*0.13/2, width*0.13, width*0.13, width*0.13);
    //bottonImageView.backgroundColor = [UIColor redColor];
    [fourView addSubview:bottonImageView];
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
        return 0.13*ScreenHeight+2;
    }
    //comment
    return  0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *strc = @"stack";
    XcHistoryDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
    if (!cell) {
        cell = [[XcHistoryDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.dict = _detailsDict;
    cell.plane_name = _dataArray[indexPath.row];
    
    NSLog(@"1111111111111111111111111111%@",_detailsDict);
    return cell;
    
    
}
- (void)gobackTo{
    
    [self.navigationController popViewControllerAnimated:NO];
}


@end
