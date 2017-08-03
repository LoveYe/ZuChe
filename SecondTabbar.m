//
//  SecondTabbar.m
//  ZuChe
//
//  Created by apple  on 16/11/7.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "SecondTabbar.h"

#import "MineController.h"
#import "NewController.h"
#import "PingjiaController.h"
#import "ShouyiController.h"
#import "XingchengController.h"

#import "MyAccountViewController.h"
#import "ZCUserData.h"
#import "HttpManager.h"
#import "Header.h"
//#import "RccChatViewController.h"
//
//#import "RcviewViewController.h"

#import "WMConversationListViewController.h"
#import "Header.h"

#define Height(H) (H)/320.0*ScreenWidth

@interface SecondTabbar ()
{
    NSMutableArray *countarray;
    NSDictionary *_dic;
    UINavigationController *myCarNavigation;
}
@end

@implementation SecondTabbar

//- (void)configureAPIKey
//{
//    if ([APIKey length] == 0)
//    {
//        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        
//        [alert show];
//    }
//    
//    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBar *tabbar = [UITabBar appearance];
    UIColor *color = Color(55, 60, 61);
    [tabbar setBarTintColor:color];
    tabbar.translucent = NO;
    tabbar.tintColor = Color(0, 215, 200);
    
    tabbar.selectionIndicatorImage = [UIImage imageNamed:@""];
    
    MineController *con1 = [MineController new];
    UINavigationController *mineNavigation = [[UINavigationController alloc] initWithRootViewController:con1];
    UITabBarItem *conTabbar = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"我的1"] tag:1];
    con1.tabBarItem = conTabbar;
    
    NewController *con2 = [NewController new];
    myCarNavigation = [[UINavigationController alloc] initWithRootViewController:con2];
    UITabBarItem *myCarTabbarItem = [[UITabBarItem alloc] initWithTitle:@"爱车" image:[UIImage imageNamed:@"爱车1"] tag:2];
    con2.tabBarItem = myCarTabbarItem;
    
    WMConversationListViewController *con3 = [WMConversationListViewController new];
    UINavigationController *pingjiaNavigation = [[UINavigationController alloc] initWithRootViewController:con3];
    con3.tabBarItem.image = [[UIImage imageNamed:@"信息蓝"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    con3.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    con3.navigationItem.title = @"消息中心";
    con3.tabBarItem.selectedImage = [[UIImage imageNamed:@"信息红"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ShouyiController *con4 = [ShouyiController new];
    UINavigationController *yueNavigation = [[UINavigationController alloc] initWithRootViewController:con4];
    UITabBarItem *yueItem = [[UITabBarItem alloc] initWithTitle:@"余额" image:[UIImage imageNamed:@"余额1"] tag:4];
    con4.tabBarItem = yueItem;
    con4.navigationItem.title = @"收益";
    
    XingchengController *con5 = [XingchengController new];
    UINavigationController *dingdanNavigation = [[UINavigationController alloc] initWithRootViewController:con5];
    UITabBarItem *dingdanItem = [[UITabBarItem alloc] init];
    dingdanItem.image = [UIImage imageNamed:@"订单1"];
    dingdanItem.title = @"订单";
    con5.tabBarItem = dingdanItem;
    con5.navigationItem.title = @"订单行程";
    
    self.viewControllers = @[myCarNavigation,yueNavigation,pingjiaNavigation,dingdanNavigation,mineNavigation];
    
}

@end
