//
//  UserMineController.m
//  ZuChe
//
//  Created by apple  on 16/12/14.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "UserMineController.h"
#import "MyCollectionViewController.h"
#import "FileAComplaintViewController.h"
#import "AboutUsViewController.h"
#import "AlterUserNameViewController.h"
#import "YaoqinViewController.h"
#import "MySelfViewController.h"
#import "GeRenZiLiaoViewController.h"
#import "LoginView.h"
#import "OwnerInformationViewController.h"
#import "MessageCenterViewController.h"
#import "ZuChe/ZCUserData.h"
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIScrollView+GifPullToRefresh.h"
#import "UILabel+SizeLabel.h"
#import "XieYiViewController.h"

#import "LoginView.h"
#import "UserDetailView.h"

#import "SDWebImage/UIButton+WebCache.m"
#import "HttpManager.h"
#import "Header.h"

#import "YHQView.h"
#import "SecondTabbar.h"

#define NowUrl  @"http://wx.leisurecarlease.com/"

@interface UserMineController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
    UITableView *_tableView;
    BOOL Denglu;
    NSDictionary *_dic;
    UILabel *_label;
    UIButton *_button;
    UIImage *_backGroundImg;
    UIAlertView *_alertVeiw;
    NSMutableArray *countarray;
    
    CGFloat width;
}

@end

@implementation UserMineController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    
    
    if ([ZCUserData share].isLogin == NO) {
        
        [_button setBackgroundImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
        _label.text = @"你好";
        
        [self AlertView];
    }else{
        
        AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSDictionary *parameters =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
        
        [HttpManager postData:parameters andUrl:[NSString stringWithFormat:@"%@api.php?op=memberinfo",NowUrl] success:^(NSDictionary *fanhuicanshu) {
            
            _dic = fanhuicanshu;
            if (_dic == nil) {
                
                
            }
            
            [[ZCUserData share]saveUserInfoWithUserId:[ZCUserData share].userId username:[ZCUserData share].username descriptions:[_dic objectForKey:@"description"] mobile:[_dic objectForKey:@"mobile"] fuwu:[_dic objectForKey:@"fuwu"] jiedan:[_dic objectForKey:@"jiedan"] lianxi:[_dic objectForKey:@"lianxi"] yinxiang:[_dic objectForKey:@"yinxiang"] nickname:[_dic objectForKey:@"nickname"] thumb:[_dic objectForKey:@"thumb"] tiqian:[_dic objectForKey: @"tiqian"] xing:[_dic objectForKey:@"xing"] xingqu:[_dic objectForKey:@"xingqu"] xueli:[_dic objectForKey:@"xueli"] zhiye:[_dic objectForKey:@"zhiye"] IsLogin:[ZCUserData share].isLogin];
            
            //            [self createTableView];
            [_tableView reloadData];
            //            NSLog(@"---%@",fanhuicanshu);
        } Error:^(NSString *cuowuxingxi) {
            
        }];
        
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    UIView *view = (UIView *)[self.view viewWithTag:11089];
    [view removeFromSuperview];
}
- (void)downLoadData{
    
    if ([ZCUserData share].isLogin == NO) {
        
        [_button setBackgroundImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
        _label.text = @"你好";
        
        [self AlertView];
    }else{
        
        AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSDictionary *parameters =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
        
        [HttpManager postData:parameters andUrl:[NSString stringWithFormat:@"%@api.php?op=memberinfo",NowUrl] success:^(NSDictionary *fanhuicanshu) {
            
            _dic = fanhuicanshu;
            if (_dic == nil) {
                
                
            }
            
            [[ZCUserData share]saveUserInfoWithUserId:[ZCUserData share].userId username:[ZCUserData share].username descriptions:[_dic objectForKey:@"description"] mobile:[_dic objectForKey:@"mobile"] fuwu:[_dic objectForKey:@"fuwu"] jiedan:[_dic objectForKey:@"jiedan"] lianxi:[_dic objectForKey:@"lianxi"] yinxiang:[_dic objectForKey:@"yinxiang"] nickname:[_dic objectForKey:@"nickname"] thumb:[_dic objectForKey:@"thumb"] tiqian:[_dic objectForKey: @"tiqian"] xing:[_dic objectForKey:@"xing"] xingqu:[_dic objectForKey:@"xingqu"] xueli:[_dic objectForKey:@"xueli"] zhiye:[_dic objectForKey:@"zhiye"] IsLogin:[ZCUserData share].isLogin];
            
//            [self createTableView];
            [_tableView reloadData];
//            NSLog(@"---%@",fanhuicanshu);
        } Error:^(NSString *cuowuxingxi) {
            
        }];
        
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    width = self.view.frame.size.width;
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _label = [[UILabel alloc] init];
    _label.text = @"你好";
    
    [self createTableView];
    [_tableView reloadData];
//    if ([ZCUserData share].isLogin==YES)
//    {
//        NSLog(@"我已经登陆了");
//        
//        AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
//        
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//        
//        NSDictionary *parameters =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
//        
//        
//        [manager POST:[NSString stringWithFormat:@"%@api.php?op=memberinfo",NowUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            _dic = responseObject;
//            
//            [[ZCUserData share]saveUserInfoWithUserId:[ZCUserData share].userId username:[ZCUserData share].username descriptions:[_dic objectForKey:@"description"] mobile:[_dic objectForKey:@"mobile"] fuwu:[_dic objectForKey:@"fuwu"] jiedan:[_dic objectForKey:@"jiedan"] lianxi:[_dic objectForKey:@"lianxi"] yinxiang:[_dic objectForKey:@"yinxiang"] nickname:[_dic objectForKey:@"nickname"] thumb:[_dic objectForKey:@"thumb"] tiqian:[_dic objectForKey: @"tiqian"] xing:[_dic objectForKey:@"xing"] xingqu:[_dic objectForKey:@"xingqu"] xueli:[_dic objectForKey:@"xueli"] zhiye:[_dic objectForKey:@"zhiye"] IsLogin:[ZCUserData share].isLogin];
//            
//            
//            [_tableView reloadData];
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            NSLog(@"Error%@",error);
//            
//        }];
//        
//    }else
//    {
//        [_tableView reloadData];
//    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        LoginView *lodin=[[LoginView alloc]init];
        
        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController pushViewController:lodin animated:YES];
    }else{
        
        return;
    }
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    _tableView.scrollEnabled = YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CGFloat width = self.view.frame.size.width;
    if (indexPath.row == 0) {
        return width*0.51;
    }
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
        
        
        _button.frame = CGRectMake(width*0.05, width*0.08, width*0.18, width*0.18);
        
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
    }
    
    if (indexPath.row == 1) {
        
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.4, width*0.08)];
        label.text = @"我的收藏";
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.83, width*0.055, width*0.06, width*0.06)];
        addImage.image = [UIImage imageNamed:@"1(12).png"];
        [view addSubview:addImage];
        
        tableViewCell.backgroundView = view;
    }
    if (indexPath.row == 2) {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.4, width*0.08)];
        label.text = @"我的优惠券";
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.83, width*0.05, width*0.06, width*0.06)];
        addImage.image = [UIImage imageNamed:@"2.png"];
        [view addSubview:addImage];
        
        tableViewCell.backgroundView = view;
    }
    if (indexPath.row == 3) {
        
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.4, width*0.08)];
        label.text = @"切换至车主模式";
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.83, width*0.055, width*0.06, width*0.06)];
        addImage.image = [UIImage imageNamed:@"6.png"];
        [view addSubview:addImage];
        
        tableViewCell.backgroundView = view;
    }
    if (indexPath.row == 4) {
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
    
    if (indexPath.row == 5) {
        
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
    if (indexPath.row == 6) {
        
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
    
    return tableViewCell;
}
#pragma mark - 点击头像按钮
- (void)xiugaiInf:(UIButton *)button{
    
    if ([ZCUserData share].isLogin == YES) {
        
        UserDetailView *view = [UserDetailView new];
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
    
    if (indexPath.row == 1) {
        
        MyCollectionViewController *view = [[MyCollectionViewController alloc] init];
        view.title = @"我的收藏";
        
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:view animated:NO ];
    }
    if (indexPath.row == 2) {
        
        YHQView *view = [[YHQView alloc] init];
        
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }
    if (indexPath.row == 3) {
        
        [self PayOver];
    }
    if (indexPath.row == 4) {
        
        FileAComplaintViewController *view = [[FileAComplaintViewController alloc] init];
        
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }
    
    if (indexPath.row == 5) {
        
        XieYiViewController *view = [[XieYiViewController alloc] init];
        view.xieyititle = @"平台规则";
        
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }
    if (indexPath.row == 6) {
        
        AboutUsViewController *view = [[AboutUsViewController alloc] init];
        
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }
}
#pragma mark - 切换模式
- (void)PayOver{
    
    if ([ZCUserData share].isLogin == NO) {
        
        LoginView *view = [[LoginView alloc] init];
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:view animated:NO];
    }else{
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        imageView.image = [UIImage imageNamed:@"切换至车主.png"];
        [self.view addSubview:imageView];
        
        self.tabBarController.tabBar.hidden = YES;
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        animation.type = @"Fade";
        //     FlipFromRight
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self performSelector:@selector(showSelectedViewController:) withObject:imageView afterDelay:1];
    }
}
#pragma mark - 切换到车主模式
- (void)showSelectedViewController:(UIImageView *)v {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [v removeFromSuperview];
    
    self.tabBarController.tabBar.hidden = NO;
    SecondTabbar *view = [[SecondTabbar alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = view;
    
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.backgroundColor = Color(77, 77, 77);
    tabbar.translucent = NO;
}

#pragma mark - 是否登陆提示
- (void)AlertView{
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.view.frame.size.height+64)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 11089;
    [self.view addSubview:bigView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenHeight/2-ScreenWidth*0.15, ScreenWidth*0.7, ScreenWidth*0.3)];
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
    
    UIButton *quxiao = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(ScreenWidth*0.35, ScreenWidth*0.19, ScreenWidth*0.35, ScreenWidth*0.1);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image11 addSubview:queding];
}
- (void)moveAll{
    
    UIView *view = (UIView *)[self.view viewWithTag:11089];
    [view removeFromSuperview];
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
#pragma mark - 暂未开放提示
- (void)createView{
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 11089;
    [self.view.window addSubview:bigView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenHeight/2-ScreenWidth*0.15, ScreenWidth*0.7, ScreenWidth*0.3)];
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
    
    UIButton *quxiao = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiao.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [quxiao setTitle:@"确定" forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    quxiao.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [quxiao setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:quxiao];
}




@end
