//
//  MineController.m
//  ZuChe
//
//  Created by apple  on 16/11/7.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "MineController.h"
#import "MySelfViewController.h"
#import "RootViewcontroller.h"
#import "RankViewController.h"
#import "NewController.h"
#import "UserDetailView.h"
#import "LoginView.h"

#import "AllPages.pch"
#import "HelpmeViewController.h"
#import "InviteFriendView.h"
#import "FanKuiViewController.h"
#import "EmergencyContactViewController.h"
#import "RcviewViewController.h"

#import "GeRenZiLiaoViewController.h"
#import "SDWebImage/UIButton+WebCache.m"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "HttpManager.h"

#import "MyCollectionViewController.h"
#import "FankuiForUsView.h"
#import "AboutUsView.h"
#import "GuizeView.h"
#import "MineDetailView.h"
#import "CarRankViewController.h"

@interface MineController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    NSDictionary *_dic;
    NSMutableArray *countarray;
    UIView *vii;
    
    CGFloat width;
    CGFloat height;
    
    UIButton *_button;
    UILabel *_label;
    
    UIView *_alertView;
    UIView *bigView;
    UIButton *queding;
    UIButton *quxiao;
    
    UIButton *_djButton;
}

@end

@implementation MineController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
   //  self.tabBarController.tabBar.hidden = NO;
    
    if ([ZCUserData share].isLogin==NO) {
        
        [_button setBackgroundImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
        _label.text = @"你好";
        // 提示 是否登陆
        [self AlertView];
        
    }else{
        // 已经登录,获取个人信息
        AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSDictionary *parameters =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
        
        [manager POST:[NSString stringWithFormat:@"%@api.php?op=memberinfo",NowUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            _dic  =responseObject;
            
            //            NSLog(@"全是个人信息：%@",_dic);
            
            [[ZCUserData share]saveUserInfoWithUserId:[ZCUserData share].userId username:[ZCUserData share].username descriptions:[_dic objectForKey:@"description"] mobile:[_dic objectForKey:@"mobile"] fuwu:[_dic objectForKey:@"fuwu"] jiedan:[_dic objectForKey:@"jiedan"] lianxi:[_dic objectForKey:@"lianxi"] yinxiang:[_dic objectForKey:@"yinxiang"] nickname:[_dic objectForKey:@"nickname"] thumb:[_dic objectForKey:@"thumb"] tiqian:[_dic objectForKey: @"tiqian"] xing:[_dic objectForKey:@"xing"] xingqu:[_dic objectForKey:@"xingqu"] xueli:[_dic objectForKey:@"xueli"] zhiye:[_dic objectForKey:@"zhiye"] IsLogin:[ZCUserData share].isLogin];
            
            [_tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error%@",error);
        }];
        
    }
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    // 隐藏 navbar
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden = NO;
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    //
}
- (void)viewWillDisappear:(BOOL)animated{
    
    UIView *view = [self.view viewWithTag:10089];
    [view removeFromSuperview];
    //进入下一个界面的时候navbar 显示出来
    [self.navigationController setNavigationBarHidden:NO];
    //    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
//    _label = [[UILabel alloc] init];
//    _label.text = @"你好";
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    //    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTableView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    // 创建 tableView
    
    // 判断是否登陆
    if ([ZCUserData share].isLogin == YES)
    {
        //        NSLog(@"我已经登陆了");
        
        AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSDictionary *parameters =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
        
        [manager POST:[NSString stringWithFormat:@"%@api.php?op=memberinfo",NowUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            _dic = responseObject;
            
            NSLog(@"全是个人信息：%@",_dic);
            
            [[ZCUserData share]saveUserInfoWithUserId:[ZCUserData share].userId username:[ZCUserData share].username descriptions:[_dic objectForKey:@"description"] mobile:[_dic objectForKey:@"mobile"] fuwu:[_dic objectForKey:@"fuwu"] jiedan:[_dic objectForKey:@"jiedan"] lianxi:[_dic objectForKey:@"lianxi"] yinxiang:[_dic objectForKey:@"yinxiang"] nickname:[_dic objectForKey:@"nickname"] thumb:[_dic objectForKey:@"thumb"] tiqian:[_dic objectForKey: @"tiqian"] xing:[_dic objectForKey:@"xing"] xingqu:[_dic objectForKey:@"xingqu"] xueli:[_dic objectForKey:@"xueli"] zhiye:[_dic objectForKey:@"zhiye"] IsLogin:[ZCUserData share].isLogin];
            
            [_tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error%@",error);
        }];
        
    }else
    {
        [_tableView reloadData];
    }
}
- (void)createTableView{
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    _tableView.scrollEnabled = YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return width*0.58;
    }else
        
        return width*0.18;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *tabCell = @"cell";
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:tabCell];
    if (!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tabCell];
    }
    tableViewCell.selectionStyle = UITableViewCellStyleDefault;
    
    if (indexPath.row == 0) {
        
        UIView *view = [[UIView alloc] init];
        
        
        _button.frame = CGRectMake(width*0.05, width*0.1, width*0.18, width*0.18);
        
        //        _button.backgroundColor = [UIColor lightGrayColor];
        [_button addTarget:self action:@selector(xiugaiInf:) forControlEvents:UIControlEventTouchUpInside];
        
        // ************************************添加头像***************************
        NSString * srting =[NSString stringWithFormat:@"%@",[ZCUserData share].thumb];
        if ([srting isKindOfClass:[NSNull class]]||[srting isEqualToString:@""]||[srting isEqual:@""]) {
            
            [_button setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
        }else{
            
            [_button sd_setBackgroundImageWithURL:[NSURL URLWithString:srting] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"头像"]];
        }
        
        [_button.layer setMasksToBounds:YES];
        _button.layer.cornerRadius = width*0.092;
        
        [tableViewCell addSubview:_button];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(_button.frame)+width*0.1, CGRectGetWidth(self.view.frame), width*0.07)];
        _label.textColor = [UIColor grayColor];
        NSString *strack = [NSString stringWithFormat:@"%@",[ZCUserData share].nickname];
        
        if ([strack isEqualToString:@""]||[strack isEqualToString:@"(null)"]||strack == nil) {
            
            _label.text = @"你好";
        }else{
            
            _label.text = [NSString stringWithFormat:@"你好，%@",strack];
        }
        _label.font = [UIFont systemFontOfSize:32];
        _label.textColor = Color(77, 77, 77);
        [view addSubview:_label];
        
        tableViewCell.backgroundView = view;
        
        _djButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _djButton.frame = CGRectMake(width*0.73, width*0.1, width*0.18, width*0.18);
        _djButton.layer.cornerRadius = width*0.09;
        //        _button.backgroundColor = [UIColor lightGrayColor];
        [_djButton addTarget:self action:@selector(dengji:) forControlEvents:UIControlEventTouchUpInside];
        [_djButton setBackgroundImage:[UIImage imageNamed:@"V1.png"] forState:UIControlStateNormal];
        [tableViewCell addSubview:_djButton];
    }
    
//    if (indexPath.row == 2) {
//        UIView *view = [[UIView alloc] init];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.4, width*0.08)];
//        label.text = @"我的收藏";
//        label.textColor = [UIColor grayColor];
//        [view addSubview:label];
//        
//        //        CGFloat width = self.view.frame.size.width;
//        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.83, width*0.055, width*0.06, width*0.06)];
//        addImage.image = [UIImage imageNamed:@"1(12).png"];
//        [view addSubview:addImage];
//        
//        tableViewCell.backgroundView = view;
//    }
    if (indexPath.row == 2) {
        
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.4, width*0.08)];
        label.text = @"切换至租客模式";
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.83, width*0.055, width*0.06, width*0.06)];
        addImage.image = [UIImage imageNamed:@"6.png"];
        [view addSubview:addImage];
        
        tableViewCell.backgroundView = view;
    }
    if (indexPath.row == 3) {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.4, width*0.08)];
        label.text = @"向我们反馈";
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        
        //        CGFloat width = self.view.frame.size.width;
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.83, width*0.055, width*0.06, width*0.06)];
        addImage.image = [UIImage imageNamed:@"311.png"];
        [view addSubview:addImage];
        
        tableViewCell.backgroundView = view;
    }
//    if (indexPath.row == 4) {
//        
//        UIView *view = [[UIView alloc] init];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.4, width*0.08)];
//        label.text = @"邀请好友";
//        label.textColor = [UIColor grayColor];
//        [view addSubview:label];
//        
//        //        CGFloat width = self.view.frame.size.width;
//        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.83, width*0.055, width*0.06, width*0.06)];
//        addImage.image = [UIImage imageNamed:@"2.png"];
//        [view addSubview:addImage];
//        
//        tableViewCell.backgroundView = view;
//    }
    if (indexPath.row == 4) {
        
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.4, width*0.08)];
        label.text = @"平台规则";
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        
        //        CGFloat width = self.view.frame.size.width;
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.83, width*0.055, width*0.06, width*0.06)];
        addImage.image = [UIImage imageNamed:@"51.png"];
        [view addSubview:addImage];
        
        tableViewCell.backgroundView = view;
    }
    if (indexPath.row == 5) {
        
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.4, width*0.08)];
        label.text = @"关于我们";
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.83, width*0.055, width*0.06, width*0.06)];
        addImage.image = [UIImage imageNamed:@"4.png"];
        [view addSubview:addImage];
        
        tableViewCell.backgroundView = view;
    }
        if (indexPath.row == 1) {
    
            UIView *view = [[UIView alloc] init];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.4, width*0.08)];
            label.text = @"我的评价";
            label.textColor = [UIColor grayColor];
            [view addSubview:label];
    
            //        CGFloat width = self.view.frame.size.width;
            UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.83, width*0.055, width*0.06, width*0.06)];
            addImage.image = [UIImage imageNamed:@"2.png"];
            [view addSubview:addImage];
    
            tableViewCell.backgroundView = view;
        }

    
    return tableViewCell;
}
// 修改信息
- (void)xiugaiInf:(UIButton *)button{
    
    if ([ZCUserData share].isLogin == YES) {
        
        MineDetailView *view = [MineDetailView new];
        view.imgURL = _dic[@"thumb"];
        view.nickName = _dic[@"nickname"];
        view.lianxi = _dic[@"mobile"];
        
        view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }else{
        
        LoginView *view =[[LoginView alloc]init];
        view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        
    }
//    if (indexPath.row == 2) {
//        
//        MyCollectionViewController *view = [[MyCollectionViewController alloc] init];
//        view.title = @"我的收藏";
//        
//        view.hidesBottomBarWhenPushed = YES;
//        CATransition *animation = [CATransition animation];
//        animation.duration = 0.3;
//        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        animation.type = @"Fade";
//        animation.subtype = kCATransitionFromLeft;
//        [self.view.window.layer addAnimation:animation forKey:nil];
//        
//        [self.navigationController pushViewController:view animated:NO];
//    }
    if (indexPath.row == 2) {
        
        [self PayOver];
    }
    if (indexPath.row == 3) {
        
        FanKuiViewController *view = [[FanKuiViewController alloc] init];
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }
    if (indexPath.row == 4) {
        
        GuizeView *view = [[GuizeView alloc] init];
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
    if (indexPath.row == 5) {
        
        AboutUsView *view = [[AboutUsView alloc] init];
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
    if (indexPath.row == 1) {
        
        RcviewViewController *view = [[RcviewViewController alloc] init];
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:YES];
    }
}
- (void)xinyongAction:(UIButton *)button{
    
    RankViewController *view = [[RankViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)PayOver{
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    imageView.image = [UIImage imageNamed:@"切换至租客.png"];
    [self.view addSubview:imageView];
    
    self.tabBarController.tabBar.hidden = YES;
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(showSelectedViewController:) withObject:imageView afterDelay:1];
}
- (void)showSelectedViewController:(UIImageView *)v {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [v removeFromSuperview];
    
    self.tabBarController.tabBar.hidden = NO;
    RootViewcontroller *rootView = [[RootViewcontroller alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.backgroundColor = [UIColor whiteColor];
    tabbar.translucent = NO;
    window.rootViewController = rootView;
}
#pragma mark - alertView
- (void)AlertView{
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight+64)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 10089;
    [self.view addSubview:bigView];
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenHeight/2-ScreenWidth*0.15, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [bigView addSubview:_alertView];
    
    UIImageView *image11 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame), CGRectGetHeight(_alertView.frame))];
    image11.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image11];
    
    image11.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.035, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"是否登陆";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image11 addSubview:label];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.18, width*0.6, 0.5)];
    line.backgroundColor = Color(217, 217, 217);
    [image11 addSubview:line];
    
    quxiao = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiao.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.35, ScreenWidth*0.08);
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *gray111 = Color(177, 177, 177);
    UIColor *color = Color(7, 187, 177);
    quxiao.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [quxiao setTitleColor:gray111 forState:UIControlStateNormal];
    [image11 addSubview:quxiao];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(image11.frame)/2, width*0.2+2, 0.5, width*0.1-width*0.02)];
    line2.backgroundColor = Color(217, 217, 217);
    [image11 addSubview:line2];
    
    queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(ScreenWidth*0.35, ScreenWidth*0.19, ScreenWidth*0.35, ScreenWidth*0.1);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image11 addSubview:queding];
}
- (void)moveAll{
    
    UIView *view = (UIView *)[self.view viewWithTag:10089];
    [view removeFromSuperview];
//    [_alertView removeFromSuperview];
}
- (void)queding{
    
    LoginView *view = [[LoginView alloc] init];
    
    view.hidesBottomBarWhenPushed = YES;view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:view animated:NO];
}
- (void)createView{
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 10089;
    [self.view addSubview:bigView];
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenHeight/2-ScreenWidth*0.15, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [bigView addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame), CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"暂未开放";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    quxiao = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiao.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [quxiao setTitle:@"确定" forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    quxiao.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [quxiao setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:quxiao];
}

- (void)dengji:(UIButton *)sender{
    
//    CarRankViewController *view = [CarRankViewController new];
//    view.hidesBottomBarWhenPushed = YES;
//    
//    view.hidesBottomBarWhenPushed = YES;view.hidesBottomBarWhenPushed = YES;
//    view.hidesBottomBarWhenPushed = YES;
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.3;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.type = @"Fade";
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
//    
//    [self.navigationController pushViewController:view animated:NO];
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

