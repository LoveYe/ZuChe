//
//  ShouCangViewController.m
//  ZuChe
//
//  Created by apple  on 2017/7/11.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ShouCangViewController.h"
#import "Header.h"
#import "ZCUserData.h"
#import "HttpManager.h"
#import "RootViewcontroller.h"

#import "UIImageView+WebCache.h"

#import "LoginView.h"
#import "ShoucangViewCell.h"
#import "CarDetailInfoView.h"
#import "YSLTransitionAnimator.h"
#import "UIViewController+YSLTransition.h"

@interface ShouCangViewController ()<UITableViewDelegate, UITableViewDataSource,YSLTransitionAnimatorDataSource,DeleteDelegate>{
    
    CGFloat width;
    CGFloat height;
    
    NSMutableArray *_dataArray;
}

@property (strong,nonatomic)UITableView  * tableView;
@end

@implementation ShouCangViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    if ([ZCUserData share].isLogin == NO) {
        
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
    else{
        
        [self downLoad];
    }
}
#pragma mark - 点击进入后的图片动画 delegate
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
#pragma mark - 是否有收藏
-(void)myCollectIsEmpty{
    
    [self.tableView removeFromSuperview];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(20, 40, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(kaishi:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"无收藏.jpg"];
    image.userInteractionEnabled = YES;
    [self.view addSubview:image];
    
    UILabel *da = [[UILabel alloc] initWithFrame:CGRectMake(width*0.7, width*0.3, width*0.2, width*0.1)];
    da.text = @"收藏";
    da.textAlignment = NSTextAlignmentRight;
    da.adjustsFontSizeToFitWidth = YES;
    da.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:35];
    da.textColor = [UIColor whiteColor];
    [image addSubview:da];
    
    UILabel *xiao = [[UILabel alloc] initWithFrame:CGRectMake(width*0.3, CGRectGetMaxY(da.frame)+20, width*0.6, width*0.1)];
    xiao.text = @"您还没有收藏任何车辆";
    xiao.textColor = [UIColor whiteColor];
    xiao.textAlignment = NSTextAlignmentRight;
    xiao.adjustsFontSizeToFitWidth = YES;
    xiao.font = [UIFont fontWithName:@"AmericanTypewriter" size:20];
    [image addSubview:xiao];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-width*0.13-64, width, width*0.13);
    button.backgroundColor = Color(0, 215, 200);
    [button setTitle:@"开始探索" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(kaishi:) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:button];
    
    //    ShoucangController *view = [[ShoucangController alloc] init];
    //    [self.navigationController pushViewController:view animated:YES];
}
- (void)kaishi:(UIButton *)sender{
    
    RootViewcontroller *view = [[RootViewcontroller alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = view;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)downLoad{
    
    _dataArray = [NSMutableArray array];
    NSDictionary *dict = @{@"userid":[ZCUserData share].userId};
    
    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=my_shoucang" success:^(NSDictionary *fanhuicanshu) {
        
        NSLog(@" --- %@",fanhuicanshu);
        _dataArray = (NSMutableArray *)fanhuicanshu;
        
        if (_dataArray.count == 0) {
            
            [self myCollectIsEmpty];
        }else{
            
            [self createTableView];
            [_tableView reloadData];
        }
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.title = @"我的收藏";
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = rightBar;
    
//    [self createTableView];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [UIView new];
}
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
    ShoucangViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stac];
    if (!cell) {
        
        cell = [[ShoucangViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stac];
    }
    NSDictionary *dict = _dataArray[indexPath.row];
    cell.model = dict;
    cell.delDelegate = self;
    
    NSString *url = [NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",dict[@"tupian"]];
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
//    view.isOK = !isClick;
    view.carid = dict[@"carid"];
    view.cartype = _dataArray[indexPath.row][@"cartype"];
    
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

#pragma mark - 放大效果
#pragma mark -- YSLTransitionAnimatorDataSource
- (UIImageView *)popTransitionImageView{
    
    return nil;
}

- (UIImageView *)pushTransitionImageView{
    
    ShoucangViewCell *cell = (ShoucangViewCell *)[_tableView cellForRowAtIndexPath:[_tableView indexPathForSelectedRow]];
    return cell.cartu111;
}
#pragma mark - 删除收藏
- (void)deleteCollection:(NSString *)carid type:(NSString *)type{
    
    NSDictionary *dict =  @{@"userid":[ZCUserData share].userId,@"carid":carid,@"model":@"delete",@"cartype":type};
    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=shoucang" success:^(NSDictionary *fanhuicanshu) {
        
        [_tableView removeFromSuperview];
//        _dataArray = [NSMutableArray array];
        [self downLoad];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
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
