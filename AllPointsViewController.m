//
//  AliMapViewDrawCustomAnnotationController.m
//  AliMapKit
//
//  Created by wangye on 17/1/12.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//

#import "AllPointsViewController.h"
//#import "AliMapViewCustomCalloutView.h"
#import "AliMapViewCustomAnnotationView.h"
#import "AliMapViewCustomPinAnnotationView.h"
#import "HttpManager.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

#import "CustomPointAnnotation.h"
#import "CustomPointAnnotation1.h"

#import <AMapLocationKit/AMapLocationKit.h>


#define PATH_URLPOST @"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks"

@interface AllPointsViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate> {
    
    NSMutableDictionary *_detailsDict;
    NSMutableArray *_arrayPoint;
}
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, strong)UISegmentedControl *segementControl;
@property (nonatomic, strong)CustomPointAnnotation1 *pointAnnotation;
@property (nonatomic, strong)CustomPointAnnotation *customPointAnnotation;
@property (nonatomic, strong)AliMapViewCustomAnnotationView *annotationView;      //纯自定义大头针标注视图
@property (nonatomic, strong)AliMapViewCustomPinAnnotationView *annotationPinView;//继承默认大头针标注视图
@property (nonatomic, strong)UIButton *telButton;
@property(nonatomic,strong)AMapLocationManager *locationManager;
@end

@implementation AllPointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _detailsDict = [NSMutableDictionary new];
    _arrayPoint = [NSMutableArray new];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    label.text = @"车辆定位";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    label.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1];
    self.navigationItem.titleView = label;
    
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(ditudanhu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    //初始化地图
    
 //   [self createPointAnnotation];
    
}
-(void)ditudanhu{
 
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     [self initArrayData];
   
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

-(void)updateAddress:(UIButton *)button {
    [_mapView removeFromSuperview];
    _mapView = nil;
    [self initArrayData];
    NSLog(@"1");
}


#pragma mark <MAMapViewDelegate>
//获取标注视图
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if([annotation isKindOfClass:[CustomPointAnnotation1 class]])
    {
          return [self fullCustomAnnotationViewWithMapView:mapView viewForAnnotation:annotation];
    }
    
    if ([annotation isKindOfClass:[CustomPointAnnotation class]]) {
        
          return [self NotfullCustomAnnotationViewWithMapView:mapView viewForAnnotation:annotation];
    }
    return nil;
}

//使用纯定义大头针标注视图
-(AliMapViewCustomAnnotationView *)fullCustomAnnotationViewWithMapView:(MAMapView *)mapView viewForAnnotation:(CustomPointAnnotation1*)annotation{
    
    
    static NSString *reuseIndetifier = @"annotationReuseIndetifier";
    AliMapViewCustomAnnotationView *annotationView = (AliMapViewCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
    
    if (annotationView == nil)
    {
        annotationView = [[AliMapViewCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        
    }
    
    annotationView.image = [UIImage imageNamed:@"车(2)"] ;
    //设置为NO，用以调用自定义的calloutView
    annotationView.canShowCallout = NO;
    
    //设置中心点偏移，使得标注底部中间点成为经纬度对应点
    annotationView.centerOffset = CGPointMake(0, -18);
    
    return annotationView;
}

//使用第二个大头针标注视图
-(AliMapViewCustomPinAnnotationView *)NotfullCustomAnnotationViewWithMapView:(MAMapView *)mapView viewForAnnotation:(CustomPointAnnotation*)annotation{
    
    
    static NSString *reuseIndetifier = @"annotationReuseIndetifier";
    AliMapViewCustomPinAnnotationView *annotationView = (AliMapViewCustomPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
    
    if (annotationView == nil)
    {
        annotationView = [[AliMapViewCustomPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        
    }
    
    annotationView.image = [UIImage imageNamed:@"icon_nav_start"] ;
    //设置为NO，用以调用自定义的calloutView
    annotationView.canShowCallout = NO;
    
    //设置中心点偏移，使得标注底部中间点成为经纬度对应点
    annotationView.centerOffset = CGPointMake(0, -18);
    
    return annotationView;
}
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view  {
   
    NSArray *array = [NSArray arrayWithArray:_arrayPoint];
    
    if([view.annotation isKindOfClass:[CustomPointAnnotation1 class]])
    {
        AliMapViewCustomAnnotationView *annotationView = (AliMapViewCustomAnnotationView *)view;
        for (int i = 0; i < array.count; i++) {
            
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:array[i]];
            
            if ([dict[@"latitude"] isKindOfClass:[NSNull class]] && [dict[@"longitude"] isKindOfClass:[NSNull class]]) {
                NSLog(@"zanwugengxin");
            }else {
                if ( annotationView.annotation.coordinate.latitude == [dict[@"latitude"] doubleValue] &&  annotationView.annotation.coordinate.longitude == [dict[@"longitude"] doubleValue]) {
                    NSString *s = dict[@"cartu"];
                    
                    annotationView.tuImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",s]]]];
                    
                    annotationView.telImage = [UIImage imageNamed:@"电话222.png"];
                    
                    NSLog(@"%@",annotationView);
                    
                    annotationView.image = [UIImage imageNamed:@"车(2).png"];
                    
                }
            }
        }

    }
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
    }
    return _locationManager;
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    
    MAOverlayRenderer *re = [[MAOverlayRenderer alloc] init];
    re.alpha = 0;
    
    return re;
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    
   // [self onClick:@"上海市" AndaddText:_centerString];
//    NSLog(@"1")
}

//网络请求数据

-(void)initArrayData {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [HttpManager postData:@{@"id":_postIdString} andUrl:PATH_URLPOST success:^(NSDictionary *fanhuicanshu) {
        
        NSLog(@"%@",fanhuicanshu);
        [_detailsDict removeAllObjects];
        [_arrayPoint removeAllObjects];
        [_detailsDict addEntriesFromDictionary:fanhuicanshu];
        NSArray *cheArray = _detailsDict[@"xcxq"][@"carlist"];
        [_arrayPoint addObjectsFromArray:cheArray];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self createPointAnnotation];
        [self addPointAnntations];
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"%@<<<<<<<<<<<<",cuowuxingxi);
        //  [refreshControl endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
//添加所有点到地图上边

//创建大头针
-(void)createPointAnnotation{
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _mapView.delegate = self;
    
    self.mapView.compassOrigin = CGPointMake(self.mapView.compassOrigin.x, 22);
    self.mapView.scaleOrigin = CGPointMake(self.mapView.scaleOrigin.x, 22);
    self.mapView.showsCompass = NO;
    self.mapView.zoomLevel = 14;
    
    [self.view addSubview:_mapView];
    
    
    UIButton *telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [telButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //  self.telButton.backgroundColor = [UIColor redColor];
    [telButton addTarget: self action:@selector(updateAddress:) forControlEvents:UIControlEventTouchUpInside];
    telButton.layer.cornerRadius = 40.0;
    [telButton setBackgroundImage:[UIImage imageNamed:@"刷新.png"] forState:UIControlStateNormal];
    CGFloat wid = self.view.frame.size.width;
    CGFloat hei = self.view.frame.size.height;
    telButton.frame = CGRectMake(wid/2-40,hei-80/2-64-49,80,80);
    [_mapView addSubview:telButton];
    
    [self.locationManager startUpdatingLocation];
    _mapView.allowsBackgroundLocationUpdates = YES;
    _mapView.showsUserLocation = NO;
     _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
}
//所有车的点
-(void)addPointAnntations {
    
    for (NSDictionary *dic in _arrayPoint) {
        
        if ([dic isKindOfClass:[NSNull class]]) {
            NSLog(@"zanwugengxin");
        }else {
            if ([dic[@"latitude"] isKindOfClass:[NSNull class]] && [dic[@"longitude"] isKindOfClass:[NSNull class]]) {
                NSLog(@"zanwugengxin");
            }else {
                CLLocationDegrees latitude= [dic[@"latitude"] doubleValue];
                CLLocationDegrees longitude=[dic[@"longitude"] doubleValue];
                self.pointAnnotation = [[CustomPointAnnotation1 alloc] init];
                self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitude,longitude);
                self.pointAnnotation.title = dic[@"tel"];
                self.pointAnnotation.subtitle = dic[@"plate_name"];
                //将大头针添加到地图中
                [_mapView addAnnotation:self.pointAnnotation];
                [_mapView selectAnnotation:self.pointAnnotation animated:YES];
            }
        }
    }
}
//中心点
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

        
        _customPointAnnotation = [[CustomPointAnnotation alloc] init];
        _customPointAnnotation.coordinate = CLLocationCoordinate2DMake(centerCoordinate.latitude,centerCoordinate.longitude);
        _customPointAnnotation.title = @"集合地点";
        // point.image = [UIImage imageNamed:@"定位40.png"];
        //将大头针添加到地图中
        [_mapView addAnnotation:_customPointAnnotation];
        
    }];
}


@end
