//
//  XiangqingController.m
//  ZuChe
//
//  Created by apple  on 16/12/21.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "WaitPiPeiViewController.h"
#import "Header.h"
#import "DengDaiPpTableViewCell.h"
#import "CommentTableViewCell.h"
#import "HttpManager.h"
#import "NoPayTableViewCell.h"
#import "ZCUserData.h"
#import "PayView.h"

#import "MBProgressHUD.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "TimeSelectViewUpdate.h"
#import "JiHeAddressViewController.h"
#import "CCDatePickerViewUpdate.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

#define PATH_URLPOST @"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks"

@interface WaitPiPeiViewController()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MAMapViewDelegate,AMapLocationManagerDelegate,addressDelgate>{
    
    CGFloat width;
    
    UIScrollView *_scrollerView;
    
    UITableView *_tableView;
    
    CGFloat _scrollerContenHeight;
    
    NSMutableArray *_dataArray;
    
    NSMutableDictionary *_detailsDict;
    
    UIView *_bigView;
    
    UILabel *_dizhi;
    
    UIView *_lianxiView;

    UIRefreshControl *refreshControl;
    
    UITextField *teField;
    UITextField *naField;
    
    UIView *_blackView;
    
    NSMutableDictionary *_wenhaoDict;
    
    UIView *_queding;
    
}
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapLocationManager *locationManager;

@property (nonatomic,retain) NSArray *timesArray;
@property (nonatomic ,retain)NSArray *kmsArray;

@end

@implementation WaitPiPeiViewController



- (NSArray *)timeArray{
    
    if (!_timesArray) {
        
        _timesArray = @[@"5",@"6",@"7",@"8",@"9",@"10"];
    }
    return _timesArray;
}
- (NSArray *)kmArray{
    
    if (!_kmsArray) {
        
        _kmsArray = @[@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",@"105",@"110",@"115",@"120",@"125",@"130",@"135",@"140",@"145",@"150",@"155",@"160",@"165",@"170",@"175",@"180",@"185",@"190",@"195",@"200",@"205",@"210",@"215",@"220",@"225",@"230",@"235",@"240",@"245",@"250",@"255",@"260",@"265",@"270",@"275",@"280",@"285",@"290",@"295",@"300"];
    }
    return _kmsArray;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self initIdWenHaoData];
    [self initArrayData];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;
//    [_countDown.timer invalidate];
//    _countDown.timer = nil;
}
-(void)initIdWenHaoData {
    
    
    [HttpManager postData:@{@"id":_postIdString} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=indent_show" success:^(NSDictionary *fanhuicanshu) {
        
        [_wenhaoDict removeAllObjects];
        [_wenhaoDict addEntriesFromDictionary:fanhuicanshu[@"arr"]];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
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
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(gobackTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    
    
    UIButton *touSu = [UIButton buttonWithType:UIButtonTypeCustom];
    touSu.frame = CGRectMake(0, 0, 25, 25);
    touSu.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    [touSu setTitle:@"投诉" forState:UIControlStateNormal];
    [touSu setTitleColor:[UIColor colorWithRed:223/255.0 green:62/255.0 blue:101/255.0 alpha:1] forState:UIControlStateNormal];
    touSu.layer.borderColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:101/255.0 alpha:1].CGColor;
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
    [_scrollerView removeFromSuperview];
    
    [self initIdWenHaoData];
    // 此处添加刷新tableView数据的代码
     [self initArrayData];
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
      [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpManager postData:@{@"id":_postIdString} andUrl:PATH_URLPOST success:^(NSDictionary *fanhuicanshu) {
        
        [_detailsDict removeAllObjects];
        [_detailsDict addEntriesFromDictionary:fanhuicanshu];
        NSArray *cheArray = _detailsDict[@"xcxq"][@"carlist"];
        
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (int j = 0; j < cheArray.count; j++) {
            [arr addObject:cheArray[j]];
            
        }
        
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:arr];
        [self creatfirstView];
        [self creatzfdjSecondView];
        [self creatzfdjthirdView];
        [self creatppzfourView];
        
        _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
         [refreshControl endRefreshing];
          [MBProgressHUD hideHUDForView:self.view animated:NO];
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"%@<<<<<<<<<<<<",cuowuxingxi);
          [refreshControl endRefreshing];
          [MBProgressHUD hideHUDForView:self.view animated:NO];
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
    
    UIButton *riqi = [UIButton buttonWithType:UIButtonTypeCustom];
    riqi.frame = CGRectMake(width*0.135, width*0.065,  width*0.1, width*0.05);
    [riqi setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    riqi.tag = 100;
    [riqi addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
    [fisrView addSubview:riqi];
    
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
    
    UIButton *lianxi = [UIButton buttonWithType:UIButtonTypeCustom];
    lianxi.frame = CGRectMake(width*0.135, width*0.265,  width*0.1, width*0.05);
    [lianxi setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    lianxi.tag = 101;
    [lianxi addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
    [fisrView addSubview:lianxi];
    
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
//    
//    UIButton *fanwei = [UIButton buttonWithType:UIButtonTypeCustom];
//    fanwei.frame = CGRectMake(width*0.135, width*0.465,  width*0.1, width*0.05);
//    [fanwei setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
//    fanwei.tag = 102;
//    [fanwei addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
//    [fisrView addSubview:fanwei];
    
    
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
    
    
    UIButton *dizhi = [UIButton buttonWithType:UIButtonTypeCustom];
    dizhi.frame = CGRectMake(width*0.8, CGRectGetMaxY(image.frame)+width*0.025,  width*0.1, width*0.05);
    //    [dizhi setTitle:@"修改" forState:UIControlStateNormal];
    dizhi.tag = 103;
    [dizhi setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [dizhi addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
    [fisrView addSubview:dizhi];
    
    
    
    UIView *grayView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dizhi.frame),width*0.9 , 1)];
    grayView11.backgroundColor =  Color(233, 233, 233);
    [fisrView addSubview:grayView11];
    
    
    
    [self onClick:@"" AndaddText:[NSString stringWithFormat:@"%@",_dizhi.text]];
}
-(void)postAddressString:(NSString *)addressString {
    NSLog(@"%@sssssssssssss",addressString);
    [self xiugaiDizhi:@"" AndaddText:addressString];
}


-(void)xiugaiDizhi:(NSString *)string AndaddText:(NSString *)addText {
    
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
        
        
        MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(31.260503, 121.503311));
        
        MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake([lau floatValue],[lon floatValue]));
        //2.计算距离
        
        CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
        
        NSString *ksffw = _detailsDict[@"xcxq"][@"ksffw"];
        NSInteger ks = [ksffw integerValue];
        if (distance >= ks) {
            NSLog(@"111123123213123213123");
            [self blackView];
        }else {
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",_postIdString,@"id",addText,@"jihe",nil];
            
            [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=edit_indent"success:^(NSDictionary *fanhuicanshu) {
                NSLog(@"%@",fanhuicanshu);
//                [_countDown.timer invalidate];
//                _countDown.timer = nil;
                [_scrollerView removeFromSuperview];
                [self initArrayData];
            } Error:^(NSString *cuowuxingxi) {
                NSLog(@"%@,",cuowuxingxi);
            }];
        }
        
        
        
        //  [self initDatas:centerCoordinate];
    }];
}

- (void)blackView{
    
    _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _blackView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    _blackView.tag = 1000;
    [self.view.window addSubview:_blackView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight/2- ScreenWidth*0.3/2, ScreenWidth*0.8, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [_blackView addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame)*0.9, CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"超出预定距离";
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
    [queding addTarget:self action:@selector(movAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
-(void)movAll {
    
    [_blackView removeFromSuperview];
}
-(void)updateNeed:(UIButton *)button {
    
    NSInteger btnTag = button.tag - 100;
    switch (btnTag) {
        case 0:{
            NSLog(@"0");
            CCDatePickerViewUpdate *dateView = [[CCDatePickerViewUpdate alloc] initWithFrame:[UIScreen mainScreen].bounds];
            dateView.inputString =_detailsDict[@"xcxq"][@"times"];
            
            [self.view.window addSubview:dateView];
            
            dateView.blcok = ^(NSDate *dateString){
                NSLog(@"年 = %ld  月 = %ld  日 = %ld  时 = %ld  分 = %ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute);
                //               //传给服务器的修改时间
                NSString *datestr = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute];
                //
                /*
                 http://wx.leisurecarlease.com/api.php?op=edit_indent
                 
                 请求参数：
                 $_POST[userid]     //用户userid
                 $_POST[id]         //订单id
                 $_POST['shijian']  //时间
                 $_POST['jihe']     //集合地址
                 
                 */
                
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",_postIdString,@"id", datestr,@"shijian",nil];
                
                [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=edit_indent"success:^(NSDictionary *fanhuicanshu) {
//                    [_countDown.timer invalidate];
//                    _countDown.timer = nil;
                    [_scrollerView removeFromSuperview];
                    [self initArrayData];
                    NSLog(@"%@",fanhuicanshu);
                } Error:^(NSString *cuowuxingxi) {
                    NSLog(@"%@,",cuowuxingxi);
                }];
                
            };
            //  dateView.chooseTimeLabel.text = @"选择时间";
            [dateView fadeIn];
            
            
            break;
        }
        case 1:{
            NSLog(@"1");
            [self UpdateTelephoneNumber];
            break;
        }
        case 2:{
            NSLog(@"2");
           
            break;
        }
        case 3:{
            NSLog(@"3");
            JiHeAddressViewController *jihe = [JiHeAddressViewController new];
            jihe.delegate = self;
            [self.navigationController pushViewController:jihe animated:YES];
            break;
        }
        case 4:{
            NSLog(@"4");
            [self kaiqiditu];
            break;
        }
        case 5:{
            NSLog(@"5");
            [self wenhao5];
            break;
        }
        case 6:{
            NSLog(@"6");
            [self wenhao6];
            break;
        }
        case 7:{
            NSLog(@"7");
            [self wenhao7];
            break;
        }
        case 8:{
            NSLog(@"8");
            [self wenhao8];
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


//开启地图定位
- (void)kaiqiditu{
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 617;
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
    label.text = @"订单未开始，开始后开启地图定位";
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
    [queding addTarget:self action:@selector(moveAllditu) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
-(void)moveAllditu {
    UIView *view617 = (UIView *)[self.view.window viewWithTag:617];
    [view617 removeFromSuperview];
}

-(void)removeWenhao8 {
    UIView *view618 = (UIView *)[self.view.window viewWithTag:618];
    [view618 removeFromSuperview];
    
}
- (void)wenhao8{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    view1.tag = 618;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeWenhao8)];
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
    [cuowu addTarget:self action:@selector(removeWenhao8) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(cuowu.frame)+width*0.02, view2.frame.size.width*0.9, width*0.1)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = Color(137, 137, 137);
    label1.text = @"尾款请在服务当天付清";
    label1.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label1];
    
    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label1.frame), view2.frame.size.width*0.9, width*0.1)];
    label2.text = @"尾款不包括现场超时费用";
    label2.textColor = Color(137, 137, 137);
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont boldSystemFontOfSize:17];
    [view2 addSubview:label2];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
}


-(void)removeAllwenhao7{
    UIView *view711 = (UIView *)[self.view.window viewWithTag:711];
    [view711 removeFromSuperview];
}
- (void)wenhao7{
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    view1.tag = 711;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAllwenhao7)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, screen_height/2-width*0.64/2, width*0.9, width*0.64)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(width*0.03, width*0.03, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(removeAllwenhao7) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(cuowu.frame), view2.frame.size.width*0.9, width*0.15)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = Color(77, 77, 77);
    label1.text = @"优惠名称";
    label1.font = [UIFont boldSystemFontOfSize:20];
    [view2 addSubview:label1];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.28, view2.frame.size.width*0.9, width*0.15)];
    label2.textAlignment = NSTextAlignmentCenter;
    
    if ([_wenhaoDict[@"yhbz"] isKindOfClass:[NSNull class]]) {
        label2.text = @"暂无优惠";
    }else {
        label2.text = _wenhaoDict[@"yhbz"];
    }
    
    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    label2.textColor = Color(255, 97, 57);
    [view2 addSubview:label2];
    
}


-(void)removeAllwenhao6{
    UIView *view719 = (UIView *)[self.view.window viewWithTag:719];
    [view719 removeFromSuperview];
}
- (void)wenhao6{
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    view1.tag = 719;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAllwenhao6)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, screen_height/2-width*0.9/2, width*0.9, width*0.9)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(width*0.03, width*0.03, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(removeAllwenhao6) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(cuowu.frame), view2.frame.size.width*0.9, width*0.15)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = Color(77, 77, 77);
    label1.text = @"支付方式";
    label1.font = [UIFont boldSystemFontOfSize:25];
    [view2 addSubview:label1];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.28, view2.frame.size.width*0.9, width*0.15)];
    label2.textAlignment = NSTextAlignmentCenter;
    if([_wenhaoDict[@"zffs"] isKindOfClass:[NSNull class]]) {
        
        label2.text = @"暂未支付";
    }else{
        label2.text = _wenhaoDict[@"zffs"];
    }
    
    label2.font = [UIFont boldSystemFontOfSize:25];
    label2.textColor = Color(255, 97, 57);
    [view2 addSubview:label2];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width*0.1, width*0.43, width*0.7, 2)];
    view.backgroundColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1];
    [view2 addSubview:view];
    
    
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.43+2, view2.frame.size.width*0.9, width*0.15)];
    labeltime.textAlignment = NSTextAlignmentCenter;
    labeltime.textColor = Color(77, 77, 77);
    labeltime.text = @"支付时间";
    labeltime.font = [UIFont boldSystemFontOfSize:25];
    [view2 addSubview:labeltime];
    
    //
    
    UILabel *labelt = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.58+2, view2.frame.size.width*0.9, width*0.15)];
    labelt.textAlignment = NSTextAlignmentCenter;
    if([_wenhaoDict[@"zfdjsj"] isKindOfClass:[NSNull class]]) {
        
        labelt.text = @"暂无支付时间";
    }else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
        NSString *a = _wenhaoDict[@"zfdjsj"];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[a intValue]];
        NSLog(@"1296035591  = %@",confromTimesp);
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        NSLog(@"1296035591  = %@",confromTimespStr);
        labelt.text = confromTimespStr;
    }
    labelt.font = [UIFont boldSystemFontOfSize:25];
    labelt.textColor = Color(255, 97, 57);
    [view2 addSubview:labelt];
    

    
}
//手机号限制开始
- (void)xianzaishoujihao{
    
    _queding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _queding.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    
    [self.view.window addSubview:_queding];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight/2- ScreenWidth*0.3/2, ScreenWidth*0.8, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [_queding addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame)*0.9, CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"手机号错误";
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
    [queding addTarget:self action:@selector(moveAllxianzhi) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
-(void)moveAllxianzhi {
    
    [_queding removeFromSuperview];
}

-(void)removeAll {
    
    UIView *view718 = (UIView *)[self.view.window viewWithTag:718];
    [view718 removeFromSuperview];
    
}

- (void)wenhao5{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [HttpManager postData:@{@"id":_postIdString} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=indent_zongjia" success:^(NSDictionary *fanhuicanshu) {
        
        [dict removeAllObjects];
        [dict addEntriesFromDictionary:fanhuicanshu[@"arr"]];
        
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
        view1.tag = 718;
        view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [self.view.window addSubview:view1];
        UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
        [view1 addGestureRecognizer:regsi];
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.2, width*0.9, width*1.18)];
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
        [cuowu addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:cuowu];
        
        NSArray *array = @[@"基础使用范围费用",@"提前预定超出费用",@"空驶费"];
        for (int i = 0; i <3; i++) {
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(cuowu.frame)+width*0.01+width*0.3*i, view2.frame.size.width*0.9, width*0.1)];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.textColor = Color(77, 77, 77);
            label1.text = array[i];
            label1.font = [UIFont boldSystemFontOfSize:18];
            [view2 addSubview:label1];
        }
        
        //    int a = [zhucheChaoshi intValue]/[tou1.text intValue];
        NSString *text = [NSString stringWithFormat:@"主车：¥ %@ X %@",dict[@"zhuche_jiage"],dict[@"zhuche_num"]];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
        UIColor *colore = Color(137, 137, 137);
        [attr setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
        UIColor *colll = Color(255, 97, 57);
        if (text.length == 13) {
            
            [attr setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 10)];
        }else{
            
            [attr setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 11)];
        }
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.24, view2.frame.size.width*0.9, width*0.1)];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.attributedText = attr;
        label2.font = [UIFont boldSystemFontOfSize:17];
        [view2 addSubview:label2];
        
        //    int c = [gencheChaoshi intValue]/[tou2.text intValue];
        NSString *text2 = [NSString stringWithFormat:@"跟车：¥ %@ X %@",dict[@"genche_jiage"],dict[@"genche_num"]];
        NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:text2];
        [attr2 setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
        if (text2.length == 8) {
            
            [attr2 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 5)];
        }else{
            
            [attr2 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 6)];
        }
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label2.frame), view2.frame.size.width*0.9, width*0.1)];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.textColor = Color(255, 97, 57);
        label3.attributedText = attr2;
        label3.font = [UIFont boldSystemFontOfSize:17];
        [view2 addSubview:label3];
        
        NSString *text3 = [NSString stringWithFormat:@"主车：¥ %@ X %@",dict[@"zhuche_csf"],dict[@"zhuche_num"]];
        NSMutableAttributedString *attr3 = [[NSMutableAttributedString alloc] initWithString:text3];
        [attr3 setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
        if (text3.length == 10) {
            
            [attr3 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 7)];
        }if (text3.length == 12) {
            
            [attr3 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 9)];
        }if (text3.length == 13) {
            
            [attr3 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 10)];
        }
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label3.frame)+width*0.1, view2.frame.size.width*0.9, width*0.1)];
        label4.textAlignment = NSTextAlignmentCenter;
        label4.textColor = Color(255, 97, 57);
        label4.attributedText = attr3;
        label4.font = [UIFont boldSystemFontOfSize:17];
        [view2 addSubview:label4];
        
        
        NSString *text4 = [NSString stringWithFormat:@"跟车：¥ %@ X %@",dict[@"genche_csf"],dict[@"genche_num"]];
        NSMutableAttributedString *attr4 = [[NSMutableAttributedString alloc] initWithString:text4];
        [attr4 setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
        if (text4.length == 10) {
            
            [attr4 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 7)];
        }if (text4.length == 12) {
            
            [attr4 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 9)];
        }if (text4.length == 13) {
            
            [attr4 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 10)];
        }
        //    [attr4 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 6)];
        UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label4.frame), view2.frame.size.width*0.9, width*0.1)];
        label5.textAlignment = NSTextAlignmentCenter;
        label5.textColor = Color(255, 97, 57);
        label5.attributedText = attr4;
        label5.font = [UIFont boldSystemFontOfSize:17];
        [view2 addSubview:label5];
        
        NSString *text5 = [NSString stringWithFormat:@"主车：¥ %@ X %@",dict[@"zhuche_ksf"],dict[@"zhuche_num"]];
        NSMutableAttributedString *attr5 = [[NSMutableAttributedString alloc] initWithString:text5];
        [attr5 setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
        if (text5.length == 10) {
            
            [attr5 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 7)];
        }if (text5.length == 12) {
            
            [attr5 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 9)];
        }if (text5.length == 13) {
            
            [attr5 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 10)];
        }
        //    [attr5 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 6)];
        UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label5.frame)+width*0.1, view2.frame.size.width*0.9, width*0.1)];
        label6.textAlignment = NSTextAlignmentCenter;
        label6.textColor = Color(255, 97, 57);
        label6.attributedText = attr5 ;
        label6.font = [UIFont boldSystemFontOfSize:17];
        [view2 addSubview:label6];
        
        
        NSString *text6 = [NSString stringWithFormat:@"跟车：¥ %@ X %@",dict[@"genche_ksf"],dict[@"genche_num"]];
        NSMutableAttributedString *attr6 = [[NSMutableAttributedString alloc] initWithString:text6];
        [attr6 setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
        if (text6.length == 10) {
            
            [attr6 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 7)];
        }if (text6.length == 12) {
            
            [attr6 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 9)];
        }if (text6.length == 13) {
            
            [attr6 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 10)];
        }
        //    [attr6 setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(3, 6)];
        UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label6.frame), view2.frame.size.width*0.9, width*0.1)];
        label7.textAlignment = NSTextAlignmentCenter;
        label7.textColor = Color(255, 97, 57);
        label7.attributedText = attr6;
        label7.font = [UIFont boldSystemFontOfSize:17];
        [view2 addSubview:label7];
        
        
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-width*0.12, view2.frame.size.height-width*0.12-view2.frame.size.width*0.05, width*0.12, width*0.12)];
        iconImage.image = [UIImage imageNamed:@"logo浅.png"];
        [view2 addSubview:iconImage];
        
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
    
}



//修改联系
- (void)UpdateTelephoneNumber{
    
    _lianxiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _lianxiView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    _lianxiView.tag = 1000;
    [self.view.window addSubview:_lianxiView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1,64, ScreenWidth*0.8, ScreenWidth*0.8)];
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*0.8, ScreenWidth*0.2)];
    label.text = @"请重新输入";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [image addSubview:label];
    
    
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.2, ScreenWidth*0.7, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    
    
    UILabel *teLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, ScreenWidth*0.25, ScreenWidth*0.2, ScreenWidth*0.1)];
    teLabel.text = @"联系人 :";
    teLabel.textColor = Color(107, 107, 107);
    teLabel.textAlignment = NSTextAlignmentLeft;
    teLabel.adjustsFontSizeToFitWidth = YES;
    teLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
    [image addSubview:teLabel];
    
    
    UILabel *fieldLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.27, ScreenWidth*0.25, ScreenWidth*0.48, ScreenWidth*0.1)];
    fieldLabel1.layer.borderColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1].CGColor;
    fieldLabel1.layer.borderWidth = 1.0;
    fieldLabel1.userInteractionEnabled = YES;
    [image addSubview:fieldLabel1];
    
    naField =  [[UITextField alloc] initWithFrame:CGRectMake(10,0, ScreenWidth*0.48-10, ScreenWidth*0.1)];
    naField.tintColor = color;
    naField.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    [fieldLabel1 addSubview:naField];
    
    
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.4, ScreenWidth*0.7, 0.5)];
    xian1.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian1];
    
    
    UILabel *naLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, ScreenWidth*0.45, ScreenWidth*0.2, ScreenWidth*0.1)];
    naLabel.text = @"联系方式 :";
    naLabel.textColor = Color(107, 107, 107);
    naLabel.textAlignment = NSTextAlignmentLeft;
    naLabel.adjustsFontSizeToFitWidth = YES;
    naLabel.font = [UIFont fontWithName:@"ArialMT" size:20];
    [image addSubview:naLabel];
    
    
    UILabel *fieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.27, ScreenWidth*0.45, ScreenWidth*0.48, ScreenWidth*0.1)];
    fieldLabel.layer.borderColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1].CGColor;
    fieldLabel.layer.borderWidth = 1.0;
    fieldLabel.userInteractionEnabled = YES;
    [image addSubview:fieldLabel];
    
    
    teField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth*0.48-10, ScreenWidth*0.1)];
    teField.keyboardType = UIKeyboardTypeNumberPad;
    teField.tintColor = color;
    teField.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    [fieldLabel addSubview:teField];
    
    
    
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.6, ScreenWidth*0.7, 0.5)];
    xian2.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian2];
    
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(width*0.425, ScreenWidth*0.65, ScreenWidth*0.325, ScreenWidth*0.1);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queding.backgroundColor = color;
    [queding addTarget:self action:@selector(moveLianx) forControlEvents:UIControlEventTouchUpInside];
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:queding];
    
    UIButton *quxiao = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiao.frame = CGRectMake(width*0.05, ScreenWidth*0.65, ScreenWidth*0.325, ScreenWidth*0.1);
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(moveLianx1) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color1 = Color(177, 177, 177);
    quxiao.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    quxiao.backgroundColor = color1;
    [image addSubview:quxiao];
    
}
-(void)moveLianx1 {
    [_lianxiView removeFromSuperview];
}
-(void)moveLianx {
    
    if (teField.text.length != 11) {
        [self xianzaishoujihao];
    }else {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",_postIdString,@"id",teField.text,@"tel",naField.text,@"username",nil];
        
        [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=edit_indent"success:^(NSDictionary *fanhuicanshu) {
            //        [_countDown.timer invalidate];
            //        _countDown.timer = nil;
            [_scrollerView removeFromSuperview];
            [self initArrayData];
            NSLog(@"%@",fanhuicanshu);
        } Error:^(NSString *cuowuxingxi) {
            NSLog(@"%@,",cuowuxingxi);
        }];
        [_lianxiView removeFromSuperview];
    }
   
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

//第二个界面
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

//第三个界面
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
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.1*ScreenHeight*i+0.03*ScreenHeight, width*0.15, 0.04*ScreenHeight)];
        leftLabel.text = array[i];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        //
        leftLabel.textColor = Color(87, 87, 87);
        leftLabel.adjustsFontSizeToFitWidth = YES;
        leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        //    shi11.teleftLabel.font = [UIFont systemFontOfSize:20];
        [thirdView addSubview:leftLabel];
        
        UIButton *wenhao = [UIButton buttonWithType:UIButtonTypeCustom];
        wenhao.frame = CGRectMake(width*0.135, 0.1*ScreenHeight*i+(ScreenHeight*0.1 - width*0.077)/2, width*0.077, width*0.077);
        wenhao.tag = 100+i+5;
        [wenhao addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
        [wenhao setBackgroundImage:[UIImage imageNamed:@"问红.png"] forState:UIControlStateNormal];
        [thirdView addSubview:wenhao];
        
        
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

//匹配中
-(void)creatppzfourView {
    
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*0.81)];
   // fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*0.81+width*0.04+64;
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
    
    
    UILabel *bottonLabel = [UILabel new];
    bottonLabel.frame = CGRectMake(0, width*0.55+width*0.07, width*0.9, width*0.1);
    bottonLabel.text = @"订单开始前七天将不能修改订单信息";
    bottonLabel.textAlignment = NSTextAlignmentCenter;
    bottonLabel.textColor = [UIColor redColor];
    // bottonLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    //bottonImageView.backgroundColor = [UIColor redColor];
    [fourView addSubview:bottonLabel];
    
    
    UILabel *Label = [UILabel new];
    Label.frame = CGRectMake(0, width*0.72-width*0.01, width*0.9, width*0.1);
    Label.text = @"订单开始前三天进行车辆匹配";
    //Label.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
    Label.textAlignment = NSTextAlignmentCenter;
    Label.textColor = [UIColor redColor];
    // bottonLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    //bottonImageView.backgroundColor = [UIColor redColor];
    [fourView addSubview:Label];
    
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
    
    
    //    if (_tableView ==tableView) {
    
    static NSString *strc = @"stack";
    DengDaiPpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
    if (!cell) {
        
        //  cell = [[DetailsCarXclTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
        cell = [[DengDaiPpTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.dict = _detailsDict;
    cell.plane_name = _dataArray[indexPath.row];
    
    NSLog(@"1111111111111111111111111111%@",_detailsDict);
    return cell;
    
    
}

@end

