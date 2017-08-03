//
//  MapViewController.h
//  ZuChe
//
//  Created by J.X.Y on 16/1/22.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "ParentsViewController.h"
#import "AllPages.pch"
@interface MapViewController : ParentsViewController<BMKMapViewDelegate,CLLocationManagerDelegate,BMKLocationServiceDelegate>
{
    BMKMapView* _mapView;
    BMKLocationService *_locService;
    UILabel * lab;//创建一个把路线距离显示的lable
    CLLocationCoordinate2D _userLocation;//赋值获取当前的坐标
    BMKCircle * circle;//圆形覆盖物
    BMKPointAnnotation * ant;//随意地图标注的大头针
    NSMutableArray *_poiResultArray;
    NSMutableArray *_searchHistoryArray;
    
}
@property (nonatomic, strong) BMKMapView                *mapView;
@property (nonatomic, assign) CLLocationCoordinate2D    selectedCoordinate;
@property (nonatomic,retain)CLLocationManager *locationManager;
@property (nonatomic,assign)BOOL hasLocation;
@property (nonatomic,retain)CLLocation *location;
@property (nonatomic, strong) BMKLocationService        *locationService;
@property (nonatomic,retain)NSString *orderid;

@end
