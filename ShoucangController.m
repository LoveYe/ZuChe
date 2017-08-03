//
//  ShoucangController.m
//  ZuChe
//
//  Created by apple  on 16/12/14.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "ShoucangController.h"
#import "Header.h"
#import "RootViewcontroller.h"

@interface ShoucangController(){
    
    CGFloat width;
}

@end

@implementation ShoucangController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    width = self.view.frame.size.width;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    title.text = @"收藏";
    title.textColor = Color(107, 107, 107);
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = title;
    
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(20, 40, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(kaishi:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"无收藏.jpg"];
    image.userInteractionEnabled = YES;
    [self.view addSubview:image];
    
    UILabel *da = [[UILabel alloc] initWithFrame:CGRectMake(width*0.7, width*0.3, width*0.2, width*0.1)];
    da.text = @"收藏";
    da.textAlignment = NSTextAlignmentRight;
    da.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:35];
    da.textColor = [UIColor whiteColor];
    [image addSubview:da];
    
    UILabel *xiao = [[UILabel alloc] initWithFrame:CGRectMake(width*0.3, CGRectGetMaxY(da.frame)+20, width*0.6, width*0.1)];
    xiao.text = @"您还没有收藏任何车辆";
    xiao.textColor = [UIColor whiteColor];
    xiao.textAlignment = NSTextAlignmentRight;
    xiao.font = [UIFont fontWithName:@"AmericanTypewriter" size:20];
    [image addSubview:xiao];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-width*0.13-64, width, width*0.13);
    button.backgroundColor = Color(0, 215, 200);
    [button setTitle:@"开始探索" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(kaishi:) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:button];
    

//    [image addSubview:fanhui];
}
- (void)kaishi:(UIButton *)sender{
    
    RootViewcontroller *view = [[RootViewcontroller alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = view;
}


@end
