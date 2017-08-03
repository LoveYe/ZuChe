//
//  UserNewViewController.m
//  ZuChe
//
//  Created by MacBookXcZl on 2017/5/23.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "XingchengController.h"
#import "Header.h"
#import "XiangqingController.h"
#import "WB_Stopwatch.h"
#import "YiWanChengView.h"
#import "ZuChe/ZCUserData.h"
#import "XingchengTableViewCell.h"
#import "completeTableViewCell.h"
#import "OrderenterViewController.h"
#import "RootViewcontroller.h"
#import "AppDelegate.h"
#import "AllPageDdViewController.h"
#import "HttpManager.h"
#import "HistoryViewController.h"
#import "AFNetworking.h"
#import "WYJPageView.h"
#import "MBProgressHUD.h"

#import "CzWeiKaiSViewController.h"
#import "CzWdaoDaViewController.h"
#import "CzYchiDaoViewController.h"
#import "CzYdaoDaViewController.h"
#import "CzDaiZhiFuWKViewController.h"
#import "CzYizhifuWkViewController.h"
#import "XcFuWuZhongViewController.h"
#import "CzChaoshiGongliViewController.h"
#import "CzWeiPingJiaViewController.h"
#import "CzYiWanChengViewController.h"

#import "WeidaodaAndFuwzViewController.h"

#import "RCDataManager.h"
#import "RCUserInfo+Addition.h"
#import <CommonCrypto/CommonCrypto.h>


#define PATH_URL @"http://wx.leisurecarlease.com/api.php?op=Czorderlist"

@interface XingchengController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    //   __block UIScrollView *_scrollView2;
    //  WYJPageView *_page;
    UIImageView *_backgroundImg;
    // UIButton *_jinruButton;
    NSMutableArray *_dataLeftArray;
    NSMutableArray *_dataRightArray;
    //    UITableView *_leftTableView;
    //   UITableView *_rightTableView;
    // UISegmentedControl *segment;
    
    UIView *_view;
    
}
@property (nonatomic, strong) AFNetworkReachabilityManager *manager;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) WYJPageView *page;
@property (nonatomic, strong) UIButton *jinruButton;

@end

@implementation XingchengController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataLeftArray = [NSMutableArray new];
    _dataRightArray = [NSMutableArray new];
    // Do any additional setup after loading the view.
    UIButton *fanctory = [UIButton buttonWithType:UIButtonTypeCustom];
    fanctory.frame = CGRectMake(0, 0, 25, 25);
    [fanctory setBackgroundImage:[UIImage imageNamed:@"历史图标.png"] forState:UIControlStateNormal];
    [fanctory addTarget:self action:@selector(barButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:fanctory];
    self.navigationItem.rightBarButtonItem = rightButton;
}



-(void)barButtonItemClick:(UIBarButtonItem *)barButton {
    NSLog(@"%@",@"wwwwww");
    [self.navigationController pushViewController:[HistoryViewController new] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent  = NO;

    __block XingchengController *blockSelf = self;
    self.manager = [AFNetworkReachabilityManager sharedManager];
    [self.manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"不可达的网络(未连接)");
                [blockSelf.leftTableView removeFromSuperview];
                [blockSelf.rightTableView removeFromSuperview];
                [blockSelf.segment removeFromSuperview];
                [blockSelf.scrollView2 removeFromSuperview];
                [blockSelf.page removeFromSuperview];
                [blockSelf.jinruButton removeFromSuperview];
                [blockSelf createView];
                break;
            }
            default: {
                if ([ZCUserData share].isLogin == YES) {
                    [blockSelf.leftTableView removeFromSuperview];
                    [blockSelf.rightTableView removeFromSuperview];
                    [blockSelf.segment removeFromSuperview];
                    [blockSelf.scrollView2 removeFromSuperview];
                    [blockSelf.page removeFromSuperview];
                    [blockSelf.jinruButton removeFromSuperview];
                    [blockSelf panDuanIsLogin];
                }else{
                    [blockSelf.leftTableView removeFromSuperview];
                    [blockSelf.rightTableView removeFromSuperview];
                    [blockSelf.segment removeFromSuperview];
                    [blockSelf.scrollView2 removeFromSuperview];
                    [blockSelf.page removeFromSuperview];
                    [blockSelf.jinruButton removeFromSuperview];
                    [blockSelf createView];
                }
                break;
            }
        }
    }];
    
    [self.manager startMonitoring];
}


#pragma mark - create segment

- (void)createSegment{
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"待处理", @"进行中", nil];
    _segment = [[UISegmentedControl alloc] initWithItems:arr];
    _segment.frame = CGRectMake(-5, 0, ScreenWidth+10, ScreenWidth*0.14);
    _segment.selectedSegmentIndex = 1;
    _segment.tag = 667;
    _segment.tintColor = Color(7, 187, 177);
    // _segment.layer.borderColor = [[UIColor clearColor] CGColor];
    [_segment addTarget:self action:@selector(segMentValueChan:) forControlEvents:UIControlEventValueChanged];
    
    _segment.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _segment.layer.borderWidth = 5.0;
    _segment.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:_segment];
    
    [self createRight];
    
   // [self createRight];
    //[self createRight];
}

#pragma mark - segment selected
- (void)segMentValueChan:(UISegmentedControl *)sender{
    
    NSInteger index = sender.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            [_rightTableView removeFromSuperview];
            _leftTableView.hidden = NO;
            _rightTableView.hidden = YES;
            [self createLeft];
            [self initLeftData];
            //            [leftTableView reloadData];
            break;
            
        case 1:
            [_leftTableView removeFromSuperview];
            _leftTableView.hidden = YES;
            _rightTableView.hidden = NO;
            [self createRight];
            [self initRightData];
            //            [rightTableView reloadData];
            break;
            
        default:
            break;
    }
}

#pragma mark - create TableView
- (void)createLeft{
    
    
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.14, ScreenWidth, self.view.frame.size.height - ScreenWidth*0.14)];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.tag = 0;
    _leftTableView.separatorStyle = UITableViewCellAccessoryNone;
    //    [leftTableView registerNib:[UINib nibWithNibName:@"name" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:name];
    [self.view addSubview:_leftTableView];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tag = 1000;
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [_leftTableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
    
    
}
- (void)createRight{
    
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.14, ScreenWidth, self.view.frame.size.height - ScreenWidth*0.14)];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.tag = 1;
    _rightTableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:_rightTableView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tag = 1001;
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [_rightTableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
    
    
}

// 下拉刷新触发，在此获取数据
-(void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    if (refreshControl.tag == 1000) {
        // 此处添加刷新tableView数据的代码
        [refreshControl endRefreshing];
        [self initLeftData];
        // [_leftTableView reloadData];// 刷新tableView即可
    }
    if (refreshControl.tag == 1001) {
        // 此处添加刷新tableView数据的代码
        [refreshControl endRefreshing];
        [self initRightData];
        //  [_rightTableView reloadData];// 刷新tableView即可
    }
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 0) {
        
        return _dataLeftArray.count;
    }else if (tableView.tag == 1){
        
        return _dataRightArray.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ScreenWidth*0.6;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 0) {
        
        static NSString *stack = @"stack";
        XingchengTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stack];
        if (!cell) {
            
            cell = [[XingchengTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stack];
            //  NSDictionary *dictull = @{};
            cell.dict = _dataLeftArray[indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (tableView.tag == 1){
        
        static NSString *stac = @"stav";
        completeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stac];
        if (!cell) {
            
            cell = [[completeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stac];
            
        }
        //  NSDictionary *dictull = @{};
        cell.dict = _dataRightArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 0) {
           }
    else if (tableView.tag == 1){
        
        NSString *statuesString = _dataRightArray[indexPath.row][@"status"];
        
//        //未开始
//        if ([statuesString isEqualToString:@"1"]) {
//            CzWeiKaiSViewController *pipz = [CzWeiKaiSViewController new];
//            pipz.postIdString = _dataRightArray[indexPath.row][@"orderid"];
//            [self.navigationController pushViewController:pipz animated:YES];
//        }
        //未到达
        if ([statuesString isEqualToString:@"1"] || [statuesString isEqualToString:@"2"] || [statuesString isEqualToString:@"3"] || [statuesString isEqualToString:@"4"] || [statuesString isEqualToString:@"5"] || [statuesString isEqualToString:@"6"] || [statuesString isEqualToString:@"7"]) {
        
            WeidaodaAndFuwzViewController *wddAndfwz = [WeidaodaAndFuwzViewController new];
            wddAndfwz.hidesBottomBarWhenPushed = YES;
            wddAndfwz.postIdString = _dataRightArray[indexPath.row][@"orderid"];
            [self.navigationController pushViewController:wddAndfwz animated:YES];
            
        }
        //超时超公里
        if ([statuesString isEqualToString:@"8"]) {
            CzChaoshiGongliViewController *daoda = [CzChaoshiGongliViewController new];
            daoda.postIdString = _dataRightArray[indexPath.row][@"orderid"];
            [self.navigationController pushViewController:daoda animated:YES];
        }
        //未评价
        if ([statuesString isEqualToString:@"9"]) {
            CzWeiPingJiaViewController *daoda = [CzWeiPingJiaViewController new];
            daoda.postIdString = _dataRightArray[indexPath.row][@"orderid"];
            [self.navigationController pushViewController:daoda animated:YES];
        }
        //已完成
        if ([statuesString isEqualToString:@"99"]) {
            CzYiWanChengViewController *daoda = [CzYiWanChengViewController new];
            daoda.postIdString = _dataRightArray[indexPath.row][@"orderid"];
            [self.navigationController pushViewController:daoda animated:YES];
        }
    }

}

-(void)initLeftData{
    
    [MBProgressHUD showHUDAddedTo:_leftTableView animated:YES];
    
    NSNumber * Membership_Id =  [NSNumber numberWithInt:[[ZCUserData share].userId intValue]];
    
    NSDictionary *dict = @{@"userid":Membership_Id,@"status":@"1"};
    
    [HttpManager postData:dict andUrl:PATH_URL success:^(NSDictionary *fanhuicanshu) {
        
        
        NSLog(@"%@",fanhuicanshu);
        
        
        if ([fanhuicanshu[@"orderlist"] isKindOfClass:[NSNull class]]) {
            
            [_dataLeftArray removeAllObjects];
//            
//            UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"没有订单(1).png"]];
//            //            imageView.image=[UIImage imageNamed:@"11.jpg"];
//            [_leftTableView setBackgroundView:imageView];
            
            _leftTableView.tableHeaderView = [self returnTableViewHeadView];
            
            [_leftTableView reloadData];
        }else {
            NSArray *xclbDict = fanhuicanshu[@"orderlist"];
            
            
            //NSArray *xclbbArray = xclbDict[@"wwcfw"];
            //            if (_dataArray.count == 0) {
            [_dataLeftArray removeAllObjects];
            [_dataLeftArray addObjectsFromArray:xclbDict];
            
            if(_dataLeftArray.count == 0){
//                UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"没有订单(1).png"]];
//                //            imageView.image=[UIImage imageNamed:@"11.jpg"];
//                [_leftTableView setBackgroundView:imageView];
                   _leftTableView.tableHeaderView = [self returnTableViewHeadView];
            }else {
//                UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
//                imageView.image=[UIImage imageNamed:@""];
//                [_leftTableView setBackgroundView:imageView];
                   _leftTableView.tableHeaderView = [self NoTableViewHeadView];
                
            }
            [_leftTableView reloadData];
            
            }
        [MBProgressHUD hideHUDForView:_leftTableView animated:NO];

    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
}

-(void)initRightData{
    
     [MBProgressHUD showHUDAddedTo:_rightTableView animated:YES];
    
    NSNumber * Membership_Id =  [NSNumber numberWithInt:[[ZCUserData share].userId intValue]];
    
    NSDictionary *dict = @{@"userid":Membership_Id,@"status":@"2"};
    
    [HttpManager postData:dict andUrl:PATH_URL success:^(NSDictionary *fanhuicanshu) {
        
        
        if ([fanhuicanshu[@"orderlist"] isKindOfClass:[NSNull class]]) {
            
            [_dataRightArray removeAllObjects];
//            
//            UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"没有订单(1).png"]];
//            //            imageView.image=[UIImage imageNamed:@"11.jpg"];
//            [_rightTableView setBackgroundView:imageView];
            _rightTableView.tableHeaderView = [self returnTableViewHeadView];
            [_rightTableView reloadData];
            
        }else {
            
            NSArray *xclbDict = fanhuicanshu[@"orderlist"];
            
            [_dataRightArray removeAllObjects];
            [_dataRightArray addObjectsFromArray:xclbDict];
            
            if(_dataRightArray.count == 0){
//                UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"没有订单(1).png"]];
//                //            imageView.image=[UIImage imageNamed:@"11.jpg"];
//                [_rightTableView setBackgroundView:imageView];
                 _rightTableView.tableHeaderView = [self returnTableViewHeadView];
            }else {
               _rightTableView.tableHeaderView = [self NoTableViewHeadView];
                
            }
            
            [_rightTableView reloadData];
        }
         [MBProgressHUD hideAllHUDsForView:_rightTableView animated:NO];
        
    } Error:^(NSString *cuowuxingxi) {
        
        NSLog(@"%@",cuowuxingxi);
    }];
}
- (void)panDuanIsLogin{
    
    [self createSegment];
    UISegmentedControl *seg = (UISegmentedControl *)[self.view viewWithTag:667];
    if (seg.selectedSegmentIndex == 0) {
        [self initLeftData];
    }else {
        [self initRightData];
    }
}
-(UIView *)returnTableViewHeadView {
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.14, ScreenWidth, self.view.frame.size.height - ScreenWidth*0.14-49)];
    _view.alpha = 1.0;
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-65, (self.view.frame.size.height - ScreenWidth*0.14-49)/2 - 65, 130, 130)];
    imageview.image = [UIImage imageNamed:@"新的没有订单.png"];
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

/**
 return 未开始的时候所有的试图
 */
- (void)createView{
    _scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-ScreenWidth*0.1)];
    [self.view addSubview:_scrollView2];
    _scrollView2.pagingEnabled = YES;
    _scrollView2.delegate = self;
    _scrollView2.showsHorizontalScrollIndicator = NO;
    _scrollView2.clipsToBounds = NO;
    _scrollView2.contentSize = CGSizeMake(ScreenWidth*3, 0);
    
    _page = [[WYJPageView alloc] initWithFrame:CGRectMake(0, ScreenHeight-ScreenWidth*0.6, ScreenWidth, ScreenWidth*0.1)];
    _page.currentPage = 0;
    _page.numberOfPages = 3;
    [_page setSelect:[UIImage imageNamed:@"白1.png"]];
    [_page setDeselest:[UIImage imageNamed:@"白.png"]];
    [_page addTarget:self action:@selector(pageTuens:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_page];
    
    _backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-ScreenWidth*0.25)];
    _backgroundImg.image = [UIImage imageNamed:@"11.jpg"];
    _backgroundImg.userInteractionEnabled = YES;
    [_scrollView2 addSubview:_backgroundImg];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-ScreenWidth*0.25)];
    image2.image = [UIImage imageNamed:@"22.jpg"];
    image2.userInteractionEnabled = YES;
    [_scrollView2 addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, ScreenHeight-ScreenWidth*0.25)];
    image3.image = [UIImage imageNamed:@"33.jpg"];
    image3.userInteractionEnabled = YES;
    [_scrollView2 addSubview:image3];
    
    UILabel *zi1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.93, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi1.text = @"省去所有中间环节，尽享";
    zi1.textColor = [UIColor whiteColor];
    zi1.textAlignment = NSTextAlignmentCenter;
    zi1.font = [UIFont fontWithName:@"ArialMT" size:24];
    [_backgroundImg addSubview:zi1];
    UILabel *zi2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.83, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi2.text = @"信息透明为您带来的";
    zi2.textColor = [UIColor whiteColor];
    zi2.textAlignment = NSTextAlignmentCenter;
    zi2.font = [UIFont fontWithName:@"ArialMT" size:24];
    [_backgroundImg addSubview:zi2];
    UILabel *jia1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.73, ScreenWidth*0.8, ScreenWidth*0.1)];
    jia1.text = @"实惠价格与优质服务";
    jia1.textColor = [UIColor whiteColor];
    jia1.textAlignment = NSTextAlignmentCenter;
    jia1.font = [UIFont fontWithName:@"ArialMT" size:24];
    [_backgroundImg addSubview:jia1];
    
    UILabel *zi3 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.83, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi3.text = @"完善的1对1车辆评价机制，";
    zi3.textColor = [UIColor whiteColor];
    zi3.textAlignment = NSTextAlignmentCenter;
    zi3.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image2 addSubview:zi3];
    UILabel *zi4 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.73, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi4.text = @"有效监督车辆的规范服务。";
    zi4.textColor = [UIColor whiteColor];
    zi4.textAlignment = NSTextAlignmentCenter;
    zi4.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image2 addSubview:zi4];
    
    UILabel *zi5 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.93, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi5.text = @"以赤城执着的匠人之心，";
    zi5.textColor = [UIColor whiteColor];
    zi5.textAlignment = NSTextAlignmentCenter;
    zi5.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image3 addSubview:zi5];
    UILabel *zi6 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.83, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi6.text = @"为您做好100%的准备，";
    zi6.textColor = [UIColor whiteColor];
    zi6.textAlignment = NSTextAlignmentCenter;
    zi6.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image3 addSubview:zi6];
    UILabel *zi7 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.73, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi7.text = @"解决您100%的问题！";
    zi7.textColor = [UIColor whiteColor];
    zi7.textAlignment = NSTextAlignmentCenter;
    zi7.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image3 addSubview:zi7];
    
    
    _jinruButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jinruButton setTitle:@"开始新行程" forState:UIControlStateNormal];
    [_jinruButton addTarget:self action:@selector(jinNextPage:) forControlEvents:UIControlEventTouchUpInside];
    _jinruButton.frame = CGRectMake(0, ScreenHeight-44-ScreenWidth*0.13-64, ScreenWidth, ScreenWidth*0.13);
    _jinruButton.backgroundColor = Color(255, 87, 87);
    [self.view addSubview:_jinruButton];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //  int count = scrollView.contentOffset.x/ScreenWidth;
    //    [UIView animateWithDuration:0.3 animations:^
    //     {
    //         _lineLabel.center =  CGPointMake(ScreenWidth/3/2+(ScreenWidth/3)*count, ScreenWidth*0.13);
    //     }];
    //
    CGFloat currentPostion = _scrollView2.contentOffset.x;
    int i = (currentPostion+ScreenWidth/2)/ScreenWidth;
    _page.currentPage = i;
    if (i == 0) {
        _jinruButton.backgroundColor = Color(255, 87, 87);
    }
    if (i == 1) {
        
        _jinruButton.backgroundColor = Color(255, 177, 7);
    }if (i == 2) {
        
        _jinruButton.backgroundColor = Color(0, 97, 107);
    }
}
- (void)pageTuens:(UIPageControl *)sender{
    
    // CGSize viewSize = _scrollView.frame.size;
    // CGRect rect = CGRectMake(sender.currentPage*viewSize.width, 0, viewSize.width, viewSize.height);
    //[_scrollView scrollRectToVisible:rect animated:YES];
    
    NSInteger page1 = _page.currentPage;
    [_scrollView2 setContentOffset:CGPointMake(ScreenWidth*page1, 0)];
}
- (void)jinNextPage:(UIButton *)button{
    //
    RootViewcontroller *view = [[RootViewcontroller alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = view;
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
// */
//-(void)zhijiedenglu {
//    [HttpManager postData:@{@"userid": [ZCUserData share].userId} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=member" success:^(NSDictionary *fanhuicanshu) {
//        //
//        //获取Token的接口
//        NSString *url = @"http://api.cn.ronghub.com/user/getToken.json";
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
//        //在这post    userId 接口
//        
//        NSString  *userid = [ZCUserData share].userId;
//        NSString  *username =  fanhuicanshu[@"arr"][@"nickname"];
//        NSString *catTu = [NSString stringWithFormat:@"%@",fanhuicanshu[@"arr"][@"thumb"]];
//        
//        NSDictionary *dict = @{@"userId":userid,@"userName":username,@"portraiUri":catTu};
//        NSString *appkey = @"kj7swf8ok47u2";
//        NSString *nonce = [self getRandomNonce];
//        NSString *timestamp = [self getTimestamp];
//        NSString *signature = [self getSignatureWithAppSecret:@"Kv26rgnvLRR" nonce:nonce timestamp:timestamp];
//        
//        NSLog(@"-------%@",appkey);
//        NSLog(@"-------%@",nonce);
//        NSLog(@"--------%@",timestamp);
//        NSLog(@"---------%@",signature);
//        
//        [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
//        [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
//        [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
//        [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
//        [manager.requestSerializer setValue:@"Kv26rgnvLRR" forHTTPHeaderField:@"appSecret"];
//        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//        [manager POST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            NSLog(@"%@",responseObject[@"token"]);
//            //   [self initLoacalTestData];
//            RCUserInfo *aUserInfo1 =[[RCUserInfo alloc]initWithUserId:userid name:username portrait:catTu QQ:@"" sex:@""];
//            RCUserInfo *aUserInfo = aUserInfo1;
//            NSString *token;
//            if([aUserInfo.userId intValue] == [userid intValue]){
//                token = responseObject[@"token"];
//            }
//            
//            [self loginRongCloudWithUserInfo:[[RCUserInfo alloc]initWithUserId:aUserInfo.userId name:aUserInfo.name portrait:aUserInfo.portraitUri QQ:aUserInfo.QQ sex:aUserInfo.sex] withToken:token];
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error);
//        }];
//        NSLog(@"点我干啥");
//        
//    } Error:^(NSString *cuowuxingxi) {
//        
//    }];
//    
//
//}
//-(void)loginRongCloudWithUserInfo:(RCUserInfo *)userInfo withToken:(NSString *)token{
//    
//    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
//        [RCIM sharedRCIM].globalNavigationBarTintColor = [UIColor redColor];
//        
//        [RCIMClient sharedRCIMClient].currentUserInfo = userInfo;
//        [[RCDataManager shareManager] refreshBadgeValue];
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"status = %ld",(long)status);
//    } tokenIncorrect:^{
//        
//        NSLog(@"token 错误");
//    }];
//    
//}
//
//-(NSString *)sha1WithKey:(NSString *)key
//{
//    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:key.length];
//    
//    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
//    
//    CC_SHA1(data.bytes, data.length, digest);
//    
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//    
//    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
//        [output appendFormat:@"%02x", digest[i]];
//    }
//    
//    return output;
//}
////获取随机数
//-(NSString *)getRandomNonce
//{
//    NSInteger randomValue = [self getRandomNumber:100000 to:999999];
//    return  [NSString stringWithFormat:@"%ld",randomValue];
//}
////获取时间戳 从1970年
//-(NSString *)getTimestamp
//{
//    NSDate *date = [NSDate date];
//    NSTimeInterval times =  [date timeIntervalSince1970];
//    return [NSString stringWithFormat:@"%.0f",times];
//}
//
////获取从 from 到  to 的随机数
//-(NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
//{
//    return (NSInteger)(from + (arc4random() % (to - from + 1)));
//}
//
//
////根据appSecret nonce timestamp 获取signature
//-(NSString *)getSignatureWithAppSecret:(NSString *)appSecret nonce:(NSString *)nonce timestamp:(NSString *)timestamp
//{
//    NSString *sha1String = [NSString stringWithFormat:@"%@%@%@",appSecret,nonce,timestamp];
//    return [self sha1WithKey:sha1String];
//}
@end
