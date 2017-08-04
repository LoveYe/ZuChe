//
//  MarriedCar.m
//  ZuChe
//
//  Created by apple  on 16/9/9.
//  Copyright © 2016年 佐途. All rights reserved.
//



#import "RootViewcontroller.h"

#import "MarriedCar.h"
#import "MyScrollView.h"
#import "SecScrollView.h"
#import "Header.h"
#import "DingdanViewC.h"
#import <WebKit/WebKit.h>
#import "HomePageViewController.h"
#import "ZCUserData.h"

#import "GiFHUD.h"

#import "UIImageView+WebCache.h"
#import "HttpManager.h"
#import "CarTypePingjia.h"
#import "LoginView.h"
#import "PjDemoTableViewCell.h"
#import "WSStarRatingView.h"
#import "AFNetworking.h"

#define URL @"http://wx.leisurecarlease.com/api.php?op=api_zclxlb"
#define PJUrl @"http://wx.leisurecarlease.com/api.php?op=api_hcpj"

@interface MarriedCar ()<UIScrollViewDelegate,View1Delegate,SecDelegate,PingjiaDelegate,PingjiaDelegate2,UITableViewDelegate,UITableViewDataSource,StarRatingViewDelegate,UIAlertViewDelegate>{
    
    CGFloat width;
    CGFloat height;
    
    UILabel *cartype111;
    UIImageView *carCount;
    UILabel *carCountint;
    NSMutableArray *weiyidongArray;
    
    NSMutableArray *zhuCheArray;
    NSMutableArray *imageArray;
    NSMutableArray *typeArray;
    NSMutableArray *intArray;
    NSMutableArray *priceArray;
    NSMutableArray *chaoshiArray;
    NSMutableArray *chaoKMArray;
    
    NSMutableArray *gencheArray;
    NSMutableArray *imageArray2;
    NSMutableArray *typeArray2;
    NSMutableArray *intArray2;
    NSMutableArray *priceArray2;
    NSMutableArray *chaoshiArray2;
    NSMutableArray *chaoKMArray2;
    
    NSMutableArray *array111;
    
    NSMutableArray *zhuche_listArray;
    NSMutableArray *genche_listArray;
    NSString *zhucheCarid;
    NSString *gencheCarid;
    
    NSString *_typeMain;
    NSString *_typrFollow;
    
    UILabel *genche;
    UIButton *yuding;
    
    NSString *carType1;
    NSString *carPrice1;
    NSString *carColor1;
    
    NSString *carType2;
    NSString *carPrice2;
    NSString *carColor2;
    
    NSString *zhuchePrice1;
    NSString *zhuchePrice2;
    NSString *genchePrice1;
    NSString *genchePrice2;
    
    UIView *alertView;
    int aPrice;
    int bPrice;
    int cPrice;
    
    UILabel *xian3;
    UIButton *phone;
    UIButton *wenhao;
    
    UIView *alert;
    UIActivityIndicatorView *donghua;
    
    UITableView *_tableView;
    
    NSString *_carID;
    NSString *_carLeixing;
    NSMutableArray *_PingJiaArray;
    
    NSString *_PJ;
    NSString *_STAR;
    
    WSStarRatingView *_wsStraRating;
    NSMutableArray *downArray;
    
    BOOL _isPoping;
}

@property (nonatomic , strong) MyScrollView *bannerView;

@property (nonatomic , strong) UILabel *starLabel;

@property (nonatomic , strong)SecScrollView *view2;


@end

@implementation MarriedCar

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (!_isPoping) {
        
        _isPoping = YES;
        return YES;
    }
    return NO;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.tabBar.hidden = YES;
    
    
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == -1) {
            
            NSLog(@"未知网络");
        }else if (status == 0){
            
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            UIAlertView *alert111 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert111 show];
            alert111.delegate = self;
        }else if (status == 1){
            
            [self downLoad];
        }else if (status == 2){
            
            [self downLoad];
        }
    }];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    _isPoping = NO;
}

- (void)yindaoView{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"you" forKey:@"yindaoye"];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 11122;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
    [self.view addSubview:view1];
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveAll)];
    [view1 addGestureRecognizer:tapges];
    [self performSelector:@selector(moveAll) withObject:view1 afterDelay:2.0];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view2.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    image.image = [UIImage imageNamed:@"滑动手势.png"];
    image.userInteractionEnabled = YES;
    [view2 addSubview:image];
}
- (void)moveAll{
    
    UIView *view = [self.view viewWithTag:11122];
    
    view.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    [view removeFromSuperview];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    [alertView removeFromSuperview];
    [downArray removeAllObjects];
    [intArray removeAllObjects];
    [imageArray removeAllObjects];
    [typeArray removeAllObjects];
    [priceArray removeAllObjects];
    [chaoKMArray removeAllObjects];
    [chaoshiArray removeAllObjects];
    [zhuche_listArray removeAllObjects];
    
    [_bannerView removeFromSuperview];
    [_view2 removeFromSuperview];
    
    UIView *view = [self.view viewWithTag:10086];
    [GiFHUD dismiss];
    [view removeFromSuperview];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downLoad{
    
    UIView *view = [GiFHUD new];
    [GiFHUD setGifWithImageName:@"动态gif.gif"];
    [GiFHUD show];
    
    NSDictionary *dict = @{@"type":@1};
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        [HttpManager postData:dict andUrl:URL success:^(NSDictionary *fanhuicanshu) {
            
//            随后 可以在 download 中替换数据，使用活数据
            NSMutableArray *array1 = [NSMutableArray arrayWithArray:fanhuicanshu[@"carlist"][@"zhuche_list"]];
            downArray = [NSMutableArray arrayWithArray:fanhuicanshu[@"carlist"][@"genche_list"]];
            intArray = [NSMutableArray array];
            for (int i = 0; i < array1.count; i++) {
                
                [intArray addObject:array1[i][@"zan"]];
            }
            [GiFHUD dismiss];
            [self createMainCar];
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"婚车";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    zhuche_listArray = [NSMutableArray array];
    genche_listArray = [NSMutableArray array];
    
    imageArray = [NSMutableArray array];
    zhuCheArray = [NSMutableArray array];
    typeArray = [NSMutableArray array];
//    intArray = [NSMutableArray array];
    priceArray = [NSMutableArray array];
    chaoshiArray = [NSMutableArray array];
    chaoKMArray = [NSMutableArray array];
    
    array111 = [NSMutableArray array];
    
    imageArray2 = [NSMutableArray array];
    gencheArray = [NSMutableArray array];
    typeArray2 = [NSMutableArray array];
    intArray2 = [NSMutableArray array];
    priceArray2 = [NSMutableArray array];
    chaoshiArray2 = [NSMutableArray array];
    chaoKMArray2 = [NSMutableArray array];
    
    weiyidongArray = [NSMutableArray array];
    downArray = [NSMutableArray array];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    
}
- (void)createMainCar{
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(width*0.05, width*0.09, width*0.08, width*0.08);
    [fanhui addTarget:self action:@selector(fanhuiClick) forControlEvents:UIControlEventTouchUpInside];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [self.view addSubview:fanhui];
    
    UILabel *zhuche = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.085, width, width*0.1)];
    zhuche.text = @"婚礼主车";
    zhuche.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    zhuche.textAlignment = NSTextAlignmentCenter;
    zhuche.textColor = Color(107, 107, 107);
    [self.view addSubview:zhuche];
    
    UIButton *wenhao1 = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao1.frame = CGRectMake(width*0.85, width*0.085, width*0.1, width*0.1);
    wenhao1.tag = 1008611;
    [wenhao1 addTarget:self action:@selector(upWenhao:) forControlEvents:UIControlEventTouchUpInside];
    [wenhao1 setBackgroundImage:[UIImage imageNamed:@"问(1).png"] forState:UIControlStateNormal];
    [self.view addSubview:wenhao1];
    
    NSArray *array = @[@"玛莎拉蒂Ghibli白.png",@"玛莎拉蒂Ghibli.png",@"保时捷Panamera白.png",@"保时捷Panamera.png",@"玛莎拉蒂总裁白.png",@"玛莎拉蒂总裁.png",@"奔驰S级.png",@"宝马7系白.png",@"宝马7系.png",@"奥迪A8.png",@"特斯拉Model S白.png",@"特斯拉Model S.png",@"特斯拉Model X.png",@"宾利飞驰白.png",@"宾利飞驰.png",@"劳斯莱斯古斯特.png",@"宾利慕尚.png",@"劳斯莱斯幻影.png",@"捷豹XJL白.png",@"捷豹XJL.png",@"保时捷Boxster白.png",@"奥迪A5.png"];
    [imageArray addObjectsFromArray:array];
    NSArray *array2 = @[@"玛莎拉蒂-Ghibli",@"玛莎拉蒂-Ghibli",@"保时捷-Panamera",@"保时捷-Panamera",@"玛莎拉蒂-总裁",@"玛莎拉蒂-总裁",@"奔驰-S级",@"宝马-7系",@"宝马-7系",@"奥迪-A8L",@"特斯拉-Model S",@"特斯拉-Model S",@"特斯拉-Model X",@"宾利-飞驰",@"宾利-飞驰",@"劳斯莱斯-古斯特",@"宾利-慕尚",@"劳斯莱斯-幻影",@"捷豹-XJL",@"捷豹-XJL",@"保时捷-Boxster",@"奥迪-A5 敞篷"];
    [typeArray addObjectsFromArray:array2];
    NSArray *array3 = @[@"2500",@"2500",@"2000",@"2000",@"3000",@"3000",@"1500",@"1500",@"1500",@"1500",@"1500",@"1500",@"2800",@"4800",@"4800",@"5800",@"7800",@"7800",@"2000",@"2000",@"2000",@"1600"];
    [priceArray addObjectsFromArray:array3];
    
    NSArray *array5 = @[@"300",@"300",@"300",@"300",@"400",@"400",@"200",@"200",@"200",@"200",@"200",@"200",@"300",@"500",@"500",@"500",@"1000",@"1000",@"200",@"200",@"200",@"200"];
    [chaoshiArray addObjectsFromArray:array5];
    NSArray *array6 = @[@"30",@"30",@"30",@"30",@"40",@"40",@"20",@"20",@"20",@"20",@"20",@"20",@"30",@"50",@"50",@"50",@"100",@"100",@"20",@"20",@"20",@"20"];
    [chaoKMArray addObjectsFromArray:array6];
    
    NSArray *array7 = @[@"14",@"13",@"2",@"11",@"3",@"8",@"1",@"4",@"10",@"12",@"17",@"22",@"16",@"9",@"7",@"6",@"15",@"5",@"19",@"18",@"20",@"21"];
    [zhuche_listArray addObjectsFromArray:array7];
    
    _bannerView = [[MyScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(zhuche.frame)+width*0.045, width, width*0.8*2/3) imageArr:imageArray carType:typeArray buZhou:intArray jiage:priceArray chaoshi:chaoshiArray chaoKM:chaoKMArray carID:zhuche_listArray];
    
    aPrice = 0;
    _bannerView.delegate   = self;
    _bannerView.pjDelegate = self;
    [self.view addSubview:_bannerView];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.8*3/5+width*0.25+width*0.145, width, 1)];
    xian.backgroundColor = Color(230, 230, 230);
    [self.view addSubview:xian];
    
    NSArray *array11 = @[@"宝马5系白.png",@"宝马5系.png",@"奥迪A6L.png",@"奔驰E级.png",@"宝马7系白.png",@"宝马7系.png",@"奔驰S级.png",@"奥迪A8.png",@"特斯拉Model S白.png",@"特斯拉Model S.png"];
    [imageArray2 addObjectsFromArray:array11];
    NSArray *array22 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L",@"特斯拉-Model S",@"特斯拉-Model S"];
    [typeArray2 addObjectsFromArray:array22];
    
    NSArray *array33 = @[@"700",@"700",@"600",@"700",@"1500",@"1500",@"1500",@"1500",@"1500",@"1500"];
    [priceArray2 addObjectsFromArray:array33];
    
    NSArray *array55 = @[@"100",@"100",@"100",@"100",@"200",@"200",@"200",@"200",@"200",@"200"];
    [chaoshiArray2 addObjectsFromArray:array55];
    NSArray *array66 = @[@"10",@"10",@"10",@"10",@"20",@"20",@"20",@"20",@"20",@"20"];
    [chaoKMArray2 addObjectsFromArray:array66];
    NSArray *array77 = @[@"3",@"4",@"8",@"2",@"16",@"14",@"15",@"13",@"23",@"24"];
    [genche_listArray addObjectsFromArray:array77];
    for (int i = 0; i < array77.count; i++) {
        
        int a = [array77[i] intValue];
        [intArray2 addObject:downArray[a][@"zan"]];
    }
    
    bPrice = 0;
    [self createFollowCar];
}
- (void)createFollowCar{
    
    genche = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.8*3/5+width*0.26+width*0.155, width, width*0.1)];
    genche.textColor = Color(107, 107, 107);
    genche.textAlignment = NSTextAlignmentCenter;
    genche.text = @"婚礼跟车";
    genche.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    [self.view addSubview:genche];
    
    wenhao = [UIButton buttonWithType:UIButtonTypeCustom];
    wenhao.frame = CGRectMake(width*0.85, width*0.8*3/5+width*0.26+width*0.155, width*0.1, width*0.1);
    wenhao.tag = 9991;
    [wenhao addTarget:self action:@selector(upWenhao:) forControlEvents:UIControlEventTouchUpInside];
    [wenhao setBackgroundImage:[[UIImage imageNamed:@"问(1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [self.view addSubview:wenhao];
    
    _view2 = [[SecScrollView alloc] initWithframe:CGRectMake(0, CGRectGetMaxY(genche.frame)+width*0.035, width, width*0.8*2/3) ImgArray:imageArray2 carType:typeArray2 buZhou:intArray2 jiage:priceArray2 chaoshi:chaoshiArray2 chaoKM:chaoKMArray2 carID:genche_listArray];
    _view2.delegate   = self;
    _view2.pjDelegate = self;
    [self.view addSubview:_view2];
    phone = [UIButton buttonWithType:UIButtonTypeCustom];
    phone.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-width*0.1, width/2, width*0.1);
    UIColor *color1 = Color(7, 187, 177);
    
    
    [phone addTarget:self action:@selector(CallPhone:) forControlEvents:UIControlEventTouchUpInside];
    [phone setTitle:@"4008-609-669" forState:UIControlStateNormal];
    [phone setTitleColor:color1 forState:UIControlStateNormal];
    phone.backgroundColor = [UIColor whiteColor];
    [phone setTitleColor:color1 forState:UIControlStateNormal];
    
    [self.view addSubview:phone];
    
    
    yuding = [UIButton buttonWithType:UIButtonTypeCustom];
    yuding.frame = CGRectMake(width/2, CGRectGetMaxY(self.view.frame)-width*0.1, width/2, width*0.1);
    
    [yuding setTitle:@"立即预定" forState:UIControlStateNormal];
    [yuding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yuding setBackgroundColor:color1];
    [yuding setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    yuding.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    [yuding addTarget:self action:@selector(xiadingdan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yuding];
    
    xian3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-width*0.1, width, 1)];
    xian3.backgroundColor = Color(7, 187, 177);
    [self.view addSubview:xian3];
    
    NSString *yindao = [[NSUserDefaults standardUserDefaults] objectForKey:@"yindaoye"];
    if (![yindao isEqualToString:@"you"]) {
        
        [self yindaoView];
    }else{
    }
}

- (void)fanhuiClick{
    
//    HomePageViewController *view = [[HomePageViewController alloc] init];
    
//    view.hidesBottomBarWhenPushed = YES;
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.25;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.type = @"Fade";
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - 打电话
- (void)CallPhone:(UIButton *)sender{
    
    NSLog(@"dianji ");
    UIColor *color = Color(7, 187, 177);
    [UIView animateWithDuration:0.1 animations:^{
        
        [sender setBackgroundColor:color];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        
        [sender setBackgroundColor:[UIColor whiteColor]];
        [sender setTitleColor:color forState:UIControlStateNormal];
    }];
    
    [self callPhone:@"4008609669"];
    
}
-(void)callPhone:(NSString *)phoneNum {
    
    if (phoneNum.length == 0) {
        
        return;
    }
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}
#pragma mark - 下订单
- (void)xiadingdan:(UIButton *)sender{
    
    NSLog(@"点击成功");
    
    if (aPrice == 0) {
        
        carType1 = @"玛莎拉蒂-Ghibli";
        carColor1 = @"白色";
        carPrice1 = @"2500";
        zhuchePrice1 = @"300";
        zhuchePrice2 = @"30";
        zhucheCarid = @"14";
        if (bPrice == 0) {
            
            carType2 = @"宝马-5系";
            carColor2 = @"白色";
            carPrice2 = @"650";
            genchePrice1 = @"100";
            genchePrice2 = @"10";
            gencheCarid = @"3";
        }
    }else{
        
        if (bPrice == 0) {
            
            if (cPrice == 0) {
                
                carType2 = @"宝马-5系";
                carColor2 = @"白色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"3";
            }
            if (cPrice == 1) {
                carType2 = @"宝马-5系";
                carColor2 = @"黑色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"4";
            }if (cPrice == 2) {
                carType2 = @"宝马-5系";
                carColor2 = @"白色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"3";
            }if (cPrice == 3) {
                carType2 = @"宝马-5系";
                carColor2 = @"黑色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"4";
            }if (cPrice == 4) {
                carType2 = @"宝马-5系";
                carColor2 = @"白色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"3";
            }if (cPrice == 5) {
                carType2 = @"宝马-5系";
                carColor2 = @"黑色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"3";
            }if (cPrice == 6) {
                carType2 = @"奔驰-E级";
                carColor2 = @"黑色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"8";
            }if (cPrice == 7) {
                carType2 = @"宝马-5系";
                carColor2 = @"白色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"4";
            }if (cPrice == 8) {
                carType2 = @"宝马-5系";
                carColor2 = @"黑色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"4";
            }if (cPrice == 9) {
                carType2 = @"奥迪-A6L";
                carColor2 = @"黑色";
                carPrice2 = @"600";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"2";
            }if (cPrice == 10) {
                carType2 = @"宝马-7系";
                carColor2 = @"白色";
                carPrice2 = @"1500";
                genchePrice1 = @"200";
                genchePrice2 = @"20";
                gencheCarid = @"3";
            }if (cPrice == 11) {
                carType2 = @"宝马-5系";
                carColor2 = @"黑色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"4";
            }if (cPrice == 12) {
                carType2 = @"特斯拉-Model S";
                carColor2 = @"白色";
                carPrice2 = @"1500";
                genchePrice1 = @"200";
                genchePrice2 = @"20";
                gencheCarid = @"23";
            }if (cPrice == 13) {
                carType2 = @"宝马-7系";
                carColor2 = @"白色";
                carPrice2 = @"1500";
                genchePrice1 = @"200";
                genchePrice2 = @"20";
                gencheCarid = @"16";
            }if (cPrice == 14) {
                carType2 = @"宝马-7系";
                carColor2 = @"黑色";
                carPrice2 = @"1500";
                genchePrice1 = @"200";
                genchePrice2 = @"20";
                gencheCarid = @"14";
            }if (cPrice == 15) {
                
                carType2 = @"宝马-7系";
                carColor2 = @"黑色";
                carPrice2 = @"1500";
                genchePrice1 = @"200";
                genchePrice2 = @"20";
                gencheCarid = @"14";
            }if (cPrice == 16) {
                
                carType2 = @"宝马-7系";
                carColor2 = @"黑色";
                carPrice2 = @"1500";
                genchePrice1 = @"200";
                genchePrice2 = @"20";
                gencheCarid = @"14";
            }if (cPrice == 17) {
                
                carType2 = @"宝马-7系";
                carColor2 = @"黑色";
                carPrice2 = @"1500";
                genchePrice1 = @"200";
                genchePrice2 = @"20";
                gencheCarid = @"14";
            }if (cPrice == 18) {
                
                carType2 = @"宝马-5系";
                carColor2 = @"白色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"3";
            }if (cPrice == 19) {
                
                carType2 = @"宝马-5系";
                carColor2 = @"黑色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"4";
            }if (cPrice == 20) {
                
                carType2 = @"宝马-5系";
                carColor2 = @"白色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"3";
            }if (cPrice == 21) {
                
                carType2 = @"宝马-5系";
                carColor2 = @"白色";
                carPrice2 = @"650";
                genchePrice1 = @"100";
                genchePrice2 = @"10";
                gencheCarid = @"3";
            }
            
        }
    }
    
    NSLog(@"---%@%@%@%@ %@ %@-%@%@%@%@%@ %@",carType1,carPrice1,carColor1,zhuchePrice1,zhucheCarid,zhuchePrice2,carType2,carColor2,carPrice2,genchePrice1,genchePrice2,gencheCarid);
    
    if ([ZCUserData share].isLogin == YES) {
        
        [self createAlertView];
    }else{
        
        [self createView];
    }
}
#pragma mark - 下订单
- (void)createAlertView{
    
    alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    alertView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    //    alertView.alpha = 0.6;
    [self.view addSubview:alertView];
    
    alert = [[UIView alloc] initWithFrame:CGRectMake(width/2-width*0.375, width*0.4, width*0.75, width*0.5)];
    alert.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        alert.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    alert.backgroundColor = [UIColor whiteColor];
    [alertView addSubview:alert];
    
    UIImageView *image11 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(alert.frame), CGRectGetHeight(alert.frame))];
    image11.image = [UIImage imageNamed:@"白背景.png"];
    image11.userInteractionEnabled = YES;
    [alert addSubview:image11];
    
    UILabel *zhuInfo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(image11.frame)+width*0.1, CGRectGetMinY(image11.frame)+width*0.1, width*0.8, width*0.1)];
    zhuInfo.textAlignment = NSTextAlignmentLeft;
    zhuInfo.text = [NSString stringWithFormat:@"主车：%@",carType1];
    zhuInfo.textColor = Color(87, 87, 87);
    zhuInfo.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    [image11 addSubview:zhuInfo];
    
    
    UILabel *genInfo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(image11.frame)+width*0.1, CGRectGetMaxY(zhuInfo.frame), width*0.8, width*0.1)];
    
    genInfo.text = [NSString stringWithFormat:@"跟车：%@",carType2];
    genInfo.textAlignment = NSTextAlignmentLeft;
    genInfo.textColor = Color(87, 87, 87);
    genInfo.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    [image11 addSubview:genInfo];
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(image11.frame)+width*0.05, CGRectGetMaxY(image11.frame)-width*0.12, width*0.65, 0.5)];
    xian1.backgroundColor = Color(217, 217, 217);
    [image11 addSubview:xian1];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(CGRectGetMinX(image11.frame), CGRectGetMaxY(image11.frame)-width*0.12, CGRectGetWidth(image11.frame)/2, width*0.12);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    UIColor *color1 = Color(7, 187, 177);
    UIColor *color2 = Color(177, 177, 177);
    [cancel addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:color2 forState:UIControlStateNormal];
    [image11 addSubview:cancel];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.frame = CGRectMake(CGRectGetMaxX(cancel.frame), CGRectGetMaxY(image11.frame)-width*0.12, CGRectGetWidth(image11.frame)/2, width*0.12);
    
    okButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    [okButton setTitleColor:color1 forState:UIControlStateNormal];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [image11 addSubview:okButton];
    [okButton addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancel.frame), CGRectGetMaxY(image11.frame)-width*0.1, 0.5, width*0.08)];
    xian2.backgroundColor = Color(217, 217, 217);
    [image11 addSubview:xian2];
}
#pragma mark - 主车更换，跟车更新
- (void)sendstr:(NSString *)str{
    
    aPrice = 1;
    [imageArray2 removeAllObjects];
    [typeArray2 removeAllObjects];
    [genche_listArray removeAllObjects];
    [priceArray2 removeAllObjects];
    [intArray2 removeAllObjects];
    [_view2 removeFromSuperview];
    [genche removeFromSuperview];
    [yuding removeFromSuperview];
    [chaoKMArray2 removeAllObjects];
    [chaoshiArray2 removeAllObjects];
    [wenhao removeFromSuperview];
    [phone removeFromSuperview];
    [xian3 removeFromSuperview];
//    _view2 = [[SecScrollView alloc] init];
    
    bPrice = 0;
    int i = [str intValue];
    cPrice = i;
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
    
    if (i == 1) {
        
        NSArray *array = @[@"宝马5系.png",@"宝马5系白.png",@"奔驰E级.png",@"奥迪A6L.png",@"奔驰S级.png",@"宝马7系.png",@"宝马7系白.png",@"奥迪A8.png",@"特斯拉Model S.png",@"特斯拉Model S白.png"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奔驰-E级",@"奥迪-A6L",@"奔驰-S级",@"宝马-7系",@"宝马-7系",@"奥迪-A8L",@"特斯拉-Model S",@"特斯拉-Model S"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"650",@"600",@"1500",@"1500",@"1500",@"1500",@"1500",@"1500"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100",@"200",@"200",@"200",@"200",@"200",@"200"];
        [chaoshiArray2 addObjectsFromArray:array5];
        NSArray *array6 = @[@"10",@"10",@"10",@"10",@"20",@"20",@"20",@"20",@"20",@"20"];
        [chaoKMArray2 addObjectsFromArray:array6];
        NSArray *array7 = @[@"4",@"3",@"8",@"2",@"15",@"14",@"16",@"13",@"24",@"23"];
        [genche_listArray addObjectsFromArray:array7];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 2) {
        
        NSArray *array = @[@"宝马5系白.png",@"宝马5系.png",@"奥迪A6L.png",@"奔驰E级.png",@"宝马7系白",@"宝马7系",@"奔驰S级",@"奥迪A8",@"特斯拉Model S白",@"特斯拉Model S"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L",@"特斯拉-Model S",@"特斯拉-Model S"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"600",@"650",@"1500",@"1500",@"1500",@"1500",@"1500",@"1500"];
        [priceArray2 addObjectsFromArray:array3];
//        NSArray *array4 = @[@"4800",@"3300",@"6700",@"3500",@"2200",@"1900",@"1800",@"1200",@"220",@"90"];
//        [intArray2 addObjectsFromArray:array4];
        NSArray *array5 = @[@"100",@"100",@"100",@"100",@"200",@"200",@"200",@"200",@"200",@"200"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10",@"20",@"20",@"20",@"20",@"20",@"20"];
        NSArray *array7 = @[@"3",@"4",@"2",@"8",@"16",@"14",@"15",@"13",@"23",@"24"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"白色";
    }
    if (i == 3) {
        
        NSArray *array = @[@"宝马5系.png",@"宝马5系白.png",@"奔驰E级.png",@"奥迪A6L.png",@"奔驰S级.png",@"宝马7系.png",@"宝马7系白.png",@"奥迪A8.png",@"特斯拉Model S.png",@"特斯拉Model S白.png"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奔驰-E级",@"奥迪-A6L",@"奔驰-S级",@"宝马-7系",@"宝马-7系",@"奥迪-A8L",@"特斯拉-Model S",@"特斯拉-Model S"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"650",@"600",@"1500",@"1500",@"1500",@"1500",@"1500",@"1500"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100",@"200",@"200",@"200",@"200",@"200",@"200"];
        [chaoshiArray2 addObjectsFromArray:array5];
        NSArray *array6 = @[@"10",@"10",@"10",@"10",@"20",@"20",@"20",@"20",@"20",@"20"];
        [chaoKMArray2 addObjectsFromArray:array6];
        NSArray *array7 = @[@"4",@"3",@"8",@"2",@"15",@"14",@"16",@"13",@"24",@"23"];
        [genche_listArray addObjectsFromArray:array7];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 4) {
        
        NSArray *array = @[@"宝马5系白.png",@"宝马5系.png",@"奥迪A6L.png",@"奔驰E级.png",@"宝马7系白",@"宝马7系",@"奔驰S级",@"奥迪A8",@"特斯拉Model S白",@"特斯拉Model S",@"玛莎拉蒂Ghibli白",@"玛莎拉蒂Ghibli",@"保时捷Panamera白",@"保时捷Panamera"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L",@"特斯拉-Model S",@"特斯拉-Model S",@"玛莎拉蒂-Ghibli",@"玛莎拉蒂-Ghibli",@"保时捷-Panamera",@"保时捷-Panamera"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"600",@"650",@"1500",@"1500",@"1500",@"1500",@"1500",@"1500",@"2500",@"2500",@"2000",@"2000"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100",@"200",@"200",@"200",@"200",@"200",@"200",@"300",@"300",@"300",@"300"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10",@"20",@"20",@"20",@"20",@"20",@"20",@"30",@"30",@"30",@"30"];
        NSArray *array7 = @[@"3",@"4",@"2",@"8",@"16",@"14",@"15",@"13",@"23",@"24",@"11",@"12",@"10",@"9"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"白色";
    }
    if (i == 5) {
        
        NSArray *array = @[@"宝马5系.png",@"宝马5系白.png",@"奥迪A6L.png",@"奔驰E级.png",@"宝马7系",@"宝马7系白",@"奔驰S级",@"奥迪A8",@"特斯拉Model S",@"特斯拉Model S白",@"玛莎拉蒂Ghibli",@"玛莎拉蒂Ghibli白",@"保时捷Panamera",@"保时捷Panamera白"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L",@"特斯拉-Model S",@"特斯拉-Model S",@"玛莎拉蒂-Ghibli",@"玛莎拉蒂-Ghibli",@"保时捷-Panamera",@"保时捷-Panamera"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"600",@"650",@"1500",@"1500",@"1500",@"1500",@"1500",@"1500",@"2500",@"2500",@"2000",@"2000"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100",@"200",@"200",@"200",@"200",@"200",@"200",@"300",@"300",@"300",@"300"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10",@"20",@"20",@"20",@"20",@"20",@"20",@"30",@"30",@"30",@"30"];
        NSArray *array7 = @[@"4",@"3",@"2",@"8",@"14",@"16",@"15",@"13",@"24",@"23",@"12",@"11",@"9",@"10"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 6) {
        
        NSArray *array = @[@"奔驰E级.png",@"奥迪A6L.png",@"宝马5系.png",@"宝马5系白.png"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"奔驰-E级",@"奥迪-A6L",@"宝马-5系",@"宝马-5系"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"600",@"650",@"650"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10"];
        NSArray *array7 = @[@"8",@"2",@"4",@"3"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 7) {
        
        NSArray *array = @[@"宝马5系白.png",@"宝马5系.png",@"奥迪A6L.png",@"奔驰E级.png"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"600",@"650"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10"];
        NSArray *array7 = @[@"3",@"4",@"2",@"8"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"白色";
    }
    if (i == 8) {
        
        NSArray *array = @[@"宝马5系.png",@"宝马5系白.png",@"奥迪A6L.png",@"奔驰E级.png"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"600",@"650"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10"];
        NSArray *array7 = @[@"4",@"3",@"8",@"2"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 9) {
        
        NSArray *array = @[@"奥迪A6L.png",@"宝马5系.png",@"宝马5系白.png",@"奔驰E级.png"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"奥迪-A6L",@"宝马-5系",@"宝马-5系",@"奔驰-E级"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"600",@"650",@"650",@"650"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10"];
        NSArray *array7 = @[@"2",@"4",@"3",@"8"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 10) {
        
        NSArray *array = @[@"宝马5系白.png",@"宝马5系.png",@"奥迪A6L.png",@"奔驰E级.png"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"650",@"650"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10"];
        NSArray *array7 = @[@"3",@"4",@"2",@"8"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"白色";
    }
    if (i == 11) {
        
        NSArray *array = @[@"宝马5系.png",@"宝马5系白.png",@"奥迪A6L.png",@"奔驰E级.png"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"600",@"650"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10"];
        NSArray *array7 = @[@"4",@"3",@"2",@"8"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 12) {
        
        NSArray *array = @[@"特斯拉Model S白",@"特斯拉Model S",@"宝马5系白",@"宝马5系",@"奥迪A6L",@"奔驰E级",@"宝马7系白",@"宝马7系",@"奔驰S级",@"奥迪A8"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"特斯拉-Model S",@"特斯拉-Model S",@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"1500",@"1500",@"650",@"650",@"600",@"650",@"1500",@"1500",@"1500",@"1500"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"200",@"200",@"100",@"100",@"100",@"100",@"200",@"200",@"200",@"200"];
        NSArray *array6 = @[@"20",@"20",@"10",@"10",@"10",@"10",@"20",@"20",@"20",@"20"];
        NSArray *array7 = @[@"24",@"23",@"3",@"4",@"2",@"8",@"16",@"14",@"15",@"13"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 13) {
        
        NSArray *array = @[@"宝马7系白",@"宝马7系",@"奔驰S级",@"奥迪A8",@"宝马5系白",@"宝马5系",@"奥迪A6L",@"奔驰E级",@"特斯拉Model S白",@"特斯拉Model S",@"玛莎拉蒂Ghibli白",@"玛莎拉蒂Ghibli",@"保时捷Panamera白",@"保时捷Panamera",@"玛莎拉蒂总裁白",@"玛莎拉蒂总裁"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L",@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"特斯拉-Model S",@"特斯拉-Model S",@"玛莎拉蒂-Ghibli",@"玛莎拉蒂-Ghibli",@"保时捷-Panamera",@"保时捷-Panamera",@"玛莎拉蒂-总裁",@"玛莎拉蒂-总裁"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"1500",@"1500",@"1500",@"1500",@"650",@"650",@"600",@"650",@"1500",@"1500",@"2500",@"2500",@"2000",@"2000",@"3000",@"3000"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"200",@"200",@"200",@"200",@"100",@"100",@"100",@"100",@"200",@"200",@"300",@"300",@"300",@"300",@"400",@"400"];
        NSArray *array6 = @[@"20",@"20",@"20",@"20",@"10",@"10",@"10",@"10",@"20",@"20",@"30",@"30",@"30",@"30",@"40",@"40"];
        NSArray *array7 = @[@"16",@"14",@"15",@"13",@"3",@"4",@"2",@"8",@"23",@"24",@"12",@"11",@"10",@"9",@"18",@"17"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"白色";
    }
    if (i == 14) {
        
        NSArray *array = @[@"宝马7系",@"宝马7系白",@"奔驰S级",@"奥迪A8",@"宝马5系",@"宝马5系白",@"奥迪A6L",@"奔驰E级",@"特斯拉Model S",@"特斯拉Model S白",@"玛莎拉蒂Ghibli",@"玛莎拉蒂Ghibli白",@"保时捷Panamera",@"保时捷Panamera白",@"玛莎拉蒂总裁",@"玛莎拉蒂总裁白"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L",@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"特斯拉-Model S",@"特斯拉-Model S",@"玛莎拉蒂-Ghibli",@"玛莎拉蒂-Ghibli",@"保时捷-Panamera",@"保时捷-Panamera",@"玛莎拉蒂-总裁",@"玛莎拉蒂-总裁"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"1500",@"1500",@"1500",@"1500",@"650",@"650",@"600",@"650",@"1500",@"1500",@"2500",@"2500",@"2000",@"2000",@"3000",@"3000"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"200",@"200",@"200",@"200",@"100",@"100",@"100",@"100",@"200",@"200",@"300",@"300",@"300",@"300",@"400",@"400"];
        NSArray *array6 = @[@"20",@"20",@"20",@"20",@"10",@"10",@"10",@"10",@"20",@"20",@"30",@"30",@"30",@"30",@"40",@"40"];
        NSArray *array7 = @[@"14",@"16",@"15",@"13",@"4",@"3",@"2",@"8",@"24",@"23",@"11",@"12",@"9",@"10",@"17",@"18"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i== 15) {
        
        NSArray *array = @[@"宝马7系",@"宝马7系白",@"奔驰S级",@"奥迪A8",@"宝马5系",@"宝马5系白",@"奥迪A6L",@"奔驰E级",@"特斯拉Model S",@"特斯拉Model S白",@"玛莎拉蒂Ghibli",@"玛莎拉蒂Ghibli白",@"保时捷Panamera",@"保时捷Panamera白",@"玛莎拉蒂总裁",@"玛莎拉蒂总裁白",@"宾利飞驰",@"宾利飞驰白"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L",@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"特斯拉-Model S",@"特斯拉-Model S",@"玛莎拉蒂-Ghibli",@"玛莎拉蒂-Ghibli",@"保时捷-Panamera",@"保时捷-Panamera",@"玛莎拉蒂-总裁",@"玛莎拉蒂-总裁",@"宾利-飞驰",@"宾利-飞驰"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"1500",@"1500",@"1500",@"1500",@"650",@"650",@"600",@"650",@"1500",@"1500",@"2500",@"2500",@"2000",@"2000",@"3000",@"3000",@"4800",@"4800"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"200",@"200",@"200",@"200",@"100",@"100",@"100",@"100",@"200",@"200",@"300",@"300",@"300",@"300",@"400",@"400",@"500",@"500"];
        NSArray *array6 = @[@"20",@"20",@"20",@"20",@"10",@"10",@"10",@"10",@"20",@"20",@"30",@"30",@"30",@"30",@"40",@"40",@"50",@"50"];
        NSArray *array7 = @[@"14",@"16",@"15",@"13",@"3",@"4",@"8",@"2",@"24",@"23",@"12",@"11",@"9",@"10",@"17",@"18",@"20",@"19"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 16) {
        
        NSArray *array = @[@"宝马7系",@"宝马7系白",@"奔驰S级",@"奥迪A8",@"宝马5系",@"宝马5系白",@"奥迪A6L",@"奔驰E级",@"特斯拉Model S",@"特斯拉Model S白",@"玛莎拉蒂Ghibli",@"玛莎拉蒂Ghibli白",@"保时捷Panamera",@"保时捷Panamera白",@"玛莎拉蒂总裁",@"玛莎拉蒂总裁白",@"宾利飞驰",@"宾利飞驰白",@"劳斯莱斯古斯特"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L",@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"特斯拉-Model S",@"特斯拉-Model S",@"玛莎拉蒂-Ghibli",@"玛莎拉蒂-Ghibli",@"保时捷-Panamera",@"保时捷-Panamera",@"玛莎拉蒂-总裁",@"玛莎拉蒂-总裁",@"宾利-飞驰",@"宾利-飞驰",@"劳斯莱斯-古斯特"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"1500",@"1500",@"1500",@"1500",@"650",@"650",@"600",@"650",@"1500",@"1500",@"2500",@"2500",@"2000",@"2000",@"3000",@"3000",@"4800",@"4800",@"5800"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"200",@"200",@"200",@"200",@"100",@"100",@"100",@"100",@"200",@"200",@"300",@"300",@"300",@"300",@"400",@"400",@"500",@"500",@"500"];
        NSArray *array6 = @[@"20",@"20",@"20",@"20",@"10",@"10",@"10",@"10",@"20",@"20",@"30",@"30",@"30",@"30",@"40",@"40",@"50",@"50",@"50"];
        NSArray *array7 = @[@"14",@"16",@"15",@"13",@"3",@"4",@"8",@"2",@"24",@"23",@"12",@"11",@"9",@"10",@"17",@"18",@"20",@"19",@"21"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 17) {
        
        NSArray *array = @[@"宝马7系",@"宝马7系白",@"奔驰S级",@"奥迪A8",@"宝马5系",@"宝马5系白",@"奥迪A6L",@"奔驰E级",@"特斯拉Model S",@"特斯拉Model S白",@"玛莎拉蒂Ghibli",@"玛莎拉蒂Ghibli白",@"保时捷Panamera",@"保时捷Panamera白",@"玛莎拉蒂总裁",@"玛莎拉蒂总裁白",@"宾利飞驰",@"宾利飞驰白",@"劳斯莱斯古斯特"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L",@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"特斯拉-Model S",@"特斯拉-Model S",@"玛莎拉蒂-Ghibli",@"玛莎拉蒂-Ghibli",@"保时捷-Panamera",@"保时捷-Panamera",@"玛莎拉蒂-总裁",@"玛莎拉蒂-总裁",@"宾利-飞驰",@"宾利-飞驰",@"劳斯莱斯-古斯特"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"1500",@"1500",@"1500",@"1500",@"650",@"650",@"600",@"650",@"1500",@"1500",@"2500",@"2500",@"2000",@"2000",@"3000",@"3000",@"4800",@"4800",@"5800"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"200",@"200",@"200",@"200",@"100",@"100",@"100",@"100",@"200",@"200",@"300",@"300",@"300",@"300",@"400",@"400",@"500",@"500",@"500"];
        NSArray *array6 = @[@"20",@"20",@"20",@"20",@"10",@"10",@"10",@"10",@"20",@"20",@"30",@"30",@"30",@"30",@"40",@"40",@"50",@"50",@"50"];
        NSArray *array7 = @[@"14",@"16",@"15",@"13",@"3",@"4",@"8",@"2",@"24",@"23",@"12",@"11",@"9",@"10",@"17",@"18",@"20",@"19",@"21"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 18) {
        
        NSArray *array = @[@"宝马5系白",@"宝马5系",@"奥迪A6L",@"奔驰E级"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"600",@"650"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10"];
        NSArray *array7 = @[@"3",@"4",@"8",@"2"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"白色";
    }
    if (i == 19) {
        
        NSArray *array = @[@"宝马5系.png",@"宝马5系白.png",@"奥迪A6L.png",@"奔驰E级.png"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"600",@"650"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10"];
        NSArray *array7 = @[@"4",@"3",@"2",@"8"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"黑色";
    }
    if (i == 20) {
        
        NSArray *array = @[@"宝马5系白",@"宝马5系",@"奥迪A6L",@"奔驰E级"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"600",@"650"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10"];
        NSArray *array7 = @[@"3",@"4",@"8",@"2"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"白色";
    }
    if (i == 21) {
        
        NSArray *array = @[@"宝马5系白",@"宝马5系",@"奥迪A6L",@"奔驰E级"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"600",@"650"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10"];
        NSArray *array7 = @[@"3",@"4",@"8",@"2"];
        [genche_listArray addObjectsFromArray:array7];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array7.count; j ++) {
            
            int a = [array7[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"白色";
    }
    if (i == 0) {
        
        NSArray *array = @[@"宝马5系白.png",@"宝马5系.png",@"奥迪A6L.png",@"奔驰E级.png",@"宝马7系白.png",@"宝马7系.png",@"奔驰S级.png",@"奥迪A8",@"特斯拉Model S",@"特斯拉Model S白"];
        [imageArray2 addObjectsFromArray:array];
        NSArray *array2 = @[@"宝马-5系",@"宝马-5系",@"奥迪-A6L",@"奔驰-E级",@"宝马-7系",@"宝马-7系",@"奔驰-S级",@"奥迪-A8L",@"特斯拉-Model S",@"特斯拉-Model S"];
        [typeArray2 addObjectsFromArray:array2];
        NSArray *array3 = @[@"650",@"650",@"650",@"600",@"1500",@"1500",@"1500",@"1500",@"1500",@"1500"];
        [priceArray2 addObjectsFromArray:array3];
        NSArray *array5 = @[@"100",@"100",@"100",@"100",@"200",@"020",@"200",@"200",@"200",@"200"];
        NSArray *array6 = @[@"10",@"10",@"10",@"10",@"20",@"20",@"20",@"20",@"20",@"20"];
        NSArray *array77 = @[@"3",@"4",@"8",@"2",@"16",@"14",@"15",@"13",@"24",@"23"];
        [genche_listArray addObjectsFromArray:array77];
        [chaoshiArray2 addObjectsFromArray:array5];
        [chaoKMArray2 addObjectsFromArray:array6];
        for (int j = 0; j < array77.count; j ++) {
            
            int a = [array77[j] intValue];
            [intArray2 addObject:downArray[a][@"zan"]];
        }
        
        carColor1 = @"白色";
    }
    
    [self createFollowCar];
    
    carType1 = typeArray[i];
    carPrice1 = priceArray[i];
    zhuchePrice1 = chaoshiArray[i];
    zhuchePrice2 = chaoKMArray[i];
}
- (void)sendtype:(NSString *)str price:(NSString *)pri color:(NSString *)col price1:(NSString *)price1 price2:(NSString *)price2{
    
    bPrice = 1;
    carType2  = str;
    carPrice2 = pri;
    carColor2 = col;
    genchePrice1 = price1;
    genchePrice2 = price2;
}
#pragma mark - 评价
- (void)openPingjia:(NSString *)str carid:(NSString *)carID{
    
    _carID = carID;
    _carLeixing = str;
    [self createTableView];
    
//    CarTypePingjia *view = [[CarTypePingjia alloc] init];
//    
//    view.cartype = str;
//    int a = [carID intValue];
//    NSString *carid1 = zhuche_listArray[a];
//    view.carId = carid1;
//    
//    [self.navigationController pushViewController:view animated:YES];
}
- (void)openPingjia2:(NSString *)str carid2:(NSString *)carID{
    
    _carID = carID;
    _carLeixing = str;
    [self createTableView];
    
//    [self downLoadTableViewData];
//    CarTypePingjia *view = [[CarTypePingjia alloc] init];
//    
//    view.cartype = str;
//    
//    NSString *carid1 = genche_listArray[[carID intValue]];
//    view.carId = carid1;
//    
//    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - WYJAlertView
- (void)queding{
    
    DingdanViewC *view = [[DingdanViewC alloc] init];
    
//    if (aPrice == 0) {
//
//        view.zhucartype = @"宾利-慕尚";
//        view.zhucarPrice = @"8800";
//        view.zhucarColor = @"黑色";
//        view.zhuchePrice1 = @"1000";
//        view.zhuchePrice2 = @"100";
//        view.zhucheid = @"15";
//    }else{
//
//        view.zhucartype = carType1;
//        view.zhucarPrice = carPrice1;
//        view.zhucarColor = carColor1;
//        view.zhuchePrice1 = zhuchePrice1;
//        view.zhuchePrice2 = zhuchePrice2;
//        view.zhucheid = zhucheCarid;
//    }
    view.zhucartype = carType1;
    view.zhucarPrice = carPrice1;
    view.zhucarColor = carColor1;
    view.zhuchePrice1 = zhuchePrice1;
    view.zhuchePrice2 = zhuchePrice2;
    view.zhucheid = zhucheCarid;
    
    view.genCartype = carType2;
    view.genCarprice = carPrice2;
    view.genCarcolor = carColor2;
    view.genchePrice1 = genchePrice1;
    view.genchePrice2 = genchePrice2;
    view.gencheid = gencheCarid;
    
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
- (void)quxiao{
    
    [alertView removeFromSuperview];
}
#pragma mark - 上下问号说明
- (void)upWenhao:(UIButton *)sender{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 10086;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.tag = 8009;
    view2.frame = CGRectMake(width*0.05, height/2-width*0.395, width*0.9, width*0.79);
    view2.backgroundColor = [UIColor whiteColor];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    [view1 addSubview:view2];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view2.frame)-width*0.22, view2.frame.size.height-width*0.15, width*0.12, width*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
    
    UITapGestureRecognizer *regis = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll:)];
    [view1 addGestureRecognizer:regis];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(width*0.035, width*0.035, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.055, width*0.17, view2.frame.size.width, view2.frame.size.width/2)];
    image.image = [UIImage imageNamed:@"套餐说明图(2).png"];
    [view2 addSubview:image];
}

- (void)xiaoshi{
    
//    NSLog(@"%f",281.5/width);
    
    UIView *view = [self.view.window viewWithTag:11111];
    [GiFHUD dismiss];
    [view removeFromSuperview];
}
- (void)removeAll:(UIView *)view{
    
    UIView *view1 = [self.view viewWithTag:10086];
     [GiFHUD dismiss];
    [view1 removeFromSuperview];
}
#pragma mark - 未登录提示框
- (void)createView{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 10086;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width/2-width*0.4, height/2-width*0.2, width*0.8, width*0.32)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UILabel *wenti = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.05, view2.frame.size.width*0.9, width*0.1)];
    wenti.text = @"还未登陆，是否登陆?";
    wenti.textColor = Color(157, 157, 157);
    wenti.textAlignment = NSTextAlignmentCenter;
    wenti.font = [UIFont fontWithName:@"ArialMT" size:18];
    [view2 addSubview:wenti];
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(wenti.frame)+width*0.05, view2.frame.size.width*0.9, 1)];
    xian1.backgroundColor = Color(237, 237, 237);
    [view2 addSubview:xian1];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(view2.frame.size.width/2, CGRectGetMaxY(xian1.frame)+width*0.01, view2.frame.size.width/2, width*0.1);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    UIColor *color1 = Color(187, 187, 187);
    UIColor *color2 = Color(7, 187, 177);
    [queding setTitleColor:color2 forState:UIControlStateNormal];
    [view2 addSubview:queding];
    [queding addTarget:self action:@selector(quedingClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *quxiao = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiao.frame = CGRectMake(0, CGRectGetMaxY(xian1.frame)+width*0.01, view2.frame.size.width/2, width*0.1);
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:color1 forState:UIControlStateNormal];
    [view2 addSubview:quxiao];
    [quxiao addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width/2, CGRectGetMaxY(xian1.frame)+width*0.025, 1, width*0.05)];
    xian2.backgroundColor = Color(237, 237, 237);
    [view2 addSubview:xian2];
}
- (void)quedingClick{
    
    UIView *view1 = [self.view viewWithTag:10086];
     [GiFHUD dismiss];
    [view1 removeFromSuperview];
    
    LoginView *view = [[LoginView alloc] init];
    
//    view.hidesBottomBarWhenPushed = YES;
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.3;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.type = @"Fade";
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:view animated:NO];
}
- (void)quxiaoClick{
    
    UIView *view1 = [self.view viewWithTag:10086];
    [GiFHUD dismiss];
    [view1 removeFromSuperview];
}
#pragma mark - 优惠券的tableView
- (void)downLoadWithViewFrame:(UIView *)view{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [view addSubview:_tableView];
    _tableView.scrollEnabled = YES;
    
    _tableView.tableFooterView = [UIView new];
    [GiFHUD dismiss];
}

- (void)createTableView{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 11111;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width/2-width*0.45, width*0.05, width*0.9, height-width*0.1)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UIView *view111 = [GiFHUD new];
    [GiFHUD setGifWithImageName:@"动态gif.gif"];
    [GiFHUD show];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(width*0.035, width*0.035, width*0.1, width*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(xiaoshi) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cuowu.frame)+width*0.02, view2.frame.size.width, view2.frame.size.height-width*0.15)];
    view3.backgroundColor = [UIColor whiteColor];
    [view2 addSubview:view3];
    
    NSDictionary *dict = [NSDictionary dictionary];
    if ([_carLeixing intValue] == 1) {
        
        dict = @{@"zid":_carID};
    }
    if ([_carLeixing intValue] == 2) {
        
        dict = @{@"gid":_carID};
    }
    [HttpManager postData:dict andUrl:PJUrl success:^(NSDictionary *fanhuicanshu) {
        
        _PingJiaArray = fanhuicanshu[@"pj_list"];
        _PJ = fanhuicanshu[@"count"];
        _STAR = fanhuicanshu[@"zong_xing"];
//        [self performSelector:@selector(downLoadWithViewFrame:) withObject:view111 afterDelay:0.5];
        
        [self downLoadWithViewFrame:view3];
        [_tableView reloadData];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _PingJiaArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *string = _PingJiaArray[indexPath.row][@"pj_content"];
    
    CGFloat height1 = [string boundingRectWithSize:CGSizeMake(ScreenWidth*0.81, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size.height;
    
    CGFloat wid = ScreenWidth *0.9;
    
    return height1 + wid*0.05*4 +0.15*wid + wid*0.2*2/3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stac = @"stack";
    PjDemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stac];
    if (!cell) {
        
        cell = [[PjDemoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stac];
    }
    
    cell.model = _PingJiaArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headVCiew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, width*0.2)];
    headVCiew.backgroundColor = [UIColor whiteColor];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, 0, width*0.9, width*0.1)];
    numberLabel.text = [NSString stringWithFormat:@"%d条评价",(int)_PingJiaArray.count];
    numberLabel.font = [UIFont boldSystemFontOfSize:25];
    numberLabel.textColor = Color(107, 107, 107);
    [headVCiew addSubview:numberLabel];
    
    float x = [_STAR doubleValue];
    
    _wsStraRating = [[WSStarRatingView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(numberLabel.frame)+width*0.05/4, 0.085*ScreenHeight*1.7, 0.02*ScreenHeight*1.5) numberOfStar:5];
    [headVCiew addSubview:_wsStraRating];
    
    _starLabel = [[UILabel alloc] initWithFrame: CGRectMake(CGRectGetMaxX(_wsStraRating.frame)+10, CGRectGetMaxY(numberLabel.frame)+width*0.05/4, 0.085*ScreenHeight, 0.03*ScreenHeight)];
    _starLabel.adjustsFontSizeToFitWidth = YES;
    _starLabel.textColor = Color(107, 107, 107);
    _starLabel.font = [UIFont systemFontOfSize:18];
    [headVCiew addSubview:_starLabel];
    
    __block MarriedCar *NeedSelf = self;
    _wsStraRating.delegate = NeedSelf;
    [_wsStraRating setScore:x/5 withAnimation:YES completion:^(BOOL finished) {
        NeedSelf.starLabel.text = [NSString stringWithFormat:@"%0.1f",x/5 * 5 ];
    }];
    
    return headVCiew;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return width*0.19;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
