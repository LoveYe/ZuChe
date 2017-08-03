//
//  SetPriceViewController.m
//  ZuChe
//
//  Created by apple  on 16/10/18.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "SetPriceViewController.h"
#import "UseWayViewController.h"
#import "Header.h"
#import "AFHTTPRequestOperationManager.h"
#import "ZuChe/ZCUserData.h"

//#import "UseWayViewController.h"

@interface SetPriceViewController()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
    CGFloat width;
    UITableView *_tableView;
    UILabel *_label;
    
    NSString *_jiage1;
    NSString *_jiage2;
    NSString *_jiage3;
    
    UITextField *_textfield1;
    UITextField *_textfield2;
    UITextField *_textfield3;
    
    NSString *_type;
    int typpe;
    
    UIView *_alertView;
    UIView *bigView;
    UIButton *queding;
    UIButton *quxiao;
    
    UIView *_alertView1;
    UIView *bigView1;
    UIButton *queding1;
}

@end

@implementation SetPriceViewController


- (void)viewWillAppear:(BOOL)animated{
    
    if (self.tag == 1111) {
        
        _type = @"1";
        typpe = 1;
    }else if (self.tag == 2001){
        
        _type = @"2";
        typpe = 2;
    }else if (self.tag == 2002){
        
        _type = @"3";
        typpe = 3;
    }else if (self.tag == 2004){
        
        _type = @"5";
        typpe = 5;
    }else if (self.tag == 3333){
        
        _type = @"6";
        typpe = 6;
    }
    
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
    UIColor *col = Color(100, 100, 100);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:col,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    [self createTableView];
    
    width = self.view.frame.size.width;
    
    UIButton *letf = [UIButton buttonWithType:UIButtonTypeCustom];
    letf.frame = CGRectMake(0, 0, 25, 25);
    [letf setImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [letf addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:letf];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarbutton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(TiJiao:)];
    rightBarbutton.tintColor = Color(0, 215, 200);
    self.navigationItem.rightBarButtonItem = rightBarbutton;
    
    // 去本地找到以前存储的
//    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage3"];
//    if ([str isEqualToString:@""]||[str isEqualToString:@"null"]) {
//        
//        _textfield3.placeholder = str;
//    }
}

- (void)TiJiao:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendMessage:sendNUm:)]) {
        
        if (_textfield1.text.length == 0 || [_textfield1.text isEqualToString:@""] || _textfield1.text == nil ||
            _textfield2.text.length == 0 || [_textfield2.text isEqualToString:@""] || _textfield2.text == nil ||
            _textfield3.text.length == 0 || [_textfield3.text isEqualToString:@""] || _textfield3.text == nil) {
            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请设置合理的价格" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alertView show];
            [self alertView];
        }else{
            
            NSString *url = @"http://wx.leisurecarlease.com/api.php?op=api_bcjiage";
            
            AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            NSDictionary *dicc = @{@"jiage1":_textfield1.text,@"jiage2":_textfield2.text,@"jiage3":_textfield3.text,@"carid":self.carid,@"type":_type};
            
            [manager POST:url parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                UITextField *textFiled = (UITextField *)[self.view viewWithTag:111];
                [_delegate sendMessage:textFiled.text sendNUm:self.number];
                [self.navigationController popViewControllerAnimated:YES];
                NSLog(@"success-----%@",_type);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
    }
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
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
            
//            UILabel *miaoshu = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.3, width*0.02, width*0.6, width*0.08)];
            
            UILabel *miaoshu = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.3, width*0.02, width*0.6, width*0.08)];
//            miaoshu.text = @"超出每小时";
            miaoshu.font = [UIFont fontWithName:@"ArialMT" size:15];
            miaoshu.textAlignment = NSTextAlignmentCenter;
            miaoshu.textColor = Color(90, 90, 90);
            [cell addSubview:miaoshu];
            if (self.tag == 1111) {
                
                miaoshu.text = @"此价格为5小时50公里的价格";
            }if (self.tag == 2001) {
                
                miaoshu.text = @"此价格为1小时10公里的价格";
            }if (self.tag == 2002) {
                
                miaoshu.text = @"此价格为拍摄一天的价格";
            }if (self.tag == 2004) {
                
                miaoshu.text = @"此价格为长租每月的价格";
            }
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.2, CGRectGetMaxY(miaoshu.frame)+width*0.02-width*0.001, width*0.13, width*0.13)];
            imageView.image = [UIImage imageNamed:@"价格设置(1)"];
//            imageView.backgroundColor = [UIColor brownColor];
            
            _textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)-5, CGRectGetMaxY(miaoshu.frame)+width*0.02+width*0.001, width*0.25, width*0.13-width*0.005)];
            _textfield1.backgroundColor = [UIColor whiteColor];
            _textfield1.textColor = Color(255, 97, 57);
            _textfield1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _textfield1.keyboardType = UIKeyboardTypeNumberPad;
            _textfield1.borderStyle = UITextBorderStyleRoundedRect;
            _textfield1.tag = 111;
            _textfield1.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
            _textfield1.layer.borderWidth = 1.1;
            UIColor *col = Color(217, 217, 217);
            _textfield1.layer.borderColor = [col CGColor];
            _textfield1.layer.cornerRadius = 3.0;
            if (self.tag == 1111) {
                
                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage11"];
                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
                    
                }else{
                    
                    _textfield1.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage11"];
                }
            }
            if (self.tag == 2001) {
                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage21"];
                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
                    
                }else{
                    _textfield1.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage21"];
                }
            }
            if (self.tag == 2002) {
                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage31"];
                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
                    
                }else{
                    _textfield1.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage31"];
                }
            }
            if (self.tag == 2004) {
                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage41"];
                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
                    
                }else{
                    _textfield1.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage41"];
                }
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:_jiage1 forKey:@"jiage1"];
            
            [cell addSubview:_textfield1];
            
            [cell addSubview:imageView];
        }
        if (indexPath.row == 1) {
            UILabel *miaoshu = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.15, width*0.02, width*0.3, width*0.08)];
            miaoshu.text = @"超出每小时";
            if (self.tag == 2004) {
                
                miaoshu.text = @"限制里程(每月)";
            }
            miaoshu.font = [UIFont fontWithName:@"ArialMT" size:15];
            miaoshu.textAlignment = NSTextAlignmentCenter;
            miaoshu.textColor = Color(90, 90, 90);
            [cell addSubview:miaoshu];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.2, CGRectGetMaxY(miaoshu.frame)+width*0.02-width*0.001, width*0.13, width*0.13)];
            imageView.image = [UIImage imageNamed:@"价格设置(1)"];
            if (self.tag == 2004) {
                imageView.image = [UIImage imageNamed:@"价格设置(2)"];
            }
//            imageView.backgroundColor = [UIColor brownColor];
            
            _textfield2 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)-5, CGRectGetMaxY(miaoshu.frame)+width*0.02+width*0.001, width*0.25, width*0.13-width*0.005)];
            _textfield2.backgroundColor = [UIColor whiteColor];
            _textfield2.textColor = Color(255, 97, 57);
            _textfield2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _textfield2.keyboardType = UIKeyboardTypeNumberPad;
            _textfield2.borderStyle = UITextBorderStyleRoundedRect;
            _textfield2.tag = 222;
            _textfield2.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
            _textfield2.layer.borderWidth = 1.1;
            UIColor *col = Color(217, 217, 217);
            _textfield2.layer.borderColor = [col CGColor];
            _textfield2.layer.cornerRadius = 3.0;
            [cell addSubview:_textfield2];
            
            [cell addSubview:imageView];
            
            if (self.tag == 1111) {
                
//                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage12"];
//                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
//                    
//                }else{
//                    
//                    _textfield2.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage12"];
//                }
            }
            if (self.tag == 2001) {
//                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage22"];
//                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
//                    
//                }else{
//                    
//                    _textfield2.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage22"];
//                }
            }
            if (self.tag == 2002) {
//                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage32"];
//                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
//                    
//                }else{
//                    _textfield2.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage32"];
//                }
            }
            if (self.tag == 2004) {
//                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage42"];
//                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
//                    
//                }else{
//                    _textfield2.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage42"];
//                }
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:_jiage2 forKey:@"jiage2"];
        }
        if (indexPath.row == 2) {
            UILabel *miaoshu = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - width*0.15, width*0.02, width*0.3, width*0.08)];
            miaoshu.text = @"超出每公里";
            miaoshu.font = [UIFont fontWithName:@"ArialMT" size:15];
            miaoshu.textAlignment = NSTextAlignmentCenter;
            miaoshu.textColor = Color(90, 90, 90);
            [cell addSubview:miaoshu];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.2, CGRectGetMaxY(miaoshu.frame)+width*0.02-width*0.001, width*0.13, width*0.13)];
            imageView.image = [UIImage imageNamed:@"价格设置(1)"];
//            imageView.backgroundColor = [UIColor brownColor];
            
            _textfield3 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)-5, CGRectGetMaxY(miaoshu.frame)+width*0.02+width*0.001, width*0.25, width*0.13-width*0.005)];
            _textfield3.backgroundColor = [UIColor whiteColor];
            //            _textfield3.layer.borderWidth = 1.0;
            //            CGColorRef *color = Color(201, 210, 210);
            
            // 先进行 存储和判断
            if (self.tag == 1111) {
                
//                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage13"];
//                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
//                    
//                }else{
//                    _textfield3.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage13"];
//                }
            }
            if (self.tag == 2001) {
//                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage23"];
//                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
//                    
//                }else{
//                    _textfield3.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage23"];
//                }
            }
            if (self.tag == 2002) {
//                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage33"];
//                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
//                    
//                }else{
//                    _textfield3.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage33"];
//                }
            }
            if (self.tag == 2004) {
//                NSString *stan = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage43"];
//                if ([stan isEqualToString:@""]||[stan isEqualToString:@"null"]){
//                    
//                }else{
//                    _textfield3.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jiage43"];
//                }
            }
            
            _textfield3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _textfield3.keyboardType = UIKeyboardTypeNumberPad;
            _textfield3.textColor = Color(255, 97, 57);
            _textfield3.borderStyle = UITextBorderStyleRoundedRect;
            _textfield3.tag = 333;
            _textfield3.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
            _textfield3.layer.borderWidth = 1.1;
            UIColor *col = Color(217, 217, 217);
            _textfield3.layer.borderColor = [col CGColor];
            _textfield3.layer.cornerRadius = 3.0;
            
            [cell addSubview:_textfield3];
            
            [cell addSubview:imageView];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame)+width*0.05, CGRectGetMaxY(_textfield3.frame)+width*0.05, width*0.9, width*0.6)];
            view.backgroundColor = [UIColor whiteColor];
            
            
            NSArray *arr = @[@"费用为5小时，50公里的车辆使用费用",@"含车辆用油、驾驶服务、车辆使用",@"不含路桥费、停车费等其他费用",@"超出5小时50公里按照超出标准计费",@"婚车送半小时扎花时间"];
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:arr];
            
            for (int i = 0; i < 4; i++) {
                
                if (self.tag == 2001) {
                    
                    [array replaceObjectAtIndex:0 withObject:@"费用为1小时，10公里的车辆使用费用"];
                    [array replaceObjectAtIndex:3 withObject:@"超出1小时10公里按超出标准计费"];
                }if (self.tag == 2002) {
                    
                    [array replaceObjectAtIndex:0 withObject:@"费用为拍摄一天的车辆使用费用"];
                    [array replaceObjectAtIndex:1 withObject:@"含10公里车辆使用、车辆用油"];
                    [array replaceObjectAtIndex:3 withObject:@"超出1小时10公里按超出标准计费"];
                }if (self.tag == 2004) {
                    
                    [array replaceObjectAtIndex:0 withObject:@"费用为长租每月的车辆使用费用"];
                    [array replaceObjectAtIndex:1 withObject:@"含车辆保养、车辆保险、正常损耗"];
                    [array replaceObjectAtIndex:2 withObject:@"不含车辆用油、驾驶员等其他费用"];
                    [array replaceObjectAtIndex:3 withObject:@"超出限制里程按照超出标准计费"];
                }
                _label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05,width*0.04+ i*width*0.1, view.frame.size.width, width*0.08)];
                _label.text = array[i];
                
                _label.textColor = Color(143, 143, 143);
                _label.font = [UIFont systemFontOfSize:15];
                _label.lineBreakMode = NSLineBreakByCharWrapping;
                _label.textAlignment = NSTextAlignmentLeft;
                [view addSubview:_label];
                if (i == 4) {
                    
                    _label.textColor = [UIColor redColor];
                }
            }
            if (_tag == 1111) {
                
                NSString *text = @"婚车送半小时扎花时间";
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
                UIColor *colore = Color(255, 97, 57);
                [attr setAttributes:@{NSForegroundColorAttributeName : colore,   NSFontAttributeName : [UIFont systemFontOfSize:15]} range:NSMakeRange(3, 7)];
                
                UIColor *colll = Color(143, 143, 143);
                [attr setAttributes:@{NSForegroundColorAttributeName : colll,   NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, 3)];
                
                UILabel *lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.45, view.frame.size.width, width*0.1)];
                lastLabel.attributedText = attr;
                lastLabel.font = [UIFont systemFontOfSize:15];
                lastLabel.lineBreakMode = NSLineBreakByCharWrapping;
                lastLabel.textAlignment = NSTextAlignmentLeft;
                [view addSubview:lastLabel];
            }
            
            
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view.frame)-width*0.28, CGRectGetMaxY(view.frame)-width*0.48, width*0.15, width*0.15)];
            imageView1.image = [UIImage imageNamed:@"logo浅"];
//            imageView1.backgroundColor = Color(240, 240, 240);
            [view addSubview:imageView1];
            
            UIButton *quxiao1 = [UIButton buttonWithType:UIButtonTypeCustom];
            quxiao1.frame = CGRectMake(width/2-width*0.2, CGRectGetMaxY(view.frame)+width*0.04, width*0.4, width*0.1);
            quxiao1.backgroundColor = Color(0, 215, 200);
            [quxiao1 setTitle:@"取消设置" forState:UIControlStateNormal];
            [quxiao1 addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:quxiao1];
            
            [cell addSubview:view];
        }
    }
    cell.backgroundColor = Color(240, 240, 240);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)quxiao{
    
    [self AlertView];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"如果取消设置，您的车辆将不会显示在相应的车辆出租模式中" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        return;
    }
    if (buttonIndex == 1) {
        
        NSString *url = @"http://wx.leisurecarlease.com/api.php?op=api_qxyt";
        
        
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
    
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    NSDictionary *dicc = @{@"carid":self.carid,@"type":[NSString stringWithFormat:@"%d",typpe]};
    
    [manager POST:url parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"success-----%d",typpe);
        
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
    //    image.backgroundColor = [UIColor redColor];
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
