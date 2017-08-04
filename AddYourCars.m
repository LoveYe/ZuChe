//
//  AddYourCars.m
//  ZuChe
//
//  Created by apple  on 16/9/14.
//  Copyright © 2016年 佐途. All rights reserved.
//
#define CHGIFAnimationDict @[\
@{@"pattern":@"PullToRefresh_%03d.png",@"drawingStart":@0,@"drawingEnd":@73,@"loadingStart":@73,@"loadingEnd":@140}\
]

#define GifRefreshControlHeight 70.0

static char UIScrollViewGifPullToRefresh;

#import "AddYourCars.h"
#import "AllPages.pch"
#import "SXFirsttableViewModel.h"
#import "HttpManager.h"
//#import "SingleLocationViewController.h"
#import "CarGaishuController.h"
#import "UseWayViewController.h"
//#import "SmallMapViewController.h"
#import "NewMapController2.h"
#import "LGLCalenderViewController.h"
#import "Header.h"
//#import "RenZhengController.h"
#import "RZController.h"
#import "CheliangController.h"

#import "SDWebImageManager.h"
#import "NSData+ImageContentType.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"

#import "CarInfoModel.h"

#import "UIScrollView+GifPullToRefresh.h"

@interface AddYourCars ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,SmallDelegate>{
    
    BOOL xuanzhong;
    
    UITableView *_tableView;
    UIImageView *KuangimageView;
    SXFirsttableViewModel *wxmodel;
    NSString *thumbss;
    NSArray *array;
    UISwitch *_switchkaiguan;
    NSString *_str;
    NSMutableArray *countarray1;
    NSDictionary *carinfo;
    
    UILabel *renzhengLabel;
    UILabel *dizhiLabel;
    
    UIButton *buton1;
    UIButton *dizi;
    UIButton *renzheng;
    UIButton *yogntu;
    UIButton *riqi;
    UIButton *ziliao;
    
    UIButton *smallButon;
    
    UILabel *small;
    UILabel *small3;
    UILabel *small1;
    UILabel *small4;
    
    NSMutableArray *chargeArray;
    NSMutableArray *change;
    
    NSString *jilu;
    int buzhou;
    
    NSString *buttonTitle1;
    NSString *buttonTitle2;
    
    UIImageView *navBarImage;
    NSMutableArray *abu;
    
    NSMutableArray *_arrarrarr;
    NSMutableArray *count;
    
    NSString *number;
    NSString *description;
    int Description;
}

@end

@implementation AddYourCars

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self DownLoad1];
//    [_tableView reloadData];
}
- (void)DownLoad1{
    
    NSDictionary *dict = @{@"carid":self.catid};
    
    NSString *url = @"http://wx.leisurecarlease.com/api.php?op=api_bz";
    
    _arrarrarr = [NSMutableArray array];
    
    [HttpManager postData:dict andUrl:url success:^(NSDictionary *fanhuicanshu) {
        
        NSDictionary *dict = fanhuicanshu[@"state"];
        CarInfoModel *model = [CarInfoModel viewWithDic:fanhuicanshu[@"state"]];
        
        if ([model.bz intValue] == 0) {
            
            self.title = @"等待审核";
            [self.navigationController popViewControllerAnimated:NO];
        }else{
            
            self.title = [NSString stringWithFormat:@"还有%@步即可完成发布",model.bz];
            number = model.bz;
            UIColor *col = Color(100, 100, 100);
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:col,NSForegroundColorAttributeName, nil];
            [self.navigationController.navigationBar setTitleTextAttributes:dic];
        }
        
        [self createSmallBUtton];
        
        int d = [model.dizhi intValue];
        if (d == 1) {
            
            small4.text = model.dizhi_info;
            [dizi setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
            
        }else{
            
            small4.text = @"停车地址将更好的为您匹配到附近的订单";
            [dizi setBackgroundImage:[UIImage imageNamed:@"勾选框(1)"] forState:UIControlStateNormal];
        }
        
        
        int y = [model.yongtu intValue];
        if (y == 0) {
            
            [yogntu setBackgroundImage:[UIImage imageNamed:@"勾选框(1)"] forState:UIControlStateNormal];
            small3.text = @"根据不同的用途设置更合理的价格";
        }else{
            
            [yogntu setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
            small3.text = model.yongtu_info;
        }
        int a = [model.biaoshi intValue];
        if (a == 1) {
            
            [ziliao setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）白"] forState:UIControlStateNormal];
            
//            NSLog(@"cartu1 is --- %@",model.cartu1);
            
            NSString *url1 = [NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",model.cartu1];
            
            NSURL *url = (NSURL *)url1;
            
            [KuangimageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"添加照片(1).jpg"]];
            
        }else{
            
            [ziliao setBackgroundImage:[UIImage imageNamed:@"勾选框白"] forState:UIControlStateNormal];
            KuangimageView.image = [UIImage imageNamed:@"添加照片(1).jpg"];
        }
        
        int b = [model.biaoshi1 intValue];
        if (b == 1) {
            
            [renzheng setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
        }else{
            
            [renzheng setBackgroundImage:[UIImage imageNamed:@"勾选框(1)"] forState:UIControlStateNormal];
        }
        
        int g = [dict[@"gaishu"] intValue];
        if (g == 0||[dict[@"gaishu_info"] isEqualToString:@""]) {
            
            [buton1 setBackgroundImage:[UIImage imageNamed:@"勾选框(1)"] forState:UIControlStateNormal];
            small1.text = @"总结您和您爱车的亮点";
        }else{
            
            [buton1 setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
            small1.text = dict[@"gaishu_info"];
        }
        
//        [_tableView reloadData];
        
        
    } Error:^(NSString *cuowuxingxi) {
        
        NSLog(@"default --- %@",cuowuxingxi);
    }];
    [self createTableView];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.view removeFromSuperview];
    [_tableView removeFromSuperview];
    [smallButon removeFromSuperview];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    chargeArray = [NSMutableArray array];
    change = [NSMutableArray array];
    jilu = [[NSString alloc] init];
    abu = [NSMutableArray array];
    
//    UIColor *col = Color(100, 100, 100);
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:col,NSForegroundColorAttributeName, nil];
//    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonFanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 头部变成白色
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
//    [self createSmallBUtton];
    
//    
//    [_tableView setSeparatorInset:UIEdgeInsetsZero];
//    [_tableView setLayoutMargins:UIEdgeInsetsZero];
}


- (void)createSmallBUtton{
    
    CGFloat width = self.view.frame.size.width;
    for (int i = 0; i < 6; i++) {
        
        smallButon = [UIButton buttonWithType:UIButtonTypeCustom];
        smallButon.frame = CGRectMake(i*(width/5)-0.1, 0, width/5 - 0.2, 10);
        smallButon.tag = 666+i;
        
//        NSMutableArray *arrayarr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"buttonTag"]];
        
        int j = [number intValue];
        
        if(i < 5-j){
            
            smallButon.backgroundColor = Color(0, 215, 200);
        }else{
            
            smallButon.backgroundColor = Color(200, 200, 200);
        }
        
        [self.view addSubview:smallButon];
    }
}

- (void)buttonFanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = Color(200, 200, 200);
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //创建tableView
    [self.view addSubview:_tableView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(DownLoad1) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
}
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    // 此处添加刷新tableView数据的代码
    [refreshControl endRefreshing];
    [_tableView reloadData];// 刷新tableView即可
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    
    CGFloat width = self.view.frame.size.width;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        if (indexPath.row == 0) {
            
//            NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"tupian1"];
//            UIImage* image = [UIImage imageWithData:imageData];
//            if (image==nil) {
//                
                KuangimageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*2/3)];
//                KuangimageView.image = [UIImage imageNamed:@"添加照片(1).jpg"];
                [cell.contentView addSubview:KuangimageView];
//
//            }else{
//                
//                KuangimageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.61)];
//                KuangimageView.image = image;
//                [cell.contentView addSubview:KuangimageView];
//            }
            ziliao = [UIButton buttonWithType:UIButtonTypeCustom];
            
            ziliao.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2+120, ScreenWidth*0.61 - 50, 30, 30);
            
//            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"ziliao"]) {
            
//                [ziliao setBackgroundImage:[UIImage imageNamed:@"勾选框白"] forState:UIControlStateNormal];
//            }else{
//                
//                [ziliao setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）白.png"] forState:UIControlStateNormal];
//            }
            [cell.contentView addSubview:ziliao];
        }
        if (indexPath.row == 1) {
            
            UIView *view = [[UIView alloc] init];
            
            UILabel *big = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 15)];
            big.text = @"认证资料";
            big.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
            big.textColor = Color(0, 215, 200);
            //        big.font = [UIFont fontWithName:@"" size:15];
            [big setAdjustsFontSizeToFitWidth:YES];
            [view addSubview:big];
            
            small = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, width*0.7, 15)];
            small.textColor = [UIColor grayColor];
            small.text = @"认证资料仅供认证审核租客无法查看";
            small.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
            //        [small setAdjustsFontSizeToFitWidth:YES];
            [view addSubview:small];
            
            renzheng = [UIButton buttonWithType:UIButtonTypeCustom];
            renzheng.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2+120, CGRectGetHeight(view.frame)/2+20, 30, 30);
            [view addSubview:renzheng];
            
            cell.backgroundView = view;
        }
        if (indexPath.row == 2) {
            UIView *view = [[UIView alloc] init];
            
            UILabel *big = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 15)];
            big.text = @"设置地址";
            big.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
            big.textColor = Color(0, 215, 200);
            //        big.font = [UIFont fontWithName:@"" size:15];
            [big setAdjustsFontSizeToFitWidth:YES];
            [view addSubview:big];
            
            small4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, width*0.8, 15)];
            small4.textColor = [UIColor grayColor];
//            small4.text = @"停车地址将更好地为您匹配到附近订单";
            small4.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
            //        [small4 setAdjustsFontSizeToFitWidth:YES];
            [view addSubview:small4];
            
            dizi = [UIButton buttonWithType:UIButtonTypeCustom];
            dizi.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2+120, CGRectGetHeight(view.frame)/2+20, 30, 30);
            
//            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"dizhi"]) {
//                
//                [dizi setBackgroundImage:[UIImage imageNamed:@"勾选框(1)"] forState:UIControlStateNormal];
//            }else{
//                
//                [dizi setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
//                
//            }
            
            [view addSubview:dizi];
            
            cell.backgroundView = view;
        }
        if (indexPath.row == 3) {
            UIView *view = [[UIView alloc] init];
            
            UILabel *big = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 15)];
            big.text = @"车辆概述";
            big.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
            big.textColor = Color(0, 215, 200);
            [big setAdjustsFontSizeToFitWidth:YES];
            [view addSubview:big];
            
            small1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 250, 15)];
            small1.textColor = [UIColor grayColor];
//            small1.text = @"总结您和您爱车的亮点";
            small1.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
            [view addSubview:small1];
            
            buton1 = [UIButton buttonWithType:UIButtonTypeCustom];
            buton1.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2+120, CGRectGetHeight(view.frame)/2+20, 30, 30);
            
//            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"button1"]) {
            
            
//            }else{
//                
//                [buton1 setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
//            }
            
            [view addSubview:buton1];
            
            cell.backgroundView = view;
        }
        if (indexPath.row == 4) {
            UIView *view = [[UIView alloc] init];
            
            UILabel *big = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 15)];
            big.text = @"设置用途";
            big.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
            big.textColor = Color(0, 215, 200);
            //        big.font = [UIFont fontWithName:@"" size:15];
            [big setAdjustsFontSizeToFitWidth:YES];
            [view addSubview:big];
            
            small3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 250, 15)];
            small3.textColor = [UIColor grayColor];
            small3.text = @"根据不同的用途设置更合理的价格";
            small3.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
            [view addSubview:small3];
            
            yogntu = [UIButton buttonWithType:UIButtonTypeCustom];
            yogntu.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2+120, CGRectGetHeight(view.frame)/2+20, 30, 30);
            
//            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"yongtu"]) {
            
//                [yogntu setBackgroundImage:[UIImage imageNamed:@"勾选框(1)"] forState:UIControlStateNormal];
//            }else{
//                
//                [yogntu setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
//            }
            
            [view addSubview:yogntu];
            
            cell.backgroundView = view;
        }
//        if (indexPath.row == 5) {
//            
//            //        cell.backgroundColor = [UIColor redColor];
//            
//            UIView *view = [[UIView alloc] init];
//            
//            UILabel *big = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 15)];
//            big.text = @"设置日期";
//            big.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
//            big.textColor = Color(0, 215, 200);
//            [view addSubview:big];
//            
//            UILabel *small2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 250, 15)];
//            small2.textColor = [UIColor grayColor];
//            small2.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
//            small2.text = @"及时更新不可用日期避免降低接单率";
//            [view addSubview:small2];
//            
//            riqi = [UIButton buttonWithType:UIButtonTypeCustom];
//            riqi.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2+120, CGRectGetHeight(view.frame)/2+20, 30, 30);
////            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"riqi"]) {
//            
////                [riqi setBackgroundImage:[UIImage imageNamed:@"勾选框(1)"] forState:UIControlStateNormal];
////            }else{
////                
////                [riqi setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
////            }
//            
//            [view addSubview:riqi];
//            
//            cell.backgroundView = view;
//            
//        }
        if (indexPath.row == 5) {
            
//            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
//            
//            UILabel *jiedan = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(view.frame)-30, 20, 60, 15)];
//            jiedan.text = @"自动接单";
//            jiedan.font = [UIFont fontWithName:@"AmericanTypewriter" size:20];
//            jiedan.adjustsFontSizeToFitWidth = YES;
//            jiedan.textColor = Color(105, 105, 105);
//            [view addSubview:jiedan];
//            
//            CGFloat width = self.view.frame.size.width;
//            
//            UIView *second = [[UIView alloc] init];
//            second.frame = CGRectMake(20, CGRectGetMaxY(jiedan.frame)+20, width-40, width*0.6);
//            second.backgroundColor = Color(255, 255, 255);
//            [view addSubview:second];
//            
//            UIImageView *iamge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"闪电"]];
//            iamge.frame = CGRectMake(CGRectGetMidX(second.frame) - 40, 20, 40, 40);
//            //        iamge.backgroundColor = [UIColor redColor];
//            [second addSubview:iamge];
//            
//            UILabel *duanju = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iamge.frame)+20, CGRectGetWidth(second.frame), 20)];
//            duanju.text = @"需要很快的接收订单吗？";
//            duanju.textColor = Color(105, 105, 105);
//            duanju.textAlignment = NSTextAlignmentCenter;
//            duanju.font = [UIFont fontWithName:@"AmericanTypewriter" size:17];
//            //        duanju.adjustsFontSizeToFitWidth = YES;
//            [second addSubview:duanju];
//            
//            UILabel *changju = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(duanju.frame)+20, CGRectGetWidth(second.frame), 20)];
//            changju.text = @"自动接单功能可以自动为您接受所有订单";
//            changju.textColor = Color(183, 183, 183);
//            changju.textAlignment = NSTextAlignmentCenter;
//            //        changju.adjustsFontSizeToFitWidth = YES;
//            changju.font = [UIFont fontWithName:@"AmericanTypewriter" size:17];
//            [second addSubview:changju];
//            
//            UILabel *kaiqi = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(changju.frame)+20, 200, 20)];
//            kaiqi.text = @"开启自动接单";
//            kaiqi.textColor = Color(105, 105, 105);
//            //        kaiqi.adjustsFontSizeToFitWidth = YES;
//            kaiqi.font = [UIFont fontWithName:@"AmericanTypewriter" size:17];
//            [second addSubview:kaiqi];
//            
//            view.userInteractionEnabled = YES;
//            _switchkaiguan = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(second.frame)-80, CGRectGetMaxY(changju.frame)+20, 0, 0)];
//            [_switchkaiguan addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//            [_switchkaiguan setOn:NO animated:YES];
//            [second addSubview:_switchkaiguan];
            
            
            UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo浅"]];
            logoImage.frame = CGRectMake(width/2-width*0.1, width*0.12, width*0.2, width*0.2);
//            [view addSubview:logoImage];
            
            
            [cell addSubview:logoImage];
        }
    }
    
    cell.backgroundColor = Color(240, 240, 240);
    cell.selectionStyle = UITableViewCellStyleDefault;
    
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
}
- (void)switchAction:(UISwitch *)kaiGuan{
    
    if ([kaiGuan isOn]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"开启该功能后，如新订单时间在可租用时间范围内，系统会自动为您接受订单，不再让您错过任何赚钱的机会，并且能够有助于您获得更多订单。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.delegate = self;
        [alertView show];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        [_switchkaiguan setOn:YES];
        
        // 还需要添加一个 取消开启自动接单的 连接
        BOOL isButtonOn = YES ;
        NSString *autolist=[NSString stringWithFormat:@"%@",isButtonOn?@"0":@"1"];
        NSString *autolist1=[NSString stringWithFormat:@"%@",isButtonOn?@"1":@"0"];
        
        NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:
                                  [ZCUserData share].userId,@"userid",
                                  self.catid,@"carid",
                                  autolist,@"autolist",nil];
        [HttpManager postData:parameters andUrl:ZIDONGJIEDAN success:^(NSDictionary *fanhuicanshu)
         {
             if ([autolist isEqualToString:@"0"]) {
                 
                 NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:
                                           [ZCUserData share].userId,@"userid",
                                           self.catid,@"carid",
                                           autolist1,@"jiedan",nil];
                 
                 [HttpManager postData:parameters andUrl:JIEDANORNO success:^(NSDictionary *fanhuicanshu) {
                     
                 } Error:^(NSString *cuowuxingxi) {
                     
                 }];
             }
         }Error:^(NSString *cuowuxingxi) {
             
         }];
    }else{
        
        [_switchkaiguan setOn:NO];
        BOOL isButtonOn = NO;
        NSString *autolist=[NSString stringWithFormat:@"%@",isButtonOn?@"0":@"1"];
        NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:
                                  [ZCUserData share].userId,@"userid",
                                  self.catid,@"carid",
                                  autolist,@"autolist",nil];
        [HttpManager postData:parameters andUrl:JIEDANORNO success:^(NSDictionary *fanhuicanshu) {
            
            
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return ScreenWidth *2/3;
    }
    if (indexPath.row == 5) {
        
        return ScreenWidth*0.45;
    }
    return ScreenWidth*0.2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *catidbenye=[NSString stringWithFormat:@"%@",[[countarray1 objectAtIndex:indexPath.row] objectForKey:@"carid"]];
    
    NSLog(@"%@",catidbenye);
    
    if (indexPath.row == 0) {
        
        CheliangController *view = [[CheliangController alloc] init];
        view.carid = self.catid;
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }
    if (indexPath.row == 1) {
        
        RZController *view = [[RZController alloc] init];
        view.carid = self.catid;
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:view animated:NO];
    }
    if (indexPath.row == 2) {
        
        NewMapController2 *view = [[NewMapController2 alloc]init];
        
        view.carid = self.catid;
        
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
        
        CarGaishuController *view= [[CarGaishuController alloc] init];
        view.delegate = self;
        view.carid = self.catid;
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:view animated:NO];
    }
    if (indexPath.row == 4) {
        
        UseWayViewController *view = [[UseWayViewController alloc] init];
        view.carid = self.catid;
        
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
#pragma mark - reloadCell
-(void)Refresh_JXY:(UITableView *)TABLEVIEW VOID:(Refresh)VOID{
    
    NSMutableArray *drawingImgs = [NSMutableArray array];
    NSMutableArray *loadingImgs = [NSMutableArray array];
    NSUInteger drawingStart = [CHGIFAnimationDict[0][@"drawingStart"] intValue];
    NSUInteger drawingEnd = [CHGIFAnimationDict[0][@"drawingEnd"] intValue];
    NSUInteger laodingStart = [CHGIFAnimationDict[0][@"loadingStart"] intValue];
    NSUInteger loadingEnd = [CHGIFAnimationDict[0][@"loadingEnd"] intValue];
    for (NSUInteger i  = drawingStart; i <= drawingEnd; i++) {
        
        NSString *fileName = [NSString stringWithFormat:CHGIFAnimationDict[0][@"pattern"],i];
        [drawingImgs addObject:[UIImage imageNamed:fileName]];
    }
    
    for (NSUInteger i  = laodingStart; i <= loadingEnd; i++) {
        
        NSString *fileName = [NSString stringWithFormat:CHGIFAnimationDict[0][@"pattern"],i];
        [loadingImgs addObject:[UIImage imageNamed:fileName]];
    }
    
    __weak UITableView *tempScrollView = TABLEVIEW;
    
    [TABLEVIEW addPullToRefreshWithDrawingImgs:drawingImgs andLoadingImgs:loadingImgs andActionHandler:^{
        [tempScrollView performSelector:@selector(didFinishPullToRefresh) withObject:nil afterDelay:1];
        VOID();
    }];
    
}
- (void)addPullToRefreshWithDrawingImgs:(NSArray*)drawingImgs andLoadingImgs:(NSArray*)loadingImgs andActionHandler:(void (^)(void))actionHandler{
    
    CHGifRefreshControl *view = [[CHGifRefreshControl alloc] initWithFrame:CGRectMake(0, -GifRefreshControlHeight, self.view.frame.size.width, GifRefreshControlHeight)];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        view.originalContentInsectY = 0;
    }
    
    view.scrollView = (UIScrollView *)self.view;
    view.pullToRefreshActionHandler = actionHandler;
    view.drawingImgs = drawingImgs;
    view.loadingImgs = loadingImgs;
    [self.view addSubview:view];
    self.refreshControl = view;
}
- (void)setRefreshControl:(CHGifRefreshControl *)pullToRefreshView {
    
    [self willChangeValueForKey:@"UIScrollViewGifPullToRefresh"];
    objc_setAssociatedObject(self, &UIScrollViewGifPullToRefresh,
                             pullToRefreshView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"UIScrollViewGifPullToRefresh"];
    
}

- (void)sendMessage{
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(DownLoad1) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
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
