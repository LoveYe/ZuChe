//
//  CarShenheView.m
//  ZuChe
//
//  Created by apple  on 2017/2/17.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "CarShenheView.h"
#import "Header.h"
#import "HttpManager.h"
#import "CarInfoModel.h"
#import "SDWebImage/UIImageView+WebCache.h"

#import "CheliangController.h"
#import "RZController.h"
#import "UseWayViewController.h"
#import "CarGaishuController.h"
#import "LGLCalenderViewController.h"
#import "NewMapController2.h"

@interface CarShenheView ()<UITableViewDelegate,UITableViewDataSource,DituMapDelegate>{
    
    CGFloat width;
    CGFloat height;
    
    UITableView *_tableView;
    
    NSMutableArray *count111;
    CarInfoModel *model;
    
    UILabel *dizhi;
    UILabel *gaishu;
    UILabel *yongtu;
    UIImageView *kuangImageView;
}

@end

@implementation CarShenheView

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.navigationController.navigationBar.hidden = NO;
    [self downLoadData];
}
- (void)downLoadData{
    
    count111 = [NSMutableArray array];
    NSDictionary *dict = @{@"carid":self.carid};
    
    model = [[CarInfoModel alloc] init];
    
    NSString *url = @"http://wx.leisurecarlease.com/api.php?op=api_bz";
    [HttpManager postData:dict andUrl:url success:^(NSDictionary *fanhuicanshu) {
        
        model = [CarInfoModel viewWithDic:fanhuicanshu[@"state"]];
        // 大图
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",model.cartu1]];
        [kuangImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        // 地址
        dizhi.text = model.dizhi_info;
        // 概述
        gaishu.text = model.gaishu_info;
        // 用途
        yongtu.text = model.yongtu_info;
        
//        [_tableView reloadData];
    } Error:^(NSString *cuowuxingxi) {
        
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    UIView *view = [self.view viewWithTag:10086];
    [view removeFromSuperview];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    [self createTableView];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = Color(240, 240, 240);
    [self.view addSubview:_tableView];
    
    _tableView.backgroundColor = Color(240, 240, 240);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return width/3*2;
    }if (indexPath.row == 7) {
        
        return width*1.6;
    }if(indexPath.row == 1){
        
        return width*0.2;
    }
    return width*0.18;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ctac = @"stav";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ctac];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ctac];
        cell.backgroundColor = Color(240, 240, 240);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            
            kuangImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width*2/3)];
            
            
            [cell addSubview:kuangImageView];
            
            UIButton *gou = [UIButton buttonWithType:UIButtonTypeCustom];
            gou.frame = CGRectMake(width*0.85, width*0.54, width*0.08, width*0.08);
            [gou setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）白.png"] forState:UIControlStateNormal];
            [cell addSubview:gou];
        }if (indexPath.row == 1) {
            
            UILabel *waiguan = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, width*0.2, width*0.08)];
            waiguan.text = @"外观";
            waiguan.textAlignment = NSTextAlignmentLeft;
            waiguan.textColor = Color(160, 160, 160);
            [cell addSubview:waiguan];
            
            UILabel *neishi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.35, width*0.02, width*0.2, width*0.08)];
            neishi.textColor = Color(160, 160, 160);
            neishi.text = @"内饰";
            neishi.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:neishi];
            
            UILabel *fuwu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.65, width*0.02, width*0.2, width*0.08)];
            fuwu.text = @"服务";
            fuwu.textColor = Color(160, 160, 160);
            fuwu.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:fuwu];
            
            for (int i = 0; i < 5; i++) {
                
                UIImageView *xingxing = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.05+i*width*0.03, CGRectGetMaxY(waiguan.frame)+width*0.02, width*0.03, width*0.03)];
                [xingxing setImage:[UIImage imageNamed:@"五角星.png"]];
                [cell addSubview:xingxing];
            }
            UILabel *five1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.23, CGRectGetMaxY(neishi.frame)+width*0.01, width*0.09, width*0.05)];
            five1.text = @"5.0";
            five1.textAlignment = NSTextAlignmentLeft;
            five1.textColor = Color(100, 100, 100);
            five1.font = [UIFont systemFontOfSize:9];
            [cell addSubview:five1];
            
            for (int i = 0; i < 5; i++) {
                
                UIImageView *xingxing = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.35+i*width*0.03, CGRectGetMaxY(neishi.frame)+width*0.02, width*0.03, width*0.03)];
                [xingxing setImage:[UIImage imageNamed:@"五角星.png"]];
                [cell addSubview:xingxing];
            }
            UILabel *five2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.53, CGRectGetMaxY(neishi.frame)+width*0.01, width*0.09, width*0.05)];
            five2.text = @"5.0";
            five2.textAlignment = NSTextAlignmentLeft;
            five2.textColor = Color(100, 100, 100);
            five2.font = [UIFont systemFontOfSize:9];
            [cell addSubview:five2];
            
            for (int i = 0; i < 5; i++) {
                
                UIImageView *xingxing = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.65+i*width*0.03, CGRectGetMaxY(fuwu.frame)+width*0.02, width*0.03, width*0.03)];
                [xingxing setImage:[UIImage imageNamed:@"五角星.png"]];
                [cell addSubview:xingxing];
            }
            UILabel *five3 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.83, CGRectGetMaxY(neishi.frame)+width*0.01, width*0.09, width*0.05)];
            five3.text = @"5.0";
            five3.textAlignment = NSTextAlignmentLeft;
            five3.textColor = Color(100, 100, 100);
            five3.font = [UIFont systemFontOfSize:9];
            [cell addSubview:five3];
            
        }if (indexPath.row == 2) {
            
            UILabel *big = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.01, width*0.6, width*0.08)];
            big.text = @"认证资料";
            big.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
            big.textColor = Color(0, 215, 200);
            big.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:big];
            
            UILabel *small = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(big.frame), width*0.8, width*0.06)];
            small.textColor = [UIColor grayColor];
            small.textAlignment = NSTextAlignmentLeft;
            small.text = @"认证资料仅供认证审核租客无法查看";
            small.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
            [cell addSubview:small];
            
            UIButton *renzheng = [UIButton buttonWithType:UIButtonTypeCustom];
            renzheng.frame = CGRectMake(width*0.85, width*0.04, width*0.08, width*0.08);
            [renzheng setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
            [cell addSubview:renzheng];
            
        }if (indexPath.row == 3) {
            
            
            UILabel *big = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.01, width*0.6, width*0.08)];
            big.text = @"设置地址";
            big.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
            big.textColor = Color(0, 215, 200);
            [big setAdjustsFontSizeToFitWidth:YES];
            [cell addSubview:big];
            
            dizhi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(big.frame), width*0.8, width*0.06)];
            dizhi.textColor = [UIColor grayColor];
            dizhi.text = model.dizhi_info;
            dizhi.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
            [cell addSubview:dizhi];
            
            UIButton *dizi = [UIButton buttonWithType:UIButtonTypeCustom];
            dizi.frame = CGRectMake(width*0.85, width*0.04, width*0.08, width*0.08);
            [dizi setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
            [cell addSubview:dizi];
//            cell.backgroundView = view;
        }if (indexPath.row == 4) {
            
            UIView *view = [[UIView alloc] init];
            
            UILabel *big = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.01, width*0.6, width*0.08)];
            big.text = @"车辆概述";
            big.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
            big.textColor = Color(0, 215, 200);
            //        big.font = [UIFont fontWithName:@"" size:15];
            [big setAdjustsFontSizeToFitWidth:YES];
            [view addSubview:big];
            
            gaishu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(big.frame), width*0.8, width*0.06)];
            gaishu.textColor = [UIColor grayColor];
            gaishu.text = model.gaishu_info;
            gaishu.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
            [view addSubview:gaishu];
            
            UIButton *buton1 = [UIButton buttonWithType:UIButtonTypeCustom];
            buton1.frame = CGRectMake(width*0.85, width*0.04, width*0.08, width*0.08);
            [buton1 setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
            [view addSubview:buton1];
            cell.backgroundView = view;
        }if (indexPath.row == 5) {
            
            UIView *view = [[UIView alloc] init];
            
            UILabel *big = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.01, width*0.6, width*0.08)];
            big.text = @"设置用途";
            big.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
            big.textColor = Color(0, 215, 200);
            //        big.font = [UIFont fontWithName:@"" size:15];
            [big setAdjustsFontSizeToFitWidth:YES];
            [view addSubview:big];
            
            yongtu = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(big.frame), width*0.8, width*0.06)];
            yongtu.textColor = [UIColor grayColor];
            yongtu.text = model.yongtu_info;
            yongtu.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
            [view addSubview:yongtu];
            
            UIButton *yogntu = [UIButton buttonWithType:UIButtonTypeCustom];
            yogntu.frame = CGRectMake(width*0.85, width*0.04, width*0.08, width*0.08);
            [yogntu setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
            [view addSubview:yogntu];
            
            cell.backgroundView = view;
        }if (indexPath.row == 6) {
            
            UIView *view = [[UIView alloc] init];
            
            UILabel *big = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.01, width*0.6, width*0.08)];
            big.text = @"设置日期";
            big.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
            big.textColor = Color(0, 215, 200);
            [view addSubview:big];
            
            UILabel *small2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(big.frame), width*0.8, width*0.06)];
            small2.textColor = [UIColor grayColor];
            small2.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
            small2.text = @"及时更新不可用日期避免降低接单率";
            [view addSubview:small2];
            
            UIButton *riqi = [UIButton buttonWithType:UIButtonTypeCustom];
            riqi.frame = CGRectMake(width*0.85, width*0.04, width*0.08, width*0.08);
            [riqi setBackgroundImage:[UIImage imageNamed:@"勾选框（已打勾）(1)"] forState:UIControlStateNormal];
            [view addSubview:riqi];
            
            cell.backgroundView = view;
        }if (indexPath.row == 7) {
            
            UILabel *jiedan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.2, width*0.05, width*0.4, width*0.08)];
            jiedan.text = @"接单设置";
            jiedan.textColor = Color(85, 85, 85);
            jiedan.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:jiedan];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width*0.04, width*0.18, width*0.92, width*0.7)];
            view.backgroundColor = [UIColor whiteColor];
            [cell addSubview:view];
            
            UIImageView *shandian = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.05-width*0.04, width*0.02, width*0.1, width*0.1)];
            shandian.image = [UIImage imageNamed:@"闪电.png"];
            [view addSubview:shandian];
            
            UILabel *kuai = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3-width*0.04, CGRectGetMaxY(shandian.frame)+width*0.01, width*0.6, width*0.08)];
            kuai.text = @"需要很快的接受订单吗？";
            kuai.textColor = Color(100, 100, 100);
            kuai.textAlignment = NSTextAlignmentCenter;
            [view addSubview:kuai];
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-width*0.04, CGRectGetMaxY(kuai.frame)+width*0.02, width*0.8, width*0.08)];
            qian.text = @"自动接单功能可以自动为您接受所有订单";
            qian.textColor = Color(175, 175, 175);
            qian.font = [UIFont systemFontOfSize:15];
            qian.textAlignment = NSTextAlignmentCenter;
            [view addSubview:qian];
            
            UILabel *kaizi = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-width*0.04, CGRectGetMaxY(qian.frame)+width*0.03, width*0.6, width*0.08)];
            kaizi.text = @"开启自动接单";
            kaizi.textColor = Color(100, 100, 100);
            kaizi.textAlignment = NSTextAlignmentLeft;
            [view addSubview:kaizi];
            
            UISwitch *kaiguan1 = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(kaizi.frame)+width*0.08, CGRectGetMaxY(qian.frame)+width*0.03, 0, 0)];
            [kaiguan1 addTarget:self action:@selector(switch111:) forControlEvents:UIControlEventValueChanged];
            UIColor *color = Color(0, 215, 200);
            [kaiguan1 setOnTintColor:color];
            [kaiguan1 setOn:YES animated:YES];
            [view addSubview:kaiguan1];
            
            UILabel *jinji = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-width*0.04,CGRectGetMaxY(kaizi.frame)+width*0.04, width*0.6, width*0.08)];
            jinji.text = @"开启接受紧急接单";
            jinji.textColor = Color(100, 100, 100);
            jinji.textAlignment = NSTextAlignmentLeft;
            [view addSubview:jinji];
            
            UISwitch *kaiguan2 = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jinji.frame)+width*0.08, CGRectGetMaxY(kaiguan1.frame)+width*0.03, 0, 0)];
            [kaiguan2 addTarget:self action:@selector(switch111:) forControlEvents:UIControlEventValueChanged];
            [kaiguan2 setOnTintColor:color];
            [kaiguan2 setOn:NO animated:YES];
            [view addSubview:kaiguan2];
            
            UILabel *bujiedan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4-width*0.04,CGRectGetMaxY(jinji.frame)+width*0.03, width*0.6, width*0.08)];
            bujiedan.text = @"暂时不接单";
            bujiedan.textColor = Color(100, 100, 100);
            bujiedan.textAlignment = NSTextAlignmentLeft;
            [view addSubview:bujiedan];
            
            UISwitch *kaiguan3 = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bujiedan.frame)+width*0.08, CGRectGetMaxY(kaiguan2.frame)+width*0.03, 0, 0)];
            [kaiguan3 addTarget:self action:@selector(switch111:) forControlEvents:UIControlEventValueChanged];
            [kaiguan3 setOnTintColor:color];
            [kaiguan3 setOn:NO animated:YES];
            [view addSubview:kaiguan3];
            
            // 二维码图片生成
            UIImageView *cheErweima = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.1, CGRectGetMaxY(view.frame)+width*0.15, width*0.2, width*0.2)];
            
//            // ***********************生成二维码
//            //二维码滤镜
//            CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
//            //恢复滤镜的默认属性
//            [filter setDefaults];
//            //将字符串转换成NSData
//            NSData *data=[@"Https://www.baidu.com" dataUsingEncoding:NSUTF8StringEncoding];
//            //通过KVO设置滤镜inputmessage数据
//            [filter setValue:data forKey:@"inputMessage"];
//            //获得滤镜输出的图像
//            CIImage *outputImage=[filter outputImage];
//            
//            cheErweima.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
            cheErweima.image = [UIImage imageNamed:@"logo浅.png"];
            [cell addSubview:cheErweima];
            // ***********************结束
            
//            UILabel *hongzi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, CGRectGetMaxY(cheErweima.frame)*width*0.05, width*0.8, width*0.06)];
//            hongzi.text = @"扫描此二维码用户可直接预订您的爱车";
//            hongzi.textColor = Color(255, 0, 0);
//            hongzi.textAlignment = NSTextAlignmentCenter;
//            [cell addSubview:hongzi];
//            
//            UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.1, CGRectGetMaxY(hongzi.frame)+width*0.05, width*0.2, width*0.2)];
//            iconImage.image = [UIImage imageNamed:@"logo浅.png"];
//            [cell addSubview:iconImage];
        }
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"审核已通过，如需修改请联系4008-609-669" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
        
        [self createAlertView];
    }if (indexPath.row == 2) {
        
        [self createAlertView];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"审核已通过，如需修改请联系4008-609-669" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
    }
    if (indexPath.row == 3) {
        
        NewMapController2 *view = [[NewMapController2 alloc] init];
        view.carid = self.carid;
        view.delegate = self;
        
        view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:view animated:NO];
    }if (indexPath.row == 4) {
        
        CarGaishuController *view = [[CarGaishuController alloc] init];
        view.carid = self.carid;
        view.gaishu = gaishu.text;
        view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:view animated:NO];
    }if (indexPath.row == 5) {
        
        UseWayViewController *view = [[UseWayViewController alloc] init];
        view.carid = self.carid;
        view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:view animated:NO];
    }if (indexPath.row == 6) {
        
        LGLCalenderViewController *view = [[LGLCalenderViewController alloc] init];
        view.carid = self.carid;
        
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
}

- (void)switch111:(UISwitch *)sender{
    
    
}
#pragma mark - 二维码
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width11 = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width11, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}
- (void)createAlertView{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 10086;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.tag = 8009;
    view2.frame = CGRectMake(width*0.1, height/2-width*0.395, width*0.8, width*0.35);
    view2.backgroundColor = [UIColor whiteColor];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    [view1 addSubview:view2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, view2.frame.size.width*0.05, view2.frame.size.width*0.9, width*0.08)];
    label.text = @"审核已通过，如需修改请联系";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [view2 addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label.frame), view2.frame.size.width*0.9, width*0.08)];
    label2.text = @"4008-609-669";
    label2.textColor = Color(107, 107, 107);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont fontWithName:@"ArialMT" size:18];
    [view2 addSubview:label2];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(label2.frame)+view2.frame.size.width*0.02, view2.frame.size.width*0.9, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [view2 addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, CGRectGetMaxY(xian.frame)+view2.frame.size.width*0.05, view2.frame.size.width, view2.frame.size.width*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [view2 addSubview:queding];
}
- (void)moveAll{
    
    UIView *view = [self.view viewWithTag:10086];
    [view removeFromSuperview];
}
#pragma mark - ditu
- (void)dituSendMessage:(NSString *)sender{
    
    dizhi.text = sender;
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
