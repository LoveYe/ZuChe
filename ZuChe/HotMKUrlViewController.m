//
//  HotMKUrlViewController.m
//  ZuChe
//
//  Created by MacBookXcZl on 2017/6/9.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "HotMKUrlViewController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"

@interface HotMKUrlViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong)WKWebView *wkWebView;

@end

@implementation HotMKUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.wkWebView.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIButton *goback = [UIButton buttonWithType:UIButtonTypeCustom];
    goback.frame = CGRectMake(0, 0, 25, 25);
    [goback setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [goback addTarget:self action:@selector(gobackTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:goback];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    
}
- (void)gobackTo{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] init];
        _wkWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64);
        _wkWebView.navigationDelegate = self;
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]]]];
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

//接收到服务器跳转请求之后调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
}

//开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"开始加载");
}
//当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
      [MBProgressHUD hideHUDForView:self.view animated:YES];
}
//页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    
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
