//
//  JiHeAddressViewController.m
//  CarHead
//
//  Created by MacBookXcZl on 2017/6/19.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
//

#import "JiHeAddressViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "ZCUserData.h"
#import "HttpManager.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@interface JiHeAddressViewController ()<MAMapViewDelegate,AMapSearchDelegate, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    
    NSMutableArray *_countArray;
    
     BOOL isFirstLocated;
}


//@property(nonatomic,strong)MKLocalSearch *mkLocalSearch;
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)CLLocation *currrentLocation;
@property(nonatomic,strong)AMapSearchAPI *search;
//@property(nonatomic,strong)AMapLocationManager *locationManager;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *middleImageView;

@end

@implementation JiHeAddressViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=YES;
    
    _countArray  = [NSMutableArray new];
    
//    _index = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.mapView.backgroundColor = [UIColor whiteColor];
    
    [self initSearch];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.searchBar.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    
    self.middleImageView.image = [UIImage  imageNamed:@"停车地点.png"];
    
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(gobackTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;

    isFirstLocated = YES;
    
}
- (void)gobackTo{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    
    _mapView.delegate = nil;
//    _locationManager.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#define mark -- 初始化搜索类
-(void)initSearch {
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}
-(void)initDatas:(CLLocationCoordinate2D )manage AndString:(NSString *)searchString{
    
    if (isFirstLocated) {
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:manage.latitude longitude:manage.longitude];
        //    request.types = @"道路交叉口|交通设施服务|域名地址信息|生活服务|公司企业|政府机构及社会团体|地理附属设施|风景名胜|商务住宅";
        request.sortrule = 0;
        request.keywords = @"交叉口";
        request.requireExtension = YES;
        request.requireSubPOIs   = YES;
        [_search AMapPOIAroundSearch:request];

    }else {
        //POI关键字搜索
        AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
        request.keywords = searchString;
        request.city = @"上海市";
        request.cityLimit = YES;
        request.page = 1;
        request.requireSubPOIs      = YES;
        [_search AMapPOIKeywordsSearch:request];
        
        
    }
}
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    
        if (response.pois.count == 0) {
            return;
        }else {
            [_countArray removeAllObjects];
            _countArray = [NSMutableArray arrayWithArray:response.pois];
            
            [_tableView reloadData];
        }
}
#pragma park -- 懒加载

-(UITableView *)tableView  {
    if (_tableView == nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, screen_width*0.7+64, screen_width, screen_height-screen_width*0.7-64) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[[UIView alloc]init];
        [self.view addSubview:_tableView];
        
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        refreshControl.tag = 1000;
        [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
        [_tableView addSubview:refreshControl];
        [refreshControl beginRefreshing];
        [self refreshClick:refreshControl];
        
        
        return _tableView;
    }
    return nil;
}
-(void)refreshClick:(UIRefreshControl *)re {
    [re endRefreshing];
    [_tableView reloadData];
}
-(UISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_width*0.13)] ;
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.barStyle = UIBarStyleDefault;
        for (UIView *view in  _searchBar.subviews) {
            // for before iOS7.0
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [view removeFromSuperview];
                break;
            }
            if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
                
                [[view.subviews objectAtIndex:0] removeFromSuperview];
                break;
            }
        }
        [self.view addSubview:_searchBar];
        return _searchBar;
    }
    return nil;
}
-(MAMapView *)mapView {
    if (_mapView == nil) {
        _mapView=[[MAMapView alloc]initWithFrame:CGRectMake(0, screen_width*0.13+64, screen_width, screen_width*0.7)];
        _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
        _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
        _mapView.showsCompass = NO;
        _mapView.zoomLevel = 15;
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        _mapView.delegate = self;
         [self.view addSubview:_mapView];
        return _mapView;
    }
    return nil;
}
-(UIImageView *)middleImageView {
    if (_middleImageView == nil) {
       _middleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(screen_width/2-17.5/2, (screen_width*0.7)/2-50, 17.5, 30)];
        [_mapView addSubview:_middleImageView];
//         UIImageView *middleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(width*0.9/2-13,width*0.2-30, 26, 30)];
        return _middleImageView;
    }
    return nil;
}
#pragma mark -- tableViewDelgate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return _countArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identfire=@"cellID";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identfire];
    }
    AMapPOI *poi = _countArray[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    AMapPOI *poi = _countArray[indexPath.row];
    
    [self sendAddressString:poi.address AndNameString:poi.name];
    

//
    
}
// 查询是否实现传地址的代理方法
-(void)sendAddressString:(NSString *)addRessstring AndNameString:(NSString *)nameString{
    
    if (_delegate && [_delegate respondsToSelector:@selector(postAddressString:AndNameString:)]) {
        
        [_delegate postAddressString:addRessstring AndNameString:nameString];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- AMapViewDelgate

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    NSLog(@"%f--------------%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    
    MAOverlayRenderer *re = [[MAOverlayRenderer alloc] init];
    re.alpha = 0;
    
    return re;
}
#pragma mark --- 地图区域改变完成后会调用此接口

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    CLLocationCoordinate2D cd ;
    
    if (isFirstLocated == YES) {
        
        [self initDatas:mapView.centerCoordinate AndString:@""];
    }else {
        [self initDatas:cd AndString:_searchBar.text];
    }
}


#pragma mark -- searchBarDelgate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self searchUserWithStr:searchBar.text];
    //[self searchUserWithStr: ];
    
}

- (void)searchUserWithStr:(NSString *)string{
    NSString *strippedStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _search.delegate = self;
    [self searchPoiBySearchString:strippedStr];
}

// 通过关键字搜索地理位置
- (void)searchPoiBySearchString:(NSString *)searchString
{
    isFirstLocated= NO;
    CLLocationCoordinate2D sd;
   
     CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:[NSString stringWithFormat:@"上海市%@",searchString] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
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
                [self initDatas:sd AndString:searchString];
            }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
