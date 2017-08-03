//
//  AboutUsView.m
//  ZuChe
//
//  Created by apple  on 2017/6/9.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "AboutUsView.h"
#import "Header.h"
#import "ParentsViewController.h"
#import "CoreMediaFuncManagerVC.h"

@interface AboutUsView ()<UIActionSheetDelegate>{
    
    ParentsViewController *view11;
}

@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIImageView*erweimaimageView;

@end

@implementation AboutUsView
-(void)viewWillAppear:(BOOL)animated
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
    // Do any additional setup after loading the view.
    view11 = [[ParentsViewController alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    title.text = @"关于我们";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = Color(107, 107, 107);
    title.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = title;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.1,60, ScreenWidth*0.8, ScreenWidth*0.8)];
    image.image =[UIImage imageNamed:@"LOGO粉.png"];
    [self.view addSubview:image];
    
    UIButton *pingjia = [UIButton buttonWithType:UIButtonTypeCustom];
    pingjia.frame = CGRectMake(ScreenWidth/2-ScreenWidth*0.3, CGRectGetMaxY(image.frame)-20, ScreenWidth*0.6, ScreenWidth *0.1);
    [pingjia setTitle:@"前往App Store评分" forState:UIControlStateNormal];
    UIColor *color = Color( 157, 157, 157);
    [pingjia addTarget:self action:@selector(pingfen) forControlEvents:UIControlEventTouchUpInside];
    [pingjia setTitleColor:color forState:UIControlStateNormal];
    [pingjia setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:pingjia];
    
    UIImageView *erweima = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.135, CGRectGetMaxY(pingjia.frame)+ScreenWidth*0.14, ScreenWidth*0.27, ScreenWidth*0.27)];
    erweima.image = [UIImage imageNamed:@"公众号.png"];
    erweima.alpha = 0.8;
    [self.view addSubview:erweima];
    
    UILabel *gongzhonghao = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(erweima.frame)+ScreenWidth*0.005, ScreenWidth, ScreenWidth*0.08)];
    gongzhonghao.text = @"公众号";
    gongzhonghao.textColor = Color(218, 94, 120);
    gongzhonghao.textAlignment = NSTextAlignmentCenter;
    gongzhonghao.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:gongzhonghao];
    
    UIButton *label = [UIButton buttonWithType:UIButtonTypeCustom];
    label.frame = CGRectMake(ScreenWidth/2-ScreenWidth*0.275, CGRectGetMaxY(gongzhonghao.frame)+ScreenWidth*0.08, ScreenWidth*0.55, ScreenWidth*0.07);
    UIColor *pink = Color(218, 94, 120);
    label.backgroundColor = pink;
    [label setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [label setTitle:@"匠人之心-专注豪华车租赁" forState:UIControlStateNormal];
    label.titleLabel.adjustsFontSizeToFitWidth = YES;
    label.layer.cornerRadius = ScreenWidth*0.035;
    label.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
    UILabel *compinity = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.1, ScreenWidth*0.8, ScreenWidth*0.1)];
    compinity.text = @"上海黄森信息技术有限公司";
    compinity.textColor = Color(157, 157, 157);
    compinity.textAlignment = NSTextAlignmentCenter;
    compinity.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:compinity];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pingfen{
    
    NSString *appstoreUrlString = [NSString stringWithFormat:
                                   @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",
                                   @"1092600640" ];
    
    NSURL * url = [NSURL URLWithString:appstoreUrlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        
        [[UIApplication sharedApplication]openURL:url];
    }
    else
    {
        NSLog(@"can not open");
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
