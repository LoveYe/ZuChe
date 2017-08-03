//
//  CarInfoView.m
//  ZuChe
//
//  Created by apple  on 16/12/23.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "CarInfoView.h"
#import "CarDetailInfoView.h"

#import "AFHTTPRequestOperationManager.h"
#import "HttpManager.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "HomePageViewController.h"
#import "ZCUserData.h"

#import "CarList.h"
#import "Header.h"

#import "AFNetworking.h"

#import "UIViewController+YSLTransition.h"
#import "YSLTransitionAnimator.h"
#import "ShaiXuanView.h"

#define  PATH_URL @"http://wx.leisurecarlease.com/api.php?op=api_zclxlb"

@interface CarInfoView()<UITableViewDataSource,UITableViewDelegate,YSLTransitionAnimatorDataSource,ShaiXuanDelegate,PaiSheDelegate>{
    
    UITableView *_tableView;
    CGFloat width;
    BOOL isClick;
    
    NSMutableArray *_dataArray;
    NSString *carid;
    
    UILabel *shang;
    UILabel *xia;
    
    NSString *type;
    NSString *state;
    NSString *bukezutime;
    NSString *jiedan;
    
    NSDictionary *dictnory;
}

@end

@implementation CarInfoView

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    
    [self downloadData];
}

- (void)downloadData{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.cartype,@"type",[ZCUserData share].userId,@"userid",state,@"state",bukezutime,@"bukezutime",jiedan,@"jiedan", nil];
//  @{@"type":self.cartype,@"state":@"1",@"bukezutime":@"2017-7-15",@"jiedan":@"1"};
    
    _dataArray = [NSMutableArray array];
    dictnory = [NSDictionary dictionary];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:PATH_URL]]) {
        
        [HttpManager postData:dict andUrl:PATH_URL success:^(NSDictionary *fanhuicanshu) {
            
            NSLog(@"fanhuicanshu === %@",fanhuicanshu);
            dictnory = fanhuicanshu;
            
            _dataArray = fanhuicanshu[@"carlist"];
//            [_dataArray addObjectsFromArray:fanhuicanshu[@"carlist"]];
            
            if (_dataArray.count == 0) {
                
                [self createAlertView];
            }else{
                
                if (_dataArray.count > 50) {
                    
                    xia.text = @"50+个车源";
                }else{
                    
                    xia.text = [NSString stringWithFormat:@"%ld个车源",(unsigned long)_dataArray.count];
                }
                [self createTableView];
                [_tableView reloadData];
            }
        } Error:^(NSString *cuowuxingxi) {
            
        }];
        
        
        if ([self.cartype intValue] == 2) {
            shang.text = @"商务专区";
        }else if ([self.cartype intValue] == 3){
            shang.text = @"拍摄专区";
        }else if ([self.cartype intValue] == 4){
            shang.text = @"长包专区";
        }else if ([self.cartype intValue] == 5){
            shang.text = @"长租专区";
        }
    }
    else{
        
        [self createAlertView];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    
    if ([_tableView indexPathForSelectedRow] ) {
        [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
    }
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    [self ysl_addTransitionDelegate:self];
    // push
    [self ysl_pushTransitionAnimationWithToViewControllerImagePointY:statusHeight + navigationHeight animationDuration:0.3];
}
- (void)viewWillDisappear:(BOOL)animated{
    
//    [_dataArray removeAllObjects];
    [self.tabBarController.tabBar setHidden:NO];
    [self ysl_removeTransitionDelegate];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    width = self.view.frame.size.width;
    self.view.backgroundColor = [UIColor whiteColor];
    isClick = YES;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIButton *shaixuan = [UIButton buttonWithType:UIButtonTypeCustom];
    shaixuan.frame = CGRectMake(0, 0, 25, 25);
    [shaixuan setBackgroundImage:[UIImage imageNamed:@"筛选.png"] forState:UIControlStateNormal];
    [shaixuan addTarget:self action:@selector(shaixuan) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:shaixuan];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIView *title = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width*0.4, 44)];
    self.navigationItem.titleView = title;
    shang = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, title.frame.size.width, title.frame.size.height/2)];
    shang.textColor = [UIColor blackColor];
    shang.textAlignment = NSTextAlignmentCenter;
    shang.font = [UIFont systemFontOfSize:18];
    [title addSubview:shang];
    
    xia = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shang.frame), title.frame.size.width, title.frame.size.height/2)];
    xia.textColor = [UIColor grayColor];
    xia.textAlignment = NSTextAlignmentCenter;
    xia.font = [UIFont systemFontOfSize:16];
    [title addSubview:xia];
    
    
}
- (void)shaixuan{
    
    ShaiXuanView *view = [[ShaiXuanView alloc] init];
    view.titleText = xia.text;
    view.delegate = self;
    view.state = dictnory[@"state"];
    view.jiedan = dictnory[@"jiedan"];
    view.bukezutime = dictnory[@"bukezutime"];
    
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
- (void)sendtime:(NSString *)time auto:(NSString *)autolist duoshao:(NSString *)duoshao{
    
    state = [[NSString alloc] init];
    bukezutime = [[NSString alloc] init];
    jiedan = [[NSString alloc] init];
    
    state = duoshao;
    bukezutime = time;
    jiedan = autolist;
    
    [self downloadData];
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, self.view.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView.frame = CGRectZero;
}

#pragma mark - TableView Delegate and Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return width*0.9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stac= @"identifier";
    CarList *cell = [tableView dequeueReusableCellWithIdentifier:stac];
    if (!cell) {
        
        cell = [[CarList alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stac];
    }
    NSDictionary *dict = _dataArray[indexPath.row];
    cell.model = dict;
    cell.pcDelegate = self;
    
    NSString *url = [NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",dict[@"cartu"]];
    [cell.cartu111 sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CATransition * animation = [CATransition animation];
    [animation setDuration:2];
    
    CarDetailInfoView *view = [[CarDetailInfoView alloc] init];
    NSDictionary *dict = _dataArray[indexPath.row];
    view.isOK = !isClick;
    view.carid = dict[@"carid"];
    view.cartype = self.cartype;
    
    view.username = dict[@"usernickname"];
    
    view.carPrice1 = dict[@"jiage2"];
    view.carPrice2 = dict[@"jiage3"];
    view.carPlate = dict[@"plate"];
    view.carid = dict[@"carid"];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void)animationWithView:(UIView *)view WithAnimationTransition:(UIViewAnimationTransition)transition{
    
    [UIView animateWithDuration:2 animations:^{
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

- (void)fanhui{
    
    HomePageViewController *view = [[HomePageViewController alloc] init];
    
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.25;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)fenlei:(UIBarButtonItem *)sender{
    
    
}
- (void)paiSheCollect{
    
    [_tableView removeFromSuperview];
    [self downloadData];
    [_tableView reloadData];
}

#pragma mark - 放大效果
#pragma mark -- YSLTransitionAnimatorDataSource
- (UIImageView *)popTransitionImageView{
    
    return nil;
}

- (UIImageView *)pushTransitionImageView{
    
    CarList *cell = (CarList *)[_tableView cellForRowAtIndexPath:[_tableView indexPathForSelectedRow]];
    return cell.cartu111;
}



- (void)createAlertView{
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.view.frame.size.height)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 10089;
    [self.view.window addSubview:bigView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(width*0.15, width*0.4, width*0.7, width*0.3)];
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
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.05, width*0.7, width*0.1)];
    label.text = @"暂无车辆，敬请期待";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.18, width*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, width*0.2, width*0.7, width*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
- (void)moveAll{
    
    HomePageViewController *view = [[HomePageViewController alloc] init];
    view.hidesBottomBarWhenPushed = YES;view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController popViewControllerAnimated:NO];
}


@end
