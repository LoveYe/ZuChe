//
//  IncomeStatementViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/10.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "IncomeStatementViewController.h"
#import "AllPages.pch"
#import "ISTableViewCell.h"
@interface IncomeStatementViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation IncomeStatementViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    UIWebView*webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-44)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zuche.ztu.wang/index.php?index&a=mingxi&userid=%@&mobile=%@",[ZCUserData share].userId,[ZCUserData share].mobile]]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
    
    
    UIButton *btn =[UIButton buttonWithType: UIButtonTypeSystem];
    btn.frame =CGRectMake(ScreenWidth *0.05,0, 64, 64);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [webView addSubview:btn];

}
-(void)btnClick
{
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
