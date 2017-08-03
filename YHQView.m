//
//  YHQView.m
//  ZuChe
//
//  Created by apple  on 2017/6/6.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "YHQView.h"
#import "ZCUserData.h"
#import "Header.h"
#import "LoginView.h"
#import "YouhuiCell.h"
#import "HttpManager.h"
#import "UserMineController.h"

@interface YHQView ()<UITableViewDelegate,UITableViewDataSource>{
    
    CGFloat width;
    CGFloat height;
    
    NSMutableArray *array;
    
    UITableView *_tableView;
    UIButton *quxiao;
    UIButton *queding;
    
    UITextField *text;
}
@end

@implementation YHQView

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    if ([ZCUserData share].isLogin == YES) {
        
        [self downLoadYouhui];
    }else{
        
        [self createAlert];
    }
}
- (void)downLoadYouhui{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_coupon" success:^(NSDictionary *fanhuicanshu) {
        
        array = fanhuicanshu[@"coupon"];
        if (array.count == 0) {
            
            [self createBGView];
        }else{
            
            [self createTableView];
            [_tableView reloadData];
        }
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    UIView *view = [self.view viewWithTag:1003];
    [view removeFromSuperview];
    
    UIView *view2 = [self.view viewWithTag:12315];
    [view2 removeFromSuperview];
}
- (void)createBGView{
    
    
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.1, width*0.45, width*0.1)];
    Label1.text = @"优惠券";
    Label1.textColor = Color(87, 87, 87);
    Label1.textAlignment = NSTextAlignmentLeft;
    Label1.font = [UIFont boldSystemFontOfSize:28];
    Label1.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:Label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(width*0.05, CGRectGetMaxY(Label1.frame)+width*0.03, width*0.8, width*0.1);
    if (array.count == 0) {
        
        label2.text = @"当前还没有优惠券...";
    }if (array.count != 0) {
        
        label2.text = [NSString stringWithFormat:@"当前有%ld张优惠券...",(unsigned long)array.count];
    }
    label2.textColor = Color(157, 157, 157);
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont systemFontOfSize:17];
    label2.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label2];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame)+width*0.03, width, 0.05)];
    xian.backgroundColor = Color(237, 237, 237);
    [self.view addSubview:xian];
    
    text = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xian.frame)+width*0.03, width*0.75, width*0.1)];
    text.placeholder = @"请输入优惠码";
    text.textAlignment = NSTextAlignmentLeft;
    text.tintColor = Color(7, 187, 177);
    UIColor *color = Color(157, 157, 157);
    UIColor *gray = Color(237, 237, 237);
    text.layer.borderWidth = 0.5;
    text.layer.borderColor = [gray CGColor];
    [self.view addSubview:text];
    
    UIButton *tianjia = [UIButton buttonWithType:UIButtonTypeCustom];
    tianjia.frame = CGRectMake(CGRectGetMaxX(text.frame), CGRectGetMaxY(xian.frame)+width*0.03, width*0.15, width*0.1);
    [tianjia setTitle:@"添加" forState:UIControlStateNormal];
    [tianjia setTitleColor:color forState:UIControlStateNormal];
    tianjia.layer.borderWidth = 0.5;
    tianjia.layer.borderColor = [gray CGColor];
    [tianjia addTarget:self action:@selector(tianjia) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tianjia];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];;
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    self.title = @"我的优惠券";
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
//    [self createTableView];;
}
- (void)fanhui{
    
    UserMineController *view = [[UserMineController alloc] init];
    
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.scrollEnabled = YES;
    _tableView.tableFooterView = [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return width*0.25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YouhuiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stav"];
    if (!cell) {
        
        cell = [[YouhuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stav"];
    }
    
    cell.model = array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width*0.6)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.1, width*0.45, width*0.1)];
    Label1.text = @"优惠券";
    Label1.textColor = Color(87, 87, 87);
    Label1.textAlignment = NSTextAlignmentLeft;
    Label1.font = [UIFont boldSystemFontOfSize:28];
    Label1.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:Label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(width*0.05, CGRectGetMaxY(Label1.frame)+width*0.03, width*0.8, width*0.1);
    if (array.count == 0) {
        
        label2.text = @"当前还没有优惠券...";
    }if (array.count != 0) {
        
        label2.text = [NSString stringWithFormat:@"当前有%ld张优惠券...",(unsigned long)array.count];
    }
    label2.textColor = Color(157, 157, 157);
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont systemFontOfSize:17];
    label2.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:label2];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame)+width*0.03, width, 0.05)];
    xian.backgroundColor = Color(237, 237, 237);
    [headerView addSubview:xian];
    
    text = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xian.frame)+width*0.03, width*0.75, width*0.1)];
    text.placeholder = @"请输入优惠码";
    text.textAlignment = NSTextAlignmentLeft;
    text.tintColor = Color(7, 187, 177);
    UIColor *color = Color(157, 157, 157);
    UIColor *gray = Color(237, 237, 237);
    text.layer.borderWidth = 0.5;
    text.layer.borderColor = [gray CGColor];
    [headerView addSubview:text];
    
    UIButton *tianjia = [UIButton buttonWithType:UIButtonTypeCustom];
    tianjia.frame = CGRectMake(CGRectGetMaxX(text.frame), CGRectGetMaxY(xian.frame)+width*0.03, width*0.15, width*0.1);
    [tianjia setTitle:@"添加" forState:UIControlStateNormal];
    [tianjia setTitleColor:color forState:UIControlStateNormal];
    tianjia.layer.borderWidth = 0.5;
    tianjia.layer.borderColor = [gray CGColor];
    [tianjia addTarget:self action:@selector(tianjia) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:tianjia];
    
    return headerView;
}
- (void)tianjia{
    
    NSDictionary *dic = @{@"userid":[ZCUserData share].userId,@"number":text.text};
    [HttpManager postData:dic andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_coupon" success:^(NSDictionary *fanhuicanshu) {
        
        if ([fanhuicanshu[@"msg"] isEqualToString:@"无效编号"]) {
            
            [self alert];
        }else{
            
            [_tableView removeFromSuperview];
            [self downLoadYouhui];
        }
        
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return width*0.6;
}

- (void)createAlert{
    
    LoginView *view = [[LoginView alloc] init];
    
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:view animated:NO];
}
- (void)moveAll{
    
    UIView *view222 = [self.view viewWithTag:12315];
    [view222 removeFromSuperview];
    
    UserMineController *view = [[UserMineController alloc] init];
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)queding{
    
    LoginView *view = [[LoginView alloc] init];
    
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:view animated:NO];
    
    UIView *view222 = [self.view viewWithTag:12315];
    [view222 removeFromSuperview];
}
- (void)quxiao{
    
    UIView *view222 = [self.view viewWithTag:12315];
    [view222 removeFromSuperview];
    
    UserMineController *view = [[UserMineController alloc] init];
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)alert{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 1013;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view addSubview:view1];
    UITapGestureRecognizer *regsi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAll)];
    [view1 addGestureRecognizer:regsi];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.15, width*0.4, width*0.7, width*0.3)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"无效优惠券号";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [view2 addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [view2 addSubview:xian];
    
    UIButton *queding11 = [UIButton buttonWithType:UIButtonTypeCustom];
    queding11.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [queding11 setTitle:@"确定" forState:UIControlStateNormal];
    [queding11 addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding11.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding11 setTitleColor:color forState:UIControlStateNormal];
    [view2 addSubview:queding11];
}
- (void)removeAll{
    
    UIView *view = [self.view viewWithTag:1013];
    [view removeFromSuperview];
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
