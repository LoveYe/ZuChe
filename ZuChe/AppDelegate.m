//
//  AppDelegate.m
//  ZuChe
//
//  Created by 佐途 on 15/10/20.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

//#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>
#import <MapKit/MapKit.h>
#import "XQyemianViewController.h"
#import "AllPages.pch"
#import <AlipaySDK/AlipaySDK.h>
#import "HomePageViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "RootViewcontroller.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//
#import "HttpManager.h"
#import "ItineraryViewController.h"
#import "SecondTabbar.h"
//#import "UMSocial.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import <UserNotifications/UserNotifications.h>

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


#import "RCDataManager.h"
#import <RongIMKit/RongIMKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>


//#import "LaunchViewController.h"
@interface AppDelegate ()<CLLocationManagerDelegate,MKReverseGeocoderDelegate,ABPeoplePickerNavigationControllerDelegate,JPUSHRegisterDelegate>
{
    BMKMapManager* _mapManager;
    ABPeoplePickerNavigationController *_abPeoplePickerVc;
}


@property (nonatomic,retain) CLLocationManager*locationManager;
@property (nonatomic, readonly) NSDictionary *addressDictionary;
@property (nonatomic , retain)UIImageView *imageView;
 
@end

@implementation AppDelegate
@synthesize backgroundTaskIdentifier;
@synthesize myTimer;


-(void)initRongClould{
    // 初始化 SDK，传入 AppKey
    self.friendsArray = [[NSMutableArray alloc]init];
    self.groupsArray = [[NSMutableArray alloc]init];
    [[RCIM sharedRCIM] initWithAppKey:@"kj7swf8ok47u2"];
    //设置用户信息提供者为 [RCDataManager shareManager]
    [RCIM sharedRCIM].userInfoDataSource = [RCDataManager shareManager];
    //设置群组信息提供者为 [RCDataManager shareManager]
    [RCIM sharedRCIM].groupInfoDataSource = [RCDataManager shareManager];
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    //[[RCIM sharedRCIM]registerMessageType:WMVideoMessage.class];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return  [WXApi handleOpenURL:url delegate:[XQyemianViewController sharedManager]];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSDictionary *dict = @{@"payString":resultDic};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayResult" object:nil userInfo:dict];
        }];
    }
    if ([url.host isEqualToString:@"pay"]) {
        
        [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}
- (void)setDefaultDisplayController{
    
    //            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    //            imageView.image = [UIImage imageNamed:@"开始.png"];
    
    [UIView animateWithDuration:3 animations:^{
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
        self.imageView.image = [UIImage imageNamed:@"开始.png"];
        [self.window addSubview:self.imageView];
    } completion:^(BOOL finished) {
        
        [self.imageView removeFromSuperview];
    }];
}

//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    
//    NSLog(@"url.host:%@",url.host);
//    
////    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    
////    if (result == FALSE) {
////       
////    }
//    
//    if ([url.host isEqualToString:@"safepay"]) {
//        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            
//            NSLog(@"result = %@",resultDic);
//        }];
//    }if ([url.host isEqualToString:@"pay"]) {
//        [WXApi handleOpenURL:url delegate:self];
//    }
//    return YES;
//}
#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
                
            case WXSuccess: {
                
                [self WxPayOver];
                break;
            }
            default: {
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"faill"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                break;
            }
        }
    }
}
- (void)WxPayOver{
    
    NSDictionary *zhifudict = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhifu"];
    
    if ([zhifudict[@"zhifu_fenduan"]  isEqualToString:@"1"]) {
        
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:zhifudict[@"userid"],@"userid",zhifudict[@"id"],@"id",@"1",@"trade_no",@"1",@"total_fee",@"微信",@"types", nil];
        
        [HttpManager postData:dict1 andUrl:@"http://wx.leisurecarlease.com/tc.php?op=zhifudingjin" success:^(NSDictionary *fanhuicanshu) {
            
        } Error:^(NSString *cuowuxingxi) {
            
        }];
        
    }else if ([zhifudict[@"zhifu_fenduan"]  isEqualToString:@"2"]){
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:zhifudict[@"userid"],@"userid",zhifudict[@"id"],@"id",@"1",@"trade_no",@"1",@"total_fee",@"微信",@"types", nil];
        
        
        [HttpManager postData:dict1 andUrl:@"http://wx.leisurecarlease.com/tc.php?op=zhifuweikuan" success:^(NSDictionary *fanhuicanshu) {
            
        } Error:^(NSString *cuowuxingxi) {
            
        }];
        
    }else {
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:zhifudict[@"userid"],@"userid",zhifudict[@"id"],@"id",@"1",@"trade_no",@"1",@"total_fee",@"微信",@"types", nil];
        
        [HttpManager postData:dict1 andUrl:@" http://wx.leisurecarlease.com/tc.php?op=zhifuchaoshifei" success:^(NSDictionary *fanhuicanshu) {
            
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }
    
}

#pragma mark - BaiduMap
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    // 极光推送
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    // 判断版本号
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"bd3f4b07a8156a0bf7c661ee"
                          channel:@"AppStore"
                 apsForProduction:1
            advertisingIdentifier:advertisingId];
    
    //百度地图
    [[NSUserDefaults standardUserDefaults] setObject:@"上海" forKey:@"dingweicity"];
    
    _mapManager = [[BMKMapManager alloc]init];
    _abPeoplePickerVc = [[ABPeoplePickerNavigationController alloc] init];
    
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    //LaKYKit40Rx4czaXOgMTxnFr 测试用这个
    //s7wfB7ixMWa64jnLv0vfjuMb 上架用这个
    
    BOOL ret = [_mapManager start:@"s7wfB7ixMWa64jnLv0vfjuMb"  generalDelegate:nil];
    
    if (!ret) {//
        
        NSLog(@"manager start failed!");
    }
    else{
        
        NSLog(@"成功");
    }
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        if ([CLLocationManager locationServicesEnabled]) {
            
            self.locationManager = [[CLLocationManager alloc] init];
            
            _locationManager.delegate = self;
            
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest; //控制定位精度,越高耗电量越大。
            
            _locationManager.distanceFilter = 100; //控制定位服务更新频率。单位是“米”
            
            [_locationManager startUpdatingLocation];
            
            //在ios 8.0下要授权
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
                
                //调用了这句,就会弹出允许框了.
                [_locationManager requestWhenInUseAuthorization];
                
//                _abPeoplePickerVc.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];;
                
            }
        }
    
//    });
//    NSLog(@"--------------------%@",[NSDate date]);
    
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    BOOL isOpen = [ud boolForKey:@"isOpen"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent ;
    
    if (isOpen == 0) {
        
        //NO表示程序没有打开过 ，程序是第一次执行
        
        self.tabbarVC = [[RootViewcontroller alloc]init];
        self.window.rootViewController = self.tabbarVC;
        self.tabbarVC.tabBar.backgroundColor = Color(255, 255, 255);
    }else {
        
        //程序不是第一次执行
        
        NSString *str= [ud objectForKey:@"nayiduan"];
        
        if ([str intValue] == 5002) {
            
            self.tabbarVC = [[RootViewcontroller alloc]init];
            self.window.rootViewController = self.tabbarVC;
            self.tabbarVC.tabBar.backgroundColor = Color(255, 255, 255);
        }
        if ([str intValue] == 5001) {
            
            self.secTabbarVC = [[SecondTabbar alloc] init];
            self.window.rootViewController = self.secTabbarVC;
            self.tabbarVC.tabBar.backgroundColor = Color(77, 77, 77);
        }if ([str isEqualToString:@""]|| str == nil) {
            
            self.tabbarVC  = [[RootViewcontroller alloc]init];
            self.window.rootViewController = self.tabbarVC;
            self.tabbarVC.tabBar.backgroundColor = Color(255, 255, 255);
        }
    }
    
    //程序已经执行过那么就本地保存下
    [ud setBool:YES forKey:@"isOpen"];
    [ud synchronize];
    
    [self initRongClould];
    
    [AMapServices sharedServices].apiKey = @"0acc3816d905c45945121762574b9059";
    
    //短信用的
    [SMSSDK registerApp:@"1bf9b5a7ebc0e" withSecret:@"5804727a02c6896884e6a57fee5a344c"];
    
    //向微信注册wx76ba3f6829e8f283  微信支付用的
    [WXApi registerApp:@"wx696a2e670848549b"];
    
    //*******************************友盟*************************//
    //友盟AppKey
//    [UMSocialData setAppKey:@"56ea243767e58e883800110d"];
    
    NSString *urlString = [[NSString alloc]init];
    
    if ([ZCUserData share].isLogin) {
         urlString =[NSString stringWithFormat:@"%@index.php?m=content&c=index&a=yaoqingma&userid=%@",NowUrl,[ZCUserData share].userId];
    }else
    {
        urlString=@"www.baidu.com";
    }
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
//    [UMSocialWechatHandler setWXAppId:@"wx76ba3f6829e8f283" appSecret:@"2274f47a8c4f8b338582f60282314f17" url:urlString];
    
    // 打开新浪微博的SSO开关
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1587353750"
//                                              secret:@"e74468fc854503bd65147de7f4cdedb6"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //    //设置分享到QQ空间的应用Id，和分享url 链接@"http://www.umeng.com/social"
//    [UMSocialQQHandler setQQWithAppId:@"1105261302" appKey:@"N6H3F8JuVqJde1rI" url:urlString];
//    
//    //    //设置支持没有客户端情况下使用SSO授权
//    [UMSocialQQHandler setSupportWebView:YES];
//    
//     //隐藏没有安装的第三方客户端~新浪微博比较恶心没有客户端也会显示，我直接不用新浪了
//    [UMSocialConfig hiddenNotInstallPlatforms:nil];
    
    //******************************友盟到此结束*******************//
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
#pragma mark - 极光接收 注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark - 实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark - JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}



//- (void)launchInto{
//    LaunchViewController *launch = [[LaunchViewController alloc]init];
//    [self.window addSubview:launch.view];
//}
/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
//    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSInteger ToatalunreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
    [UIApplication sharedApplication].applicationIconBadgeNumber = ToatalunreadMsgCount;
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    
    
//    [NSString stringWithFormat:@"经度%f",manager.location.coordinate.longitude];
//    [NSString stringWithFormat:@"纬度%f",manager.location.coordinate.latitude];
//    NSLog(@"经度 = %f", manager.location.coordinate.longitude);
//    NSLog(@"维度 = %f", manager.location.coordinate.latitude);
//
//    [_locationManager stopUpdatingLocation];
//    
//    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
//    [geoCoder reverseGeocodeLocation:manager.location completionHandler:^(NSArray *placemarks, NSError *error) {
//        for (CLPlacemark * placemark in placemarks) {
//            NSDictionary *test = [placemark addressDictionary];
//            //  Country(国家)  State(城市)  SubLocality(区)
//            //            NSLog(@"%@", [test objectForKey:@"Country"]);
//            
//            NSLog(@"定位成功===%@", [test objectForKey:@"State"]);
//            //            NSLog(@"%@", [test objectForKey:@"SubLocality"]);
//            //            NSLog(@"%@", [test objectForKey:@"Street"]);
//            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[test objectForKey:@"State"]] forKey:@"dingweicity"];
//        }
//    }];
//    //方法2:成功定位(推荐不要用这个)
//    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(manager.location.coordinate.latitude,manager.location.coordinate.longitude);//纬度，经度
//    MKReverseGeocoder *geocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coords];
//    geocoder.delegate = self;
//    [geocoder start];
}
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
//{
//    NSLog(@"方法2:成功定位(推荐不要用这个)=%@",placemark.locality );
//    NSString*dingwei=[NSString stringWithFormat:@"%@",placemark.locality];
//    NSArray *ar=[dingwei componentsSeparatedByString:@"市"];
//    NSString *ddd=[NSString stringWithFormat:@"%@",ar[0]];
//    [[NSUserDefaults standardUserDefaults] setObject:ddd forKey:@"dingweicity"];
//}
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
//}
+ (AppDelegate* )shareAppDelegate {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
@end
