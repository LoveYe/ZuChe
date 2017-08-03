//
//  XiangqingController.m
//  ZuChe
//
//  Created by apple  on 16/12/21.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "YongHuXingChengDetailsViewController.h"
#import "Header.h"
#import "DetailsCarXclTableViewCell.h"
#import "CommentTableViewCell.h"
#import "HttpManager.h"
#import "NoPayTableViewCell.h"
#import "ZCUserData.h"
#import "PayView.h"



#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

//#import "CZCountDownView.h"
#import "TimeSelectViewUpdate.h"
#import "JiHeAddressViewController.h"
#import "CCDatePickerViewUpdate.h"
#import "MBProgressHUD.h"
#import "DengDaiPpTableViewCell.h"
//投诉
#import "TouSuAddImageViewController.h"
#import "TousuTableViewCell.h"

//集合中
#import "AllPointsViewController.h"

//服务中

#import "FwzMapAnniviewViewController.h"

#import "VPImageCropperViewController.h"

#import "NoPjDjmTableViewCell.h"


#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define ORIGINAL_MAX_WIDTH 640.0f

//#import "WSStarRatingView.h"

#define PATH_URLPOST @"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks"

@interface YongHuXingChengDetailsViewController()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MAMapViewDelegate,AMapLocationManagerDelegate,addressDelgate,toushuDelgate,UIActionSheetDelegate,VPImageCropperDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    
    CGFloat width;
    
    UIScrollView *_scrollerView;
    
    UITableView *_tableView;
    
    CGFloat _scrollerContenHeight;
    
    NSMutableArray *_dataArray;
    
    NSMutableDictionary *_detailsDict;
    
    UIView *_bigView;
    
    UILabel *_dizhi;
    
    UIView *_lianxiView;
    
    //CZCountDownView *_countDown;
    
    UIRefreshControl *refreshControl;
    
    UITextField *tefield;
    UITextField *nafield;
    
    NSString *_addString;
    
    UIView *_blackView;
    
    NSMutableDictionary *_wenhaoDict;
    //未支付计时器
    NSTimer *_zhifuTimer;
    //未开始计时器
    NSTimer *_wksTime;
    
    UILabel *_timeLabel;
    
    UIView *_queding;
    
    //投诉tableview
    UITableView *_tanchuTableView;
    
    
    UILabel *tomelabel;
    

    NSTimer *_shuaxinTImer;
    
    UILabel *_chaoshiLabel;
    UILabel *_chaogongliLabel;

    
}
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapLocationManager *locationManager;

@property (nonatomic,retain) NSArray *timesArray;
@property (nonatomic ,retain)NSArray *kmsArray;

@property(nonatomic,assign)NSInteger timestamp;


@property(nonatomic,assign)NSInteger wksTimestamp;
@end

@implementation YongHuXingChengDetailsViewController



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
#pragma mark -- 创建定时器

-(void)creatTimer {
    
    _shuaxinTImer =[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(shuaxintimer:) userInfo:nil repeats:YES];
}

-(void)shuaxintimer:(NSTimer*)timer{

   
    [_zhifuTimer invalidate];
    _zhifuTimer = nil;
    [_shuaxinTImer invalidate];
    _shuaxinTImer = nil;
    [_wksTime invalidate];
    _wksTime = nil;
     [_scrollerView removeFromSuperview];
    // 此处添加刷新tableView数据的代码
    [self initIdWenHaoData];
    [self initArrayData];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    [_scrollerView removeFromSuperview];
    [_zhifuTimer invalidate];
    _zhifuTimer = nil;
    [_shuaxinTImer invalidate];
    _shuaxinTImer = nil;
    [_wksTime invalidate];
     _wksTime = nil;
    [self initIdWenHaoData];
    [self initArrayData];
    
    
    [self creatTimer];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    [_scrollerView removeFromSuperview];
    
    [_zhifuTimer invalidate];
    _zhifuTimer = nil;
    
    [_wksTime invalidate];
    _wksTime = nil;
    
    [_shuaxinTImer invalidate];
     _shuaxinTImer = nil;

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
    
}

#pragma mark -- 下拉刷新触发，在此获取数据
-(void)refreshClick1:(UIRefreshControl *)refreshContro {
    NSLog(@"refreshClick: -- 刷新触发");
    
   
  
    [_zhifuTimer invalidate];
    _zhifuTimer = nil;
    [_shuaxinTImer invalidate];
    _shuaxinTImer = nil;
    [_wksTime invalidate];
    _wksTime = nil;
    [_scrollerView removeFromSuperview];
    // 此处添加刷新tableView数据的代码
    [self initIdWenHaoData];
    [self initArrayData];
}



- (void)gobackTo{
    
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)tousu:(UIButton *)tsButton {
    NSLog(@"投诉");
    
    [self AlertView];
}
#pragma mark -- 所有问号和备注的数据网络请求数据
-(void)initIdWenHaoData {
    
    [HttpManager postData:@{@"id":_postIdString} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=indent_show" success:^(NSDictionary *fanhuicanshu) {
        
        [_wenhaoDict removeAllObjects];
        [_wenhaoDict addEntriesFromDictionary:fanhuicanshu[@"arr"]];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}

-(void)creatTousuwks {
    
    
    UIButton *touSu = [UIButton buttonWithType:UIButtonTypeCustom];
    touSu.frame = CGRectMake(0, 0, 25, 25);
    touSu.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    [touSu setTitle:@"投诉" forState:UIControlStateNormal];
    [touSu setTitleColor:[UIColor colorWithRed:223/255.0 green:62/255.0 blue:101/255.0 alpha:1] forState:UIControlStateNormal];
    touSu.layer.borderColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:101/255.0 alpha:1].CGColor;
    touSu.layer.borderWidth = 1;
    touSu.layer.cornerRadius = 12.5;
    [touSu addTarget:self action:@selector(tousuwks:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:touSu];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
}
-(void)tousuwks:(UIButton *)tsButton {
    NSLog(@"投诉");
    
    [self AlertViewwks];
}
//投诉未开始
- (void)AlertViewwks{
    
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
    label.text = @"订单尚未开始，开始后开启投诉";
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
    [queding addTarget:self action:@selector(moveAllwks) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
-(void)moveAllwks {
    
    [_bigView removeFromSuperview];
}


#pragma mark -- 未开启投诉弹出框
-(void)creatTousu {
    
    
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
#pragma mark -- 开启投诉弹出框
-(void)creatKqTousu {
    
    UIButton *touSu = [UIButton buttonWithType:UIButtonTypeCustom];
    touSu.frame = CGRectMake(0, 0, 25, 25);
    touSu.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    [touSu setTitle:@"投诉" forState:UIControlStateNormal];
    [touSu setTitleColor:[UIColor colorWithRed:223/255.0 green:62/255.0 blue:101/255.0 alpha:1] forState:UIControlStateNormal];
    touSu.layer.borderColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:101/255.0 alpha:1].CGColor;
    touSu.layer.borderWidth = 1;
    touSu.layer.cornerRadius = 12.5;
    [touSu addTarget:self action:@selector(kaiqitousu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:touSu];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
-(void)kaiqitousu{
    
    [self kaiqitousuView];
}
- (void)kaiqitousuView{
    
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

- (void)kaiqitousuView1{
    

 
    
    _bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:_bigView];
    
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wozaixiangxiang)];
    [_bigView addGestureRecognizer:regsi];
    
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
    label.text = @"将返回订单列表进入评价界面";
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
    [queding addTarget:self action:@selector(wozaixiangxiang1) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
 
}
-(void)wozaixiangxiang1 {
    
    [_bigView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)imageButtonClick:(NSDictionary *)dict AndchePai:(NSDictionary *)cheopaiDict{
    
    [_blackView removeFromSuperview];
    //  [self needView];
    TouSuAddImageViewController *tousu = [TouSuAddImageViewController new];
    tousu.tousuDict = dict;
    tousu.chepai = cheopaiDict;
    [self.navigationController pushViewController:tousu animated:NO];
    
}




#pragma mark -- 所有需要的数据网络请求数据
-(void)initArrayData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [HttpManager postData:@{@"id":_postIdString} andUrl:PATH_URLPOST success:^(NSDictionary *fanhuicanshu) {
        
        NSLog(@"%@",fanhuicanshu);
        
        [_detailsDict removeAllObjects];
        [_detailsDict addEntriesFromDictionary:fanhuicanshu];
        NSArray *cheArray = _detailsDict[@"xcxq"][@"carlist"];
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (int j = 0; j < cheArray.count; j++) {
            [arr addObject:cheArray[j]];
            
        }
        
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:arr];
        
        NSString *status = fanhuicanshu[@"xcxq"][@"status"];
        if ([status isEqualToString:@"1"]) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"待支付定金";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
            [self creatTousu];
            [self creatfirstView];
            [self creatzfdjSecondView];
            [self creatzfdjthirdView];
            [self creatzfdjfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            
        }else if([status isEqualToString:@"2"]) {
       
            
            [_zhifuTimer invalidate];
             _zhifuTimer = nil;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"等待匹配";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
             [self creatTousu];
            [self creatfirstView];
            [self creatzfdjSecondView];
            [self creatzfdjthirdView];
            [self creatppzfourView];
            
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            
        }else if([status isEqualToString:@"3"]) {
            
          
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"匹配中";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
             [self creatTousu];
            [self creatXinFirstView];
            [self creatzfdjSecondView];
            [self creatzfdjthirdView];
            [self creatSuccessPpfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            
        }else if([status isEqualToString:@"4"]) {
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"未开始";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
             [self creatTousuwks];
            [self creatXinFirstView];
            [self creatzfdjSecondView];
            [self creatzfdjthirdView];
            [self creatwksourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            
        }else if([status isEqualToString:@"5"]) {
            
            [_wksTime invalidate];
             _wksTime = nil;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"集合中";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
            [self creatKqTousu];
            [self creatJhzAndlastfirstView];
            [self creatzfdjSecondView];
            [self creatJheAndLastthirdView];
            [self creaJhzfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            
        }else if([status isEqualToString:@"6"]) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"待支付尾款";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
            [self creatKqTousu];
            [self creatJhzAndlastfirstView];
            [self creatzfdjSecondView];
            [self creatJheAndLastthirdView];
            [self creatzfwkfourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            [HttpManager postData:@{@"id":_postIdString}andUrl:@"http://wx.leisurecarlease.com/tc.php?op=maps_del" success:^(NSDictionary *fanhuicanshu) {
                
            } Error:^(NSString *cuowuxingxi) {
                
            }];
        }else if([status isEqualToString:@"7"]) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"等待服务";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
            [self creatKqTousu];
            [self creatJhzAndlastfirstView];
            [self creatzfdjSecondView];
            [self creatJheAndLastthirdView];
            [self creatdengdaifuwufourView];
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
            
            
          
        }else if([status isEqualToString:@"8"]) {
            
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
                label.text = @"服务中";
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
                label.textColor = Color(140, 140, 140);
                self.navigationItem.titleView = label;
                
                [self creatKqTousu];
                [self creatfwzfirstView];
                [self creatzfdjSecondView];
                [self creatfwzthirdView];
                [self creatfwzfourView];
                _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
          
         
        }else if([status isEqualToString:@"9"]) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"带支付超时费用";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
            
            [self creatKqTousu];
            [self creatzfchaoshifirstView];
            [self creatzfdjSecondView];
            [self creatzfchaoshithirdView];
            [self creatzfcsFourTwoView];
            
            _scrollerView.contentSize = CGSizeMake(ScreenWidth,  _scrollerContenHeight+64);
        }else if([status isEqualToString:@"10"]) {
            
            [_shuaxinTImer invalidate];
            _shuaxinTImer = nil;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.text = @"未评价";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            label.textColor = Color(140, 140, 140);
            self.navigationItem.titleView = label;
            
            [self kaiqitousuView1];
//            [self creatwpjfirstView];
//            [self creatwpjsecondView];
//            
//            [self creatTupianView];
//            
//            [self creatNeedJiage];
//            [self creatwpjFourTwoView];
//            
//            [self creaTrackIng];
//            _scrollerView.contentSize = CGSizeMake(ScreenWidth,_scrollerContenHeight+0.05*ScreenHeight+0.3*ScreenWidth);
//
        }
        
   
        [refreshControl endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"%@<<<<<<<<<<<<",cuowuxingxi);
        [refreshControl endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }];
    
}

#pragma mark -- 创建所有试图
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
    // [self refreshClick1:refreshControl];
    
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

//第四个界面
-(void)creatzfdjfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*1.05)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*1.05+width*0.04;
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
    NSInteger a = [_detailsDict[@"xcxq"][@"zhifu_time"] integerValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"1296035591  = %@",confromTimespStr);
    NSString *hours = [self dateTimeDifferenceWithStartTime:starString endTime:confromTimespStr];
    NSInteger hou = [hours integerValue];
    [self setTimestamp:hou];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.9/2-width*0.6/2, width*0.3 +width*0.1,width*0.6, width*0.1)];
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    _timeLabel.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    _timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor redColor];
    [fourView addSubview:_timeLabel];
    
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.5+width*0.05, width*0.6, width*0.08)];
    duan.textColor = [UIColor redColor];
    duan.text = @"请在7天内支付定金";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:duan];
    
    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-0.05*width, width*0.63+width*0.02, width*0.8, width*0.08)];
    chang.textColor = [UIColor redColor];
    chang.text = @"逾期未支付系统将自动取消订单";
    chang.textAlignment = NSTextAlignmentCenter;
    chang.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [fourView addSubview:chang];
    
    //
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(width/2-width*0.3-0.05*width, width*0.78, width*0.6, width*0.1);
    button2.tag = 109;
    [button2 setTitle:@"支付定金" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonZfdjClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.tintColor = [UIColor whiteColor];
    button2.backgroundColor = Color(7, 187, 177);
    [fourView addSubview:button2];
    
    UIButton *cuo = [UIButton buttonWithType:UIButtonTypeCustom];
    cuo.frame = CGRectMake(0, width*0.965, width*0.035, width*0.035);
    [cuo setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
    [cuo addTarget:self action:@selector(cuo:) forControlEvents:UIControlEventTouchUpInside];
    [fourView addSubview:cuo];
}


#pragma mark -- 修改联系人

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
    
    nafield =  [[UITextField alloc] initWithFrame:CGRectMake(10,0, ScreenWidth*0.48-10, ScreenWidth*0.1)];
    nafield.tintColor = color;
    nafield.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    [fieldLabel1 addSubview:nafield];
    
    
    
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
    
    
    tefield = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth*0.48-10, ScreenWidth*0.1)];
    tefield.keyboardType = UIKeyboardTypeNumberPad;
    tefield.tintColor = color;
    tefield.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    [fieldLabel addSubview:tefield];
    
    
    
    
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
    
    if (tefield.text.length !=11) {
        
        [self xianzaishoujihao];
    }else {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",_postIdString,@"id",tefield.text,@"tel",nafield.text,@"username",nil];
        
        
        [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=edit_indent"success:^(NSDictionary *fanhuicanshu) {
            
            [_zhifuTimer invalidate];
            _zhifuTimer = nil;
            [_shuaxinTImer invalidate];
            _shuaxinTImer = nil;
            [_wksTime invalidate];
            _wksTime = nil;
            [_scrollerView removeFromSuperview];
            // 此处添加刷新tableView数据的代码
            [self initIdWenHaoData];
            [self initArrayData];            NSLog(@"%@",fanhuicanshu);
        } Error:^(NSString *cuowuxingxi) {
            NSLog(@"%@,",cuowuxingxi);
        }];
        
        [_lianxiView removeFromSuperview];
    }
    
}



#pragma mark -- 修改地址的地图反编译

-(void)postAddressString:(NSString *)addressString AndNameString:(NSString *)nameString {
    _addString = nameString;
    NSLog(@"%@sssssssssssss",addressString);
    [self xiugaiDizhi:addressString AndaddText:nameString];
    
}

-(void)xiugaiDizhi:(NSString *)address AndaddText:(NSString *)name {
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //判断是否为空
    if (address.length ==0) {
        return;
    }
    [geocoder geocodeAddressString:[NSString stringWithFormat:@"%@%@",address,name] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
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
        
        NSString *ksffw = @"";
        if ([ _detailsDict[@"xcxq"][@"ksffw"] isEqualToString:@""]) {
            ksffw = @"15000";
        }else {
            ksffw = _detailsDict[@"xcxq"][@"ksffw"];
        }
        NSInteger ks = [ksffw integerValue];
        
        if (distance > ks) {
            NSLog(@"111123123213123213123");
            [self blackView];
        }else {
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",_postIdString,@"id",[NSString stringWithFormat:@"%@%@",address,name],@"jihe",nil];
            
            [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=edit_indent"success:^(NSDictionary *fanhuicanshu) {
                NSLog(@"%@",fanhuicanshu);
                //                [_countDown.timer invalidate];
                //                _countDown.timer = nil;
                
                [_zhifuTimer invalidate];
                _zhifuTimer = nil;
                [_shuaxinTImer invalidate];
                _shuaxinTImer = nil;
                [_wksTime invalidate];
                _wksTime = nil;
                [_scrollerView removeFromSuperview];
                // 此处添加刷新tableView数据的代码
                [self initIdWenHaoData];
                [self initArrayData];
            } Error:^(NSString *cuowuxingxi) {
                NSLog(@"%@,",cuowuxingxi);
            }];
        }
        
        
        
        //  [self initDatas:centerCoordinate];
    }];
}


#pragma mark -- 修改日期

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
                
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",_postIdString,@"id", datestr,@"shijian",nil];
                
                [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=edit_indent"success:^(NSDictionary *fanhuicanshu) {
                    //                    [_countDown.timer invalidate];
                    //                    _countDown.timer = nil;
                    
                    [_zhifuTimer invalidate];
                    _zhifuTimer = nil;
                    [_shuaxinTImer invalidate];
                    _shuaxinTImer = nil;
                    [_wksTime invalidate];
                    _wksTime = nil;
                    [_scrollerView removeFromSuperview];
                    // 此处添加刷新tableView数据的代码
                    [self initIdWenHaoData];
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
            jihe.postIdString = _postIdString;
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
            [self wenhao8];
            NSLog(@"8");
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

#pragma mark -- 订单未开始的时候地图定位的弹出框

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



#pragma mark -- 初始化地理位置反编译
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


#pragma mark --高德地图的代理方法
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

#pragma mark -- 拿到外界传来的时间戳开启定时器

- (void)setTimestamp:(NSInteger)timestamp{
    _timestamp = timestamp;
    if (_timestamp != 0) {
        _zhifuTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    }
}

-(void)timer:(NSTimer*)timerr{
    _timestamp--;
    [self getDetailTimeWithTimestamp:_timestamp];
    if (_timestamp == 0) {
        [_zhifuTimer invalidate];
        _zhifuTimer = nil;
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
    
    
    
    _timeLabel.text = [NSString stringWithFormat:@"%@ : %@ : %@ : %@",q,a,b,c];
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

#pragma mark --点击支付定金的点击事件

-(void)buttonZfdjClick:(UIButton *)Zfbutton {
    
    NSDictionary *dict11 = @{@"userid":[ZCUserData share].userId,@"id":_postIdString,@"zhifu_fenduan":@"1"};
    //    NSDictionary *dict11 = [NSMutableDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",_postIdString,@"id",@"1",@"zhifu_fendduan",nil];
    //
    [[NSUserDefaults standardUserDefaults] setObject:dict11 forKey:@"zhifu"];
    
    //  NSMutableDictionary *d = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhifu"];
    
    NSInteger dingjin  = [_detailsDict[@"xcxq"][@"dingjin"] integerValue];
    
    NSLog(@"点击了支付定金");
    PayView *view = [PayView new];
    view.jiage = [NSString stringWithFormat:@"%ld",dingjin];
    
    view.hidesBottomBarWhenPushed = YES;
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:view animated:NO];
    
    //    [_zhifuTimer invalidate];
    //    _zhifuTimer = nil;
    //
    
}

#pragma mark -- 取消订单的点击事件

-(void)QdqxButton:(UIButton *)xButton {
    
    UIView *bigview = (UIView *)[self.view.window viewWithTag:718];
    [bigview removeFromSuperview];
    NSString *str = [NSString stringWithFormat:@"%@",_detailsDict[@"state"][@"id"]];
    int s = [str intValue];
    NSLog(@"点击了确定按钮");
    // NSString *userId =  [ZCUserData share].userId ;
    
    NSNumber * Membership_Id =  [NSNumber numberWithInt:s];
    
    NSDictionary *dict = @{@"userid":[ZCUserData share].userId,@"id":Membership_Id};
    
    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_delorder" success:^(NSDictionary *fanhuicanshu) {
        [_zhifuTimer invalidate];
        _zhifuTimer = nil;
        [self.navigationController popViewControllerAnimated:YES];
    } Error:^(NSString *cuowuxingxi) {
        
    }
     ];
}

#pragma mark -- tableVIew的所有代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return _dataArray.count;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
        return 1;
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_tableView == tableView ||_tanchuTableView == tableView){
        return 0.13*ScreenHeight+2;
    }
   
    //comment
    return  0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
      static NSString *strc = @"stack";
    
      NSString *status = _detailsDict[@"xcxq"][@"status"];
    
    if (_tableView == tableView) {
        
      
      
        if ([status isEqualToString:@"1"] || [status isEqualToString:@"4"] || [status isEqualToString:@"5"] || [status isEqualToString:@"6"] || [status isEqualToString:@"7"] || [status isEqualToString:@"8"] || [status isEqualToString:@"9"]){
            
            DetailsCarXclTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
            if (!cell) {
                
                //  cell = [[DetailsCarXclTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
                cell = [[DetailsCarXclTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell.dict = _detailsDict;
            cell.plane_name = _dataArray[indexPath.row];
            
            NSLog(@"1111111111111111111111111111%@",_detailsDict);
            return cell;
            
            
        }
        if ([status isEqualToString:@"2"] || [status isEqualToString:@"3"]) {
            
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
    }
    
    
    
    if (_tanchuTableView == tableView){
        

        TousuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
        if (!cell) {
            
            //  cell = [[DetailsCarXclTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
            cell = [[TousuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.dict = _detailsDict;
        
        cell.delgete = self;
        //
        cell.plane_name = _dataArray[indexPath.row];
        
        NSLog(@"1111111111111111111111111111%@",_detailsDict);
        return cell;
      
    }
    
    
//    if (_tanchuTableView1 == tableView){
//        
//    
//        TousuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
//        if (!cell) {
//            
//            //  cell = [[DetailsCarXclTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
//            cell = [[TousuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        cell.dict = _detailsDict;
//        
//        cell.delgete = self;
//        //
//        cell.plane_name = _dataArray[indexPath.row];
//        
//        NSLog(@"1111111111111111111111111111%@",_detailsDict);
//        return cell;
//        
//    }
//
//    if (_wpjtableView == tableView){
//        
//        if ([status isEqualToString:@"10"]) {
//        
//        NoPjDjmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
//        if (!cell) {
//            
//            //  cell = [[DetailsCarXclTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
//            cell = [[NoPjDjmTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strc];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//        }
//        
//        cell.dict = _dataArray[indexPath.row];
//        //cell.plantName = _dataArray[indexPath.row];
//        return cell;
//    }
//    }
    return nil;
}



#pragma mark -- 未开始投诉的弹出框和删除

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


#pragma mark -- 点击错号的弹出框和取消

- (void)cuo:(UIButton *)sender{
    
    //    NSLog(@"cuowu cuowu");
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消订单将扣除您支付的全额定金 取消之后将无法在行程中查看订单 取消之后将无法恢复订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //    [alert show];
    
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 718;
    [self.view.window addSubview:bigView];
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenHeight-ScreenWidth*0.9-ScreenWidth*0.15-64, ScreenWidth*0.9, ScreenWidth*0.9)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.alpha = 1.0;
    
    alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [bigView addSubview:alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(alertView.frame), CGRectGetHeight(alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.2, ScreenWidth*0.1)];
    label.text = @"取消";
    label.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"Arial" size:30];
    [image addSubview:label];
    
    
    UIButton  *dHx = [UIButton buttonWithType:UIButtonTypeCustom];
    dHx.frame = CGRectMake(ScreenWidth*0.75,0, ScreenWidth*0.15, ScreenWidth*0.15);
    [dHx addTarget:self action:@selector(wozaixiangxiang:) forControlEvents:UIControlEventTouchUpInside];
    [dHx setBackgroundImage:[[UIImage imageNamed:@"错灰(2).png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [image addSubview:dHx];
    
    UIButton  *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xButton.frame = CGRectMake(ScreenWidth*0.75, ScreenWidth*0.05, ScreenWidth*0.1, ScreenWidth*0.1);
    [xButton setBackgroundImage:[[UIImage imageNamed:@"错灰(1).png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(xHaoButton:) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:xButton];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(label.frame)+ScreenWidth*0.1, ScreenWidth*0.15, 1)];
    lineLabel.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [image addSubview:lineLabel];
    
    NSArray *array = @[@"取消订单将扣除您支付的全额定金",@"取消后将无法在行程中查看订单",@"取消后将无法恢复订单"];
    
    for (int i = 0 ; i< 3 ; i++ ) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05,  CGRectGetMaxY(lineLabel.frame)+ScreenWidth*0.05+ScreenWidth*0.1*i, ScreenWidth*0.7, ScreenWidth*0.1)];
        label.text = array[i];
        label.textColor = [UIColor colorWithRed:255/255.0 green:97/255.0 blue:57/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        [image addSubview:label];
    }
    
    UIButton  *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(ScreenWidth*0.05,ScreenWidth*0.7, ScreenWidth*0.3, ScreenWidth*0.1);
    [queding setTitle:@"我再想想" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(wozaixiangxiang:) forControlEvents:UIControlEventTouchUpInside];
    UIColor *gary = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1];
    //    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queding.backgroundColor = gary;
    [image addSubview:queding];
    
    UIButton  *wZxx = [UIButton buttonWithType:UIButtonTypeCustom];
    wZxx.frame = CGRectMake(ScreenWidth*0.4,ScreenWidth*0.7, ScreenWidth*0.3, ScreenWidth*0.1);
    [wZxx setTitle:@"确定取消" forState:UIControlStateNormal];
    [wZxx addTarget:self action:@selector(QdqxButton:) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    //    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [wZxx setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    wZxx.backgroundColor = color;
    [image addSubview:wZxx];
    
    UIImageView  *imageView = [UIImageView new];
    imageView.frame = CGRectMake(ScreenWidth*0.75, ScreenWidth*0.7, ScreenWidth*0.1, ScreenWidth*0.1);
    imageView.image = [UIImage imageNamed:@"logo浅.png"];
    [image addSubview:imageView];
    
}
-(void)xHaoButton:(UIButton *)xButton {
    
    UIView *bigview = (UIView *)[self.view.window viewWithTag:718];
    [bigview removeFromSuperview];
}

-(void)wozaixiangxiang:(UIButton *)xButton {
    
    UIView *bigview = (UIView *)[self.view.window viewWithTag:718];
    [bigview removeFromSuperview];
}

#pragma mark -- 超出预定范围的弹出框和删除事件

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
#pragma mark -- 尾款的问号弹出框
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

#pragma mark -- 优惠的问号弹出框

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
    
    if([_wenhaoDict[@"yhbz"] isKindOfClass:[NSNull class]]) {
        
        label2.text = @"暂无优惠";
    }else{
        label2.text = _wenhaoDict[@"yhbz"];
    }
    label2.font = [UIFont boldSystemFontOfSize:20];
    label2.textColor = Color(255, 97, 57);
    [view2 addSubview:label2];
    
}

#pragma mark -- 支付方式的问号弹出框

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



#pragma mark -- 总价的问号弹出框

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

#pragma mark -- 手机号位数限制弹出框

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








































#pragma mark --- 等待匹配的第四个UI界面
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





































#pragma mark ---- 匹配中和后边的firstview

//第一个界面
-(void)creatXinFirstView {
    
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
    
    UIView *grayView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dizhi.frame),width*0.9 , 1)];
    grayView11.backgroundColor =  Color(233, 233, 233);
    [fisrView addSubview:grayView11];
    
    [self onClick:@"" AndaddText:[NSString stringWithFormat:@"%@",_dizhi.text]];
}


-(void)creatSuccessPpfourView {
    
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
    bottonLabel.text = @"正在为您匹配车辆";
    bottonLabel.textAlignment = NSTextAlignmentCenter;
    bottonLabel.textColor = [UIColor redColor];
    // bottonLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    //bottonImageView.backgroundColor = [UIColor redColor];
    [fourView addSubview:bottonLabel];
    
    
    UILabel *Label = [UILabel new];
    Label.frame = CGRectMake(0, width*0.72-width*0.01, width*0.9, width*0.1);
    Label.text = @"匹配成功后将直接显示车辆车型";
    //Label.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
    Label.textAlignment = NSTextAlignmentCenter;
    Label.textColor = [UIColor redColor];
    // bottonLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    //bottonImageView.backgroundColor = [UIColor redColor];
    [fourView addSubview:Label];
    
}





































#pragma mark ----未开始界面第四个试图
//第四个界面
-(void)creatwksourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*0.95)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*0.95+width*0.04;
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
    NSString *hours = [self dateTimeDifferenceWithStartTime1:starString endTime:confromTimespStr];
    NSInteger hou = [hours integerValue];
    [self setTimestamp:hou];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.9/2-width*0.6/2, width*0.55 +width*0.1,width*0.6, width*0.1)];
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    _timeLabel.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    _timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor redColor];
    [fourView addSubview:_timeLabel];
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.75, width*0.6, width*0.2)];
    duan.textColor = [UIColor redColor];
    duan.text = @"距离服务开始";
    duan.textAlignment = NSTextAlignmentCenter;
    // duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [fourView addSubview:duan];
}
// 拿到外界传来的时间戳
- (void)setWksTimestamp:(NSInteger)wksTimestamp{
    _wksTimestamp = wksTimestamp;
    if (_wksTimestamp != 0) {
        _wksTime =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(wkstimer:) userInfo:nil repeats:YES];
    }
}

-(void)wkstimer:(NSTimer*)timerr{
    _wksTimestamp--;
    [self getDetailTimeWithTimestamp1:_wksTimestamp];
    if (_wksTimestamp <= 0) {
        [_wksTime invalidate];
        _wksTime = nil;
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






































#pragma mark ----- 集合中的试图界面

-(void)creatJhzAndlastfirstView {
    
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
    
    
    UIButton *dingwei = [UIButton buttonWithType:UIButtonTypeCustom];
    dingwei.frame = CGRectMake(width*0.9-40-width*0.02,width*0.02, 40, 40);
    // [dingwei setTitle:@"修改" forState:UIControlStateNormal];
    dingwei.tag = 104;
    [dingwei setBackgroundImage:[UIImage imageNamed:@"定位.png"] forState:UIControlStateNormal];
    [dingwei addTarget:self action:@selector(updateNeedNew:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mapView addSubview:dingwei];
    
    _dizhi = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), width*0.7, width*0.1)];
    _dizhi.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"address"]];
    _dizhi.textColor = [UIColor grayColor];
    [fisrView addSubview:_dizhi];

    UIView *grayView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dizhi.frame),width*0.9 , 1)];
    grayView11.backgroundColor =  Color(233, 233, 233);
    [fisrView addSubview:grayView11];
    
    [self onClick:@"" AndaddText:[NSString stringWithFormat:@"%@",_dizhi.text]];
}

-(void)updateNeedNew:(UIButton *)button {
    
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
            AllPointsViewController *a =[AllPointsViewController new];
            a.postIdString = _postIdString;
            a.hidesBottomBarWhenPushed = YES;
            a.centerString =  _detailsDict[@"xcxq"][@"address"];
            [self.navigationController pushViewController:a animated:YES];
            break;
        }
        default:
            break;
    }
}

//第三个界面
-(void)creatJheAndLastthirdView {
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
        wenhao.tag = 100+i;
        [wenhao addTarget:self action:@selector(updateNeedNew:) forControlEvents:UIControlEventTouchUpInside];
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

//第四个界面
-(void)creaJhzfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*1.05)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*1.05+width*0.04;
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
    
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(0,width*0.55+width*0.1, width*0.9, width*0.1)];
    duan.textColor = [UIColor redColor];
    duan.text = @"车辆正在集合中...";
    duan.adjustsFontSizeToFitWidth = YES;
    duan.textAlignment = NSTextAlignmentCenter;
    // duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [fourView addSubview:duan];
    
    UILabel *duan1 = [[UILabel alloc] initWithFrame:CGRectMake(0,width*0.65+width*0.1, width*0.9, width*0.1)];
    duan1.textColor = [UIColor redColor];
    duan1.text = @"可点击地图右上方定位按钮查看";
    duan1.adjustsFontSizeToFitWidth = YES;
    duan1.textAlignment = NSTextAlignmentCenter;
    // duan.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [fourView addSubview:duan1];
    
}


































//第四个界面
-(void)creatzfwkfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*1.2)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*1.2+width*0.04;
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
    
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.55+width*0.1, width*0.6, width*0.1)];
    duan.textColor = [UIColor redColor];
    duan.text = @"车辆已全部到达";
    duan.textAlignment = NSTextAlignmentCenter;
    duan.adjustsFontSizeToFitWidth = YES;
    [fourView addSubview:duan];
    
    UILabel *duan1 = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.75, width*0.6, width*0.1)];
    duan1.textColor = [UIColor redColor];
    duan1.text = @"请在半小时内支付尾款";
    duan1.textAlignment = NSTextAlignmentCenter;
    duan1.adjustsFontSizeToFitWidth = YES;
    [fourView addSubview:duan1];
    
    UILabel *duan2 = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-0.05*width,width*0.85, width*0.6, width*0.1)];
    duan2.textColor = [UIColor redColor];
    duan2.text = @"支付尾款后开始服务";
    duan2.textAlignment = NSTextAlignmentCenter;
    duan2.adjustsFontSizeToFitWidth = YES;
    [fourView addSubview:duan2];
    
    
    //
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(width/2-width*0.3-0.05*width, width*1.0, width*0.6, width*0.1);
    button2.tag = 109;
    [button2 setTitle:@"支付尾款" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonZFWK:) forControlEvents:UIControlEventTouchUpInside];
    button2.tintColor = [UIColor whiteColor];
    button2.backgroundColor = Color(7, 187, 177);
    [fourView addSubview:button2];
}
-(void)buttonZFWK:(UIButton *)zfwk {
    NSLog(@"zhifuweikuan");
    //
    NSDictionary *dict11 = @{@"userid":[ZCUserData share].userId,@"id":_postIdString,@"zhifu_fenduan":@"2"};
    [[NSUserDefaults standardUserDefaults] setObject:dict11 forKey:@"zhifu"];
    
    NSLog(@"点击了支付定金");
    PayView *view = [PayView new];
    view.jiage = _detailsDict[@"xcxq"][@"yue"];
    
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:view animated:NO];
    
}








































#pragma mark ----  等待服务第四个界面

-(void)creatdengdaifuwufourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*1.2)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*1.2+width*0.04;
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
    bottonImageView.frame = CGRectMake(0.9*width/2-width*0.25, width*0.3+width*0.1, width*0.5, width*0.5);
    bottonImageView.alpha = 0.6;
    //bottonImageView.backgroundColor = [UIColor redColor];
    
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    //将字符串转换成NSData
    NSString  *url =[NSString stringWithFormat:@"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks&&id=%@",_postIdString];
    
    NSData *data=[url dataUsingEncoding:NSUTF8StringEncoding];
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //获得滤镜输出的图像
    CIImage *outputImage=[filter outputImage];
    bottonImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    [fourView addSubview:bottonImageView];
    
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,width*0.9+0.07*width, 0.9*width, width*0.1)];
    bottomLabel.text = @"司机扫描此二维码后结束计费";
    bottomLabel.textColor = [UIColor redColor];
    bottomLabel.adjustsFontSizeToFitWidth = YES;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
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








































#pragma mark ---- 服务中界面

//第一个界面
-(void)creatfwzfirstView {
    
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
    [dingwei addTarget:self action:@selector(updateNeedFwz:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self onClick:@"" AndaddText:[NSString stringWithFormat:@"%@",_dizhi.text]];
}

//第三个界面
-(void)creatfwzthirdView {
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
        wenhao.tag = 100+i;
        [wenhao addTarget:self action:@selector(updateNeedFwz:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)creatfwzfourView {
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width, width*1.2)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*1.2+width*0.04;
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
    bottonImageView.frame = CGRectMake(0.9*width/2-width*0.25, width*0.3+width*0.1, width*0.5, width*0.5);
    bottonImageView.alpha = 0.6;
    //bottonImageView.backgroundColor = [UIColor redColor];
    
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    //将字符串转换成NSData
    NSString  *url =[NSString stringWithFormat:@"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks&&id=%@",_postIdString];
    
    NSData *data=[url dataUsingEncoding:NSUTF8StringEncoding];
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //获得滤镜输出的图像
    CIImage *outputImage=[filter outputImage];
    bottonImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    [fourView addSubview:bottonImageView];
    
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,width*0.9+0.07*width, 0.9*width, width*0.1)];
    bottomLabel.text = @"司机扫描此二维码后结束计费";
    bottomLabel.textColor = [UIColor redColor];
    bottomLabel.adjustsFontSizeToFitWidth = YES;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [fourView addSubview:bottomLabel];
    
}


-(void)updateNeedFwz:(UIButton *)button {
    
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
            FwzMapAnniviewViewController *a =[FwzMapAnniviewViewController new];
            a.postIdString = _postIdString;
            a.hidesBottomBarWhenPushed = YES;
            a.centerString =  _detailsDict[@"xcxq"][@"address"];
            [self.navigationController pushViewController:a animated:YES];
            break;
        }
        default:
            break;
    }
}










































#pragma mark --  支付超时费用界面

-(void)creatzfchaoshifirstView {
    
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
    [dingwei addTarget:self action:@selector(updateNeedzfcs:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mapView addSubview:dingwei];
    
    _dizhi = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), width*0.7, width*0.1)];
    _dizhi.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"address"]];
    _dizhi.textColor = [UIColor grayColor];
    [fisrView addSubview:_dizhi];
    
    
    UIView *grayView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dizhi.frame),width*0.9 , 1)];
    grayView11.backgroundColor =  Color(233, 233, 233);
    [fisrView addSubview:grayView11];
    
    [self onClick:@"" AndaddText:[NSString stringWithFormat:@"%@",_dizhi.text]];
}

-(void)updateNeedzfcs:(UIButton *)button {
    
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
            NSLog(@"");
            [self wenhao10];
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


-(void)creatGUANBI {
    UIButton *touSu = [UIButton buttonWithType:UIButtonTypeCustom];
    touSu.frame = CGRectMake(0, 0, 25, 25);
    touSu.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    [touSu setTitle:@"投诉" forState:UIControlStateNormal];
    [touSu setTitleColor:[UIColor colorWithRed:223/255.0 green:62/255.0 blue:101/255.0 alpha:1] forState:UIControlStateNormal];
    touSu.layer.borderColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:101/255.0 alpha:1].CGColor;
    touSu.layer.borderWidth = 1;
    touSu.layer.cornerRadius = 12.5;
    [touSu addTarget:self action:@selector(guanbiditudingwei) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:touSu];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
}
//关闭地图定位
- (void)guanbiditudingwei{
    
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
    [queding addTarget:self action:@selector(guanbiditu) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
-(void)guanbiditu {
    UIView *view617 = (UIView *)[self.view.window viewWithTag:617];
    [view617 removeFromSuperview];
}


//第三个界面
-(void)creatzfchaoshithirdView {
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
        wenhao.tag = 100+i;
        [wenhao addTarget:self action:@selector(updateNeedzfcs:) forControlEvents:UIControlEventTouchUpInside];
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



-(void)creatzfcsFourTwoView {
    
    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width,width*1.125+ScreenHeight*0.2)];
    //fourView.backgroundColor = [UIColor purpleColor];
    _scrollerContenHeight+= width*1.125+ScreenHeight*0.2+width*0.04;
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
    
    NSString *hours = [self dateTimeDifferenceWithStartTime2:confromTimespStr endTime:confromTimespStr1];
    NSInteger hou = [hours integerValue];
    [self getDetailTimeWithTimestamp2:hou];

    
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
            [wenhao addTarget:self action:@selector(updateNeedzfcs:) forControlEvents:UIControlEventTouchUpInside];
            [wenhao setBackgroundImage:[UIImage imageNamed:@"问红.png"] forState:UIControlStateNormal];
            [thirdView addSubview:wenhao];
        }else {
            UIButton *wenhao = [UIButton buttonWithType:UIButtonTypeCustom];
            wenhao.frame = CGRectMake(width*0.17, 0.1*ScreenHeight*i+(ScreenHeight*0.1 - width*0.077)/2, width*0.077, width*0.077);
            wenhao.tag = 100+i+5;
            [wenhao addTarget:self action:@selector(updateNeedzfcs:) forControlEvents:UIControlEventTouchUpInside];
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
    [jieshu setTitle:@"支付超时费用" forState:UIControlStateNormal];
    [jieshu setTintColor:[UIColor whiteColor]];
    [jieshu addTarget:self action:@selector(chaoshi:) forControlEvents:UIControlEventTouchUpInside];
    [fourView addSubview:jieshu];
}

- (void)getDetailTimeWithTimestamp2:(NSInteger)timestamp{
    
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
- (NSString *)dateTimeDifferenceWithStartTime2:(NSString *)startTime endTime:(NSString *)endTime{
    
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

-(void)chaoshi:(UIButton *)Button {
    NSLog(@"chaoshi");
    NSDictionary *dict11 = @{@"userid":[ZCUserData share].userId,@"id":_postIdString,@"zhifu_fenduan":@"3"};
    [[NSUserDefaults standardUserDefaults] setObject:dict11 forKey:@"zhifu"];
    
    NSInteger jiage  = [_detailsDict[@"xcxq"][@"chaoshijiage"] integerValue];
    NSInteger yufukuan  = [_detailsDict[@"xcxq"][@"chaogonglijiage"] integerValue];
    
    NSLog(@"点击了支付定金");
    PayView *view = [PayView new];
    
    NSInteger chaoshichaogongli = jiage+yufukuan;
    
    view.jiage = [NSString stringWithFormat:@"%ld",chaoshichaogongli];
    
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:view animated:NO];
    
    
}































//
//
//
//
//
//
//
//
//
//
//
//
//
//
//-(void)creaTrackIng {
//    
//    NSLog(@"%@",_detailsDict);
//    
//    NSArray *newArray = _detailsDict[@"xcxq"][@"carlist"];
//    NSDictionary *dict = newArray.firstObject;
//    
//    NSString *userid = dict[@"userid"];
//    NSString *carid = dict[@"carid"];
//    NSString *idneed =_postIdString;
//    
//    [HttpManager postData:@{@"userid":userid,@"id":idneed,@"carid":carid} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=maps_list" success:^(NSDictionary *fanhuicanshu) {
//        
//        
//        [_arrayTrank removeAllObjects];
//        [_arrayTrank addObjectsFromArray:fanhuicanshu[@"list"]];
//        
//        if (_arrayTrank.count >= 2) {
//            
//            CLLocationCoordinate2D commonPolyLineCoords[2];
//            
//            for (int i = 0; i< _arrayTrank.count-1; i++) {
//                
//                for (int j = i+1; j<i+2; j++) {
//                    
//                    commonPolyLineCoords[0].longitude = [_arrayTrank[i][@"longitude"] doubleValue];
//                    commonPolyLineCoords[0].latitude = [_arrayTrank[i][@"latitude"] doubleValue];
//                    
//                    commonPolyLineCoords[1].longitude = [_arrayTrank[j][@"longitude"] doubleValue];
//                    commonPolyLineCoords[1].latitude = [_arrayTrank[j][@"latitude"] doubleValue];
//                    
//                    MAPolyline *commonPoly = [MAPolyline polylineWithCoordinates:commonPolyLineCoords count:2];
//                    [self.mapView addOverlay:commonPoly];
//                    
//                }
//            }
//            
//            
//        }
//        
//        
//    } Error:^(NSString *cuowuxingxi) {
//        
//    }];
//}
//
//
////第一个界面
//-(void)creatwpjfirstView {
//    
//    [self creatScrollerView];
//    
//    UIView *fisrView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, 0.9*width, 1.145*width)];
//    // fisrView.backgroundColor = [UIColor yellowColor];
//    _scrollerContenHeight += 1.145*width;
//    [_scrollerView addSubview:fisrView];
//    
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.9*width, 1)];
//    topView.backgroundColor = Color(233, 233, 233);
//    [fisrView addSubview:topView];
//    UILabel *label02 = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.04, width*0.15, width*0.1)];
//    label02.text = @"日期";
//    label02.textColor = Color(87, 87, 87);
//    // label02.backgroundColor = [UIColor redColor];
//    label02.adjustsFontSizeToFitWidth = YES;
//    label02.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//    [fisrView addSubview:label02];
//    
//    //    UIButton *riqi = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    riqi.frame = CGRectMake(width*0.135, width*0.065,  width*0.1, width*0.05);
//    //    [riqi setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
//    //    riqi.tag = 100;
//    //    [riqi addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
//    //    [fisrView addSubview:riqi];
//    
//    UILabel *zhou = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), width*0.035, fisrView.frame.size.width*0.5-0.05*width, width*0.08)];
//    zhou.text = [NSString stringWithFormat:@"%@,%@",_detailsDict[@"xcxq"][@"zhou"],_detailsDict[@"xcxq"][@"yueri"]];
//    zhou.textColor = Color(140, 140, 140);
//    zhou.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
//    zhou.textAlignment = NSTextAlignmentRight;
//    [fisrView addSubview:zhou];
//    
//    UILabel *lainxi = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), CGRectGetMaxY(zhou.frame), fisrView.frame.size.width*0.5-0.05*width, width*0.05)];
//    lainxi.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"shijian"]];
//    lainxi.textColor = Color(170, 170, 170);
//    lainxi.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    lainxi.textAlignment = NSTextAlignmentRight;
//    
//    [fisrView addSubview:lainxi];
//    
//    
//    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.2*width, 0.9*width, 1)];
//    //    [grayView setBackgroundColor:[UIColor colorWithDisplayP3Red:242 green:242 blue:242 alpha:1]];
//    grayView.backgroundColor = Color(233, 233, 233);
//    [fisrView addSubview:grayView];
//    
//    UILabel *label22 = [[UILabel alloc] initWithFrame:CGRectMake(0,width*0.24,width*0.15, width*0.1)];
//    label22.text = @"联系";
//    // label22.backgroundColor = [UIColor blueColor];
//    label22.textColor = Color(87, 87, 87);
//    label22.adjustsFontSizeToFitWidth = YES;
//    label22.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//    label22.textAlignment = NSTextAlignmentLeft;
//    [fisrView addSubview:label22];
//    
//    //    UIButton *lianxi = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    lianxi.frame = CGRectMake(width*0.135, width*0.265,  width*0.1, width*0.05);
//    //    [lianxi setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
//    //    lianxi.tag = 101;
//    //    [lianxi addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
//    //    [fisrView addSubview:lianxi];
//    
//    UILabel *zhou11 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), width*0.235, fisrView.frame.size.width*0.5-0.05*width, width*0.08)];
//    zhou11.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"tel"]];
//    zhou11.textColor = Color(140, 140, 140);
//    zhou11.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
//    zhou11.textAlignment = NSTextAlignmentRight;
//    [fisrView addSubview:zhou11];
//    
//    UILabel *shi11 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), CGRectGetMaxY(zhou11.frame), fisrView.frame.size.width*0.5-0.05*width, width*0.05)];
//    //    shi11.text = @"徐吊样";
//    shi11.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"username"]];
//    shi11.textColor = Color(170, 170, 170);
//    shi11.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    //    shi11.textColor = [UIColor grayColor];
//    shi11.textAlignment = NSTextAlignmentRight;
//    [fisrView addSubview:shi11];
//    
//    UIView *grayView1 = [[UIView alloc] initWithFrame:CGRectMake(0,0.4*width, 0.9*width, 1)];
//    grayView1.backgroundColor =  Color(233, 233, 233);
//    [fisrView addSubview:grayView1];
//    
//    UILabel *label42 = [[UILabel alloc] initWithFrame:CGRectMake(0,width*0.44,width*0.15, width*0.1)];
//    label42.text = @"范围";
//    label42.adjustsFontSizeToFitWidth = YES;
//    // label42.backgroundColor = [UIColor blueColor];
//    label42.textColor = Color(87, 87, 87);
//    label42.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//    label42.textAlignment = NSTextAlignmentLeft;
//    [fisrView addSubview:label42];
//    
//    //    UIButton *fanwei = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    fanwei.frame = CGRectMake(width*0.135, width*0.465,  width*0.1, width*0.05);
//    //    [fanwei setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
//    //    fanwei.tag = 102;
//    //    [fanwei addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
//    //    [fisrView addSubview:fanwei];
//    
//    
//    UILabel *chaoshi = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), width*0.435, fisrView.frame.size.width*0.5-0.05*width, width*0.065)];
//    
//    chaoshi.text = [NSString stringWithFormat:@"%@小时",_detailsDict[@"xcxq"][@"zhuche_chaoshi"]];
//    chaoshi.textColor = Color(140, 140, 140);
//    chaoshi.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    chaoshi.textAlignment = NSTextAlignmentRight;
//    [fisrView addSubview:chaoshi];
//    
//    UILabel *chaogongli = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(fisrView.frame), CGRectGetMaxY(chaoshi.frame), fisrView.frame.size.width*0.5-0.05*width, width*0.065)];
//    chaogongli.text = [NSString stringWithFormat:@"%@公里",_detailsDict[@"xcxq"][@"zhuche_chaogongli"]];
//    chaogongli.textColor = Color(140, 140, 140);
//    chaogongli.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    chaogongli.textAlignment = NSTextAlignmentRight;
//    [fisrView addSubview:chaogongli];
//    
//    
//    UIView *grayView6 = [[UIView alloc] initWithFrame:CGRectMake(0,0.6*width, 0.9*width, 1)];
//    grayView6.backgroundColor =  Color(233, 233, 233);
//    [fisrView addSubview:grayView6];
//    
//    
//    UIView *image = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(grayView6.frame)+width*0.02, width*0.9, width*0.4)];
//    [fisrView addSubview:image];
//    //初始化地图
//    self.mapView = [[MAMapView alloc] initWithFrame:image.frame];
//    self.mapView.delegate = self;
//    self.mapView.compassOrigin = CGPointMake(self.mapView.compassOrigin.x, 22);
//    self.mapView.scaleOrigin = CGPointMake(self.mapView.scaleOrigin.x, 22);
//    self.mapView.showsCompass = NO;
//    self.mapView.zoomLevel = 15;
//    self.mapView.scrollEnabled = NO;
//    //    self.mapView.isScrollEnabled = NO;
//    //添加到view上
//    [fisrView addSubview:self.mapView];
//    
//    [self.locationManager startUpdatingLocation];
//    
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;
//    _mapView.showsUserLocation = YES;
//    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
//    _mapView.userInteractionEnabled = YES;
//    UIImageView *middleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(width*0.9/2-9,width*0.2-30, 17.5, 30)];
//    middleImageView.image = [UIImage  imageNamed:@"停车地点.png"];
//    [self.mapView addSubview:middleImageView];
//    
//    
//    
//    UIButton *dingwei = [UIButton buttonWithType:UIButtonTypeCustom];
//    dingwei.frame = CGRectMake(width*0.9-40-width*0.02,width*0.02, 40, 40);
//    // [dingwei setTitle:@"修改" forState:UIControlStateNormal];
//    dingwei.tag = 104;
//    [dingwei setBackgroundImage:[UIImage imageNamed:@"定位.png"] forState:UIControlStateNormal];
//    [dingwei addTarget:self action:@selector(updateNeedWpj:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.mapView addSubview:dingwei];
//    
//    _dizhi = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), width*0.7, width*0.1)];
//    _dizhi.text = [NSString stringWithFormat:@"%@",_detailsDict[@"xcxq"][@"address"]];
//    _dizhi.textColor = [UIColor grayColor];
//    [fisrView addSubview:_dizhi];
//    
//    
//    //    UIButton *dizhi = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    dizhi.frame = CGRectMake(width*0.8, CGRectGetMaxY(image.frame)+width*0.025,  width*0.1, width*0.05);
//    //    //    [dizhi setTitle:@"修改" forState:UIControlStateNormal];
//    //    dizhi.tag = 103;
//    //    [dizhi setImage:[[UIImage imageNamed:@"修改(7).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
//    //    [dizhi addTarget:self action:@selector(updateNeed:) forControlEvents:UIControlEventTouchUpInside];
//    //    [fisrView addSubview:dizhi];
//    
//    
//    
//    UIView *grayView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dizhi.frame),width*0.9 , 1)];
//    grayView11.backgroundColor =  Color(233, 233, 233);
//    [fisrView addSubview:grayView11];
//    
//    [self onClick:@"" AndaddText:[NSString stringWithFormat:@"%@",_dizhi.text]];
//}
//
//-(void)updateNeedWpj:(UIButton *)button {
//    
//    NSInteger btnTag = button.tag - 100;
//    switch (btnTag) {
//        case 0:{
//            NSLog(@"0");
//            [self wenhao5];
//            break;
//        }
//        case 1:{
//            NSLog(@"1");
//            [self wenhao6];
//            break;
//        }
//        case 2:{
//            NSLog(@"2");
//            [self wenhao7];
//            break;
//        }
//        case 3:{
//            NSLog(@"3");
//            [self wenhao8];
//            break;
//        }
//        case 4:{
//            NSLog(@"4");
//            [self guanbiditudingwei];
//            //            AllPointsViewController *a =[AllPointsViewController new];
//            //            a.postIdString = _postIdString;
//            //            a.hidesBottomBarWhenPushed = YES;
//            //            a.centerString =  _detailsDict[@"xcxq"][@"address"];
//            //            [self.navigationController pushViewController:a animated:YES];
//            break;
//            
//            break;
//        }
//        case 5:{
//            NSLog(@"5");
//            [self wenhao9];
//            break;
//        }
//        case 6:{
//            NSLog(@"6");
//            [self wenhao10];
//            break;
//        }case 7:{
//            NSLog(@"7");
//            break;
//        }
//        default:
//            break;
//    }
//}
//
//
//
//-(void)creatwpjsecondView {
//    
//    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, _dataArray.count*0.15*ScreenHeight)];
//    // secondView.backgroundColor = [UIColor orangeColor];
//    _scrollerContenHeight+= 0.15*ScreenHeight*_dataArray.count+ 2*_dataArray.count;
//    [_scrollerView addSubview:secondView];
//    
//    _wpjtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(secondView.frame), _dataArray.count*0.15*ScreenHeight+ 2*_dataArray.count) style:UITableViewStylePlain];
//    _wpjtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _wpjtableView.dataSource =self;
//    _wpjtableView.delegate = self;
//    _wpjtableView.showsHorizontalScrollIndicator = NO;
//    _wpjtableView.showsVerticalScrollIndicator = NO;
//    //_tableView.backgroundColor = [UIColor redColor];
//    [secondView addSubview:_wpjtableView];
//    
//}
//
//// three
//
//-(void)creatTupianView {
//    
//    
//    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.3*ScreenWidth)];
//    //fourView.backgroundColor = [UIColor purpleColor];
//    _scrollerContenHeight+= 0.3*ScreenWidth;
//    fourView.tag = 12345;
//    [_scrollerView addSubview:fourView];
//    
//    //  fourView.backgroundColor = [UIColor redColor];
//    
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.9*width, width*0.1)];
//    label.text = @"图片";
//    [label setTextColor:[UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1]];
//    label.font = [UIFont fontWithName:@"ArialMT" size:15];
//    label.textAlignment = NSTextAlignmentCenter;
//    [fourView addSubview:label];
//    
//    
//    
//    _view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+width*0.03, ScreenWidth*0.9,ScreenWidth*0.9/4*2/3)];
//    [fourView addSubview:_view];
//    
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
//}
//
//// 4
////第三个界面
//-(void)creatNeedJiage {
//    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight, 0.9*width, 0.4*ScreenHeight)];
//    //thirdView.backgroundColor = [UIColor greenColor];
//    _scrollerContenHeight+= 0.4*ScreenHeight;
//    [_scrollerView addSubview:thirdView];
//    
//    UIView *grayView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 0.9*width, 1)];
//    grayView1.backgroundColor = Color(233, 233, 233);
//    [thirdView addSubview:grayView1];
//    
//    
//    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.4*ScreenHeight-1, 0.9*width, 1)];
//    grayView.backgroundColor = Color(233, 233, 233);
//    [thirdView addSubview:grayView];
//    NSArray *array = @[@"总价",@"定金",@"优惠",@"尾款"];
//    NSInteger jiage  = [_detailsDict[@"xcxq"][@"jiage"] integerValue];
//    NSInteger yufukuan  = [_detailsDict[@"xcxq"][@"dingjin"] integerValue];
//    NSInteger youhui = [_detailsDict[@"xcxq"][@"youhui"] integerValue];
//    NSInteger weikuan  = [_detailsDict[@"xcxq"][@"yue"] integerValue];
//    
//    // NSLog(@"%@",_detailsDict[@"xcxq"][@"jiage"]);
//    NSMutableArray *priceArray = [NSMutableArray new];
//    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",jiage]];
//    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",yufukuan]];
//    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"-¥",youhui]];
//    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",weikuan]];
//    //  NSArray *priceArray = @[@jiage,@yufukuan,@weikuan];
//    
//    for (int i = 0; i<priceArray.count; i++) {
//        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.1*ScreenHeight*i+0.03*ScreenHeight, width*0.15, 0.04*ScreenHeight)];
//        leftLabel.text = array[i];
//        leftLabel.textAlignment = NSTextAlignmentLeft;
//        //
//        leftLabel.textColor = Color(87, 87, 87);
//        leftLabel.adjustsFontSizeToFitWidth = YES;
//        leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//        //    shi11.teleftLabel.font = [UIFont systemFontOfSize:20];
//        [thirdView addSubview:leftLabel];
//        
//        UIButton *wenhao = [UIButton buttonWithType:UIButtonTypeCustom];
//        wenhao.frame = CGRectMake(width*0.135, 0.1*ScreenHeight*i+(ScreenHeight*0.1 - width*0.077)/2, width*0.077, width*0.077);
//        wenhao.tag = 100+i;
//        [wenhao addTarget:self action:@selector(updateNeedWpj:) forControlEvents:UIControlEventTouchUpInside];
//        [wenhao setBackgroundImage:[UIImage imageNamed:@"问红.png"] forState:UIControlStateNormal];
//        [thirdView addSubview:wenhao];
//        
//        
//        if (i==0) {
//            
//        }else {
//            UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.1*i*ScreenHeight, 0.9*width, 1)];
//            //        [grayView setBackgroundColor:[UIColor colorWithDisplayP3Red:242 green:242 blue:242 alpha:1]];
//            grayView.backgroundColor = Color(233, 233, 233);
//            
//            [thirdView addSubview:grayView];
//            
//        }
//        if (i  == 2) {
//            UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*ScreenWidth, 0.1*ScreenHeight*i+0.03*ScreenHeight, 0.2*ScreenWidth, 0.04*ScreenHeight)];
//            rightLabel.text = priceArray[i];
//            rightLabel.textColor = [UIColor redColor];
//            rightLabel.textColor = Color(7, 187, 177);
//            rightLabel.textAlignment = NSTextAlignmentCenter;
//            rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 ];
//            [thirdView addSubview:rightLabel];
//        }else {
//            UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*ScreenWidth, 0.1*ScreenHeight*i+0.03*ScreenHeight, 0.2*ScreenWidth, 0.04*ScreenHeight)];
//            rightLabel.text = priceArray[i];
//            rightLabel.textColor = [UIColor redColor];
//            rightLabel.textColor = Color(255, 97, 57);
//            rightLabel.textAlignment = NSTextAlignmentCenter;
//            rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 ];
//            [thirdView addSubview:rightLabel];
//        }
//        
//        
//    }
//}
//
//
//-(void)creatwpjFourTwoView {
//    
//    UIView *fourView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, _scrollerContenHeight+width*0.04, 0.9*width,width*1.125+ScreenHeight*0.2)];
//    // fourView.backgroundColor = [UIColor purpleColor];
//    _scrollerContenHeight+= width*0.925+ScreenHeight*0.2+width*0.04;
//    [_scrollerView addSubview:fourView];
//    
//    UIView *aplap = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width*0.9, width*0.3)];
//    aplap.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
//    [fourView addSubview:aplap];
//    
//    UILabel *beizhu = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width*0.9, width*0.1)];
//    beizhu.text = @"备注";
//    beizhu.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
//    beizhu.textAlignment = NSTextAlignmentCenter;
//    beizhu.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
//    
//    [aplap addSubview:beizhu];
//    
//    
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(width*0.05, width*0.1, width*0.8, width*0.2)];
//    textView.textColor = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1];
//    if ([_wenhaoDict[@"beizhu"] isEqualToString:@""]) {
//        textView.text = @"暂未备注";
//    }else {
//        textView.text = _wenhaoDict[@"beizhu"];
//    }
//    
//    textView.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
//    textView.editable = NO;
//    textView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
//    [aplap addSubview:textView];
//    
//    
//    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - width*0.38, width*0.3+width*0.1, width*0.35, width*0.35)];
//    //            image1.backgroundColor = [UIColor purpleColor];
//    image1.image = [UIImage imageNamed:@"找车@3x.png"];
//    [fourView addSubview:image1];
//    
//    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2+width*0.03-0.1*width, width*0.3+width*0.1, width*0.35, width*0.35)];
//    //image2.backgroundColor = [UIColor purpleColor];
//    image2.image = [UIImage imageNamed:@"找车@3x.png"];
//    [fourView addSubview:image2];
//    
//    
//    
//    tomelabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.38+width*0.175/2, width*0.4+width*0.175/2, width*0.175, width*0.175)];
//    tomelabel.adjustsFontSizeToFitWidth = YES;
//    tomelabel.textColor = [UIColor redColor];
//    tomelabel.textAlignment = NSTextAlignmentCenter;
//    tomelabel.font = [UIFont systemFontOfSize:18];
//    [fourView addSubview:tomelabel];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
//    NSInteger a = [_detailsDict[@"xcxq"][@"kssj"] integerValue];
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a];
//    NSLog(@"1296035591  = %@",confromTimesp);
//    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
//    NSLog(@"1296035591  = %@",confromTimespStr);
//    
//    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init] ;
//    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
//    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
//    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
//    NSInteger a1 = [_detailsDict[@"xcxq"][@"jssj"] integerValue];
//    NSDate *confromTimesp1 = [NSDate dateWithTimeIntervalSince1970:a1];
//    NSLog(@"1296035591  = %@",confromTimesp1);
//    NSString *confromTimespStr1 = [formatter1 stringFromDate:confromTimesp1];
//    NSLog(@"1296035591  = %@",confromTimespStr1);
//    
//    NSString *hours = [self dateTimeDifferenceWithStartTime2:confromTimespStr endTime:confromTimespStr1];
//    NSInteger hou = [hours integerValue];
//    [self getDetailTimeWithTimestamp2:hou];
//    
//    
//    
//    
//    UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake(width/2+width*0.03+width*0.175/2-0.1*width, width*0.4+width*0.175/2, width*0.175, width*0.175)];
//    NSInteger gonglishu  = [_detailsDict[@"xcxq"][@"gonglishu"] integerValue];
//    timeLable.text = [NSString stringWithFormat:@"%ld",gonglishu];
//    // timeLable .backgroundColor = [UIColor Color(255, 97, 57);greenColor];
//    timeLable.textColor = [UIColor redColor];
//    timeLable.adjustsFontSizeToFitWidth = YES;
//    timeLable.textAlignment = NSTextAlignmentCenter;
//    timeLable.font = [UIFont systemFontOfSize:18];
//    [fourView addSubview:timeLable];
//    
//    UILabel *sJcheng = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.38+width*0.35/2, width*0.4+width*0.35*2/3, width*0.175, width*0.175)];
//    sJcheng.text = @"时间";
//    //licheng .backgroundColor = [UIColor greenColor];
//    sJcheng.textColor = [UIColor redColor];
//    sJcheng.textAlignment = NSTextAlignmentCenter;
//    sJcheng.font = [UIFont systemFontOfSize:14];
//    [fourView addSubview:sJcheng];
//    
//    
//    UILabel *licheng = [[UILabel alloc] initWithFrame:CGRectMake(width/2+width*0.03+width*0.35/2-0.1*width, width*0.4+width*0.35*2/3, width*0.175, width*0.175)];
//    licheng.text = @"里程";
//    //licheng .backgroundColor = [UIColor greenColor];
//    licheng.textColor = [UIColor redColor];
//    licheng.textAlignment = NSTextAlignmentCenter;
//    licheng.font = [UIFont systemFontOfSize:14];
//    [fourView addSubview:licheng];
//    
//    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, width*0.4+width*0.35*2/3+width*0.175+width*0.05, 0.9*ScreenWidth, 1)];
//    views.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
//    [fourView addSubview:views];
//    
//    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(0,width*0.4+width*0.35*2/3+width*0.175+width*0.05, 0.9*width, 0.2*ScreenHeight)];
//    [fourView addSubview:thirdView];
//    
//    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.2*ScreenHeight-1, 0.9*width, 1)];
//    grayView.backgroundColor = Color(233, 233, 233);
//    [thirdView addSubview:grayView];
//    NSArray *array = @[@"超时",@"超公里"];
//    NSInteger jiage  = [_detailsDict[@"xcxq"][@"chaoshijiage"] integerValue];
//    NSInteger yufukuan  = [_detailsDict[@"xcxq"][@"chaogonglijiage"] integerValue];
//    // NSLog(@"%@",_detailsDict[@"xcxq"][@"jiage"]);
//    NSMutableArray *priceArray = [NSMutableArray new];
//    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",jiage]];
//    [priceArray addObject:[NSString stringWithFormat:@"%@ %ld",@"¥",yufukuan]];
//    //  NSArray *priceArray = @[@jiage,@yufukuan,@weikuan];
//    
//    for (int i = 0; i<priceArray.count; i++) {
//        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.1*ScreenHeight*i+0.03*ScreenHeight, width*0.15, 0.04*ScreenHeight)];
//        leftLabel.text = array[i];
//        leftLabel.textAlignment = NSTextAlignmentLeft;
//        //
//        leftLabel.textColor = Color(87, 87, 87);
//        leftLabel.adjustsFontSizeToFitWidth = YES;
//        leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//        //    shi11.teleftLabel.font = [UIFont systemFontOfSize:20];
//        [thirdView addSubview:leftLabel];
//        
//        if (i == 0) {
//            UIButton *wenhao = [UIButton buttonWithType:UIButtonTypeCustom];
//            wenhao.frame = CGRectMake(width*0.135, 0.1*ScreenHeight*i+(ScreenHeight*0.1 - width*0.077)/2, width*0.077, width*0.077);
//            wenhao.tag = 100+i+5;
//            [wenhao addTarget:self action:@selector(updateNeedWpj:) forControlEvents:UIControlEventTouchUpInside];
//            [wenhao setBackgroundImage:[UIImage imageNamed:@"问红.png"] forState:UIControlStateNormal];
//            [thirdView addSubview:wenhao];
//        }else {
//            UIButton *wenhao = [UIButton buttonWithType:UIButtonTypeCustom];
//            wenhao.frame = CGRectMake(width*0.17, 0.1*ScreenHeight*i+(ScreenHeight*0.1 - width*0.077)/2, width*0.077, width*0.077);
//            wenhao.tag = 100+i+5;
//            [wenhao addTarget:self action:@selector(updateNeedWpj:) forControlEvents:UIControlEventTouchUpInside];
//            [wenhao setBackgroundImage:[UIImage imageNamed:@"问红.png"] forState:UIControlStateNormal];
//            [thirdView addSubview:wenhao];
//            
//        }
//        
//        
//        
//        if (i==0) {
//            
//        }else {
//            UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.1*i*ScreenHeight, 0.9*width, 1)];
//            //        [grayView setBackgroundColor:[UIColor colorWithDisplayP3Red:242 green:242 blue:242 alpha:1]];
//            grayView.backgroundColor = Color(233, 233, 233);
//            
//            [thirdView addSubview:grayView];
//            
//        }
//        
//        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*ScreenWidth, 0.1*ScreenHeight*i+0.03*ScreenHeight, 0.2*ScreenWidth, 0.04*ScreenHeight)];
//        rightLabel.text = priceArray[i];
//        rightLabel.textColor = [UIColor redColor];
//        rightLabel.textColor = Color(255, 97, 57);
//        rightLabel.textAlignment = NSTextAlignmentCenter;
//        rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 ];
//        [thirdView addSubview:rightLabel];
//    }
//    
//    UIButton *jieshu = [UIButton buttonWithType:UIButtonTypeCustom];
//    jieshu.frame = CGRectMake(width*0.2-0.05*width,width*0.4+width*0.35*2/3+width*0.175+width*0.05+ScreenHeight*0.2+width*0.08, width*0.6, width*0.12);
//    jieshu.backgroundColor = Color(7, 187, 177);
//    jieshu.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//    [jieshu setTitle:@"提交评价" forState:UIControlStateNormal];
//    [jieshu setTintColor:[UIColor whiteColor]];
//    [jieshu addTarget:self action:@selector(jieshu:) forControlEvents:UIControlEventTouchUpInside];
//    [fourView addSubview:jieshu];
//}
////评价界面保存星星的数组 通知传至
//- (void)changeBgColor:(NSNotification *)notification{
//    
//    [_starStringArray addObject:notification.userInfo[@"starSring"]];
//    
//    
//    NSLog(@"111111111111111111111111%@",_starStringArray);
//    
//    // [_latArray addObjectsFromArray:aaa];
//}
//-(void)jieshu:(UIButton *) button {
//
//    NSMutableArray *array = [NSMutableArray new];
//    for (NSArray *arr in _starStringArray) {
//        NSString *s = [arr componentsJoinedByString:@""];
//        [array addObject:s];
//    }
//    NSMutableString *ss = [NSMutableString new];
//    for (NSString *s in array) {
//        [ss appendString:[NSString stringWithFormat:@"%@;",s]];
//    }
//    NSString * sss = [ss substringWithRange:NSMakeRange(0, ss.length-1)];
//    //   NSString *s = [NSString stringWithFormat:@"%@",@"488|5.0|5.0|5.0|服务很好车子也很新"];
//    NSMutableDictionary *dict = [NSMutableDictionary new];
//    [dict setObject:[ZCUserData share].userId  forKey:@"userid"];
//    [dict setObject:_detailsDict[@"state"][@"id"] forKey:@"orderid"];
//    [dict setObject:sss forKey:@"car_list"];
//    
//    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_tjpj" success:^(NSDictionary *fanhuicanshu) {
//        
//        NSLog(@"1112331231");
//        NSLog(@"%@",dict);
//        
//        
//        [self chunPic];
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    } Error:^(NSString *cuowuxingxi) {
//        
//    }];
//}
//
//-(void)chunPic {
//    
//    // NSDictionary *postdict= @{@"orderid":[ZCUserData share].userId,@"username":[ZCUserData share].username,@"0":image1Base64,@"1":image2Base64,@"2":image3Base64};
//    // 开始上传
//    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:_detailsDict[@"state"][@"id"],@"orderid",nil];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    AFHTTPRequestOperation *operation = [manager POST:@"http://wx.leisurecarlease.com/api.php?op=api_tjpjpic" parameters:postDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
//        
//        UIImage *pic1 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"love"]];
//        NSData *imageData1 = UIImageJPEGRepresentation(pic1, 0.5);
//        // NSString *image1Base64 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        
//        UIImage *pic2 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"love1"]];
//        NSData *imageData2 = UIImageJPEGRepresentation(pic2, 0.5);
//        // NSString *image2Base64 = [imageData2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        UIImage *pic3 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"love2"]];
//        NSData *imageData3 = UIImageJPEGRepresentation(pic3, 0.5);
//        // NSString *image3Base64 = [imageData3 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        
//        if (imageData1 != nil && imageData2 != nil && imageData3 != nil) {
//            
//            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"love.jpg" mimeType:@"image/jpeg/png/jpg"];
//            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"love1.jpg" mimeType:@"image/jpeg/png/jpg"];
//            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"love2.jpg" mimeType:@"image/jpeg/png/jpg"];
//        }else if (imageData1 != nil && imageData2 == nil && imageData3 == nil) {
//            
//            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"love.jpg" mimeType:@"image/jpeg/png/jpg"];
//        }else if (imageData1 == nil && imageData2 != nil && imageData3 == nil) {
//            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"love1.jpg" mimeType:@"image/jpeg/png/jpg"];
//        }else if (imageData1 == nil && imageData2 == nil && imageData3 != nil) {
//            
//            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"love2.jpg" mimeType:@"image/jpeg/png/jpg"];
//        }else if (imageData1 != nil && imageData2 != nil && imageData3 == nil) {
//            
//            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"love.jpg" mimeType:@"image/jpeg/png/jpg"];
//            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"love1.jpg" mimeType:@"image/jpeg/png/jpg"];
//        }else if (imageData1 == nil && imageData2 != nil && imageData3 != nil) {
//            
//            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"love1.jpg" mimeType:@"image/jpeg/png/jpg"];
//            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"love2.jpg" mimeType:@"image/jpeg/png/jpg"];
//        }else if (imageData1 != nil && imageData2 == nil && imageData3 != nil) {
//            
//            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"love.jpg" mimeType:@"image/jpeg/png/jpg"];
//            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"love2.jpg" mimeType:@"image/jpeg/png/jpg"];
//        }
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject){
//        
//        NSLog(@"1");
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"love"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"love1"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"love2"];
//        
//        //[self performSelector:@selector(stopit) withObject:dong afterDelay:2.0];
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        
//        NSLog(@"%@",error);
//        
//    }];
//    [operation start];
//    
//}
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
//                [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"love"];
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
//              
//                _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,width*0.9/4, width*0.9/4*2/3)];
//                _leftImageView.image = _imageDataView[0];
//                //                _leftImageView.frame = CGRectMake(0,0,width*0.8/4, width*0.8/4*2/3);
//                [_view addSubview:_leftImageView];
//                [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"love1"];
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
//                
//                
//                
//                //                _middleImageView.image = _imageDataView[1];
//                //                _leftImageView.image = _imageDataView[0];
//                [_view addSubview:_rightImageView];
//                
//                _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.9/4,0,width*0.9/4, width*0.9/4*2/3)];                //  _leftImageView.image = _imageDataView[0];
//                _middleImageView.image = _imageDataView[1];
//              
//                _leftImageView.image = _imageDataView[0];
//                _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,width*0.9/4, width*0.9/4*2/3)];
//                [_view addSubview:_leftImageView];
//                [_view addSubview:_middleImageView];
//                
//                [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"love2"];
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
