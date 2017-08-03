//
//  XieYiViewController.m
//  ZuChe
//
//  Created by J.X.Y on 16/1/29.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "RankViewController.h"
#import "AllPages.pch"
@interface RankViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@end

@implementation  RankViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"信用累计"];
    UIWebView*webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height(64))];
    webView.scrollView.bounces=NO;
    [self.view addSubview: webView];
    
    if ([ZCUserData share].isLogin) {
        
        [GiFHUD setGifWithImageName:@"加载动画.gif"];
        [GiFHUD showWithOverlay];
            NSString *urlString =[NSString stringWithFormat:@"%@index.php?m=content&c=index&a=dengji&userid=%@",NowUrl,[ZCUserData share].userId];
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
            
        [GiFHUD dismiss];
    }else
    {
        
        
        UILabel *  tishi23 =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2, ScreenWidth*0.55, ScreenWidth*0.2)];
        tishi23.numberOfLines =0;
        tishi23.textAlignment =NSTextAlignmentCenter;
        [self label:tishi23 isBold:YES isFont:14];
        tishi23.textColor=Color(99,99, 99);
        tishi23.text= @"请先登录才能分享！";
        [webView addSubview:tishi23];
        
        UIImageView *   imageView23 =[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-ScreenWidth*0.30)/2,150, ScreenWidth*0.30,ScreenWidth*0.30)];
        imageView23.image =[UIImage imageNamed:@"大图"];
        [webView addSubview:imageView23];
        
        
        
    }
    
    
    
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
