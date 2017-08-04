//
//  UseWayViewController.m
//  ZuChe
//
//  Created by apple  on 16/10/14.
//  Copyright © 2016年 佐途. All rights reserved.
//
/*
 这个地方获取值有问题，你直接传值过去
 
 */
#define jiage1 [NSString stringWithFormat:@"%@",[SaveString valueForKey:@"jiage1"]]
#define jiage2 [NSString stringWithFormat:@"%@",[SaveString valueForKey:@"jiage2"]]
#define jiage3 [NSString stringWithFormat:@"%@",[SaveString valueForKey:@"jiage3"]]
#define jiage4 [NSString stringWithFormat:@"%@",[SaveString valueForKey:@"jiage4"]]
#define jiage5 [NSString stringWithFormat:@"%@",[SaveString valueForKey:@"jiage5"]]


#import "UseWayViewController.h"
#import "SetPriceViewController.h"
#import "MJRefresh.h"
#import "ChangBaoController.h"
#import "Header.h"
#import "AFHTTPRequestOperationManager.h"
#import "ZuChe/ZCUserData.h"
#import "HttpManager.h"

#import "UserWayModel.h"

@interface UseWayViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,SendPriceDelegate,ChangBaoDelegate>{
    
    UITableView *_tableView;
    BOOL _XuanZhong;
    UILabel *_jiage1;
    UILabel *_jiage2;
    UILabel *_jiage3;
    UILabel *_jiage4;
    UILabel *_jiage5;
    UILabel *_jiage6;
    NSInteger _indexPath;
    UISwitch *_sitch;
    
    UISwitch *switchButton;
    
    UILabel *name1;
    UILabel *name2;
    UILabel *name3;
    UILabel *name4;
    UILabel *name5;
    UILabel *name6;
    
    UIImageView *_image1;
    UIImageView *_image2;
    UIImageView *_image3;
    UIImageView *_image4;
    UIImageView *_image5;
    UIImageView *_image6;
    
    NSMutableArray *array;
    NSMutableDictionary *SaveString;

    NSDictionary *dazidian;
    
    UIView *_alertView;
    UIView *bigView;
    UIButton *quxiao;
    UIButton *queding;
    
    UIView *_alertView1;
    UIView *bigView1;
    UIButton *quxiao1;
    UIButton *queding1;
}
@end

@implementation UseWayViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self DownLoad];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)DownLoad{
    
    dazidian = [NSDictionary dictionary];
    NSDictionary *dic = @{@"carid":self.carid};
    NSString *url = @"http://wx.leisurecarlease.com/api.php?op=api_ytlb";
    
    [HttpManager postData:dic andUrl:url success:^(NSDictionary *fanhuicanshu) {
        
        dazidian = fanhuicanshu[@"state"];
        if (dazidian == nil) {
            
            _jiage1.text = @"未设置";
            _image1.image = [UIImage imageNamed:@"勾选框(1)"];
            
            _jiage2.text = @"未设置";
            _image2.image = [UIImage imageNamed:@"勾选框(1)"];
            
            _jiage3.text = @"未设置";
            _image3.image = [UIImage imageNamed:@"勾选框(1)"];
            
            _jiage4.text = @"未设置";
            _image4.image = [UIImage imageNamed:@"勾选框(1)"];
            
            _jiage5.text = @"未设置";
            _image5.image = [UIImage imageNamed:@"勾选框(1)"];
        }else{
            NSArray *array1 = dazidian[@"1"];
            NSArray *array2 = dazidian[@"2"];
            NSArray *array3 = dazidian[@"3"];
            NSArray *array4 = dazidian[@"4"];
            NSArray *array5 = dazidian[@"5"];
            
            if (array1.count == 0) {
                
                _jiage1.text = @"未设置";
                _image1.image = [UIImage imageNamed:@"勾选框(1)"];
            }else{
                
                NSDictionary *zidian = dazidian[@"1"];
                _jiage1.text = [NSString stringWithFormat:@"¥ %@",zidian[@"jiage1"]];
                _image1.image = [UIImage imageNamed:@"勾选框（已打勾）(1)"];
            }
            if (array2.count == 0) {
                
                _jiage2.text = @"未设置";
                _image2.image = [UIImage imageNamed:@"勾选框(1)"];
            }else{
                
                NSDictionary *zidian = dazidian[@"2"];
                _jiage2.text = [NSString stringWithFormat:@"¥%@",zidian[@"jiage1"]];
                _image2.image = [UIImage imageNamed:@"勾选框（已打勾）(1)"];
            }
            if (array3.count == 0) {
                
                _jiage3.text = @"未设置";
                _image3.image = [UIImage imageNamed:@"勾选框(1)"];
            }else{
                
                NSDictionary *zidian = dazidian[@"3"];
                _jiage3.text = [NSString stringWithFormat:@"¥%@",zidian[@"jiage1"]];
                _image3.image = [UIImage imageNamed:@"勾选框（已打勾）(1)"];
            }
            if (array4.count == 0) {
                
                _jiage4.text = @"未设置";
                _image4.image = [UIImage imageNamed:@"勾选框(1)"];
            }else{
                
                NSDictionary *zidian = dazidian[@"4"];
                _jiage4.text = [NSString stringWithFormat:@"¥%@",zidian[@"jiage1"]];
                _image4.image = [UIImage imageNamed:@"勾选框（已打勾）(1)"];
            }
            if (array5.count == 0) {
                
                _jiage5.text = @"未设置";
                _image5.image = [UIImage imageNamed:@"勾选框(1)"];
            }else{
                
                NSDictionary *zidian = dazidian[@"5"];
                _jiage5.text = zidian[@"jiage1"];
                _image5.image = [UIImage imageNamed:@"勾选框（已打勾）(1)"];
            }
        }
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}

- (void)viewDidLoad{
    
//    [self AlertView11];
    
    SaveString = [NSMutableDictionary dictionary];
    
    self.title = @"6种出租方式";
    UIColor *col = Color(100, 100, 100);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:col,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIButton *baocun = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    baocun.frame = CGRectMake(0, 0, 40, 30);
    [baocun setTitle:@"保存" forState:UIControlStateNormal];
    UIColor *color = Color(0, 215, 200);
//    [baocun setBackgroundColor:color];
    [baocun setTitleColor:color forState:UIControlStateNormal];
    [baocun addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarbutton = [[UIBarButtonItem alloc] initWithCustomView:baocun];
    self.navigationItem.rightBarButtonItem = rightbarbutton;
    
    array = [NSMutableArray array];
    
    self.navigationController.navigationBar.alpha = 1.0;
    
    [self createTableView];
    
    [self AlertView11];
}
- (void)fanhui{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jiage1"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTableView{
    
    CGFloat width = self.view.frame.size.width;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-width*0.15)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = self.view.frame.size.width;
    if (indexPath.row == 6) {
        
        return width;
    }
    return width*0.25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        cell.tag = indexPath.row;
        
        CGFloat width = self.view.frame.size.width;
        
        if (indexPath.row == 0&& cell.tag == 0) {
            
//            NSDictionary *zidian = dazidian[@"1"];
            
            name1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.03, width*0.2, width*0.08)];
            name1.text = @"婚车";
            name1.textColor = Color(143, 143, 143);
            name1.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:25];
            
            [cell addSubview:name1];
            
            UILabel *huafei = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name1.frame), width*0.03, width*0.4, width*0.08)];
            huafei.text = @"(5小时50公里起)";
            huafei.textColor = Color(143, 143, 143);
            huafei.font = [UIFont systemFontOfSize:15];
            [cell addSubview:huafei];
            
            _jiage1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.17, width*0.03, width*0.15, width*0.06)];
            _jiage1.textColor = Color(255, 97, 57);
            
            _image1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.21, CGRectGetMaxY(_jiage1.frame)+width*0.02, width*0.08, width*0.08)];
            
            _jiage1.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
            _jiage1.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:_jiage1];
            
            UILabel *maioshu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(name1.frame)+ width*0.03, width*0.8, width*0.06)];
            maioshu.text = @"提供车辆及驾驶员，新人结婚用于娶亲";
            maioshu.textColor = Color(165, 165, 165);
            maioshu.font = [UIFont systemFontOfSize:13];
            [cell addSubview:maioshu];
            
            
            [cell addSubview:_image1];
        }
        if (indexPath.row == 1&& cell.tag == 1) {
            
            name2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.03, width*0.2, width*0.08)];
            name2.text = @"商务";
            name2.textColor = Color(143, 143, 143);
            name2.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:25];
            
            [cell addSubview:name2];
            
            UILabel *huafei = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name1.frame), width*0.03, width*0.4, width*0.08)];
            huafei.text = @"(1小时10公里起)";
            huafei.textColor = Color(143, 143, 143);
            huafei.font = [UIFont systemFontOfSize:15];
            [cell addSubview:huafei];
            
            _jiage2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.17, width*0.03, width*0.15, width*0.06)];
            _jiage2.textColor = Color(255, 97, 57);
            
            _jiage2.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
            _jiage2.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:_jiage2];
            
            UILabel *maioshu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(name2.frame)+ width*0.03, width*0.8, width*0.06)];
            maioshu.text = @"提供车辆及驾驶人，接送及等待用车人";
            maioshu.textColor = Color(165, 165, 165);
            maioshu.font = [UIFont systemFontOfSize:13];
            [cell addSubview:maioshu];
            
            _image2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.21, CGRectGetMaxY(_jiage2.frame)+width*0.02, width*0.08, width*0.08)];
            
            [cell addSubview:_image2];
        }
        if (indexPath.row == 2&& cell.tag == 2) {
            name3 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.03, width*0.2, width*0.08)];
            name3.text = @"拍摄";
            name3.textColor = Color(143, 143, 143);
            name3.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:25];
            
            [cell addSubview:name3];
            
            UILabel *huafei = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name1.frame), width*0.03, width*0.4, width*0.08)];
            huafei.text = @"(1天起)";
            huafei.textColor = Color(143, 143, 143);
            huafei.font = [UIFont systemFontOfSize:15];
            [cell addSubview:huafei];
            
            _jiage3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.17, width*0.03, width*0.15, width*0.06)];
            _jiage3.textColor = Color(255, 97, 57);

            _jiage3.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
            _jiage3.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:_jiage3];
            
            UILabel *maioshu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(name3.frame)+ width*0.03, width*0.8, width*0.06)];
            maioshu.text = @"提供车辆，满足影视剧中汽车镜头的拍摄";
            maioshu.textColor = Color(165, 165, 165);
            maioshu.font = [UIFont systemFontOfSize:13];
            [cell addSubview:maioshu];
            
            _image3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.21, CGRectGetMaxY(_jiage3.frame)+width*0.02, width*0.08, width*0.08)];
            
            [cell addSubview:_image3];
        }
        if (indexPath.row == 3&& cell.tag == 3) {
            name4 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.03, width*0.2, width*0.08)];
            name4.text = @"长包";
            name4.textColor = Color(143, 143, 143);
            name4.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:25];
            
            [cell addSubview:name4];
            
            UILabel *huafei = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name1.frame), width*0.03, width*0.4, width*0.08)];
            huafei.text = @"(1月起)";
            huafei.textColor = Color(143, 143, 143);
            huafei.font = [UIFont systemFontOfSize:15];
            [cell addSubview:huafei];
            
             _jiage4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.17, width*0.03, width*0.15, width*0.06)];
            
            _jiage4.textColor = Color(255, 97, 57);
            
            _jiage4.textAlignment = NSTextAlignmentCenter;
            _jiage4.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
            [cell addSubview:_jiage4];
            
            UILabel *maioshu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(name4.frame)+ width*0.03, width*0.8, width*0.06)];
            maioshu.text = @"提供车辆及驾驶员，长包期间全职服务租客";
            maioshu.textColor = Color(165, 165, 165);
            maioshu.font = [UIFont systemFontOfSize:13];
            [cell addSubview:maioshu];
            
            _image4 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.21, CGRectGetMaxY(_jiage4.frame)+width*0.02, width*0.08, width*0.08)];
           
            [cell addSubview:_image4];
        }if (indexPath.row == 4&& cell.tag == 4) {
            name5 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.03, width*0.2, width*0.08)];
            name5.text = @"长租";
            name5.textColor = Color(143, 143, 143);
            name5.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:25];
            
            [cell addSubview:name5];
            
            UILabel *huafei = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name1.frame), width*0.03, width*0.4, width*0.08)];
            huafei.text = @"(半年起)";
            huafei.textColor = Color(143, 143, 143);
            huafei.font = [UIFont systemFontOfSize:15];
            [cell addSubview:huafei];
            
            _jiage5 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.17, width*0.03, width*0.15, width*0.06)];
            _jiage5.textColor = Color(255, 97, 57);

            _jiage5.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
            _jiage5.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:_jiage5];
            
            UILabel *maioshu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(name5.frame)+ width*0.03, width*0.8, width*0.06)];
            maioshu.text = @"提供车辆，经平台审核将车辆单独出租";
            maioshu.textColor = Color(165, 165, 165);
            maioshu.font = [UIFont systemFontOfSize:13];
            [cell addSubview:maioshu];
            
            _image5 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.21, CGRectGetMaxY(_jiage5.frame)+width*0.02, width*0.08, width*0.08)];
            
            [cell addSubview:_image5];
        }if (indexPath.row == 5&& cell.tag == 5) {
            name6 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.03, width*0.2, width*0.08)];
            name6.text = @"车队";
            name6.textColor = Color(190, 190, 190);
            name6.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:25];
            
            [cell addSubview:name6];
            
            UILabel *huafei = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name1.frame), width*0.03, width*0.4, width*0.08)];
            huafei.text = @"(8小时100公里起)";
            huafei.textColor = Color(210, 210, 210);
            huafei.font = [UIFont systemFontOfSize:15];
            [cell addSubview:huafei];
            
            _jiage6 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.18, width*0.03, width*0.15, width*0.06)];
            _jiage6.textColor = Color(255, 97, 57);
//            _jiage6.text = @"未认证";
//            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage1"];
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"jiage6"]) {
                
                _jiage6.text = @"未认证";
            }
            else{
                
                _jiage6.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage6"];
            }
            
            _jiage6.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
            [cell addSubview:_jiage6];
            
            UILabel *maioshu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(name6.frame)+ width*0.03, width*0.8, width*0.06)];
            maioshu.text = @"平台等级达到V2以上车辆可以加入礼宾车队";
            maioshu.textColor = Color(190, 190, 190);
            maioshu.font = [UIFont systemFontOfSize:13];
            [cell addSubview:maioshu];
            
            _image6 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huafei.frame)+width*0.21, CGRectGetMaxY(_jiage6.frame)+width*0.02, width*0.08, width*0.08)];
            _image6.image = [UIImage imageNamed:@"勾选框(1)"];
//            imageView.backgroundColor = [UIColor grayColor];
//            [imageView setHighlightedImage:[UIImage imageNamed:@""]];
            [cell addSubview:_image6];
        }
        if (indexPath.row == 6&& cell.tag == 6) {
            
           // UIView *view = [[UIView alloc] init];
            UILabel *shezhi = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3, width*0.05, width*0.6, width*0.06)];
            shezhi.text = @"自动设置价格";
            shezhi.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
            shezhi.textAlignment = NSTextAlignmentCenter;
            shezhi.textColor = Color(0, 215, 200);
            [cell addSubview:shezhi];
            
            UILabel *jieshi = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4, CGRectGetMaxY(shezhi.frame)+width*0.04, width*0.8, width*0.06)];
            jieshi.text = @"平台会根据市场价格为您设置价格";
            jieshi.textAlignment = NSTextAlignmentCenter;
//            jieshi.adjustsFontSizeToFitWidth = YES;
            jieshi.font = [UIFont systemFontOfSize:15];
            jieshi.textColor = Color(127, 127, 127);
            [cell addSubview:jieshi];
            
            UILabel *secJieshi = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.45, CGRectGetMaxY(jieshi.frame)+width*0.03, width*0.9, width*0.06)];
            secJieshi.textAlignment = NSTextAlignmentCenter;
            secJieshi.textColor = Color(127, 127, 127);
            secJieshi.text = @"设置价格后可根据自身情况自行调整";
            secJieshi.font = [UIFont systemFontOfSize:15];
            [cell addSubview:secJieshi];
            
            //        CGFloat maxSecjieshi = secJieshi.frame.size.height;
            UILabel *kaiqi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(secJieshi.frame)+width*0.05, width*0.5, width*0.06)];
            kaiqi.text = @"开启自动价格";
            kaiqi.font = [UIFont systemFontOfSize:15];
            kaiqi.textColor = Color(100, 100, 100);
            [cell addSubview:kaiqi];
            
            cell.userInteractionEnabled = YES;
            UIColor *color111 = Color(0, 215, 200);
            _sitch = [[UISwitch alloc] initWithFrame:CGRectMake(width*0.8, CGRectGetMaxY(secJieshi.frame)+width*0.05, 0, 0)];
            [_sitch setOnTintColor:color111];
            [_sitch setOn:NO animated:YES];
            [_sitch addTarget:self action:@selector(switchMove:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:_sitch];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.075, CGRectGetMaxY(kaiqi.frame)+width*0.1, width*0.15, width*0.15)];
            imageView.image = [UIImage imageNamed:@"logo浅.png"];
            [cell addSubview:imageView];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = Color(0, 215, 200);
            button.frame = CGRectMake(width/2- width*0.3, CGRectGetMaxY(imageView.frame)+width*0.09, width*0.6, width*0.1);
            [button setTitle:@"保存价格" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
            
            
        }
    }
    
    cell.tag = indexPath.row;
    _indexPath = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        SetPriceViewController *view = [[SetPriceViewController alloc] init];
        view.delegate = self;
        view.tag = 1111;
        view.number = indexPath.row;
        
        view.carid = self.carid;
        
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }
    else if (indexPath.row == 1||indexPath.row == 2|| indexPath.row == 4) {
        
        SetPriceViewController *view = [[SetPriceViewController alloc] init];
        view.delegate = self;
        view.tag = 2000 + indexPath.row;
        view.number = indexPath.row;
        
        view.carid = self.carid;
        
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }else if(indexPath.row == 3){
        
        ChangBaoController *view = [[ChangBaoController alloc] init];
        view.delegate = self;
        view.tag = 3333;
        
        view.carid = self.carid;
        
        
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
- (void)sendMessage:(NSString *)str sendNUm:(NSInteger)num{
    
    if (num == 0) {
        if ([str isEqualToString:@""] || [str isEqualToString:@"null"]) {
            
        }else {
            
            _jiage1.text = [NSString stringWithFormat:@"¥%@",str];
            
            _image1.image = [UIImage imageNamed:@"勾选框（已打勾）(1)"];
            _image1.tag = 1111;
            NSString *str1 = [NSString stringWithFormat:@"%ld",_image1.tag];
            [[NSUserDefaults standardUserDefaults] setObject:str1 forKey:@"image1"];
            
            [array addObject:name1.text];
        }
    } if (num == 1) {
        if ([str isEqualToString:@""] || str == nil) {
            
        }else {
            
            _jiage2.text = [NSString stringWithFormat:@"¥%@",str];
            
            _image2.image = [UIImage imageNamed:@"勾选框（已打勾）(1)"];
            _image2.tag = 1112;
            NSString *str2 = [NSString stringWithFormat:@"%ld",_image2.tag];
            [[NSUserDefaults standardUserDefaults] setObject:str2 forKey:@"image2"];
            
            [array addObject:name2.text];
        }
    } if (num == 2) {
        if ([str isEqualToString:@""] || str == nil) {
            
        }else {
            _jiage3.text = [NSString stringWithFormat:@"¥%@",str];
            
            _image3.image = [UIImage imageNamed:@"勾选框（已打勾）(1)"];
            _image3.tag = 1113;
            NSString *str3 = [NSString stringWithFormat:@"%ld",_image3.tag];
            [[NSUserDefaults standardUserDefaults] setObject:str3 forKey:@"image3"];
            
            [array addObject:name3.text];
        }
    }
     if (num == 4) {
        if ([str isEqualToString:@""] || str == nil) {
            
        }else {
            
            _jiage5.text = [NSString stringWithFormat:@"¥%@",str];
            
            _image5.image = [UIImage imageNamed:@"勾选框（已打勾）(1)"];
            _image5.tag = 1115;
            NSString *str5 = [NSString stringWithFormat:@"%ld",_image5.tag];
            [[NSUserDefaults standardUserDefaults] setObject:str5 forKey:@"image5"];
            
            [array addObject:name5.text];
        }
    }
}
// delegate
- (void)sendNews:(NSString *)str{
    
    if ([str isEqualToString:@"" ] || str == nil) {
            
        
    }else{
        
        _jiage4.text = [NSString stringWithFormat:@"¥%@",str];
        
        _image4.image = [UIImage imageNamed:@"勾选框（已打勾）(1)"];
        _image4.tag = 1114;
        NSString *str4 = [NSString stringWithFormat:@"%ld",_image4.tag];
        [[NSUserDefaults standardUserDefaults] setObject:str4 forKey:@"image4"];
        
        [array addObject:name4.text];
    }
}

// 代理
- (void)queDingJiaGe{
    
    for (NSString *str in array) {
        
        _allName = [NSString stringWithFormat:@"%@ ",str];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(sendAString:)]) {
        
        [_delegate sendAString:_allName];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)switchMove:(UISwitch *)seitch{
    
    if ([seitch isOn]) {
        
        [self AlertView];
    }
}
#pragma mark - alertView
- (void)AlertView{
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:bigView];
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenHeight/2- ScreenWidth*0.15, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    [bigView addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame), CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"敬请期待";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
    
    [_sitch setOn:NO];
}

- (void)AlertView11{
    
    bigView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:bigView1];
    
    _alertView1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenWidth/2 - ScreenWidth*0.15, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView1.backgroundColor = [UIColor whiteColor];
    _alertView1.alpha = 1.0;
    
    [bigView1 addSubview:_alertView1];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView1.frame), CGRectGetHeight(_alertView1.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView1 addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"请根据需要设置出租方式";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    queding1 = [UIButton buttonWithType:UIButtonTypeCustom];
    queding1.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [queding1 setTitle:@"确定" forState:UIControlStateNormal];
    [queding1 addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding1.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding1 setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding1];
}
- (void)moveAll{
    
    [bigView removeFromSuperview];
    [bigView1 removeFromSuperview];
}

@end
