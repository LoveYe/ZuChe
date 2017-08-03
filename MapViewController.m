//
//  MapViewController.m
//  ZuChe
//
//  Created by J.X.Y on 16/1/22.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
{
    float Xx;
    float Yy;
    NSArray * arrays;
    NSString *_cityName;   // 检索城市名
    NSString *_keyWord;    // 检索关键字
    int currentPage;            //  当前页
    NSArray * _listArray;
}

@end

@implementation MapViewController
@synthesize  mapView=_mapView;
@synthesize selectedCoordinate=_selectedCoordinate;
@synthesize hasLocation=_hasLocation;
@synthesize location=_location;
@synthesize locationService=_locationService;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    //    //初始化BMKLocationService
    self.locationService = [[BMKLocationService alloc]init];
    //    [_mapView updateLocationData:userLocation];
    self.mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.mapView.showsUserLocation = YES;//显示定位图层
    [self.view addSubview:self.mapView];
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
    self.locationService.delegate = self;
    _mapView.delegate=self;
    [self.locationService startUserLocationService];

    NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",self.orderid,@"orderid", nil];
    [HttpManager arrayPostData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=getadd",NowUrl] Arraysuccess:^(NSArray *arrayfanhui) {
        NSLog(@"%@",arrayfanhui);
        _listArray =arrayfanhui;
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"%@",cuowuxingxi);
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
}
-(void)setArraySpace
{
    NSMutableArray *mutArr1 = [[NSMutableArray alloc]init];
    _poiResultArray = mutArr1;
    
    NSMutableArray *mutArr2 = [[NSMutableArray alloc]init];
    _searchHistoryArray = mutArr2;
}

- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    
    
//    NSArray * array =[NSArray arrayWithObjects:@"31.251883",@"31.253072",@"31.243717",@"31.153738", nil];
//    NSArray * array2 =[NSArray arrayWithObjects:@"121.418603",@"121.419348",@"121.43015",@"121.333709", nil];
//    NSArray * array3 =[NSArray arrayWithObjects:@"小贾的面包车",@"应江的法拉利",@"亚飞的拖拉机",@"域名的小飞机", nil];
    
    
    for (int i=0; i<_listArray.count; i++)
    {
        
        NSString * str =[[_listArray objectAtIndex:i] objectForKey:@"weizhi"];
        
        NSArray * array =[str componentsSeparatedByString:@","];

        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude =[[array objectAtIndex: 0] floatValue] ;
        coor.longitude = [[array objectAtIndex: 1] floatValue];

        annotation.coordinate = coor;
//        annotation.title = [array3 objectAtIndex:i];
        [_mapView addAnnotation:annotation];
        
        NSLog(@"%f",coor.latitude);
        NSLog(@"%f",coor.longitude);
    }
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [self.locationManager stopUpdatingLocation];
    if (!self.hasLocation) {
        //获取用户最新位置
        CLLocation *currentLocation = [locations lastObject];
        self.location = currentLocation;
        
        //获取当前所在城市
        
        
        //        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        //        CLLocationCoordinate2D coor;
        //        coor.latitude = 31.242328;
        //        coor.longitude = 121.419350;
        //        annotation.coo = coor;
        //        annotation.title = @"这里时你的位置";
        //        [_mapView addAnnotation:annotation];
        //        self.hasLocation = YES;
        //        //把位置上传到服务器
        //
    }
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    //定位成功
    self.selectedCoordinate = userLocation.location.coordinate;
    [self.locationService stopUserLocationService];
    self.locationService.delegate = nil;
    
    //将位置显示在地图上
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.title = userLocation.title;
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    self.mapView.zoomLevel = 16;
    self.navigationItem.title = @"位置选择";
    [_mapView updateLocationData:userLocation];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    NSLog(@"定位经纬度： lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    // float   去接受定位的位置。
    Yy =userLocation.location.coordinate.latitude;
    Xx=userLocation.location.coordinate.longitude;
    
    
}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}
@end
