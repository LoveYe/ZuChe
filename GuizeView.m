//
//  GuizeView.m
//  ZuChe
//
//  Created by apple  on 2017/6/9.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "GuizeView.h"
#import "GiFHUD.h"
#import "Header.h"

@interface GuizeView ()

@end

@implementation GuizeView

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    title.text = @"平台规则";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = title;
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 25, 25);
    [left setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = rightBarButton;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = leftBarButton;
    
    [self createWebView];
}
- (void)createWebView{
    
    UIWebView*webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight+64)];
    webView.scrollView.bounces=NO;
    [self.view addSubview: webView];
    
    [GiFHUD setGifWithImageName:@"动态gif.gif"];
    [GiFHUD showWithOverlay];
    NSString *urlString=[[NSString alloc]init];
    
    urlString=[NSString stringWithFormat:@"%@index.php?m=content&c=index&a=lists&catid=44",NowUrl];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
    [GiFHUD dismiss];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
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
