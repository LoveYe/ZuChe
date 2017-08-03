//
//  XingchengController.m
//  ZuChe
//
//  Created by apple  on 16/11/7.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "NewsPageConreoller.h"
#import "Header.h"
#import "XiangqingController.h"
#import "WB_Stopwatch.h"
#import "YiWanChengView.h"
#import "ZuChe/ZCUserData.h"
#import "LoginView.h"
#import "MessageCenterViewController.h"
#import "XingchengTableViewCell.h"
#import "completeTableViewCell.h"
#import "OrderenterViewController.h"
#import "RootViewcontroller.h"
#import "AppDelegate.h"
#import "AllPageDdViewController.h"
#import "HttpManager.h"
#import "YesFinaViewController.h"
#import "HistoryTableViewCell.h"

#define CHEZHU_URL @"http://wx.leisurecarlife.com/api.php?op=Czorderlist"

@interface NewsPageConreoller()<UITableViewDelegate,UITableViewDataSource>{
    
    CGFloat width;
    UITableView *leftTableView;
    UITableView *rightTableView;
    NSInteger tag;
    UITableView *_aplaphTabelView;
    
    
    UIButton *_jinruButton;
    UIButton *_jinruTwoButton;
    
    NSMutableArray *_rightArray;
    NSMutableArray  *_dataArray;
    
    //UISegmentedControl *segment;
    NSArray *_commArray;
    UIImageView *_leftImageView;
    UIImageView *_rightImageView;
    UIView *_view;
}

@end

@implementation NewsPageConreoller

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    [self initData];
}
-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = NO;
    // [leftTableView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor whiteColor];
    width = self.view.frame.size.width;
    
    self.navigationItem.title  = @"行程动态";
    
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhuile) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    
     [self createTableView];
}
- (void)fanhuile{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initData {
    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",@"3",@"status", nil];
//    [HttpManager postData:dict andUrl:CHEZHU_URL success:^(NSDictionary *fanhuicanshu) {
//        
//        
//        NSArray *arr = fanhuicanshu[@"orderlist"];
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:@[]];
        
        if (_dataArray.count == 0) {
         
            leftTableView.tableHeaderView =  [self returnTableViewHeadView];
        }else {
            leftTableView.tableHeaderView =  [self NoTableViewHeadView];
        }
        
        [leftTableView reloadData];
  
}
-(UIView *)returnTableViewHeadView {
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.view.frame.size.height-49-64)];
    _view.alpha = 1.0;
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-65, (self.view.frame.size.height-49-64)/2 - 65, 130, 130)];
    imageview.image = [UIImage imageNamed:@"没有消息.png"];
    [_view addSubview:imageview];
    
    return _view;
}
-(UIView *)NoTableViewHeadView {
    
    _view = [[UIView alloc] init];
    _view.alpha = 0.0;
    
    
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-65, (self.view.frame.size.height - ScreenWidth*0.14-49)/2 - 65, 130, 130)];
    imageview.image = [UIImage imageNamed:@""];
    [_view addSubview:imageview];
    
    return _view;
}
#pragma mark - create TableView
- (void)createTableView{
    
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, self.view.frame.size.height-49-64)];
    //leftTableView.backgroundColor = [UIColor redColor];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.separatorStyle = UITableViewCellAccessoryNone;
    
    [self.view addSubview:leftTableView];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tag = 1000;
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [leftTableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
    
}
-(void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    if (refreshControl.tag == 1000) {
        // 此处添加刷新tableView数据的代码
        [refreshControl endRefreshing];
        [self initData];
        // [_leftTableView reloadData];// 刷新tableView即可
    }
}
#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return width*0.6;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stack = @"stack";
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stack];
    if (!cell) {
        
        cell = [[HistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stack];
        
        cell.dict = _dataArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        XiangqingController *view = [[XiangqingController alloc] init];
    //        AllPageDdViewController *view = [AllPageDdViewController new];
    //        view.postIdString = _dataArray[indexPath.row][@"orderid"];
    //        [self.navigationController pushViewController:view animated:NO];
    //
    YesFinaViewController *fin = [YesFinaViewController new];
    [self.navigationController pushViewController:fin animated:YES];
    fin.postIdString = _dataArray[indexPath.row][@"orderid"];
    fin.poststates = @"已完成";
    
}

@end

