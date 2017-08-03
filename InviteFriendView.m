//
//  InviteFriendView.m
//  ZuChe
//
//  Created by apple  on 16/11/8.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "InviteFriendView.h"
#import "AllPages.pch"

@interface InviteFriendView ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    //    ParentsViewController *_view;
}
@end

@implementation InviteFriendView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    _view = [ParentsViewController new];
    
    self.title = @"邀请好友";
    
    if ([ZCUserData share].isLogin) {
//        UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
//        [rightbutton setTitle:@"分享" forState:UIControlStateNormal];
//        [rightbutton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
//        //        [_view addItemWithCustomView:@[rightbutton] isLeft:NO];
//        
//        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
//        self.navigationItem.rightBarButtonItem = rightBarItem;
    }
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight+64)];
    
    webView.scrollView.bounces=NO;
    [self.view addSubview: webView];
    
    if ([ZCUserData share].isLogin) {
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.mode=MBProgressHUDModeIndeterminate;
        HUD.removeFromSuperViewOnHide=YES;
        HUD.labelText = @"正在加载数据...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            NSString *urlString =[NSString stringWithFormat:@"%@index.php?m=content&c=index&a=yaoqingma&userid=%@",NowUrl,[ZCUserData share].userId];
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
        }completionBlock:^{
            
        }];
    }else{
        
        UILabel *  tishi23 =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2, ScreenWidth*0.55, ScreenWidth*0.2)];
        tishi23.numberOfLines =0;
        tishi23.textAlignment =NSTextAlignmentCenter;
        //            [_view label:tishi23 isBold:YES isFont:14];
        tishi23.textColor=Color(99,99, 99);
        tishi23.text= @"请先登录才能分享！";
        [webView addSubview:tishi23];
        
        UIImageView *   imageView23 =[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-ScreenWidth*0.30)/2,150, ScreenWidth*0.30,ScreenWidth*0.30)];
        imageView23.image =[UIImage imageNamed:@"大图"];
        [webView addSubview:imageView23];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor=[UIColor whiteColor];
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
-(void)share:(UIButton *)sender
{
    //    NSString *urlString =[NSString stringWithFormat:@"%@index.php?m=content&c=index&a=yaoqingma&userid=%@",NowUrl,[ZCUserData share].userId];
    //    NSLog(@"分享链接：%@",urlString);
//    NSString *sharetext=@"闲车分享邀请好友码，感谢你对闲车的支持送上一个邀请码邀请您的好友一起体验“闲车”";
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"56ea243767e58e883800110d"
//                                      shareText:sharetext
//                                     shareImage:[UIImage imageNamed:@"分享显示icon.jpg"]
//                                shareToSnsNames:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSms]
//                                       delegate:self];
}
//实现回调方法（可选）：
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}

@end
