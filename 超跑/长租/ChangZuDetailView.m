//
//  ChangZuDetailView.m
//  ZuChe
//
//  Created by apple  on 2017/7/14.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ChangZuDetailView.h"
#import "Header.h"
#import "HttpManager.h"
#import "CustomOrderView.h"
#import "CarDetailInfoCell.h"
#import "ChangzuDTCell.h"

#import "AboutUsViewController.h"

#import "UIViewController+YSLTransition.h"
#import "YSLTransitionAnimator.h"
#import "GiFHUD.h"
#import "UIImageView+WebCache.h"
#import "ChangzuView.h"
#import "ChangBaoView.h"
#import "ZCUserData.h"

#import "XieYiViewController.h"

#define CarDetailInfo @"http://wx.leisurecarlease.com/api.php?op=api_cartypexq"

@interface ChangZuDetailView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,YSLTransitionAnimatorDataSource,CarDetailDelegate>{
    
    BOOL _isClick1;
    CGFloat width;
    CGFloat height;
    UITableView *_tableView;
    NSDictionary *dicta;
    NSDictionary *dicta2;
    NSString *url;
    
    NSString *_typeCar;
    
    NSString *_color;
    
    NSMutableArray *likeArray;
    NSMutableArray *imgArray;
    NSMutableArray *priceArray;
    NSMutableArray *pjArray;
    NSMutableArray *typeArray;
    NSMutableArray *plateArray;
    NSMutableArray *iconArray;
    NSMutableArray *colorArray;
    NSMutableArray *nameArray;
    NSMutableArray *starArray;
    
    BOOL  isPOISearch[4];
    bool isGeoSearch;
    
    UIImageView *_chuanImage;
}

@property (nonatomic , retain)UIImageView *carImageView;

@end

@implementation ChangZuDetailView

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.translucent = NO;
    [self downLoadData];
    
    [self searchCollection];
}
#pragma mark - 查询是否收藏
- (void)searchCollection{
    
    UIButton *timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(0, 0, 25, 25);
    //    [timeBtn setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
    
    [timeBtn addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barTimeBtn=[[UIBarButtonItem alloc]initWithCustomView:timeBtn];
    self.navigationItem.rightBarButtonItem = barTimeBtn;
    NSDictionary *dictionary = @{@"userid":[ZCUserData share].userId,@"carid":self.carid,@"model":@"select",@"cartype":self.cartype};
    
    [HttpManager postData:dictionary andUrl:@"http://wx.leisurecarlease.com/api.php?op=shoucang" success:^(NSDictionary *fanhuicanshu) {
        
        if ([fanhuicanshu[@"error"] isEqualToString:@"1"]) {
            
            timeBtn.selected = NO;
            [timeBtn setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
        }else{
            
            timeBtn.selected = YES;
            [timeBtn setBackgroundImage:[UIImage imageNamed:@"收藏333.png"] forState:UIControlStateNormal];
        }
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    
    // [super viewDidAppear:animated];
    [self ysl_addTransitionDelegate:self];
    // pop
    [self ysl_popTransitionAnimationWithCurrentScrollView:nil
                                    cancelAnimationPointY:0
                                        animationDuration:0.3
                                  isInteractiveTransition:YES];
}
- (void)downLoadData{
    
    NSDictionary *dic = @{@"carid":self.carid,@"type":self.cartype};
    
    [HttpManager postData:dic andUrl:CarDetailInfo success:^(NSDictionary *fanhuicanshu) {
        
        NSLog(@"---%@",fanhuicanshu);
        dicta = fanhuicanshu[@"carinfo"];
        dicta2 = fanhuicanshu;
        
        _carPrice = dicta[@"jiage1"];
        _color = dicta[@"color"];
        likeArray = fanhuicanshu[@"xscarlist"];
        _typeCar = dicta[@"cartype"];
        
        UIView *view = [GiFHUD new];
        [GiFHUD setGifWithImageName:@"动态gif.gif"];
        [GiFHUD show];
        _tableView.scrollEnabled = NO;
        
        [self performSelector:@selector(stopit) withObject:view afterDelay:0.5];
        
    } Error:^(NSString *cuowuxingxi) {
        
        NSLog(@"%@",cuowuxingxi);
    }];
}
- (void)stopit{
    
    [GiFHUD dismiss];
    
    [self createScrollView];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    [self ysl_removeTransitionDelegate];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.title = @"车辆信息";
    _isClick1 = YES;
    dicta = [NSDictionary dictionary];
    url = [NSString string];
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    likeArray  = [NSMutableArray array];
    imgArray   = [NSMutableArray array];
    priceArray = [NSMutableArray array];
    pjArray    = [NSMutableArray array];
    typeArray  = [NSMutableArray array];
    plateArray = [NSMutableArray array];
    iconArray  = [NSMutableArray array];
    colorArray = [NSMutableArray array];
    nameArray  = [NSMutableArray array];
    starArray  = [NSMutableArray array];
    _chuanImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, ScreenWidth, ScreenWidth*2/3)];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    searchBtn.frame = CGRectMake(0, 0, 25, 25);
    //    [searchBtn setBackgroundImage :[UIImage imageNamed:@"分享1.png"] forState:UIControlStateNormal];
    //    [searchBtn addTarget:self action:@selector(fenxiang:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(0, 0, 25, 25);
    [timeBtn setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
    timeBtn.selected = NO;
    [timeBtn addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barTimeBtn=[[UIBarButtonItem alloc]initWithCustomView:timeBtn];
    self.navigationItem.rightBarButtonItem = barTimeBtn;
    //    UIBarButtonItem *barSearchBtn=[[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    //    NSArray *rightBtns=[NSArray arrayWithObjects:barTimeBtn,barSearchBtn, nil];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *xiadingdan = [UIButton buttonWithType:UIButtonTypeCustom];
    xiadingdan.frame = CGRectMake(0, height-width*0.1-64, width, width*0.1);
    xiadingdan.backgroundColor = Color(7, 187, 177);
    [xiadingdan setTitle:@"立即预定" forState:UIControlStateNormal];
    [xiadingdan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xiadingdan addTarget:self action:@selector(xiaDingDan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiadingdan];
    
    // 大图
    //    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    self.carImageView = [[UIImageView alloc]init];
    self.carImageView.frame =  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*2/3);
    [self.view addSubview:self.carImageView];
    
    
}
#pragma mark - 下订单
- (void)xiaDingDan{
    
    NSString *type1 = dicta2[@"state"][@"type"];
    
    if ([type1 intValue] == 4) {
        
        ChangzuView *view = [[ChangzuView alloc] init];
        view.cartype = dicta2[@"carinfo"][@"cartype"];
        view.carprice = dicta2[@"carinfo"][@"jiage1"];
        view.chaochu1 = dicta2[@"carinfo"][@"jiage3"];
        view.chaochu2 = dicta2[@"carinfo"][@"jiage2"];
        view.carid = dicta2[@"state"][@"carid"];
        view.jiedan = dicta[@"jiedan"];
        [self.navigationController pushViewController:view animated:YES];
    }
    else if ([type1 intValue] == 5) {
        
        ChangBaoView *view = [[ChangBaoView alloc] init];
        view.cartype = dicta2[@"carinfo"][@"cartype"];
        view.carprice = dicta2[@"carinfo"][@"jiage1"];
        view.chaochu1 = dicta2[@"carinfo"][@"jiage3"];
        view.carid = dicta2[@"state"][@"carid"];
        view.jiedan = dicta[@"jiedan"];
        [self.navigationController pushViewController:view animated:YES];
    }else{
        
        CustomOrderView *view = [[CustomOrderView alloc] init];
        
        view.carType = _typeCar;
        view.carPrice = _carPrice;
        view.chao1= _carPrice1;
        view.chao2 = _carPrice2;
        view.carURL = dicta2[@"carinfo"][@"cartu1"];
        view.userName = _username;
        view.jiedan = dicta[@"jiedan"];
        view.carPaizhao = dicta2[@"carinfo"][@"plate"];
        view.carColor = dicta2[@"carinfo"][@"color"];
        view.phoneNUM = dicta2[@"carinfo"][@"phone"];
        view.carid = dicta2[@"state"][@"carid"];
        
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (void)createScrollView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height-width*0.1-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = YES;
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [UIView new];
    // header
    _tableView.tableHeaderView = self.carImageView;
    _tableView.separatorStyle = 0;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([dicta2[@"state"][@"type"] intValue] == 4) {
        
        return width*5-width*0.02-width/3*2-width*0.1-64;
    }else{
        return width*5-width*0.02-width/3*2-width*0.2-64;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stac = @"stav";
    
    ChangzuDTCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[ChangzuDTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stac];
    }
    
    cell.model = dicta2;
    cell.dicDelegate = self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - 点击进入详情界面
- (void)sendCarId:(NSString *)carID sendPSG:(NSString *)sender{
    
    ChangZuDetailView *view = [[ChangZuDetailView alloc] init];
    view.carid = carID;
    
    [_chuanImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",sender]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    view.cartype = _typeCar;
    view.carPrice = _carPrice;
    view.carPrice1= _carPrice1;
    view.carPrice2 = _carPrice2;
    view.carImageView = _carImageView;
    view.username = _username;
    
    [self.navigationController pushViewController:view animated:YES];
}
- (void)sendPSG:(NSDictionary *)sender{
    
    NSLog(@"sender === %@",sender);
}
#pragma mark - 评价界面
- (void)pinglunUserID:(NSString *)userID{
    
    NSLog(@"5555555555");
}

#pragma mark - 平台规则
- (void)fuwuUserID{
    
    XieYiViewController *view = [[XieYiViewController alloc] init];
    view.xieyititle = @"平台规则";
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - fanhui
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 收藏
- (void)shoucang:(UIButton *)sender{
    
    if (sender.selected == NO) {
        
        sender.selected = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"收藏333.png"] forState:UIControlStateNormal];
        
        NSDictionary *dictionary = @{@"userid":[ZCUserData share].userId,@"carid":self.carid,@"model":@"insert",@"cartype":self.cartype};
        
        [HttpManager postData:dictionary andUrl:@"http://wx.leisurecarlease.com/api.php?op=shoucang" success:^(NSDictionary *fanhuicanshu) {
            
            NSLog(@"tainjia --- %@",fanhuicanshu);
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }else if (sender.selected == YES) {
        
        sender.selected = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
        
        NSDictionary *dictionary = @{@"userid":[ZCUserData share].userId,@"carid":self.carid,@"model":@"delete",@"cartype":self.cartype};
        
        [HttpManager postData:dictionary andUrl:@"http://wx.leisurecarlease.com/api.php?op=shoucang" success:^(NSDictionary *fanhuicanshu) {
            
            NSLog(@"quxiao --- %@",fanhuicanshu);
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }
}

#pragma mark -- YSLTransitionAnimatorDataSource
#pragma mark - 大图动画
- (UIImageView *)popTransitionImageView
{
    return self.carImageView;
}

- (UIImageView *)pushTransitionImageView
{
    return _chuanImage;
}


#pragma mark - 分享
- (void)fenxiang:(UIButton *)sender{
    
    //    NSString *shareText = @"这是我心中的车";
    //    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dicta[@"cartu1"]]];
    //    UIImage *shareImage = [UIImage imageWithData:data];
    
    //    NSArray *arr = [NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone, nil];
    //    [UMSocialData defaultData].extConfig.qqData.title = @"我喜欢这辆车，你呢？";
    //    [UMSocialData defaultData].extConfig.qzoneData.title = @"我喜欢这辆车，你呢？";
    //    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"我喜欢这辆车，你呢？";
    //    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"我喜欢这辆车，你呢？";
    //
    //    [UMSocialData defaultData].extConfig.qqData.url = url;
    //    [UMSocialData defaultData].extConfig.qzoneData.url = url;
    //    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    //    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    //
    //    [UMSocialSnsService presentSnsController:self appKey:@"56ea243767e58e883800110d" shareText:shareText shareImage:shareImage shareToSnsNames:arr delegate:self];
    //    [UMSocialData openLog:YES];
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
