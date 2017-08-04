//
//  HomePageViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/10/21.
//  Copyright (c) 2015年 佐途. All rights reserved.

//首页

#import "HomePageViewController.h"
#import "AllPages.pch"
#import "UINavigationBar+Awesome.h"
#import "FirstPageController.h"
#import "CycleScrollView.h"
#import "TLCityPickerController.h"
#import "DropDownListViewController.h"

#import "MyCollectionViewController.h"
#import "NowLiulanViewController.h"
#import "UIImageView+WebCache.h"


#import "SecondTabbar.h"
#import "MarriedCar.h"
#import "CarInfoView.h"
#import "ShangWuDingdanView.h"
#import "ChangBaoView.h"
#import "ChangzuView.h"
#import "MyAnnomationView.h"
#import "ShangwuController.h"
#import "JieSongViewController.h"
#import "ChaoPaoViewController.h"
#import "ChangbaoViewController.h"
#import "ChangzuViewController.h"
#import "ShouCangViewController.h"

#define NAVBAR_CHANGE_POINT 80
#define DINGWEI [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dingweicity"]]
#define CITY_CT  [[NSUserDefaults standardUserDefaults] valueForKey:@"city.cityName"]

@interface HomePageViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,TLCityPickerDelegate>{
    
    NSString *cityname;
    NSInteger page;
    NSArray *appList;
    
    UITableView *_tableView;
    
    UIView *_alertView;
    UIButton *queding;
    UIButton *quxiao;
    UIView *bigView;
//    UIScrollView *CarTypeSV;
    UIButton *quanju;
    
    UIView * _sliderView;
    
    CGFloat maxisem ;
    CGFloat minisem ;
    
    UIPageControl *page1;
    UIButton *jie;
    UIButton *song;
    
    NSString *plateAddress;
    NSString *getOrsend;
}
//轮播器
@property (nonatomic)          NSInteger Numberpage;
@property (nonatomic,retain) UIPageControl *pagectl;;
@property (nonatomic,retain) NSArray *colorArray;
@property (nonatomic,retain) UIScrollView *scrolview;

@property (nonatomic, strong)UIScrollView *CarTypeSV;
@property (nonatomic, assign)CGFloat imageWidth;
@property (nonatomic, assign)CGFloat imageHeight;
@property (nonatomic, assign)CGFloat typeWidth;
@property (nonatomic, assign)NSInteger lastPageIndex;
@property (nonatomic, strong)MyAnnomationView *lastImageView;
@property (nonatomic, strong)NSArray *imageNameArray;
@property (nonatomic, strong)NSArray *typeArray;
@property (nonatomic, strong)UIView *labelView;
@property (nonatomic, strong)UIView *annimationSuperView;
@property (nonatomic, strong)NSMutableArray<MyAnnomationView*> *imageViewArray;

@end

@implementation HomePageViewController

-(NSArray *)colorArray
{
    if (!_colorArray) {
        self.colorArray=[NSArray array];
    }
    return _colorArray;
}

- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
    //navbar 不透明
    self.tabBarController.tabBar.hidden = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"首页收藏(2).png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton *rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(0, 0, 25, 25);
    [rightbutton setBackgroundImage:[UIImage imageNamed:@"定位4.png"] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(leftBtnClickk:) forControlEvents:UIControlEventTouchUpInside];
//    [self addItemWithCustomView:@[rightbutton] isLeft:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*0.4, ScreenWidth*0.1)];
    
    image.image = [UIImage imageNamed:@"241"];
    self.navigationItem.titleView = image;
    
    _imageNameArray = @[@"MPV",@"行政",@"奢华",@"激情",@"尊贵"];
    _typeArray =  @[@"MPV",@"行政级",@"奢华",@"激情",@"尊贵"];
    self.imageWidth = [UIScreen mainScreen].bounds.size.width;
    self.imageHeight = self.imageWidth*0.7;
    self.typeWidth = self.imageWidth/5.00;
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageViewArray = [NSMutableArray array];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_reset];
    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.tabBarController.tabBar.hidden = NO;
}
- (UIImage *)scaleToSize:(UIImage *)Img size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    [Img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImg;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"5002" forKey:@"nayiduan"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self createTableView];
    
    maxisem = 0;
    minisem = 0;
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = YES;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:_tableView];
}
#pragma Delegate and Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = self.view.frame.size.width;
    return width*0.65;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    UITableViewCell *tabcell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!tabcell) {
        
        tabcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"婚车.png"]];
        tabcell.backgroundView = image;
    }
    if (indexPath.row == 1) {
        
        tabcell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"商务.png"]];
    }
    
    if (indexPath.row == 2) {
        
        tabcell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"接机.png"]];
    }
    if (indexPath.row == 3) {
        
        tabcell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"超跑.png"]];
    }
    if (indexPath.row == 4) {
        
        tabcell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"拍摄.png"]];
    }
    if (indexPath.row == 5) {
        tabcell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"长包.png"]];
    }
    if (indexPath.row == 6) {
        tabcell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"长租.png"]];
    }if (indexPath.row == 7) {
        tabcell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"短租.png"]];
    }
    
    tabcell.selectionStyle = UITableViewCellStyleDefault;
    
    return tabcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        
        MarriedCar *view = [MarriedCar new];
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }
    else if (indexPath.row == 4) {
        
        CarInfoView *view = [[CarInfoView alloc] init];
        // 拍摄
        view.cartype = @"3";
        view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
        
    }else if (indexPath.row == 5){
        
        ChangbaoViewController *view = [[ChangbaoViewController alloc] init];
        // 长包
        view.cartype = @"4";
        view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
        
    }else if (indexPath.row == 6){
        
        ChangzuViewController *view = [[ChangzuViewController alloc] init];
        // 长租
        view.cartype = @"5";
        view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }else if (indexPath.row == 1){
        
        ShangwuController *view = [[ShangwuController alloc] init];
        
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
    else if (indexPath.row == 2){
        
        [self shangwuClick];
    }else if (indexPath.row == 3){
        
        [self ChaoPaoClick];
    }
    else{
        
        [self AlertView];
    }
}
#pragma mark - 暂未开放提示
- (void)AlertView{
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 10089;
    [self.view.window addSubview:bigView];
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenHeight/2 - ScreenWidth*0.15, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [bigView addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame), CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"敬请期待";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
- (void)moveAll{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
}


#pragma mark - 右边车队
//*****************************右边车队****************************************//
-(void)rightBtnClickk:(UIButton *)sender
{
        LoginView *log=[[LoginView alloc]init];
        [self.navigationController pushViewController:log animated:YES];
    
}
//*****************************右边车队结束****************************************//
// 可以保留
//*****************************定位****************************************//
-(void)leftBtnClickk:(UIButton *)sender
{
    
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    [cityPickerVC setDelegate:self];
    if ([DINGWEI isEqualToString:@"null"]||[DINGWEI isKindOfClass:[NSNull class]]||[DINGWEI isEqual:NULL]) {
        cityPickerVC.locationCityName=@"上海";
    }else
    {
        NSLog(@"=1=%@",DINGWEI);
        cityPickerVC.locationCityName =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dingweicity"]] ;
    }
    
    // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[ @"200010000"]];
    cityPickerVC.hotCitys = @[@"100010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:NO completion:^{
        
    }];
    
}
//*****************************定位结束****************************************//
#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    NSLog(@"city.shortName=%@",city.shortName);
    if ([city.shortName isEqualToString:@"上海"]) {
        [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
            self.labell.text=city.shortName;
            [[NSUserDefaults standardUserDefaults] setObject:city.shortName forKey:@"dingweicity"];
            
        }];
    }else
    {
        [XWAlterview showmessage:@"温馨提示" subtitle:@"目前只开放上海地区" cancelbutton:@"确定"];
    }
    
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        [[NSUserDefaults standardUserDefaults] setObject:@"上海" forKey:@"dingweicity"];
    }];
}

- (void)todoSomethin:(id)sender{
    
    FirstPageController *firstview=[[FirstPageController alloc]init];
    firstview.ids=sender;
    [self.navigationController pushViewController:firstview animated:YES];
}

- (void)collectionAction:(UIButton *)sender{
    
    ShouCangViewController *view = [ShouCangViewController new];
    
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

-(void)sousuobtn:(UIButton *)sender{
    
    DropDownListViewController *view=[[DropDownListViewController alloc]init];
    
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:view animated:NO];
}
#pragma mark - 接送机
- (void)shangwuClick{
    
    plateAddress = @"1";
    getOrsend = @"1";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    view.tag = 10089;
    [self.view.window addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.075, ScreenWidth*0.3, ScreenWidth*0.85, ScreenWidth*0.88)];
    view2.tag = 10088;
    view2.backgroundColor = [UIColor whiteColor];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    [view addSubview:view2];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(ScreenWidth*0.035, ScreenWidth*0.035, ScreenWidth*0.1, ScreenWidth*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UILabel *yongtuXZ = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.2, ScreenWidth*0.04, view2.frame.size.width*0.6, ScreenWidth*0.1)];
    yongtuXZ.text = @"请选择用途";
    yongtuXZ.textColor = Color(77, 77, 77);
    yongtuXZ.textAlignment = NSTextAlignmentCenter;
    yongtuXZ.font = [UIFont boldSystemFontOfSize:19];
    yongtuXZ.adjustsFontSizeToFitWidth = YES;
    [view2 addSubview:yongtuXZ];
    
    UILabel *xian0 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(yongtuXZ.frame)+ScreenWidth*0.03, view2.frame.size.width*0.9, 0.7)];
    xian0.backgroundColor = Color(207, 207, 207);
    [view2 addSubview:xian0];
    
    UIColor *color = Color(7, 187, 177);
    jie = [UIButton buttonWithType:UIButtonTypeCustom];
    jie.frame = CGRectMake(ScreenWidth*0.1, CGRectGetMaxY(xian0.frame)+ScreenWidth*0.05, ScreenWidth*0.3, ScreenWidth*0.1);
    jie.backgroundColor = [UIColor whiteColor];
    [jie setTitle:@"接机" forState:UIControlStateNormal];
    [jie setTitleColor:color forState:UIControlStateNormal];
    jie.layer.borderWidth = 1;
    jie.titleLabel.font = [UIFont systemFontOfSize:20];
    [jie addTarget:self action:@selector(jieji:) forControlEvents:UIControlEventTouchUpInside];
    jie.layer.borderColor = [color CGColor];
    [view2 addSubview:jie];
    
    song = [UIButton buttonWithType:UIButtonTypeCustom];
    song.frame = CGRectMake(ScreenWidth*0.45, CGRectGetMaxY(xian0.frame)+ScreenWidth*0.05, ScreenWidth*0.3, ScreenWidth*0.1);
    song.backgroundColor = [UIColor whiteColor];
    [song setTitle:@"送机" forState:UIControlStateNormal];
    [song setTitleColor:color forState:UIControlStateNormal];
    song.layer.borderWidth = 1;
    song.titleLabel.font = [UIFont systemFontOfSize:20];
    [song addTarget:self action:@selector(songji:) forControlEvents:UIControlEventTouchUpInside];
    song.layer.borderColor = [color CGColor];
    [view2 addSubview:song];
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(jie.frame)+ScreenWidth*0.05, view2.frame.size.width*0.9, 0.7)];
    xian1.backgroundColor = Color(207, 207, 207);
    [view2 addSubview:xian1];
    
    NSArray *array = @[@"虹桥机场T1",@"虹桥机场T2",@"浦东机场T1",@"浦东机场T2",@"上海南站",@"虹桥火车站"];
    for (int i = 0; i < 6; i++) {
        
        if (i %2 == 0) {
            
            UIButton *jichang = [UIButton buttonWithType:UIButtonTypeCustom];
            jichang.frame = CGRectMake(ScreenWidth*0.1, CGRectGetMaxY(xian1.frame)+ScreenWidth*0.05+ (i/2)*ScreenWidth*0.15 , ScreenWidth*0.3, ScreenWidth*0.1);
            [jichang setTitle:array[i] forState:UIControlStateNormal];
            [jichang setTitleColor:color forState:UIControlStateNormal];
            jichang.layer.borderWidth = 1;
            jichang.tag = 10022+i;
            [jichang addTarget:self action:@selector(jichangmingzi:) forControlEvents:UIControlEventTouchUpInside];
            jichang.layer.borderColor = [color CGColor];
            [view2 addSubview:jichang];
        }else{
            
            UIButton *jichang = [UIButton buttonWithType:UIButtonTypeCustom];
            jichang.frame = CGRectMake(ScreenWidth*0.45, CGRectGetMaxY(xian1.frame)+ScreenWidth*0.05+ ((i-1)/2)*ScreenWidth*0.15, ScreenWidth*0.3, ScreenWidth*0.1);
            [jichang setTitle:array[i] forState:UIControlStateNormal];
            [jichang setTitleColor:color forState:UIControlStateNormal];
            jichang.layer.borderWidth = 1;
            jichang.tag = 10022+i;
            [jichang addTarget:self action:@selector(jichangmingzi:) forControlEvents:UIControlEventTouchUpInside];
            jichang.layer.borderColor = [color CGColor];
            [view2 addSubview:jichang];
        }
    }
    
}
- (void)jieji:(UIButton *)sender{
    
    UIColor *color = Color(7, 187, 177);
    sender.backgroundColor = color;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    song.backgroundColor = [UIColor whiteColor];
    [song setTitleColor:color forState:UIControlStateNormal];
    
    getOrsend = @"jie";
    
    if (![plateAddress isEqualToString:@"1"]) {
        
        JieSongViewController *view = [[JieSongViewController alloc] init];
        
        view.address = plateAddress;
        view.jiesong = getOrsend;
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
        
        UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
        [view1 removeFromSuperview];
    }
}
- (void)songji:(UIButton *)sender{
    
    UIColor *color = Color(7, 187, 177);
    sender.backgroundColor = color;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    jie.backgroundColor = [UIColor whiteColor];
    [jie setTitleColor:color forState:UIControlStateNormal];
    
    getOrsend = @"song";
    if (![plateAddress isEqualToString:@"1"]) {
        
        JieSongViewController *view = [[JieSongViewController alloc] init];
        
        view.address = plateAddress;
        view.jiesong = getOrsend;
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
        
        UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
        [view1 removeFromSuperview];
    }else{
        
        
    }
    
}
- (void)jichangmingzi:(UIButton *)sender{
    
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = Color(7, 187, 177);
    
    plateAddress = sender.titleLabel.text;
    
    float a = sender.tag - 10022;
    
    UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
    UIView *view2 = [view1 viewWithTag:10088];
    for (int i = 0; i < 6; i++) {
        
        if (a != i) {
            
            UIColor *color2 = Color(7, 187, 177);
            UIButton *button = (UIButton *)[view2 viewWithTag:10022+i];
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:color2 forState:UIControlStateNormal];
        }
    }
    
    if (! [getOrsend isEqualToString:@"1"]){
        
        JieSongViewController *view = [[JieSongViewController alloc] init];
        
        view.address = plateAddress;
        view.jiesong = getOrsend;
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
        
        UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
        [view1 removeFromSuperview];
    }
}

- (UIColor *)randomColor{
    
    CGFloat hue = (arc4random()%256/256.0);
    CGFloat saturation = (arc4random()%128/256.0)+0.5;
    CGFloat brightness = (arc4random()%128/256.0)+0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
- (void)removeAll{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
}
- (void)queding{
    
    if (plateAddress == nil || [plateAddress isEqualToString:@""] || getOrsend == nil || [getOrsend isEqualToString:@""]) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        view.tag = 10087;
        [self.view.window addSubview:view];
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenWidth*0.3, ScreenWidth*0.8, ScreenWidth*0.3)];
        view2.tag = 10086;
        view2.backgroundColor = [UIColor whiteColor];
        view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
            
            view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
        view2.center = self.view.center;
        [view addSubview:view2];
        
        UILabel *huahsu = [[UILabel alloc] initWithFrame:CGRectMake(0, view2.frame.size.width*0.04, view2.frame.size.width, ScreenWidth*0.1)];
        huahsu.text = @"方式或地址有误";
        huahsu.textColor = Color(157, 157, 157);
        huahsu.textAlignment = NSTextAlignmentCenter;
        huahsu.font = [UIFont systemFontOfSize:18];
        [view2 addSubview:huahsu];
        
        UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(huahsu.frame)+ScreenWidth*0.04, view2.frame.size.width*0.9, 1)];
        xian.backgroundColor = Color(207, 207, 207);
        [view2 addSubview:xian];
        
        UIButton *iKnow = [UIButton buttonWithType:UIButtonTypeCustom];
        iKnow.frame = CGRectMake(0, CGRectGetMaxY(xian.frame)+ScreenWidth*0.02, view2.frame.size.width, ScreenWidth*0.1);
        [iKnow setTitle:@"确定" forState:UIControlStateNormal];
        UIColor *itemColor = Color(7, 187, 177);
        [iKnow setTitleColor:itemColor forState:UIControlStateNormal];
        [view2 addSubview:iKnow];
        
        [iKnow addTarget:self action:@selector(IKnowHowtoDo) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        
        UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
        [view1 removeFromSuperview];
        
        JieSongViewController *view = [[JieSongViewController alloc] init];
        
        view.address = plateAddress;
        view.jiesong = getOrsend;
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }
}

- (void)IKnowHowtoDo{
    
    UIView *view1 = (UIView *)[self.view.window viewWithTag:10087];
    [view1 removeFromSuperview];
}
#pragma mark - 超跑
- (void)ChaoPaoClick{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    view.tag = 10089;
    [self.view.window addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.3, ScreenWidth*0.9, ScreenWidth*0.85)];
    view2.tag = 10088;
    view2.backgroundColor = [UIColor whiteColor];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    [view addSubview:view2];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(ScreenWidth*0.035, ScreenWidth*0.035, ScreenWidth*0.1, ScreenWidth*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UILabel *yongtu = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.8, ScreenWidth*0.08)];
    yongtu.text =@"请选择用途";
    yongtu.textColor = Color(77, 77, 77);
    yongtu.textAlignment = NSTextAlignmentCenter;
    yongtu.font = [UIFont boldSystemFontOfSize:19];
    [view2 addSubview:yongtu];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(yongtu.frame)+ScreenWidth*0.04, ScreenWidth*0.8, 0.7)];
    xian.backgroundColor = Color(207, 207, 207);
    [view2 addSubview:xian];
    
    UIColor *color = Color(7, 187, 177);
    NSArray *array = @[@"结婚用车",@"展示拍摄",@"商务活动",@"自驾租赁"];
    for (int i = 0; i < 4; i++) {
        
        UIButton *fangshi = [UIButton buttonWithType:UIButtonTypeCustom];
        fangshi.frame = CGRectMake(ScreenWidth * 0.15, CGRectGetMaxY(yongtu.frame)+ScreenWidth*0.1 + i*ScreenWidth*0.15, ScreenWidth*0.6, ScreenWidth*0.1);
        [fangshi setTitle:array[i] forState:UIControlStateNormal];
        [fangshi setTitleColor:color forState:UIControlStateNormal];
        fangshi.layer.borderColor = [color CGColor];
        fangshi.layer.borderWidth = 1;
        [view2 addSubview:fangshi];
        [fangshi addTarget:self action:@selector(yongtuxuanze:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)yongtuxuanze:(UIButton *)sender{
    
    UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
    [view1 removeFromSuperview];
    
    ChaoPaoViewController *view = [[ChaoPaoViewController alloc] init];
    view.fangshi = sender.titleLabel.text;
    
    view.hidesBottomBarWhenPushed = YES;
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.3;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.type = @"Fade";
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:view animated:YES];
}











@end
