//
//  XiangqingController.m
//  ZuChe
//
//  Created by apple  on 16/12/21.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "YesFinaViewController.h"
#import "Header.h"
#import "WB_Stopwatch.h"
#import "DetailsCarXclTableViewCell.h"
#import "CommentTableViewCell.h"
#import "HttpManager.h"
#import "AFNetworking.h"
#import "ZCUserData.h"
#import "TousuTableViewCell.h"


#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "TouSuAddImageViewController.h"
#import "VPImageCropperViewController.h"



//#import "WSStarRatingView.h"
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

#define PATH_URLPOST @"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks"



#define ORIGINAL_MAX_WIDTH 640.0f

@interface YesFinaViewController()<UITableViewDataSource,UITableViewDelegate,WB_StopWatchDelegate,UIAlertViewDelegate,MAMapViewDelegate,AMapLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,toushuDelgate,UIActionSheetDelegate,VPImageCropperDelegate>{
    
    CGFloat width;
    
    UIScrollView *_scrollerView;
    
    UITableView *_tableView;
    
    WB_Stopwatch *stopLabel;
    
    CGFloat _scrollerContenHeight;
    
    NSMutableArray *_dataArray;
    
    NSMutableDictionary *_detailsDict;
    //
    //    UILabel *_scoreLabel;
    
    
    NSMutableArray *_starStringArray;
    
    
    NSMutableArray *_latArray;
    
    
    NSMutableArray *_gencheArray;
    NSMutableArray *_zhucheArray;
    
    UIView *_blackView;
    
    UITableView *_tanchuTableView;
    
    NSMutableArray *_imageDataView;
    
    UILabel *_dizhi;
    NSMutableDictionary *_wenhaoDict;
    
    
    
    UIImageView *_leftImageView;
    UIImageView *_middleImageView;
    UIImageView *_rightImageView;
    
    UIView *_view;
    
    UILabel *tomelabel;
    
    UILabel *_chaoshiLabel;
    
    
    NSMutableArray *_arrayTrank;
    NSMutableArray *_dictTrank;
    //    WSStarRatingView *_starRatingView;
    //
}
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapLocationManager *locationManager;

@end

@implementation YesFinaViewController

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

-(void)initIdWenHaoData {
    
    
    [HttpManager postData:@{@"id":_postIdString} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=indent_show" success:^(NSDictionary *fanhuicanshu) {
        
        [_wenhaoDict removeAllObjects];
        [_wenhaoDict addEntriesFromDictionary:fanhuicanshu[@"arr"]];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    _imageDataView = [NSMutableArray new];
    
    _starStringArray = [NSMutableArray new];
    
    _latArray = [NSMutableArray new];
    
    _zhucheArray = [NSMutableArray new];
    
    _gencheArray = [NSMutableArray new];
    
    _wenhaoDict = [NSMutableDictionary new];
    
    
    _arrayTrank = [NSMutableArray new];
    
    _dictTrank = [NSMutableDictionary new];
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
    [self initIdWenHaoData];
    [self initArrayData];
    
    // [self createTableView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBgColor:) name:@"changeString" object:nil];
//    
//    
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
-(void)fanhui {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tousu:(UIButton *)tsButton {
    
    NSLog(@"投诉");
    [self AlertView];
}
- (void)AlertView{
    
    _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _blackView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    _blackView.tag = 1000;
    [self.view.window addSubview:_blackView];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wozaixiangxiang)];
    [_blackView addGestureRecognizer:regsi];
    
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, 64, ScreenWidth*0.9, _tableView.frame.size.height+74)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [_blackView addSubview:_alertView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*0.9, 60)];
    label.text = @"请选择投诉车辆";
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    [_alertView addSubview:label];

    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0.05*screen_width, 63, 0.8*width, 1)];
    //        [grayView setBackgroundColor:[UIColor colorWithDisplayP3Red:242 green:242 blue:242 alpha:1]];
    grayView.backgroundColor = Color(233, 233, 233);
    
    [_alertView addSubview:grayView];
    
    
    _tanchuTableView = [[UITableView alloc] initWithFrame:CGRectMake(width*0.05, 64, ScreenWidth*0.8, _alertView.frame.size.height-64)];
    _tanchuTableView.tag = 111;
    _tanchuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tanchuTableView.delegate = self;
    _tanchuTableView.dataSource = self;
    [_alertView addSubview:_tanchuTableView];
    
}

-(void)wozaixiangxiang {
    
    [_blackView removeFromSuperview];
}

-(void)initArrayData {
    
    [HttpManager postData:@{@"id":_postIdString} andUrl:PATH_URLPOST success:^(NSDictionary *fanhuicanshu) {
        
      
        [_detailsDict removeAllObjects];
        [_detailsDict addEntriesFromDictionary:fanhuicanshu];
        
        
          NSLog(@"%@",_detailsDict);
        NSArray *cheArray = _detailsDict[@"xcxq"][@"carlist"];
        
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (int j = 0; j < cheArray.count; j++) {
            [arr addObject:cheArray[j]];
            
        }
        
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:arr];
        
        [self creatfirstView];
        [self creatwpjsecondView];
        
        [self creatTupianView];
        
        [self creatNeedJiage];
        [self creatwpjFourTwoView];
        
        [self creaTrackIng];
        
        _scrollerView.contentSize = CGSizeMake(ScreenWidth,_scrollerContenHeight+0.05*ScreenHeight+0.3*ScreenWidth);
        
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"%@<<<<<<<<<<<<",cuowuxingxi);
    }];
    
}


-(void)creaTrackIng {
    
    NSLog(@"%@",_detailsDict);
    
    NSArray *newArray = _detailsDict[@"xcxq"][@"carlist"];
    NSDictionary *dict = newArray.firstObject;
    
    NSString *userid = dict[@"userid"];
    NSString *carid = dict[@"carid"];
    NSString *idneed =_postIdString;
    
    [HttpManager postData:@{@"userid":userid,@"id":idneed,@"carid":carid} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=maps_list" success:^(NSDictionary *fanhuicanshu) {
        
        
        [_arrayTrank removeAllObjects];
        [_arrayTrank addObjectsFromArray:fanhuicanshu[@"list"]];
        
        if (_arrayTrank.count >= 2) {
            
            CLLocationCoordinate2D commonPolyLineCoords[2];
            
            for (int i = 0; i< _arrayTrank.count-1; i++) {
                
                for (int j = i+1; j<i+2; j++) {
                    
                    commonPolyLineCoords[0].longitude = [_arrayTrank[i][@"longitude"] doubleValue];
                    commonPolyLineCoords[0].latitude = [_arrayTrank[i][@"latitude"] doubleValue];
                    
                    commonPolyLineCoords[1].longitude = [_arrayTrank[j][@"longitude"] doubleValue];
                    commonPolyLineCoords[1].latitude = [_arrayTrank[j][@"latitude"] doubleValue];
                    
                    MAPolyline *commonPoly = [MAPolyline polylineWithCoordinates:commonPolyLineCoords count:2];
                    [self.mapView addOverlay:commonPoly];
                    
                }
            }
            
            
        }
        
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}


-(void)creatScrollerView {
    _scrollerContenHeight = 0;
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _scrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollerView];
    
    _scrollerView.contentOffset = CGPointMake(0, 0);
    
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
    
    //    UIButton *riqi = [UIButton buttonWithType:UIButtonTypeCustom];
    //    riqi.frame = CGRectMake(width*0.135, width*0.065,  width*0.1, width*0.05);
    //    [riqi setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    //    riqi.tag = 100;
    //    [riqi addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
    //    [fisrView addSubview:riqi];
    
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
    
    //    UIButton *lianxi = [UIButton buttonWithType:UIButtonTypeCustom];
    //    lianxi.frame = CGRectMake(width*0.135, width*0.265,  width*0.1, width*0.05);
    //    [lianxi setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    //    lianxi.tag = 101;
    //    [lianxi addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
    //    [fisrView addSubview:lianxi];
    
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
    
    
    //    UIButton *dizhi = [UIButton buttonWithType:UIButtonTypeCustom];
    //    dizhi.frame = CGRectMake(width*0.8, CGRectGetMaxY(image.frame)+width*0.025,  width*0.1, width*0.05);
    //    //    [dizhi setTitle:@"修改" forState:UIControlStateNormal];
    //    dizhi.tag = 103;
    //    [dizhi setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    //    [dizhi addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
    //    [fisrView addSubview:dizhi];
    
    
    
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
            [self wenhao5];
            break;
        }
        case 1:{
            NSLog(@"1");
            [self wenhao6];
            break;
        }
        case 2:{
            NSLog(@"2");
            [self wenhao7];
            break;
        }
        case 3:{
            NSLog(@"3");
            [self wenhao8];
            break;
        }
        case 4:{
            NSLog(@"4");
            [self kaiqiditu];
            break;
        }
        case 5:{
            NSLog(@"5");
            [self wenhao9];
            break;
        }
        case 6:{
            NSLog(@"6");
            [self wenhao10];
            break;
        }
        case 7:{
            NSLog(@"7");
            break;
        }
  
        default:
            break;
    }
}

- (void)wenhao10{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    view1.tag = 510;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeWenhao10)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.4, width*0.9, width*0.64)];
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
    [cuowu addTarget:self action:@selector(removeWenhao10) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(cuowu.frame), view2.frame.size.width*0.9, width*0.15)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = Color(77, 77, 77);
    label1.text = @"超公里";
    label1.font = [UIFont boldSystemFontOfSize:20];
    [view2 addSubview:label1];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.28, view2.frame.size.width*0.9, width*0.15)];
    label2.textAlignment = NSTextAlignmentCenter;
    
    
    NSString *s1 = _detailsDict[@"xcxq"][@"gonglishu"];
    NSString *s2 = _detailsDict[@"xcxq"][@"zhuche_chaogongli"];
    
    
    NSInteger gongli = [s1 integerValue]- [s2 integerValue];
    
    if (gongli > 0) {
        label2.text = [NSString stringWithFormat:@"%zd",gongli];
    }else {
        label2.text = [NSString stringWithFormat:@"%@",@"0"];
    }
    label2.font = [UIFont boldSystemFontOfSize:20];
    label2.textColor = Color(255, 97, 57);
    [view2 addSubview:label2];
    
    
}
-(void)removeWenhao10 {
    UIView *view410 = (UIView *)[self.view.window viewWithTag:510];
    [view410 removeFromSuperview];
    
}
- (void)wenhao9{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    view1.tag = 510;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeWenhao9)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.4, width*0.9, width*0.64)];
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
    [cuowu addTarget:self action:@selector(removeWenhao9) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(cuowu.frame), view2.frame.size.width*0.9, width*0.15)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = Color(77, 77, 77);
    label1.text = @"超时";
    label1.font = [UIFont boldSystemFontOfSize:20];
    [view2 addSubview:label1];
    
    
    _chaoshiLabel = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.28, view2.frame.size.width*0.9, width*0.15)];
    _chaoshiLabel.textAlignment = NSTextAlignmentCenter;
    _chaoshiLabel.font = [UIFont boldSystemFontOfSize:20];
    _chaoshiLabel.textColor = Color(255, 97, 57);
    [view2 addSubview:_chaoshiLabel];
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
    NSInteger a = [_detailsDict[@"xcxq"][@"kssj"] integerValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"1296035591  = %@",confromTimespStr);
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init] ;
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
    NSInteger a1 = [_detailsDict[@"xcxq"][@"jssj"] integerValue];
    NSDate *confromTimesp1 = [NSDate dateWithTimeIntervalSince1970:a1];
    NSLog(@"1296035591  = %@",confromTimesp1);
    NSString *confromTimespStr1 = [formatter1 stringFromDate:confromTimesp1];
    NSLog(@"1296035591  = %@",confromTimespStr1);
    
    
    NSString *hours = [self dateTimeDifferenceWithStartTimechaoshi:confromTimespStr endTime:confromTimespStr1];
    NSString *ss = _detailsDict[@"xcxq"][@"zhuche_chaoshi"];
    NSInteger hou = [hours integerValue] - [ss integerValue]*3600;
    
    [self getDetailTimeWithTimestampchahsi:hou];
    

    
    
}
- (void)getDetailTimeWithTimestampchahsi:(NSInteger)timestamp{
    
    
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
    
    
    if (timestamp <=0) {
        
        
        _chaoshiLabel.text = @"0";
    }else {
        if(hour >=0) {
            if (minute>=10) {
                a = [NSString stringWithFormat:@"%zd",hour+1];
            }else {
                a = [NSString stringWithFormat:@"%zd",hour];
            }
        }else {
            
            a = [NSString stringWithFormat:@"%zd",@"0"];
            
        }
        _chaoshiLabel.text = a;
    }
    
    
}


- (NSString *)dateTimeDifferenceWithStartTimechaoshi:(NSString *)startTime endTime:(NSString *)endTime{
    
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

-(void)removeWenhao9 {
    UIView *view510 = (UIView *)[self.view.window viewWithTag:510];
    [view510 removeFromSuperview];
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
     label.text = @"订单已结束,无法查看定位";
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
    
    
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.lineWidth   = 5.f;
        polylineRenderer.strokeColor = [[UIColor colorWithRed:7/255.0 green:177/255.0 blue:187/255.0 alpha:1] colorWithAlphaComponent:0.7];
        return polylineRenderer;
    }
    
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
    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",youhui]];
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
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*ScreenWidth, 0.1*ScreenHeight*i+0.03*ScreenHeight, 0.2*ScreenWidth, 0.04*ScreenHeight)];
        rightLabel.text = priceArray[i];
        rightLabel.textColor = [UIColor redColor];
        rightLabel.textColor = Color(255, 97, 57);
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 ];
        [thirdView addSubview:rightLabel];
        
    }
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

// three


-(void)creatTupianView {
    
    
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.3*ScreenWidth)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= 0.3*ScreenWidth;
    fourView.tag = 12345;
    [_scrollerView addSubview:fourView];
    
    //  fourView.backgroundColor = [UIColor redColor];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.9*width, width*0.1)];
    label.text = @"图片";
    [label setTextColor:[UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1]];
    label.font = [UIFont fontWithName:@"ArialMT" size:15];
    label.textAlignment = NSTextAlignmentCenter;
    [fourView addSubview:label];
    
    
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+width*0.03, ScreenWidth*0.9,ScreenWidth*0.9/4*2/3)];
    [fourView addSubview:_view];
    
    
    
    
    
    _leftImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,width*0.9/4, width*0.9/4*2/3)];
    _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.9/4,0,width*0.9/4, width*0.9/4*2/3)];
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.9/4*2,0,width*0.9/4,width*0.9/4*2/3)];
    if ([_detailsDict[@"xcxq"][@"pic1"] isKindOfClass:[NSNull class]]) {
        _leftImageView.image = [UIImage imageNamed:@""];
    }else {
        _leftImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",_detailsDict[@"xcxq"][@"pic1"]]]]];
    }
    [_view addSubview:_leftImageView];
    
    
    if ([_detailsDict[@"xcxq"][@"pic2"] isKindOfClass:[NSNull class]]) {
        _middleImageView.image = [UIImage imageNamed:@""];
    }else {
        _middleImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",_detailsDict[@"xcxq"][@"pic2"]]]]];
    }
    [_view addSubview:_middleImageView];
    
    
    if ([_detailsDict[@"xcxq"][@"pic3"] isKindOfClass:[NSNull class]]) {
        _rightImageView.image = [UIImage imageNamed:@""];
    }else {
        _rightImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",_detailsDict[@"xcxq"][@"pic3"]]]]];
    }
    [_view addSubview:_rightImageView];
    
    
    
    //
    //
    //    UIButton *jieshu = [UIButton buttonWithType:UIButtonTypeCustom];
    //    jieshu.frame = CGRectMake(0,0, width*0.9/4,width*0.9/4*2/3);
    //    // jieshu.backgroundColor = Color(7, 187, 177);
    //    jieshu.tag = 123456;
    //    [jieshu setBackgroundImage:[UIImage imageNamed:@"加图(1).png"] forState:UIControlStateNormal];
    //    [jieshu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    [jieshu setTintColor:[UIColor whiteColor]];
    //    [jieshu addTarget:self action:@selector(tianjiatupian:) forControlEvents:UIControlEventTouchUpInside];
    //    [_view addSubview:jieshu];
}

//
//-(void)tianjiatupian:(UIButton*)button {
//    
//    
//    //创建UIImagePickerController对象，并设置代理和可编辑
//    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
//    imagePicker.editing = YES;
//    imagePicker.delegate = self;
//    imagePicker.allowsEditing = YES;
//    
//    //创建sheet提示框，提示选择相机还是相册
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    //相机选项
//    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        //选择相机时，设置UIImagePickerController对象相关属性
//        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
//        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
//        imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
//        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//        //跳转到UIImagePickerController控制器弹出相机
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }];
//    
//    //相册选项
//    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        //选择相册时，设置UIImagePickerController对象相关属性
//        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        //跳转到UIImagePickerController控制器弹出相册
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }];
//    
//    //取消按钮
//    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
//    
//    //添加各个按钮事件
//    [alert addAction:camera];
//    [alert addAction:photo];
//    [alert addAction:cancel];
//    
//    //弹出sheet提示框
//    [self presentViewController:alert animated:YES completion:nil];
//    
//    
//    NSLog(@"%@",_imageDataView);
//    
//}
//#pragma mark - imagePickerController delegate
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//    
//    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
//    
//    
//    if (_imageDataView.count == 0) {
//        
//        UIView *view = (UIView *)[_scrollerView viewWithTag:12345];
//        UIButton *button = (UIButton *)[view viewWithTag:123456];
//        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,width*0.13,width*0.9/4, width*0.24)];
//        leftImageView.image = image;
//        [view addSubview:leftImageView];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"love"];
//        
//        button.frame = CGRectMake(width*0.9/4,width*0.13,width*0.9/4, width*0.24);
//        
//    }
//    if (_imageDataView.count == 1) {
//        
//        UIView *view = (UIView *)[_scrollerView viewWithTag:12345];
//        UIButton *button = (UIButton *)[view viewWithTag:123456];
//        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.9/4,width*0.13,width*0.9/4, width*0.24)];
//        leftImageView.image = image;
//        [view addSubview:leftImageView];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"love1"];
//        
//        button.frame = CGRectMake(width*0.9/4*2,width*0.13,width*0.9/4, width*0.24);
//    }
//    if (_imageDataView.count == 2) {
//        
//        UIView *view = (UIView *)[_scrollerView viewWithTag:12345];
//        UIButton *button = (UIButton *)[view viewWithTag:123456];
//        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.9/4*2,width*0.13,width*0.9/4, width*0.24)];
//        leftImageView.image = image;
//        [view addSubview:leftImageView];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"love2"];
//        
//        button.frame = CGRectMake(width*0.9/4*3,width*0.13,width*0.9/4, width*0.24);
//    }
//    
//    [_imageDataView addObject:[info valueForKey:UIImagePickerControllerEditedImage]];
//    
//    //获取到的图片
//    //
//    //    if (flag ==1) {
//    //        _leftImageView.image = image;
//    //        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"left"];
//    //        NSString *path = NSHomeDirectory();
//    //        NSString *endPath = [path stringByAppendingString:@"/Document/pic1.jpg"];
//    //        [UIImagePNGRepresentation(image) writeToFile:endPath atomically:YES];
//    //    }else if (flag ==2) {
//    //        _middleImageView.image = image;
//    //        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"middle"];
//    //        NSString *path = NSHomeDirectory();
//    //        NSString *endPath = [path stringByAppendingString:@"/Document/pic2.jpg"];
//    //        [UIImagePNGRepresentation(image) writeToFile:endPath atomically:YES];
//    //    }else if(flag ==3) {
//    //        _rightImageView.image = image;
//    //        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"right"];
//    //        NSString *path = NSHomeDirectory();
//    //        NSString *endPath = [path stringByAppendingString:@"/Document/pic3.jpg"];
//    //        [UIImagePNGRepresentation(image) writeToFile:endPath atomically:YES];
//    //    }
//    
//}

// 4
//第三个界面
-(void)creatNeedJiage {
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.4*ScreenHeight)];
    //thirdView.backgroundColor = [UIColor greenColor];
    _scrollerContenHeight+= 0.4*ScreenHeight;
    [_scrollerView addSubview:thirdView];
    
    UIView *grayView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 0.9*width, 1)];
    grayView1.backgroundColor = Color(233, 233, 233);
    [thirdView addSubview:grayView1];
    
    
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
        wenhao.tag = 100+i;
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



-(void)creatwpjFourTwoView {
    
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width,width*1.125+ScreenHeight*0.2)];
    // fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*0.925+ScreenHeight*0.2+width*0.04;
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
    
    
    tomelabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.38+width*0.175/2, width*0.4+width*0.175/2, width*0.175, width*0.175)];
    tomelabel.adjustsFontSizeToFitWidth = YES;
    tomelabel.textColor = [UIColor redColor];
    tomelabel.textAlignment = NSTextAlignmentCenter;
    tomelabel.font = [UIFont systemFontOfSize:18];
    [fourView addSubview:tomelabel];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
    NSInteger a = [_detailsDict[@"xcxq"][@"kssj"] integerValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"1296035591  = %@",confromTimespStr);
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init] ;
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
    NSInteger a1 = [_detailsDict[@"xcxq"][@"jssj"] integerValue];
    NSDate *confromTimesp1 = [NSDate dateWithTimeIntervalSince1970:a1];
    NSLog(@"1296035591  = %@",confromTimesp1);
    NSString *confromTimespStr1 = [formatter1 stringFromDate:confromTimesp1];
    NSLog(@"1296035591  = %@",confromTimespStr1);
    
    NSString *hours = [self dateTimeDifferenceWithStartTime:confromTimespStr endTime:confromTimespStr1];
    NSInteger hou = [hours integerValue];
    [self getDetailTimeWithTimestamp:hou];
    
    
    

    UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake(width/2+width*0.03+width*0.175/2-0.1*width, width*0.4+width*0.175/2, width*0.175, width*0.175)];
    NSInteger gonglishu  = [_detailsDict[@"xcxq"][@"gonglishu"] integerValue];
    timeLable.text = [NSString stringWithFormat:@"%ld",gonglishu];
    // timeLable .backgroundColor = [UIColor Color(255, 97, 57);greenColor];
    timeLable.textColor = [UIColor redColor];
    timeLable.adjustsFontSizeToFitWidth = YES;
    timeLable.textAlignment = NSTextAlignmentCenter;
    timeLable.font = [UIFont systemFontOfSize:18];
    [fourView addSubview:timeLable];
    
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
    
    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, width*0.4+width*0.35*2/3+width*0.175+width*0.05, 0.9*ScreenWidth, 1)];
    views.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    [fourView addSubview:views];
    
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(0,width*0.4+width*0.35*2/3+width*0.175+width*0.05, 0.9*width, 0.2*ScreenHeight)];
    [fourView addSubview:thirdView];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.2*ScreenHeight-1, 0.9*width, 1)];
    grayView.backgroundColor = Color(233, 233, 233);
    [thirdView addSubview:grayView];
    NSArray *array = @[@"超时",@"超公里"];
    NSInteger jiage  = [_detailsDict[@"xcxq"][@"chaoshijiage"] integerValue];
    NSInteger yufukuan  = [_detailsDict[@"xcxq"][@"chaogonglijiage"] integerValue];
    // NSLog(@"%@",_detailsDict[@"xcxq"][@"jiage"]);
    NSMutableArray *priceArray = [NSMutableArray new];
    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",jiage]];
    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",yufukuan]];
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
        
        if (i == 0) {
            UIButton *wenhao = [UIButton buttonWithType:UIButtonTypeCustom];
            wenhao.frame = CGRectMake(width*0.135, 0.1*ScreenHeight*i+(ScreenHeight*0.1 - width*0.077)/2, width*0.077, width*0.077);
            wenhao.tag = 100+i+5;
            [wenhao addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
            [wenhao setBackgroundImage:[UIImage imageNamed:@"问红.png"] forState:UIControlStateNormal];
            [thirdView addSubview:wenhao];
        }else {
            UIButton *wenhao = [UIButton buttonWithType:UIButtonTypeCustom];
            wenhao.frame = CGRectMake(width*0.17, 0.1*ScreenHeight*i+(ScreenHeight*0.1 - width*0.077)/2, width*0.077, width*0.077);
            wenhao.tag = 100+i+5;
            [wenhao addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
            [wenhao setBackgroundImage:[UIImage imageNamed:@"问红.png"] forState:UIControlStateNormal];
            [thirdView addSubview:wenhao];
            
        }
        
        
        
        if (i==0) {
            
        }else {
            UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.1*i*ScreenHeight, 0.9*width, 1)];
            //        [grayView setBackgroundColor:[UIColor colorWithDisplayP3Red:242 green:242 blue:242 alpha:1]];
            grayView.backgroundColor = Color(233, 233, 233);
            
            [thirdView addSubview:grayView];
            
        }
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*ScreenWidth, 0.1*ScreenHeight*i+0.03*ScreenHeight, 0.2*ScreenWidth, 0.04*ScreenHeight)];
        rightLabel.text = priceArray[i];
        rightLabel.textColor = [UIColor redColor];
        rightLabel.textColor = Color(255, 97, 57);
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 ];
        [thirdView addSubview:rightLabel];
    }
    
    UIButton *jieshu = [UIButton buttonWithType:UIButtonTypeCustom];
    jieshu.frame = CGRectMake(width*0.2-0.05*width,width*0.4+width*0.35*2/3+width*0.175+width*0.05+ScreenHeight*0.2+width*0.08, width*0.6, width*0.12);
    jieshu.backgroundColor = Color(7, 187, 177);
    jieshu.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [jieshu setTitle:@"评价我们" forState:UIControlStateNormal];
    [jieshu setTintColor:[UIColor whiteColor]];
    [jieshu addTarget:self action:@selector(wanchengle:) forControlEvents:UIControlEventTouchUpInside];
    [fourView addSubview:jieshu];
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
    
    
    
    tomelabel.text = [NSString stringWithFormat:@"%@ : %@",a,b];
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


-(void)wanchengle:(UIButton *)button {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"love"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"love1"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"love2"];
    
    
    
    NSLog(@"评价我们");
    NSString *appstoreUrlString = [NSString stringWithFormat:
                                   @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",
                                   @"1092600640" ];
    
    NSURL * url = [NSURL URLWithString:appstoreUrlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        
        [[UIApplication sharedApplication]openURL:url];
    }
    else
    {
        NSLog(@"can not open");
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // if (_tableView == tableView ||_tanchuTableView == tableView){
    return _dataArray.count;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_tanchuTableView == tableView) {
        NSLog(@"1");
        
        NSDictionary *dict = _dataArray[indexPath.row];
        NSLog(@"%@",dict);
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_tableView == tableView ||_tanchuTableView == tableView){
        return 1;
    }
    return  0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0.15*ScreenHeight+2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_tableView == tableView){
        
        static NSString *strc = @"stack";
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
        if (!cell) {
            
            //  cell = [[DetailsCarXclTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
            cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.dict = _dataArray[indexPath.row];
        //cell.plantName = _dataArray[indexPath.row];
        return cell;
    }
    if (_tanchuTableView == tableView){
        
        static NSString *strc = @"stack";
        TousuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
        if (!cell) {
            
            //  cell = [[DetailsCarXclTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
            cell = [[TousuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.dict = _detailsDict;
        
        cell.delgete =self;
        
        cell.plane_name = _dataArray[indexPath.row];
        
        NSLog(@"1111111111111111111111111111%@",_detailsDict);
        return cell;
        
    }
    return nil;
}
-(void)imageButtonClick:(NSDictionary *)dict AndchePai:(NSDictionary *)cheopaiDict{
    
    [_blackView removeFromSuperview];
    //  [self needView];
    TouSuAddImageViewController *tousu = [TouSuAddImageViewController new];
    tousu.tousuDict = dict;
    tousu.chepai = cheopaiDict;
    [self.navigationController pushViewController:tousu animated:NO];
    
}

//
//#pragma mark--调用相机还是相册
//-(void)tianjiatupian:(UIButton *)button{
//    
//    UIActionSheet*myActionSheet = [[UIActionSheet alloc]
//                                   initWithTitle:nil
//                                   delegate:self
//                                   cancelButtonTitle:@"取消"
//                                   destructiveButtonTitle:nil
//                                   otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
//    
//    [myActionSheet showInView:self.view];
//}
//#pragma mark--actionSheet选择调用相机还是相册
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    
//    switch (buttonIndex) {
//        case 0://照相机
//        {
//            // 拍照
//            if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
//                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
//                if ([self isFrontCameraAvailable]) {
//                    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//                }
//                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
//                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
//                controller.mediaTypes = mediaTypes;
//                controller.delegate = self;
//                [self presentViewController:controller
//                                   animated:YES
//                                 completion:^(void){
//                                     NSLog(@"Picker View Controller is presented");
//                                 }];
//                [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
//            }
//        }
//            break;
//        case 1://本地相簿
//        {
//            // 从相册中选取
//            if ([self isPhotoLibraryAvailable]) {
//                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//                controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
//                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
//                controller.mediaTypes = mediaTypes;
//                controller.delegate = self;
//                [self presentViewController:controller
//                                   animated:YES
//                                 completion:^(void){
//                                     NSLog(@"Picker View Controller is presented");
//                                 }];
//                [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
//            }
//            
//        }
//            break;
//        default:
//            break;
//    }
//}
//- (BOOL) isPhotoLibraryAvailable{
//    return [UIImagePickerController isSourceTypeAvailable:
//            UIImagePickerControllerSourceTypePhotoLibrary];
//}
//#pragma mark -UIActionSheet Delegate
//- (BOOL) isCameraAvailable
//{
//    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
//}
//- (BOOL) doesCameraSupportTakingPhotos {
//    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
//}
//- (BOOL) isFrontCameraAvailable {
//    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
//}
//- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
//    __block BOOL result = NO;
//    if ([paramMediaType length] == 0) {
//        return NO;
//    }
//    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
//    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
//        NSString *mediaType = (NSString *)obj;
//        if ([mediaType isEqualToString:paramMediaType]){
//            result = YES;
//            *stop= YES;
//        }
//    }];
//    return result;
//}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    [picker dismissViewControllerAnimated:YES completion:^() {
//        
//        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//        portraitImg = [self imageByScalingToMaxSize:portraitImg];
//        // 裁剪
//        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0,100, self.view.frame.size.width, self.view.frame.size.width*2/3) limitScaleRatio:3.0];
//        imgEditorVC.delegate = self;
//        [self presentViewController:imgEditorVC animated:YES completion:^{
//            // TO DO
//        }];
//    }];
//}
//
//- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
//    
//    [cropperViewController dismissViewControllerAnimated:YES completion:^{
//        
//        
//    }];
//}
//
//-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
//{
//    
//    UIGraphicsBeginImageContext(newSize);
//    
//    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return newImage;
//}
//- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
//    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
//    CGFloat btWidth = 0.0f;
//    CGFloat btHeight = 0.0f;
//    if (sourceImage.size.width > sourceImage.size.height) {
//        btHeight = ORIGINAL_MAX_WIDTH;
//        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
//    } else {
//        btWidth = ORIGINAL_MAX_WIDTH;
//        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
//    }
//    CGSize targetSize = CGSizeMake(btWidth, btHeight);
//    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
//}
//- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
//    UIImage *newImage = nil;
//    CGSize imageSize = sourceImage.size;
//    CGFloat width1 = imageSize.width;
//    CGFloat height = imageSize.height;
//    CGFloat targetWidth = targetSize.width;
//    CGFloat targetHeight = targetSize.height;
//    CGFloat scaleFactor = 0.0;
//    CGFloat scaledWidth = targetWidth;
//    CGFloat scaledHeight = targetHeight;
//    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
//    if (CGSizeEqualToSize(imageSize, targetSize) == NO){
//        
//        CGFloat widthFactor = targetWidth / width1;
//        CGFloat heightFactor = targetHeight / height;
//        
//        if (widthFactor > heightFactor)
//            scaleFactor = widthFactor; // scale to fit height
//        else
//            scaleFactor = heightFactor; // scale to fit width
//        scaledWidth  = width1 * scaleFactor;
//        scaledHeight = height * scaleFactor;
//        
//        // center the image
//        if (widthFactor > heightFactor)
//        {
//            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
//        }
//        else
//            if (widthFactor < heightFactor)
//            {
//                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
//            }
//    }
//    UIGraphicsBeginImageContext(targetSize); // this will crop
//    CGRect thumbnailRect = CGRectZero;
//    thumbnailRect.origin = thumbnailPoint;
//    thumbnailRect.size.width  = scaledWidth;
//    thumbnailRect.size.height = scaledHeight;
//    
//    [sourceImage drawInRect:thumbnailRect];
//    
//    newImage = UIGraphicsGetImageFromCurrentImageContext();
//    if(newImage == nil) NSLog(@"could not scale image");
//    
//    //pop the context to get back to the default
//    UIGraphicsEndImageContext();
//    return newImage;
//}
//#pragma mark VPImageCropperDelegate
//- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
//    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [cropperViewController dismissViewControllerAnimated:YES completion:^{
//        
//        
//        
//        if (_imageDataView.count<3) {
//            
//            if (_imageDataView.count == 0) {
//                
//                
//                UIButton *button = (UIButton *)[_view viewWithTag:123456];
//                _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,width*0.9/4, width*0.9/4*2/3)];
//                _leftImageView.image = editedImage;
//                [_view addSubview:_leftImageView];
//                
//            //    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"love"];
//                
//                button.frame = CGRectMake(width*0.9/4,0,width*0.9/4, width*0.9/4*2/3);
//                
//                [_imageDataView addObject:editedImage];
//                
//            }else if (_imageDataView.count == 1) {
//                
//                UIButton *button = (UIButton *)[_view viewWithTag:123456];
//                _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.9/4,0,width*0.9/4, width*0.9/4*2/3)];
//                //  _leftImageView.image = _imageDataView[0];
//                _middleImageView.image = editedImage;
//                [_view addSubview:_middleImageView];
//                
//                //                _leftImageView.image = (UIImage *)_initdataView[0];
//                //                _leftImageView.frame = CGRectMake(0,0,width*0.8/4, width*0.8/4*2/3);
//                //                  [_view addSubview:_leftImageView];
//            //    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"love1"];
//                
//                button.frame = CGRectMake(width*0.9/4*2,0,width*0.9/4, width*0.9/4*2/3);
//                
//                [_imageDataView addObject:editedImage];
//                
//            }else if (_imageDataView.count == 2) {
//                
//                
//                UIButton *button = (UIButton *)[_view viewWithTag:123456];
//                _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.9/4*2,0,width*0.9/4,width*0.9/4*2/3)];
//                _rightImageView.image = editedImage;
//                //                _middleImageView.image = _imageDataView[1];
//                //                _leftImageView.image = _imageDataView[0];
//                [_view addSubview:_rightImageView];
//                
//              //  [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"love2"];
//                
//                button.frame = CGRectMake(width*0.9/4*3,0,width*0.9/4, width*0.9/4*2/3);
//                
//                [_imageDataView addObject:editedImage];
//                
//            }
//            
//            
//        }
//        
//        
//    }];
//}



@end
