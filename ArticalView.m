//
//  ViewController.m
//  CarsLeiSi
//
//  Created by MacBookXcZl on 2017/5/31.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
//

#import "ArticalView.h"
#import "FSSegmentTitleView.h"
#import "HttpManager.h"
#import "HotMenTableViewCell.h"
#import "HotMKUrlViewController.h"
#import "HeadTitleView.h"
#import "MBProgressHUD.h"

@interface ArticalView ()<UITableViewDelegate,UITableViewDataSource,FSSegmentTitleViewDelegate,UIScrollViewDelegate> {
    
    
    NSMutableArray *_dataArray;
    NSMutableArray *_leftDataArray;
    NSMutableArray *_rightDataArray;
    HeadTitleView *_headTitleView;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) FSBottomTableViewCell *contentCell;
@property (nonatomic, strong) FSSegmentTitleView *titleView1;
@end

@implementation ArticalView

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication
      sharedApplication]
     setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent  = NO;
    
    //  [UINavigationBar appearance].barTintColor = [UIColor blackColor];
    
    self.tabBarController.tabBar.hidden = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.leftTableView.backgroundColor = [UIColor whiteColor];
    self.rightTableView.backgroundColor = [UIColor whiteColor];
    [self initData0];
    [self initData1];
    [self initData2];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    //imageView.backgroundColor = [UIColor redColor];
    _headTitleView = [[HeadTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //_headTitleView.backgroundColor = [UIColor redColor];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2- (self.view.frame.size.width/7-16)/2, 10, self.view.frame.size.width/7-16, self.view.frame.size.width/7-16)];
    [_headTitleView addSubview:imageView1];
    //imageView1.backgroundColor = [UIColor redColor];
    imageView1.image = [UIImage imageNamed:@"logo浅.png"];
    
    self.navigationItem.titleView = _headTitleView;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray new];
    _leftDataArray = [NSMutableArray new];
    _rightDataArray = [NSMutableArray new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titleView1 = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) titles:@[@"热 门",@"活 动",@"体 验"] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    [self.view addSubview:self.titleView1];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)initData0 {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [HttpManager postData:@{} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_faxian" success:^(NSDictionary *fanhuicanshu) {
        if ([fanhuicanshu[@"faxian"] isKindOfClass:[NSNull class]]) {
            
        }else {
            [_dataArray removeAllObjects];
            NSArray *fanhui = fanhuicanshu[@"faxian"] ;
            [_dataArray addObjectsFromArray:fanhui];
            [self.tableView reloadData];
            NSLog(@"1");
        }
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"2");
        NSLog(@"%@",cuowuxingxi);
    }];
    
}

-(void)initData1 {
    
    [_leftDataArray removeAllObjects];
    [_leftDataArray addObjectsFromArray:@[]];
    [self.leftTableView reloadData];
}
-(void)initData2 {
    
    
    [_rightDataArray removeAllObjects];
    [_rightDataArray addObjectsFromArray:@[]];
    [self.rightTableView reloadData];
}
#pragma mark --tableViedwDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_tableView == tableView) {
        return _dataArray.count;
        
    }else if (_leftTableView == tableView) {
        return _leftDataArray.count;
        
    }else if (_rightTableView == tableView) {
        return _rightDataArray.count;
        
    }else {
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.frame.size.width*2/3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *stave = @"state";
    if (_tableView == tableView) {
        
        HotMenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stave];
        if(!cell) {
            cell = [[HotMenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stave];
        }
        //cell.textLabel.text = [NSString stringWithFormat: @"%ld",indexPath.row];
        cell.dict = _dataArray[indexPath.row];
        return cell;
    }else if (_leftTableView == tableView ) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stave];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stave];
        }
        cell.textLabel.text = [NSString stringWithFormat: @"%ld",indexPath.row];
        return cell;
    }else  if (_rightTableView == tableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stave];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stave];
        }
        cell.textLabel.text = [NSString stringWithFormat: @"%ld",indexPath.row];
        return cell;
    }else {
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_tableView == tableView) {
        
        HotMKUrlViewController *url = [HotMKUrlViewController new];
        url.urlString = _dataArray[indexPath.row][@"url"];
        url.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:url animated:YES];
        
    }else if (_leftTableView == tableView) {
        
    }else if (_rightTableView == tableView) {
        
    }else {
        
    }
    
}

#pragma mark LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-50-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        [self.scrollView addSubview:self.tableView];
    }
    return _tableView;
}
-(UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-50-49) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.bounces = YES;
        _leftTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂无活动(1).png"]];
        _leftTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        [self.scrollView addSubview:self.leftTableView];
    }
    return _leftTableView;
}
-(UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)*2, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-50-49) style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.bounces = YES;
        _rightTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂无体验(1).png"]];
        _rightTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        [self.scrollView addSubview:self.rightTableView];
    }
    return _rightTableView;
    
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-50-49)];
        _scrollView.delegate = self;
        _scrollView.contentOffset = CGPointMake( 0, 0);
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds)*3, CGRectGetHeight(self.view.bounds)-49-50);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
#pragma mark FSSegmentTitleViewDelegate

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    switch (endIndex) {
        case 0:{
            NSLog(@"0");
            _scrollView.contentOffset = CGPointMake(0, 0);
            [self initData0];
            break;
        }
        case 1:{
            NSLog(@"1");
            _scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.view.bounds),  0);
            [self initData1];
            break;
        }
        case 2:{
            NSLog(@"2");
            _scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.view.bounds)*2,  0);
            [self initData2];
            break;
        }
        default:
            break;
    }
}
#pragma mark scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x/CGRectGetWidth(self.view.bounds)+0.5;
    NSLog(@"%ld",index);
    if (self.scrollView == scrollView) {
        self.titleView1.selectIndex = index;
        //        _tableView.alpha = 0;
        if(index == 0) {
            
            
            //            [UIView animateWithDuration:0.3 animations:^{
            //                _tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-49-50);
            //                _tableView.alpha = 1;
            //            }];
            [self initData0];
        }else  if(index == 1) {
            
            
            //            [UIView animateWithDuration:0.3 animations:^{
            //                _tableView.frame = CGRectMake(1*CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-49-50);
            //                _tableView.alpha = 1;
            //            }];
            [self initData1];
            
        }
        else  if(index == 2) {
            
            
            //            [UIView animateWithDuration:0.3 animations:^{
            //                _tableView.frame = CGRectMake(2*CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-49-50);
            //                _tableView.alpha = 1;
            //            }];
            [self initData2];
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
