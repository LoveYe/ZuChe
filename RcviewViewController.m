//
//  RcviewViewController.m
//  ZuChe
//
//  Created by MacBookXcZl on 2017/6/12.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "RcviewViewController.h"
#import "Header.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "HttpManager.h"
#import "ZCUserData.h"
#import "SecondTabbar.h"
#import "PJTableViewCell.h"
#import "DetailPjViewController.h"


@interface RcviewViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    
    NSMutableArray *_dataLeftArray;
    UIRefreshControl *refreshControl;
    
    UIImageView *_imageView;
    UIButton *_imageButton;
    NSMutableDictionary *_deticDict;
}
@property (nonatomic, strong) UITableView *leftTableView;
@end


@implementation RcviewViewController


#define PJPATH @"http://wx.leisurecarlease.com/tc.php?op=dianping_list"

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent  = NO;
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self initLeftData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataLeftArray = [NSMutableArray new];
    _deticDict = [NSMutableDictionary new];
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(gobackTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;

}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataLeftArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0.13*ScreenHeight+2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        static NSString *stack = @"stack";
        PJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stack];
        if (!cell) {
            
            cell = [[PJTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stack];
        }
       // cell.textLabel.text = @"1";
        cell.dict = _dataLeftArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DetailPjViewController *view = [DetailPjViewController new];
    view.caridtring = _dataLeftArray[indexPath.row][@"carid"];
    [self.navigationController pushViewController:view animated:YES];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.36)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *pjLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05,0, ScreenWidth*0.9, ScreenWidth*0.2)];
    //  pjLabel.backgroundColor = [UIColor purpleColor];
    pjLabel.text = @"评价";
    pjLabel.textAlignment = NSTextAlignmentLeft;
    pjLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:35];
    pjLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    [headView addSubview:pjLabel];
    
    
    
    UILabel *leiJiLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.15, ScreenWidth*0.9, ScreenWidth*0.2)];
    leiJiLabel.textAlignment = NSTextAlignmentLeft;
    leiJiLabel.text = [NSString stringWithFormat:@"累计收到%ld条评价",[_deticDict[@"num"] integerValue]];
    leiJiLabel.textColor =  [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
    leiJiLabel.font =  [UIFont fontWithName:@"ArialMT" size:20];;
    [headView addSubview:leiJiLabel];
    
    UILabel *xianLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.36-1.3, 50, 1.3)];
    xianLabel.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    [headView addSubview:xianLabel];
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return ScreenWidth*0.36;
}


//解析数据模型

-(void)initLeftData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSNumber * Membership_Id =  [NSNumber numberWithInt:[[ZCUserData share].userId intValue]];
    
    NSDictionary *dict = @{@"userid":Membership_Id};
    
    [HttpManager postData:dict andUrl:PJPATH success:^(NSDictionary *fanhuicanshu) {
        
        NSLog(@"%@",fanhuicanshu);
        

        NSArray *array = fanhuicanshu[@"list"];
        if (array.count == 0) {
            
            [self creatIMageView];
            [_leftTableView removeFromSuperview]
            ;
        }else {
            [self createLeft];
            [_imageView removeFromSuperview];
            [_imageButton removeFromSuperview];
            
            [_deticDict removeAllObjects];
            [_deticDict addEntriesFromDictionary:fanhuicanshu];
            
            
            [_dataLeftArray removeAllObjects];
            [_dataLeftArray addObjectsFromArray:array];
            
        }
        
        [_leftTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view  animated:NO];
        [refreshControl endRefreshing];
        
    } Error:^(NSString *cuowuxingxi) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [refreshControl endRefreshing];
        
    }];
    
}


//创建ui

-(void)creatIMageView {
    
    _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"没有评价.png"]];
    _imageView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imageButton setTitle:@"分享爱车" forState:UIControlStateNormal];
    _imageButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_imageButton addTarget:self action:@selector(jinNextPage:) forControlEvents:UIControlEventTouchUpInside];
    _imageButton.frame = CGRectMake(0, ScreenHeight-64-ScreenWidth*0.13, ScreenWidth, ScreenWidth*0.13);
    _imageButton.backgroundColor = Color(7, 187, 197);
    [_imageView addSubview:_imageButton];
}

- (void)createLeft{
    
    
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = UITableViewCellAccessoryNone;
    //    [leftTableView registerNib:[UINib nibWithNibName:@"name" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:name];
    _leftTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_leftTableView];
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tag = 1000;
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [_leftTableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    
    
}

//点击跳进发布爱车

- (void)jinNextPage:(UIButton *)button{
    //
    SecondTabbar *view = [[SecondTabbar alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = view;
}

//返回主视图

-(void) gobackTo {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//下拉刷新

-(void)refreshClick:(UIRefreshControl *)refresh {
    
    [refresh endRefreshing];
    [self.leftTableView reloadData];
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
