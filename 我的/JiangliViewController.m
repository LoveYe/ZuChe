//
//  JiangliViewController.m
//  ZuChe
//
//  Created by J.X.Y on 16/3/9.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "JiangliViewController.h"
#import "AllPages.pch"
@interface JiangliViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@end

@implementation JiangliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"奖励中心"];
    self.view.backgroundColor=[UIColor whiteColor];
    UIWebView*webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height(64))];
    webView.scrollView.bounces=NO;
    [self.view addSubview: webView];
    [GiFHUD setGifWithImageName:@"加载动画.gif"];
    [GiFHUD showWithOverlay];
    
    
        if ([ZCUserData share].isLogin) {
            NSString *urlString =[NSString stringWithFormat:@"%@index.php?m=content&c=index&a=lists&catid=42",NowUrl];
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
        }else
        {
            
            LoginView *log=[[LoginView alloc]init];
            [self.navigationController pushViewController:log animated:YES];
            [self xiaojiadeTishiTitle:@"请先登录"];
        }
        
        
  [GiFHUD dismiss];
}

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
