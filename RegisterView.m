//
//  RegisterView.m
//  ZuChe
//
//  Created by apple  on 2017/3/20.
//  Copyright © 2017年 黄森. All rights reserved.
//

#import "RegisterView.h"
#import "Header.h"
#import "ResignView.h"
#import "MBProgressHUD.h"
#import "AllPages.pch"

@interface RegisterView ()<UITextFieldDelegate>{
    
    CGFloat width;
    CGFloat height;
    
    UITextField *phoneNUM;
    UIButton *button;
    UIButton *duihao;
    UITextField *passwordText;
    UIButton *dui;
    UIButton *registor;
    
    UIButton *loginButton;
    int flag;
}

@end

@implementation RegisterView
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [self registerForKeyBoard];
    
    [phoneNUM becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    UIView *view = (UIView *)[self.view viewWithTag:718];
    [view removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardFrameBeginUserInfoKey object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    self.view.backgroundColor = Color(7, 187, 177);
    flag = 0;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(width*0.03, width*0.11, width*0.1, width*0.1);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回白1.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhuiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    
    
    
    UILabel *login = [[UILabel alloc] initWithFrame:CGRectMake(width*0.06, CGRectGetMaxY(fanhui.frame)+width*0.1, width*0.9, width*0.1)];
    login.text = @"您的电话号码?";
    login.textColor = [UIColor whiteColor];
    login.textAlignment = NSTextAlignmentLeft;
    login.font = [UIFont fontWithName:@"ArialMT" size:30];
    [self.view addSubview:login];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(login.frame)+width*0.12, width*0.2, width*0.06)];
    num.text = @"电话号码";
    num.textColor = [UIColor whiteColor];
    num.textAlignment = NSTextAlignmentLeft;
    num.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:num];
    
    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(width*0.05, CGRectGetMaxY(num.frame)+width*0.03, width*0.12, width*0.07);
    UIColor *color11 = Color(7, 187, 177);
    [button setTitle:@"+86" forState:UIControlStateNormal];
    [button setTitleColor:color11 forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    button.layer.cornerRadius = 4.0;
    [self.view addSubview:button];
    
    
    phoneNUM = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+width*0.05, CGRectGetMaxY(num.frame)+width*0.025, width*0.6, width*0.08)];
    phoneNUM.backgroundColor = Color(7, 187, 177);
    phoneNUM.textColor = [UIColor whiteColor];
    phoneNUM.tag = 30001;
    phoneNUM.delegate = self;
    phoneNUM.tintColor = [UIColor whiteColor];
    [phoneNUM becomeFirstResponder];
    phoneNUM.keyboardType = UIKeyboardTypeNumberPad;
    phoneNUM.textAlignment = NSTextAlignmentLeft;
    phoneNUM.font = [UIFont fontWithName:@"Arial-BoldMT" size:27];
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    phoneNUM.inputAccessoryView = bar;
    [self.view addSubview:phoneNUM];
    
    duihao = [UIButton buttonWithType:UIButtonTypeCustom];
    duihao.frame = CGRectMake(CGRectGetMaxX(phoneNUM.frame)+width*0.03, CGRectGetMaxY(num.frame)+width*0.025, width*0.06, width*0.06);
    [self.view addSubview:duihao];
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(button.frame)+width*0.035, width*0.9, 1)];
    xian1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xian1];
    
    UILabel *password = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xian1.frame)+width*0.04, width*0.1, width*0.06)];
    password.text = @"昵称";
    password.textColor = [UIColor whiteColor];
    password.textAlignment = NSTextAlignmentLeft;
    password.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:password];
    
    passwordText = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(password.frame)+width*0.03, width*0.77, width*0.08)];
    passwordText.backgroundColor = Color(7, 187, 177);
    passwordText.textColor = [UIColor whiteColor];
//    passwordText.secureTextEntry = YES;
    passwordText.tag = 30002;
    passwordText.delegate = self;
    passwordText.tintColor = [UIColor whiteColor];
    passwordText.font = [UIFont fontWithName:@"Arial-BoldMT" size:24];
    passwordText.inputAccessoryView = bar;
    passwordText.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passwordText];;
    
//    dui = [UIButton buttonWithType:UIButtonTypeCustom];
//    dui.frame = CGRectMake(CGRectGetMaxX(passwordText.frame)+width*0.03, CGRectGetMaxY(password.frame)+width*0.03, width*0.06, width*0.06);
//    //    [dui setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
//    [self.view addSubview:dui];
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(passwordText.frame)+width*0.02, width*0.9, 1)];
    xian2.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:xian2];
    
    loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"右1.png"] forState:UIControlStateNormal];
    //    loginButton.backgroundColor = [UIColor whiteColor];
    //    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    //    [loginButton setTitleColor:color forState:UIControlStateNormal];
    
    [loginButton addTarget:self action:@selector(yanzheng:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginButton];
    
}
- (void)registerForKeyBoard{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
    
}
- (void)keyBoardShow:(NSNotification *)notic{
    
    NSDictionary *info = [notic userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyBoardSize = [value CGRectValue].size;
    CGFloat keyBoardY = keyBoardSize.height;
    flag = keyBoardY;
    
    loginButton.frame = CGRectMake(width*0.825, height - flag-width*0.17-width*0.22, width*0.13, width*0.13);
}

- (void)yanzheng:(UIButton *)sender{
    
    if (phoneNUM.text.length != 11 || ![[phoneNUM.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
        
//        [self ShowMBHubWithTitleOnlyWithTitle:@"" withTime:1.0f];
        [self createPNMERROR:@"您的手机号输入有误"];
    }else{
        
        if (passwordText.text.length == 0) {
            
            [self createPNMERROR:@"没有输入昵称"];
        }else{
            
            [self testPhoneNUM];
            
            
        }
    }
}
- (void)testPhoneNUM{
    
    NSDictionary *dict = @{@"tel":phoneNUM.text};
    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_yzhuce" success:^(NSDictionary *fanhuicanshu) {
        
        UIButton *button = (UIButton *)[self.view viewWithTag:10001];
        if ([fanhuicanshu[@"msg"] isEqualToString:@"手机号已注册"]) {
            
            
            [self createPNMERROR:@"手机号已注册"];
        }else{
            
            ResignView *view = [[ResignView alloc] init];
            
            view.phoneNumber = phoneNUM.text;
            view.nickname = passwordText.text;
            view.hidesBottomBarWhenPushed = YES;view.hidesBottomBarWhenPushed = YES;
            view.hidesBottomBarWhenPushed = YES;
            CATransition *animation = [CATransition animation];
            animation.duration = 0.3;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.type = @"Fade";
            animation.subtype = kCATransitionFromLeft;
            [self.view.window.layer addAnimation:animation forKey:nil];
            
            [self.navigationController pushViewController:view animated:NO];
        }
    } Error:^(NSString *cuowuxingxi) {
        
        
    }];
}
- (void)fanhuiClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createPNMERROR:(NSString *)str{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.tag = 718;
    view1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view addSubview:view1];
    
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
    [queding addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [view2 addSubview:queding];
}
- (void)removeAll{
    
    UIView *view = [self.view viewWithTag:718];
    [view removeFromSuperview];
}

- (void)valueChanged:(NSNotification *)notification{
    
    if (phoneNUM.text.length < 11) {
        
        UIColor *color1 = Color(7, 187, 177);
        phoneNUM.backgroundColor = color1;
        passwordText.backgroundColor = color1;
        registor.backgroundColor = color1;
        self.view.backgroundColor = color1;
        [duihao setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setTitleColor:color1 forState:UIControlStateNormal];
        
    }
    if (phoneNUM.text.length > 11){
        
        UIColor *color2 = Color(237, 77, 77);
        //        [duihao setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [duihao setBackgroundImage:[UIImage imageNamed:@"错1.png"] forState:UIControlStateNormal];
        self.view.backgroundColor = color2;
        phoneNUM.backgroundColor = color2;
        passwordText.backgroundColor = color2;
        registor.backgroundColor = color2;
        [button setTitleColor:color2 forState:UIControlStateNormal];
        //        [phoneNUM addSubview:duihao];
    }
    if (phoneNUM.text.length == 11) {
        
        UIColor *color1 = Color(7, 187, 177);
        phoneNUM.backgroundColor = color1;
        passwordText.backgroundColor = color1;
        registor.backgroundColor = color1;
        self.view.backgroundColor = color1;
        //        [duihao setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [duihao setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
        //        [phoneNUM addSubview:duihao];
        [button setTitleColor:color1 forState:UIControlStateNormal];
    }
    
    if (phoneNUM.text.length == 11 && passwordText.text.length != 0) {
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"右完成.png"] forState:UIControlStateNormal];
    }else{
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"右1.png"] forState:UIControlStateNormal];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [phoneNUM resignFirstResponder];
    [passwordText resignFirstResponder];
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
