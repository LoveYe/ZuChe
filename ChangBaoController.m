//
//  ChangBaoController.m
//  ZuChe
//
//  Created by apple  on 16/11/22.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "ChangBaoController.h"
#import "UseWayViewController.h"
#import "Header.h"
#import "AFHTTPRequestOperationManager.h"
#import "ZuChe/ZCUserData.h"

@interface ChangBaoController ()<UITableViewDelegate,UITableViewDataSource>{
    
    CGFloat width;
    UITableView *_tableView;
    UILabel *_label;
    
    UITextField *_textField1;
    UITextField *_textField2;
    UITextField *_textField3;
    UITextField *_textField4;
    
    NSString *_type;
    
    int typpe;
    
    UIView *_alertView;
    UIView *bigView;
    UIButton *quxiao;
    UIButton *queding;
    
    UIView *_alertView1;
    UIView *bigView1;
    UIButton *queding1;
}

@end


@implementation ChangBaoController
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.title = @"编辑价格";
    [self createTableView];
    
    width = self.view.frame.size.width;
    
    UIButton *letf = [UIButton buttonWithType:UIButtonTypeCustom];
    letf.frame = CGRectMake(0, 0, 25, 25);
    [letf setImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [letf addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:letf];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarbutton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(TiJiao:)];
    rightBarbutton.tintColor = Color(0, 215, 200);
    self.navigationItem.rightBarButtonItem = rightBarbutton;
    
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
//    rightButton.tintColor = Color(0, 210, 190);
//    rightButton.frame = CGRectMake(0, 0, 50, 30);
//    [rightButton addTarget:self action:@selector(TiJiao:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarbutton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    [rightBarbutton setTintColor:[UIColor blueColor]];
//    self.navigationItem.rightBarButtonItem = rightBarbutton;
    
    
    //    UIBarButtonItem *rightBarbutton = [UIBarButtonItem ]
}
- (void)TiJiao:(UIButton *)button{
    
    if (_textField1.text.length == 0||_textField2.text.length == 0 || _textField3.text.length == 0||_textField4.text.length == 0) {
        
        [self alertView];
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(sendNews:)]) {
            
            
            NSString *url = @"http://wx.leisurecarlease.com/api.php?op=api_bcjiage";
            
            _type = @"4";
            
            AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            NSDictionary *dicc = @{@"jiage1":_textField1.text,@"jiage2":_textField2.text,@"jiage3":_textField3.text,@"jiage4":_textField4.text,@"carid":self.carid,@"type":_type};
            
            [manager POST:url parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jiage111"];
//    [[NSUserDefaults standardUserDefaults] setObject:_textField1.text forKey:@"jiage111"];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jiage222"];
//    [[NSUserDefaults standardUserDefaults] setObject:_textField2.text forKey:@"jiage222"];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jiage333"];
//    [[NSUserDefaults standardUserDefaults] setObject:_textField3.text forKey:@"jiage333"];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jiage444"];
//    [[NSUserDefaults standardUserDefaults] setObject:_textField4.text forKey:@"jiage444"];
}

- (void)fanhui{
    
    UseWayViewController *view = [[UseWayViewController alloc] init];
    
    view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(self.view.frame)-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat widthOfTableView = self.view.frame.size.width;
    
    if (indexPath.row == 2) {
        
        return widthOfTableView*1.1;
    }
    return widthOfTableView*0.3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        if (indexPath.row == 0) {
            
            UILabel *miaoshu = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.3, width*0.02, width*0.6, width*0.08)];
            miaoshu.text = @"此价格为长包每月的价格";
            miaoshu.textAlignment = NSTextAlignmentCenter;
            miaoshu.font = [UIFont systemFontOfSize:15];
            miaoshu.textColor = Color(90, 90, 90);
            [cell addSubview:miaoshu];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.2, CGRectGetMaxY(miaoshu.frame)+width*0.02-width*0.001, width*0.13, width*0.13)];
            imageView.image = [UIImage imageNamed:@"价格设置(1)"];
//            imageView.backgroundColor = [UIColor brownColor];
            
            _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)-5, CGRectGetMaxY(miaoshu.frame)+width*0.02+width*0.001, width*0.25, width*0.13-width*0.005)];
            _textField1.backgroundColor = [UIColor whiteColor];
            _textField1.textColor = Color(255, 97, 57);
            _textField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _textField1.keyboardType = UIKeyboardTypeNumberPad;
            _textField1.borderStyle = UITextBorderStyleRoundedRect;
            _textField1.tag = 111;
            _textField1.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
            _textField1.layer.borderWidth = 1.1;
            UIColor *col = Color(217, 217, 217);
            _textField1.layer.borderColor = [col CGColor];
            _textField1.layer.cornerRadius = 3.0;
            
//            _textField1.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage111"];
            [cell addSubview:_textField1];
            
            [cell addSubview:imageView];
            
            
        }
        if (indexPath.row == 1) {
            
//            UILabel *chaochuLC = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame)+30,20,width*0.4,width*0.6)];
            UILabel *chaochuLC = [[UILabel alloc] initWithFrame:CGRectMake(0,width*0.02,width*0.5,width*0.08)];
            chaochuLC.text = @"限制里程(每月)";
            chaochuLC.textAlignment = NSTextAlignmentCenter;
            chaochuLC.font = [UIFont systemFontOfSize:15];
            chaochuLC.textColor = Color(90, 90, 90);
            [cell addSubview:chaochuLC];
            
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.1, CGRectGetMaxY(chaochuLC.frame)-width*0.001+width*0.02, width*0.13, width*0.13)];
            imageView1.image = [UIImage imageNamed:@"价格设置(2)"];
//            imageView1.backgroundColor = [UIColor brownColor];
            
            _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame)-5, CGRectGetMaxY(chaochuLC.frame)+width*0.02+width*0.001, width*0.25, width*0.13-width*0.005)];
            _textField2.backgroundColor = [UIColor whiteColor];
            _textField2.textColor = Color(255, 97, 57);
            _textField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _textField2.keyboardType = UIKeyboardTypeNumberPad;
            _textField2.borderStyle = UITextBorderStyleRoundedRect;
            //            _textField2.tag = 333;
            _textField2.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
            _textField2.layer.borderWidth = 1.1;
            UIColor *col = Color(217, 217, 217);
            _textField2.layer.borderColor = [col CGColor];
            _textField2.layer.cornerRadius = 3.0;
//            _textField2.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage222"];
            [cell addSubview:_textField2];
            
            [cell addSubview:imageView1];
            
            
            UILabel *miaoshu = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(chaochuLC.frame), width*0.02, width*0.3, width*0.08)];
            miaoshu.text = @"超出每公里";
            miaoshu.textAlignment = NSTextAlignmentCenter;
            miaoshu.font = [UIFont systemFontOfSize:15];
            miaoshu.textColor = Color(90, 90, 90);
            [cell addSubview:miaoshu];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_textField2.frame)+width*0.05, CGRectGetMaxY(miaoshu.frame)-width*0.001+width*0.02, width*0.13, width*0.13)];
            imageView.image = [UIImage imageNamed:@"价格设置(1)"];
//            imageView.backgroundColor = [UIColor brownColor];
            
            _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)-5, CGRectGetMaxY(miaoshu.frame)+width*0.02+width*0.001, width*0.25, width*0.13-width*0.005)];
            _textField3.backgroundColor = [UIColor whiteColor];
            _textField3.textColor = Color(255, 97, 57);
            _textField3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _textField3.keyboardType = UIKeyboardTypeNumberPad;
            _textField3.borderStyle = UITextBorderStyleRoundedRect;
            _textField3.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
            //            _textField3.tag = 222;
//            _textField3.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage333"];
            _textField3.layer.borderWidth = 1.1;
//            UIColor *col = Color(217, 217, 217);
            _textField3.layer.borderColor = [col CGColor];
            _textField3.layer.cornerRadius = 3.0;
            [cell addSubview:_textField3];
            
            [cell addSubview:imageView];
            
            
        }
        if (indexPath.row == 2) {
            UILabel *miaoshu = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.15, width*0.02, width*0.3, width*0.08)];
            miaoshu.text = @"加班每小时";
            miaoshu.textAlignment = NSTextAlignmentCenter;
            miaoshu.font = [UIFont systemFontOfSize:15];
            miaoshu.textColor = Color(90, 90, 90);
            [cell addSubview:miaoshu];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.2, CGRectGetMaxY(miaoshu.frame)+width*0.02-width*0.001, width*0.13, width*0.13)];
            imageView.image = [UIImage imageNamed:@"价格设置(1)"];
//            imageView.backgroundColor = [UIColor brownColor];
            
            _textField4 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)-5, CGRectGetMaxY(miaoshu.frame)+width*0.02+width*0.001, width*0.25, width*0.13-width*0.005)];
            _textField4.backgroundColor = [UIColor whiteColor];
            //            textField.textColor = [UIColor redColor];
            _textField4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _textField4.keyboardType = UIKeyboardTypeNumberPad;
            _textField4.textColor = Color(255, 97, 57);
            _textField4.borderStyle = UITextBorderStyleRoundedRect;
            _textField4.layer.borderWidth = 1.1;
            UIColor *col = Color(217, 217, 217);
            _textField4.layer.borderColor = [col CGColor];
            _textField4.layer.cornerRadius = 3.0;
            _textField4.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
//            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage444"];
            
//            if ([str isEqualToString:@""]||[str isEqualToString:@"null"]) {
//                
////                _textField4.text = @"";
//            }
//            else{
//                
//                _textField4.text = [NSString stringWithFormat:@"%@",str];
//            }
            
            [cell addSubview:_textField4];
            
            [cell addSubview:imageView];
            
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame)+width*0.05, CGRectGetMaxY(_textField4.frame)+width*0.03, width*0.9, width*0.6)];
            view.backgroundColor = [UIColor whiteColor];
            
            NSArray *array = [NSArray array];
            array = @[@"费用为长包每月的车辆使用费用",@"含车辆用油、驾驶服务、车辆使用",@"不含路桥费、停车费等其他费用",@"超出5小时50公里按照超出标准计费",@"超出限制里程按超出标准计费",@"超出工作时间按超出标准计费"];
            
            for (int i = 0; i < 6; i++) {
                
                _label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05,width*0.04+ i*width*0.08, view.frame.size.width, width*0.06)];
                _label.text = array[i];
                
                _label.textColor = Color(143, 143, 143);
                //            label.adjustsFontSizeToFitWidth = YES;
                _label.font = [UIFont systemFontOfSize:15];
                _label.lineBreakMode = NSLineBreakByCharWrapping;
                _label.textAlignment = NSTextAlignmentLeft;
                [view addSubview:_label];
                
            }
            
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view.frame)-width*0.28, CGRectGetMaxY(view.frame)-width*0.48, width*0.15, width*0.15)];
            imageView1.image = [UIImage imageNamed:@"logo浅"];
//            imageView1.backgroundColor = [UIColor brownColor];
            [view addSubview:imageView1];
            
            [cell addSubview:view];
            
            UIButton *quxiao1 = [UIButton buttonWithType:UIButtonTypeCustom];
            quxiao1.frame = CGRectMake(width/2-width*0.2, CGRectGetMaxY(view.frame)+width*0.04, width*0.4, width*0.1);
            quxiao1.backgroundColor = Color(0, 215, 200);
            [quxiao1 setTitle:@"取消设置" forState:UIControlStateNormal];
            [quxiao1 addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:quxiao1];
        }
    }
    cell.backgroundColor = Color(240, 240, 240);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)quxiao{
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"如果取消设置，您的车辆将不会显示在相应的车辆出租模式中" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertView show];
    
    [self AlertView];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        return;
    }
    if (buttonIndex == 1) {
        
        NSString *url = @"http://wx.leisurecarlease.com/api.php?op=api_qxyt";
        
        typpe = 4;
        
        AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        
        NSDictionary *dicc = @{@"carid":self.carid,@"type":[NSString stringWithFormat:@"%d",typpe]};
        
        [manager POST:url parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"success-----%d",typpe);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}
#pragma mark - alertView
- (void)AlertView{
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    //    bigView.alpha = 0.5;
    //    bigView.backgroundColor = [UIColor blackColor];
    [self.view.window addSubview:bigView];
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenWidth*0.4, ScreenWidth*0.7, ScreenWidth*0.36)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    [bigView addSubview:_alertView];
    
    UIImageView *image11 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame), CGRectGetHeight(_alertView.frame))];
    image11.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image11];
    
    image11.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.04, ScreenWidth*0.7, ScreenWidth*0.07)];
    label.text = @"取消设置，您的车辆将不会";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image11 addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.11, width*0.7, width*0.07)];
    label2.textColor = Color(107, 107, 107);
    label2.text = @"显示在相应的出租模式中";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image11 addSubview:label2];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.24, width*0.6, 0.5)];
    line.backgroundColor = Color(217, 217, 217);
    [image11 addSubview:line];
    
    quxiao = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiao.frame = CGRectMake(0, ScreenWidth*0.26, ScreenWidth*0.35, ScreenWidth*0.08);
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *gray111 = Color(177, 177, 177);
    UIColor *color = Color(7, 187, 177);
    quxiao.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [quxiao setTitleColor:color forState:UIControlStateNormal];
    [image11 addSubview:quxiao];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(image11.frame)/2, width*0.26+2, 0.5, width*0.1-width*0.02)];
    line2.backgroundColor = Color(217, 217, 217);
    [image11 addSubview:line2];
    
    queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(ScreenWidth*0.35, ScreenWidth*0.25, ScreenWidth*0.35, ScreenWidth*0.1);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [queding setTitleColor:gray111 forState:UIControlStateNormal];
    [image11 addSubview:queding];
}
- (void)moveAll{
    
    [bigView removeFromSuperview];
    [bigView1 removeFromSuperview];
}
- (void)queding{
    
    NSString *url = @"http://wx.leisurecarlease.com/api.php?op=api_qxyt";
    
    typpe = 4;
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    NSDictionary *dicc = @{@"carid":self.carid,@"type":[NSString stringWithFormat:@"%d",typpe]};
    
    [manager POST:url parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)alertView{
    
    bigView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view.window addSubview:bigView1];
    
    _alertView1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenWidth*0.4, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView1.backgroundColor = [UIColor whiteColor];
    _alertView1.alpha = 1.0;
    
    [bigView1 addSubview:_alertView1];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView1.frame), CGRectGetHeight(_alertView1.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    [_alertView1 addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"请设置合理的价格";
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



@end
