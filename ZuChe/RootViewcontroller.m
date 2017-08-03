//
//  RootViewcontroller.m
//  Damai
//
//  Created by qianfeng01 on 15-1-20.
//  Copyright (c) 2015年 BSL. All rights reserved.
//
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define Height(H) (H)/320.0*ScreenWidth
#define Font(F) [UIFont fontWithName:@"STHeitiSC-Light" size:(F)/320.0*ScreenWidth]
#define Color(a,b,c)  [UIColor colorWithRed:a/255.0 green:b/255.0  blue:c/255.0  alpha:1.0];
#import "RootViewcontroller.h"
#import "ParentsViewController.h"
#import "MySelfViewController.h"
#import "ItineraryViewController.h"
#import "HomePageViewController.h"
#import "UserMineController.h"
#import "ArticalView.h"
#import "NewsPageConreoller.h"
#import "UserNewViewController.h"
#import "WMConversationListViewController.h"

#import "NewController.h"

@interface RootViewcontroller (){
    
    UIImageView *_imageView;
}
@end
@implementation RootViewcontroller

//- (void)viewWillAppear:(BOOL)animated{
//    
//    UITabBar *tabbar = [UITabBar appearance];
//    tabbar.backgroundColor = Color(255, 255, 255);
//    tabbar.translucent = NO;
//}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self creatViewControllers];
    self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    NSInteger a = tabBarController.selectedIndex;
    _imageView.frame = CGRectMake(a* w/4, 0, w/4, 49);
}
- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}

-(void)creatViewControllers{
    
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.backgroundColor = Color(255, 255, 255);
    tabbar.translucent = NO;
    
    NSArray *viewClass=@[@"HomePageViewController",@"ArticalView",@"WMConversationListViewController",@"UserNewViewController",@"UserMineController"];
    NSArray *titles=@[@"精选",@"发现",@"",@"行程",@"我的"];
    NSArray *imagesName=@[@"找车",@"行程",@"信息蓝",@"车主",@"我的"];
    NSMutableArray *controllers=[[NSMutableArray alloc]init];
    
    for (int i=0; i<viewClass.count; i++){
        
        UIViewController *vc;
        if (i==1) {
            
            vc=[[ArticalView alloc] init];
        }if (i==0) {
            
            vc=[[HomePageViewController alloc] init];
        }if (i == 2) {
            
            vc = [[WMConversationListViewController alloc] init];
        }
        if (i==3) {
            
            vc=[[UserNewViewController alloc] init];
        }if (i==4) {
            
            vc=[[UserMineController alloc] init];
        }
        UINavigationController *navC=[[UINavigationController alloc]initWithRootViewController:vc];
        
//        if (i>2) {
//            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
//            lable.textAlignment=NSTextAlignmentCenter;
//            lable.text=toptitles[i];
//            lable.font=[UIFont boldSystemFontOfSize:17];
//            lable.textColor=[UIColor whiteColor];
//            vc.navigationItem.titleView=lable;
//        }
        
        [vc.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"白背景.jpg"] forBarMetrics:UIBarMetricsDefault];
        navC.tabBarItem.title=titles[i];
        
        if (i == 2) {
            
            navC.tabBarItem.title = nil;
            navC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        }
        navC.tabBarItem.image = [[UIImage imageNamed:imagesName[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        if (i != 2) {
            
            navC.tabBarItem.selectedImage=[[UIImage imageNamed:@"点击后效果"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else{
            
            navC.tabBarItem.selectedImage=[[UIImage imageNamed:@"信息红"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        [controllers addObject:navC];
    }
    self.viewControllers = controllers;
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:(18)/255.0f green:(152)/255.0f blue:(233)/255.0f alpha:1]];
    
#pragma mark--将返回按钮的文字position设置不在屏幕上显示
    //自定义返回按钮
//    UIImage *backButtonImage = [[UIImage imageNamed:@"back_返回"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,Height(30), 0, 0)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //隐藏返回两个字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMax,self.view.bounds.size.width/4) forBarMetrics:UIBarMetricsDefault];
    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    UIView *veiw = [[UIView alloc] init];
//    veiw.backgroundColor = Color(255, 255, 255);
//    veiw.frame = self.tabBar.bounds;
//    [[UITabBar appearance] insertSubview:veiw atIndex:0];

//    UITabBar *tabbar = [UITabBar appearance];
//    [tabbar setBarTintColor:[UIColor whiteColor]];
//    tabbar.translucent = NO;
}
-(void)addTitleViewWithTitle:(NSString *)title{
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=title;
    lable.font =Font(22);
    lable.textColor=[UIColor whiteColor];
    self.navigationItem.titleView=lable;
}
@end
