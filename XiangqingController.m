//
//  XiangqingController.m
//  ZuChe
//
//  Created by apple  on 16/12/21.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "XiangqingController.h"
#import "Header.h"
#import "WB_Stopwatch.h"

@interface XiangqingController()<UITableViewDataSource,UITableViewDelegate,WB_StopWatchDelegate,UIAlertViewDelegate>{
    
    CGFloat width;
    UITableView *_tableView;
    
    WB_Stopwatch *stopLabel;
}

@end

@implementation XiangqingController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    width = self.view.frame.size.width;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 30, 30);
    [right setBackgroundImage:[UIImage imageNamed:@"Hi聊天.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self createTableView];
}
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, self.view.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        
        return width*0.22;
    }
    else if (indexPath.row == 2) {
        
        return width *0.8;
    }
    else if (indexPath.row == 3){
        
        return width*0.2;
    }
    else
        return width*0.9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *strc = @"stack";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strc];
        
        if (indexPath.row == 0) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, width*0.3, width*0.1)];
            label.text = @"日期";
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:25];
            label.textColor = [UIColor blackColor];
            [cell addSubview:label];
            
            UILabel *zhou = [[UILabel alloc] initWithFrame:CGRectMake(width*0.45, width*0.02, width*0.5, width*0.08)];
            zhou.text = @"周一, 10月10日";
            zhou.textColor = [UIColor grayColor];
            zhou.font = [UIFont systemFontOfSize:18];
            zhou.textAlignment = NSTextAlignmentRight;
            [cell addSubview:zhou];
            
            UILabel *shi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.45, CGRectGetMaxY(zhou.frame)+width*0.03, width*0.5, width*0.08)];
            shi.text = @"上午 9:30";
            shi.textColor = [UIColor grayColor];
            shi.textAlignment = NSTextAlignmentRight;
            shi.font = [UIFont systemFontOfSize:16];
            [cell addSubview:shi];
        }
        if (indexPath.row == 1) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, width*0.3, width*0.1)];
            label.text = @"联系";
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:25];
            label.textColor = [UIColor blackColor];
            [cell addSubview:label];
            
            UILabel *zhou = [[UILabel alloc] initWithFrame:CGRectMake(width*0.45, width*0.02, width*0.5, width*0.08)];
            zhou.text = @"15138841681";
            zhou.textColor = [UIColor grayColor];
            zhou.font = [UIFont systemFontOfSize:18];
            zhou.textAlignment = NSTextAlignmentRight;
            [cell addSubview:zhou];
            
            UILabel *shi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.45, CGRectGetMaxY(zhou.frame)+width*0.03, width*0.5, width*0.08)];
            shi.text = @"wei";
            shi.textColor = [UIColor grayColor];
            shi.textAlignment = NSTextAlignmentRight;
            shi.font = [UIFont systemFontOfSize:16];
            [cell addSubview:shi];
        }
        if (indexPath.row == 2) {
            
            UIView *image = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.9, width*0.5)];
            
            
            
            image.backgroundColor = [UIColor redColor];
            [cell addSubview:image];
            
            UILabel *dizhi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(image.frame)+width*0.03, width*0.96, width*0.08)];
            dizhi.text = @"远东国际";
            dizhi.textColor = [UIColor grayColor];
            dizhi.textAlignment = NSTextAlignmentLeft;
            dizhi.font = [UIFont systemFontOfSize:13];
            [cell addSubview:dizhi];
        }
        if (indexPath.row == 3) {
            
            UILabel *shouyi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.3, width*0.08)];
            shouyi.text = @"收益";
            shouyi.textColor = [UIColor grayColor];
            shouyi.textAlignment = NSTextAlignmentLeft;
            shouyi.font = [UIFont systemFontOfSize:20];
            [cell addSubview:shouyi];
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.8, width*0.05, width*0.15, width*0.08)];
            qian.textAlignment = NSTextAlignmentRight;
            qian.text = @"¥800";
            qian.textColor = Color(255, 70, 30);
            qian.font = [UIFont systemFontOfSize:16];
            [cell addSubview:qian];
        }
        if (indexPath.row == 4) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(width/2-width*0.1, width*0.08, width*0.2, width*0.2);
//            button.tintColor = Color(255, 70, 90);
//            [button setTitle:@"60:00" forState:UIControlStateNormal];
//            button.backgroundColor = [UIColor greenColor];
//            button.titleLabel.textColor = Color(255, 70, 90);
            
//            UIColor *color = Color(255, 70, 90);
//            [button setTitleColor:color forState:UIControlStateNormal];
            
            [button setBackgroundImage:[UIImage imageNamed:@"计时框.png"] forState:UIControlStateNormal];
            [cell addSubview:button];
            
            
            stopLabel = [[WB_Stopwatch alloc] initWithLabel:stopLabel andTimerType:WBTypeTimer];
            stopLabel.frame = CGRectMake(width/2-width*0.1, width*0.08, width*0.2, width*0.2);
            stopLabel.delegate = self;
            stopLabel.textColor = Color(255, 70, 90);
            stopLabel.textAlignment = NSTextAlignmentCenter;
            [stopLabel setTimeFormat:@"mm:ss"];
// ************************ 时间是后台获取的 ***********************************
            [stopLabel setCountDownTime:3599];
            [stopLabel start];
            [cell addSubview:stopLabel];
            
            UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3, CGRectGetMaxY(stopLabel.frame)+width*0.08, width*0.6, width*0.08)];
            duan.textColor = Color(255, 70, 90);
            duan.text = @"请给租客1小时的支付时间";
            duan.textAlignment = NSTextAlignmentCenter;
            duan.font = [UIFont systemFontOfSize:13];
            [cell addSubview:duan];
            
            UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4, CGRectGetMaxY(duan.frame)+width*0.02, width*0.8, width*0.08)];
            chang.textColor = Color(255, 70, 90);
            chang.text = @"逾期未支付系统将自动取消订单";
            chang.textAlignment = NSTextAlignmentCenter;
            chang.font = [UIFont systemFontOfSize:13];
            [cell addSubview:chang];
            
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            button2.frame = CGRectMake(width/2-width*0.3, CGRectGetMaxY(chang.frame)+width*0.02, width*0.6, width*0.1);
            [button2 setTitle:@"待支付定金" forState:UIControlStateNormal];
            button2.tintColor = [UIColor whiteColor];
            button2.backgroundColor = Color(0, 215, 200);
            [cell addSubview:button2];
            
            UIButton *cuo = [UIButton buttonWithType:UIButtonTypeCustom];
            cuo.frame = CGRectMake(width*0.01, width*0.9-width*0.11, width*0.06, width*0.06);
//            cuo.backgroundColor = [UIColor redColor];
            [cuo setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
            [cuo addTarget:self action:@selector(cuo:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cuo];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)cuo:(UIButton *)sender{
    
//    NSLog(@"cuowu cuowu");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消订单将扣除您支付的全额定金 取消之后将无法在行程中查看订单 取消之后将无法恢复订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)timerLabel:(WB_Stopwatch*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    NSLog(@"时间结束");
}
-(void)timerLabel:(WB_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WB_StopwatchLabelType)timerType{
    
//    NSLog(@"开始计时");
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        NSLog(@"点击了取消按钮");
        
        return;
    }else
        return ;
}

















@end
