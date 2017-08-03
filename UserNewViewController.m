//
//  UserNewViewController.m
//  ZuChe
//
//  Created by MacBookXcZl on 2017/5/23.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "UserNewViewController.h"
#import "ZCUserData.h"
#import "Header.h"
#import "HttpManager.h"
#import "WYJPageView.h"
#import "RootViewcontroller.h"

//#import "NoPayViewController.h"
//#import "PipzViewController.h"
//#import "NoStartViewController.h"
//#import "JhzViewController.h"
//#import "GetViewController.h"
//#include "DengDiafwViewController.h"
//#import "FuwzViewController.h"
//#import "ChaoshichaoGlViewController.h"
#import "NoPjViewController.h"
#import "YongHuXingChengDetailsViewController.h"
#import "YesFinaViewController.h"

//#import "WaitPiPeiViewController.h"


#import "JxzTableViewCell.h"
#import "NoFinnedTableViewCell.h"
#import "AFNetworking.h"

#import "XcHistoryViewController.h"

#import "MBProgressHUD.h"
#import "WnahcnegfuwuTableViewCell.h"

#define PATH_URL @"http://wx.leisurecarlease.com/api.php?op=api_xclb"

@interface UserNewViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
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

@implementation UserNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
     self.navigationItem.title = @"行程中心";
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
    [self.navigationController pushViewController:[XcHistoryViewController new] animated:YES];
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent  = NO;
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;

    
    __block UserNewViewController *blockSelf = self;
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
                    break;
                }else{
                    [blockSelf.leftTableView removeFromSuperview];
                    [blockSelf.rightTableView removeFromSuperview];
                    [blockSelf.segment removeFromSuperview];
                    [blockSelf.scrollView2 removeFromSuperview];
                    [blockSelf.page removeFromSuperview];
                    [blockSelf.jinruButton removeFromSuperview];
                    [blockSelf createView];
                    break;
                }
            }
        }
    }];
    
    [self.manager startMonitoring];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
   
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
#pragma mark - create segment

- (void)createSegment{
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"进行中", @"已完成", nil];
    _segment = [[UISegmentedControl alloc] initWithItems:arr];
    _segment.frame = CGRectMake(-5, 0, ScreenWidth+10, ScreenWidth*0.14);
    _segment.selectedSegmentIndex = 0;
    _segment.tag = 667;
    _segment.tintColor = Color(7, 187, 177);
   // _segment.layer.borderColor = [[UIColor clearColor] CGColor];
    [_segment addTarget:self action:@selector(segMentValueChang:) forControlEvents:UIControlEventValueChanged];
    
    _segment.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _segment.layer.borderWidth = 5.0;
    _segment.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:_segment];
    
    [self createLeft];
    //[self createRight];
}

#pragma mark - segment selected
- (void)segMentValueChang:(UISegmentedControl *)sender{
    
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
    [self.view addSubview:_leftTableView];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tag = 1000;
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [_leftTableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
    
}

-(UIView *)returnTableViewHeadView {
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.14, ScreenWidth, self.view.frame.size.height - ScreenWidth*0.14)];
    _view.alpha = 1.0;

    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-65, (self.view.frame.size.height - ScreenWidth*0.14)/2 - 65, 130, 130)];
    imageview.image = [UIImage imageNamed:@"新的没有订单.png"];
    [_view addSubview:imageview];
    
    return _view;
}
-(UIView *)NoTableViewHeadView {
    
    _view = [[UIView alloc] init];
    _view.alpha = 0.0;
   
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-65, (self.view.frame.size.height - ScreenWidth*0.14)/2 - 65, 130, 130)];
    imageview.image = [UIImage imageNamed:@""];
    [_view addSubview:imageview];
    
    return _view;
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
    
    return ScreenWidth*0.8*8/11 +ScreenWidth*0.02;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 0) {
        
        static NSString *stack = @"stack";
        JxzTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stack];
        if (!cell) {
            
            cell = [[JxzTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stack];
        }
        cell.dict = _dataLeftArray[indexPath.row];
        
        cell.groupId = _dataLeftArray[indexPath.row][@"groupid"];
      //  cell.groupId =
        //        cell.tagId = indexPath.row;
        //        cell.delgate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (tableView.tag == 1){
        
        static NSString *stac = @"stav";
        WnahcnegfuwuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stac];
        if (!cell) {
            
            cell = [[WnahcnegfuwuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stac];
        }
        cell.dict = _dataRightArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 0) {
        
        
       
        NSString *statuesString = _dataLeftArray[indexPath.row][@"state"];
//        
//        if ([statuesString isEqualToString:@"待支付定金"]) {
//            
//            NoPayViewController *noPay = [NoPayViewController new];
//            [self.navigationController pushViewController:noPay animated:YES];
//            noPay.postIdString = _dataLeftArray[indexPath.row][@"id"];
//            noPay.poststates = _dataLeftArray[indexPath.row][@"status"];
//            NSLog(@"0000000000000000000000%@%@",noPay.poststates,noPay.postIdString);
//            
//        }else if ([statuesString isEqualToString:@"等待匹配"]) {
//            
//            WaitPiPeiViewController *pipz = [WaitPiPeiViewController new];
//            [self.navigationController pushViewController:pipz animated:YES];
//            pipz.postIdString = _dataLeftArray[indexPath.row][@"id"];
//            pipz.poststates = _dataLeftArray[indexPath.row][@"status"];
//            NSLog(@"0000000000000000000000%@%@",pipz.poststates,pipz.postIdString);
//            
//        }else if ([statuesString isEqualToString:@"匹配中"]) {
//            
//            PipzViewController *pipz = [PipzViewController new];
//            [self.navigationController pushViewController:pipz animated:YES];
//            pipz.postIdString = _dataLeftArray[indexPath.row][@"id"];
//            pipz.poststates = _dataLeftArray[indexPath.row][@"status"];
//            NSLog(@"0000000000000000000000%@%@",pipz.poststates,pipz.postIdString);
//            
//        }else if ([statuesString isEqualToString:@"未开始"]) {
//            
//            NoStartViewController *noStar = [NoStartViewController new];
//            [self.navigationController pushViewController:noStar animated:YES];
//            noStar.postIdString = _dataLeftArray[indexPath.row][@"id"];
//            noStar.poststates = _dataLeftArray[indexPath.row][@"status"];
//            
//        }else if ([statuesString isEqualToString:@"集合中"]) {
//            
//            JhzViewController *jhz = [JhzViewController new];
//            [self.navigationController pushViewController:jhz animated:YES];
//            jhz.postIdString = _dataLeftArray[indexPath.row][@"id"];
//            jhz.poststates = _dataLeftArray[indexPath.row][@"status"];
//            
//        }else if ([statuesString isEqualToString:@"待支付尾款"]) {
//            
//            GetViewController *getView = [GetViewController new];
//            [self.navigationController pushViewController: getView animated:YES];
//            getView.postIdString = _dataLeftArray[indexPath.row][@"id"];
//            getView.poststates = _dataLeftArray[indexPath.row][@"status"];
//            
//        }else if ([statuesString isEqualToString:@"等待服务"]) {
//            
//            DengDiafwViewController *fuz = [DengDiafwViewController new];
//            [self.navigationController pushViewController:fuz animated:YES];
//            fuz.postIdString = _dataLeftArray[indexPath.row][@"id"];
//            fuz.poststates = _dataLeftArray[indexPath.row][@"status"];
//            
//        }else if ([statuesString isEqualToString:@"服务中"]) {
//            
//            FuwzViewController *fuz = [FuwzViewController new];
//            [self.navigationController pushViewController:fuz animated:YES];
//            fuz.postIdString = _dataLeftArray[indexPath.row][@"id"];
//            fuz.poststates = _dataLeftArray[indexPath.row][@"status"];
//            
//        }else if ([statuesString isEqualToString:@"待支付超时费用"]) {
//            
//            ChaoshichaoGlViewController *fuz = [ChaoshichaoGlViewController new];
//            [self.navigationController pushViewController:fuz animated:YES];
//            fuz.postIdString = _dataLeftArray[indexPath.row][@"id"];
//            fuz.poststates = _dataLeftArray[indexPath.row][@"status"];
//            
//        }else
        
        if ([statuesString isEqualToString:@"未评价"]) {
//            
            NoPjViewController * noPj = [NoPjViewController new];
            noPj.hidesBottomBarWhenPushed = YES;
            noPj.postIdString = _dataLeftArray[indexPath.row][@"id"];
            
            noPj.poststates = _dataLeftArray[indexPath.row][@"status"];
//            animation.subtype = kCATransitionFromLeft;
//            [self.view.window.layer addAnimation:animation forKey:nil];
//
            [self.navigationController pushViewController: noPj animated:YES];
          
            
        }else {
            YongHuXingChengDetailsViewController *noPay = [YongHuXingChengDetailsViewController new];
            noPay.hidesBottomBarWhenPushed = YES;
            noPay.postIdString = _dataLeftArray[indexPath.row][@"id"];

            [self.navigationController pushViewController:noPay animated:YES];
           
        }
    }
    else if (tableView.tag == 1){
        
        NSString *statuesString1 = _dataRightArray[indexPath.row][@"state"];
        
        if ([statuesString1 isEqualToString:@"已完成"]) {
            
            YesFinaViewController *fin = [YesFinaViewController new];
            fin.hidesBottomBarWhenPushed = YES;
            fin.postIdString = _dataRightArray[indexPath.row][@"id"];
            fin.poststates = _dataRightArray[indexPath.row][@"status"];
            [self.navigationController pushViewController:fin animated:YES];
           
            
        }
    }
}

-(void)initLeftData{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    NSNumber * Membership_Id =  [NSNumber numberWithInt:[[ZCUserData share].userId intValue]];
    
    NSDictionary *dict = @{@"userid":Membership_Id};
    
    [HttpManager postData:dict andUrl:PATH_URL success:^(NSDictionary *fanhuicanshu) {
        

        NSLog(@"%@",fanhuicanshu);
        
        
        
        if ([fanhuicanshu[@"xclb"] isKindOfClass:[NSNull class]]) {
            
            [_dataLeftArray removeAllObjects];
//            
//            UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"没有订单(1).png"]];
//            //            imageView.image=[UIImage imageNamed:@"11.jpg"];
//            [_leftTableView setBackgroundView:imageView];
            
            _leftTableView.tableHeaderView = [self returnTableViewHeadView];
            
            [_leftTableView reloadData];
        }else {
    
            NSArray *xclbDict = fanhuicanshu[@"xclb"];

          //  NSArray *xclbbArray = xclbDict[@"wwcfw"];
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
           
            [MBProgressHUD hideHUDForView:self.view animated:NO];
        }
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
}

-(void)initRightData{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSNumber * Membership_Id =  [NSNumber numberWithInt:[[ZCUserData share].userId intValue]];
    
    NSDictionary *dict = @{@"userid":Membership_Id,@"status":@"99"};
    
    [HttpManager postData:dict andUrl:PATH_URL success:^(NSDictionary *fanhuicanshu) {
        
      
        if ([fanhuicanshu[@"xclb"] isKindOfClass:[NSNull class]]) {
            
            [_dataRightArray removeAllObjects];
//            
//            UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"没有订单(1).png"]];
//            //            imageView.image=[UIImage imageNamed:@"11.jpg"];
//            [_rightTableView setBackgroundView:imageView];
              _rightTableView.tableHeaderView = [self returnTableViewHeadView];
            [_rightTableView reloadData];
            
        }else {
            NSArray *xclbDict = fanhuicanshu[@"xclb"];
          //  NSArray *xclbbArray = xclbDict[@"wwcfw"];
            [_dataRightArray removeAllObjects];
            [_dataRightArray addObjectsFromArray:xclbDict];
            
            if(_dataRightArray.count == 0){
//                UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"没有订单(1).png"]];
//                //            imageView.image=[UIImage imageNamed:@"11.jpg"];
//                [_rightTableView setBackgroundView:imageView];
                  _rightTableView.tableHeaderView = [self returnTableViewHeadView];
            }else {
//                UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
//                [_rightTableView setBackgroundView:imageView];
                  _rightTableView.tableHeaderView = [self NoTableViewHeadView];
                
            }
            
            [_rightTableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:NO];
        }
        
    } Error:^(NSString *cuowuxingxi) {
        
        NSLog(@"%@",cuowuxingxi);
    }];
}
- (void)panDuanIsLogin{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager  POST:@"http://wx.leisurecarlease.com/api.php?op=iforder" parameters:@{@"userid":[ZCUserData share].userId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = [NSData dataWithData:responseObject];
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        // NSString *str =  [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        // NSLog(@"wocoanimabi caonimabi%@",str);
        NSString  *dingdan=[NSString stringWithFormat:@"%@",[[NSDictionary dictionaryWithDictionary:dict] objectForKey:@"error"]];
        if ([dingdan isEqualToString:@"0"]) {
            //有数据
            // [wself itinerary];
            [self createSegment];
            UISegmentedControl *seg = (UISegmentedControl *)[self.view viewWithTag:667];
            if (seg.selectedSegmentIndex == 0) {
                [self initLeftData];
            }else {
                [self initRightData];
            }
        }else
        {
            [self createView];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@<<<<<<<<<<<<",error);
        
    }];
    
}

/**
 return 未开始的时候所有的试图
 */
- (void)createView{
    _scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49)];
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
    
    _backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49)];
    _backgroundImg.image = [UIImage imageNamed:@"11.jpg"];
    _backgroundImg.userInteractionEnabled = YES;
    [_scrollView2 addSubview:_backgroundImg];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-ScreenWidth*0.12)];
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
 */

@end
