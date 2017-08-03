//
//  TiJiaoViewController.m
//  ZuChe
//
//  Created by apple  on 2017/8/1.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "TiJiaoViewController.h"
#import "PaizhaoViewController.h"
#import "chexinmodelViewController.h"
#import "Header.h"

#import "LXKColorChoice.h"
#import "CarYearView.h"
#import "CarColorView.h"
#import "SexView.h"
#import "AFNetworking.h"
#import "ZmjPickView.h"

#import "ZCUserData.h"
#import "HttpManager.h"

@interface TiJiaoViewController ()<UITableViewDelegate,UITableViewDataSource,LXKColorChoiceDelegate,LXKColorChoiceDelegate1,LXKColorChoiceDelegate2,LXKColorChoiceDelegate3>{
    
    UITableView *_tableView;
    
    CGFloat width;
    CGFloat height;
    UIButton *paizhaoButton;
    
    NSString *paizhaoPlate;
    
    AFHTTPRequestOperationManager *manager;
    
    UILabel *chexingLabel;
    UILabel *timeLabel;
    UILabel *colorLabel;
    UILabel *lichengLabel;
    UILabel *sexLabel;
    UILabel *addressLabel;
    
    UITextField *chePai;
    UITextField *nameTextfield;
    UITextField *inviteTextfield;
}
@property (nonatomic , strong)NSArray *gongli;
@property (nonatomic , strong)NSArray *carYear;
@property (nonatomic , strong)NSArray *carColor;
@property (nonatomic , strong)NSArray *sexArray;

@property(nonatomic,strong)LXKColorChoice *colorDatePickerView;
@property (nonatomic,strong)CarYearView *carYearView;
@property (nonatomic,strong)CarColorView *carColorView;
@property (nonatomic ,strong)SexView *sexView;
@property (strong, nonatomic) ZmjPickView *zmjPickView;

@end

@implementation TiJiaoViewController

- (NSArray *)gongliArray{
    
    if (!_gongli) {
        
        _gongli = @[@"3万以下",@"3万-6万",@"6万-10万",@"10万以上"];
    }
    return _gongli;
}
- (NSArray *)carYearArray{
    
    if (!_carYear) {
        _carYear = @[@"2017",@"2016",@"2015",@"2014",@"2013",@"2012",@"2011",@"2010"];
    }
    return _carYear;
}
- (NSArray *)colorArray{
    
    if (!_carColor) {
        
        _carColor = @[@"黑色",@"白色",@"红色",@"棕色",@"灰色",@"蓝色",@"绿色",@"黄色",@"紫色"];
    }
    return _carColor;
}
- (NSArray *)sexArray{
    
    if (!_sexArray) {
        _sexArray = @[@"男",@"女"];
    }
    return _sexArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden =YES;
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:ADDCARURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([ responseObject  isKindOfClass:[NSDictionary class]]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:@"addcarurl"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"carTitle"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    UILabel *tit = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    tit.text = @"发布车辆";
    tit.textColor = Color(77, 77, 77);
    tit.textAlignment = NSTextAlignmentCenter;
    tit.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
    self.navigationItem.titleView = tit;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self createTablView];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - width*0.075, width*0.12*9+width*0.1, width*0.15, width*0.15)];
    logo.image = [UIImage imageNamed:@"logo浅.png"];
    [self.view addSubview:logo];
    
    UIButton *tijiao = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiao.frame = CGRectMake(width/2-width*0.3, CGRectGetMaxY(logo.frame)+width*0.1, width*0.6, width*0.1);
    [tijiao setTitle:@"提交" forState:UIControlStateNormal];
    tijiao.backgroundColor = Color(7, 187, 177);
    [tijiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:tijiao];
    [tijiao addTarget:self action:@selector(tijiaoInfo) forControlEvents:UIControlEventTouchUpInside];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(paizhao_duile:) name:@"paizhao_duile" object:nil];
    [nc addObserver:self selector:@selector(zhexing:) name:@"chexingshizhege" object:nil];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTablView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, width*0.12*9)];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIColor *color = Color(217, 217, 217);
    [_tableView setSeparatorColor:color];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return width * 0.12;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        if (indexPath.row == 0) {
            
            paizhaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
            paizhaoButton.frame = CGRectMake(width*0.05, 0, width*0.15, width*0.12);
            [paizhaoButton setTitle:@"沪A >" forState:UIControlStateNormal];
            UIColor *color = Color(77, 77, 77);
            paizhaoPlate = @"沪A";
            [paizhaoButton setTitleColor:color forState:UIControlStateNormal];
            [paizhaoButton addTarget:self action:@selector(paiZhao:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:paizhaoButton];
            
            UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.2, width*0.02, 1, width*0.08)];
            xian.backgroundColor = Color(217, 217, 217);
            [cell addSubview:xian];
            
            chePai = [[UITextField alloc] initWithFrame:CGRectMake(width*0.21, 0, width*0.74, width*0.12)];
            chePai.placeholder = @"请点击添加";
            chePai.tintColor = Color(7, 187, 177);
            chePai.textColor = Color(77, 77, 77);
            chePai.textAlignment = NSTextAlignmentRight;
            chePai.font = [UIFont systemFontOfSize:17];
            [cell addSubview:chePai];
        }if (indexPath.row == 1) {
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.06, 0, width*0.15, width*0.12)];
            qian.text = @"车型";
            qian.adjustsFontSizeToFitWidth = YES;
            qian.textColor = Color(77, 77, 77);
            qian.textAlignment = NSTextAlignmentLeft;
            qian.font = [UIFont systemFontOfSize:17];
            [cell addSubview:qian];
            
            chexingLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.21, 0, width*0.7, width*0.12)];
            chexingLabel.text = @"点击设置";
            chexingLabel.textColor = Color(207, 207, 207);
            chexingLabel.textAlignment = NSTextAlignmentRight;
            chexingLabel.font = [UIFont systemFontOfSize:17];
            [cell addSubview:chexingLabel];
        }if (indexPath.row == 2) {
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.06, 0, width*0.15, width*0.12)];
            qian.text = @"年份";
            qian.adjustsFontSizeToFitWidth = YES;
            qian.textColor = Color(77, 77, 77);
            qian.textAlignment = NSTextAlignmentLeft;
            qian.font = [UIFont systemFontOfSize:17];
            [cell addSubview:qian];
            
            timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.21, 0, width*0.7, width*0.12)];
            timeLabel.text = @"点击设置";
            timeLabel.textColor = Color(207, 207, 207);
            timeLabel.textAlignment = NSTextAlignmentRight;
            timeLabel.font = [UIFont systemFontOfSize:17];
            [cell addSubview:timeLabel];
        }if (indexPath.row == 3) {
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.06, 0, width*0.15, width*0.12)];
            qian.text = @"颜色";
            qian.adjustsFontSizeToFitWidth = YES;
            qian.textColor = Color(77, 77, 77);
            qian.textAlignment = NSTextAlignmentLeft;
            qian.font = [UIFont systemFontOfSize:17];
            [cell addSubview:qian];
            
            colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.21, 0, width*0.7, width*0.12)];
            colorLabel.text = @"点击设置";
            colorLabel.textColor = Color(207, 207, 207);
            colorLabel.textAlignment = NSTextAlignmentRight;
            colorLabel.font = [UIFont systemFontOfSize:17];
            [cell addSubview:colorLabel];
        }if (indexPath.row == 4) {
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.06, 0, width*0.15, width*0.12)];
            qian.text = @"里程";
            qian.adjustsFontSizeToFitWidth = YES;
            qian.textColor = Color(77, 77, 77);
            qian.textAlignment = NSTextAlignmentLeft;
            qian.font = [UIFont systemFontOfSize:17];
            [cell addSubview:qian];
            
            lichengLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.21, 0, width*0.7, width*0.12)];
            lichengLabel.text = @"点击设置";
            lichengLabel.textColor = Color(207, 207, 207);
            lichengLabel.textAlignment = NSTextAlignmentRight;
            lichengLabel.font = [UIFont systemFontOfSize:17];
            [cell addSubview:lichengLabel];
        }if (indexPath.row == 5) {
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.06, 0, width*0.15, width*0.12)];
            qian.text = @"姓名";
            qian.adjustsFontSizeToFitWidth = YES;
            qian.textColor = Color(77, 77, 77);
            qian.textAlignment = NSTextAlignmentLeft;
            qian.font = [UIFont systemFontOfSize:17];
            [cell addSubview:qian];
            
            nameTextfield = [[UITextField alloc] initWithFrame:CGRectMake(width*0.21, 0, width*0.74, width*0.12)];
            nameTextfield.placeholder = @"点击设置";
            nameTextfield.textColor = Color(77, 77, 77);
            nameTextfield.textAlignment = NSTextAlignmentRight;
            nameTextfield.font = [UIFont systemFontOfSize:17];
            [cell addSubview:nameTextfield];
        }if (indexPath.row == 6) {
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.06, 0, width*0.15, width*0.12)];
            qian.text = @"性别";
            qian.adjustsFontSizeToFitWidth = YES;
            qian.textColor = Color(77, 77, 77);
            qian.textAlignment = NSTextAlignmentLeft;
            qian.font = [UIFont systemFontOfSize:17];
            [cell addSubview:qian];
            
            sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.21, 0, width*0.7, width*0.12)];
            sexLabel.text = @"点击设置";
            sexLabel.textColor = Color(207, 207, 207);
            sexLabel.textAlignment = NSTextAlignmentRight;
            sexLabel.font = [UIFont systemFontOfSize:17];
            [cell addSubview:sexLabel];
        }if (indexPath.row == 7) {
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.06, 0, width*0.15, width*0.12)];
            qian.text = @"邀请码";
            qian.adjustsFontSizeToFitWidth = YES;
            qian.textColor = Color(77, 77, 77);
            qian.textAlignment = NSTextAlignmentLeft;
            qian.font = [UIFont systemFontOfSize:17];
            [cell addSubview:qian];
            
            inviteTextfield = [[UITextField alloc] initWithFrame:CGRectMake(width*0.21, 0, width*0.74, width*0.12)];
            inviteTextfield.placeholder = @"点击设置";
            inviteTextfield.textColor = Color(77, 77, 77);
            inviteTextfield.textAlignment = NSTextAlignmentRight;
            inviteTextfield.font = [UIFont systemFontOfSize:17];
            [cell addSubview:inviteTextfield];
        }if (indexPath.row == 8) {
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.06, 0, width*0.2, width*0.12)];
            qian.text = @"所在城市";
            qian.adjustsFontSizeToFitWidth = YES;
            qian.textColor = Color(77, 77, 77);
            qian.textAlignment = NSTextAlignmentLeft;
            qian.font = [UIFont systemFontOfSize:17];
            [cell addSubview:qian];
            
            addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.21, 0, width*0.7, width*0.12)];
            addressLabel.text = @"点击设置";
            addressLabel.textColor = Color(207, 207, 207);
            addressLabel.textAlignment = NSTextAlignmentRight;
            addressLabel.font = [UIFont systemFontOfSize:17];
            [cell addSubview:addressLabel];
        }
    }
    
    cell.userInteractionEnabled = YES;
    
    if (indexPath.row != 5 && indexPath.row != 0 && indexPath.row != 7) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
        chexinmodelViewController *chexin=[[chexinmodelViewController alloc]init];
        [self.navigationController pushViewController:chexin animated:YES];
    }if (indexPath.row == 2) {
        
        self.carYearView = [CarYearView makeViewWithMaskDatePicker1:self.view.window.frame setTitle1:@"年份选择" Arr1:self.carYearArray];
        self.carYearView.delegate = self;
    }if (indexPath.row == 3) {
        
        self.carColorView = [CarColorView makeViewWithMaskDatePicker2:self.view.window.frame setTitle2:@"颜色选择" Arr2:self.colorArray];
        self.carColorView.delegate = self;
    }if (indexPath.row == 4) {
        
        self.colorDatePickerView = [LXKColorChoice makeViewWithMaskDatePicker:self.view.window.frame setTitle:@"公里选择" Arr:self.gongliArray];
        self.colorDatePickerView.delegate = self;
    }if (indexPath.row == 6) {
        
        self.sexView = [SexView makeViewWithMaskDatePicker3:self.view.window.frame setTitle3:@"性别选择" Arr3:self.sexArray];
        self.sexView.delegate = self;
    }
    
    if (indexPath.row == 8) {
        
        [self zmjPickView];
        [_zmjPickView show];
        
        __weak typeof(self) weakSelf = self;
        _zmjPickView.determineBtnBlock = ^(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName){
            __strong typeof(weakSelf)strongSelf = weakSelf;
            
            [strongSelf ShengName:shengName ShiName:shiName XianName:xianName];
        };
    }
}
#pragma mark - 提交车辆基本信息
- (void)tijiaoInfo{
    
    if ( chePai.text.length == 0) {
        
        [self createPNMERROR:@"请检查车牌号是否添加"];
    }else if ([chexingLabel.text isEqualToString:@"点击设置"]){
        
        [self createPNMERROR:@"请检查车型是否添加"];
    }else if ([timeLabel.text isEqualToString:@"点击设置"]){
        
        [self createPNMERROR:@"请检查车辆年份是否添加"];
    }else if ([colorLabel.text isEqualToString:@"点击设置"]){
        
        [self createPNMERROR:@"请检查车辆颜色是否添加"];
    }else if ([lichengLabel.text isEqualToString:@"点击设置"]){
        
        [self createPNMERROR:@"请检查车辆里程是否添加"];
    }else if (nameTextfield.text.length == 0){
        
        [self createPNMERROR:@"请检查车辆所有名字人是否添加"];
    }else if ([sexLabel.text isEqualToString:@"点击设置"]){
        
        [self createPNMERROR:@"请检查车辆性别是否添加"];
    }else if ([addressLabel.text isEqualToString:@"点击设置"]){
        
        [self createPNMERROR:@"请检查城市里程是否添加"];
    }else{
        
        NSString *pinpai = [[NSUserDefaults standardUserDefaults] objectForKey:@"carTitle"];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",[ZCUserData share].username,@"username",paizhaoPlate,@"plate_num1",chePai.text,@"plate_num2",chexingLabel.text,@"models",pinpai,@"pinpai",timeLabel.text,@"caryear",colorLabel.text,@"color",lichengLabel.text,@"carm",nameTextfield.text,@"name",sexLabel.text,@"sex",addressLabel.text,@"city",inviteTextfield.text,@"ctma", nil];
        
        [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_fabucar" success:^(NSDictionary *fanhuicanshu) {
            
            if ([[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"error"]] isEqualToString:@"0"]) {
                
                [self tishi1];
            }else{
                
                [self tishi2];
            }
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }
}

#pragma mark - 地址选择
- (ZmjPickView *)zmjPickView {
    if (!_zmjPickView) {
        _zmjPickView = [[ZmjPickView alloc]init];
    }
    return _zmjPickView;
}
#pragma mark - 牌照界面与 车型界面
- (void)paiZhao:(UIButton *)sender{
    
    PaizhaoViewController *view=[[PaizhaoViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
- (void)chexing:(UIButton *)sender{
    
    chexinmodelViewController *chexin=[[chexinmodelViewController alloc]init];
    [self.navigationController pushViewController:chexin animated:YES];
}

#pragma mark - 车辆地址
- (void)ShengName:(NSString *)shengName ShiName:(NSString *)shiName XianName:(NSString *)xianName{
    
    addressLabel.text = [NSString stringWithFormat:@"%@%@%@",shengName,shiName,xianName];
    addressLabel.textColor = Color(77, 77, 77);
}

#pragma mark - 车型改变
-(void)zhexing:(NSNotification *)not{
    
    chexingLabel.text = [not object];
    chexingLabel.textColor = Color(77, 77, 77);
}
#pragma mark - 牌照改变
-(void)paizhao_duile:(NSNotification*)not{
    
    NSString *str = [not object];
    NSString *string = [NSString stringWithFormat:@"%@ >",str];
    [paizhaoButton setTitle:string forState:UIControlStateNormal];
    UIColor *color = Color(77, 77, 77);
    paizhaoPlate = str;
    [paizhaoButton setTitleColor:color forState:UIControlStateNormal];
}
#pragma mark - 颜色代理方法
-(void)getColorChoiceValues:(NSString *)values{
    
    lichengLabel.text = values;
    lichengLabel.textColor = Color(77, 77, 77);
}
#pragma mark - 年份代理方法
- (void)getColorChoiceValues11:(NSString *)values{
    
    timeLabel.text = values;
    timeLabel.textColor = Color(77, 77, 77);
}
#pragma mark - 车辆颜色
- (void)getColorChoiceValues22:(NSString *)values{
    
    colorLabel.text = values;
    colorLabel.textColor = Color(77, 77, 77);
}
#pragma mark - 性别选择
- (void)getColorChoiceValues33:(NSString *)values{
    
    sexLabel.text = values;
    sexLabel.textColor = Color(77, 77, 77);
}
#pragma mark - 发布成功
- (void)tishi1{
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 10089;
    [self.view.window addSubview:bigView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(width*0.15, height/2 - width*0.15, width*0.7, width*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [bigView addSubview:_alertView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.05, width*0.7, width*0.1)];
    label.text = @"发布成功";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [_alertView addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.18, width*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [_alertView addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, width*0.2, width*0.7, width*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [_alertView addSubview:queding];
}
#pragma mark - 车牌已发布
- (void)tishi2{
    
//    这个车牌已经发布过了
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
    label.text = @"此车牌已经发布";
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
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
- (void)moveAll{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)queding{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
}
#pragma mark - 一个一个的提示
- (void)createPNMERROR:(NSString *)str{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.1, height/2-width*0.25, width*0.8, width*0.3)];
    view2.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:view2];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.03, view2.frame.size.width*0.9, width*0.1)];
    label.text = str;
    label.textColor = Color(157, 157, 157);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [view2 addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label.frame)+width*0.03, view2.frame.size.width*0.9, 1)];
    xian.backgroundColor = Color(237, 237, 237);
    [view2 addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, CGRectGetMaxY(xian.frame), view2.frame.size.width, width*0.14);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [view2 addSubview:queding];
}
- (void)buttonClick{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:718];
    [view removeFromSuperview];
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
