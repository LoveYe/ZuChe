//
//  EnergencyView.m
//  ZuChe
//
//  Created by apple  on 2017/3/27.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "EnergencyView.h"
#import "Header.h"
#import <SMS_SDK/SMSSDK.h>
#import "MBProgressHUD.h"

@interface EnergencyView (){
    
    CGFloat width;
    CGFloat height;
    
    UIButton *button;
    UITextField *phoneNUM;
    UITextField *passWordText;
    UIButton *duihao;
    UIButton *dui;
    UIButton *registor;
    UIButton *huoqu;
    
    UITextField *yanzheng;
}

@end

@implementation EnergencyView

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [self registerForKeyBoard];
    [phoneNUM becomeFirstResponder];
    //    [IQKeyboardManager sharedManager].shouldPlayInputClicks = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardFrameBeginUserInfoKey object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    self.view.backgroundColor = Color(7, 187, 177);
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(width*0.03, width*0.11, width*0.1, width*0.1);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回白1.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhuiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    
    UIButton *forget = [UIButton buttonWithType:UIButtonTypeCustom];
    forget.frame = CGRectMake(width*0.77, width*0.13, width*0.2, width*0.05);
    [forget setTitle:@"保存" forState:UIControlStateNormal];
    [forget setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forget addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
    forget.titleLabel.font = [UIFont systemFontOfSize:17];;
    forget.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:forget];
    
    UILabel *login = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3, width*0.11, width*0.6, width*0.1)];
    login.text = @"紧急联系方式";
    login.textColor = [UIColor whiteColor];
    login.textAlignment = NSTextAlignmentCenter;
    login.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    [self.view addSubview:login];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(login.frame)+width*0.12, width*0.6, width*0.06)];
    num.text = @"紧急联系人姓名";
    num.textColor = [UIColor whiteColor];
    num.textAlignment = NSTextAlignmentLeft;
    num.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:num];
    
    phoneNUM = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(num.frame)+width*0.025, width*0.8, width*0.08)];
    phoneNUM.backgroundColor = Color(7, 187, 177);
    phoneNUM.textColor = [UIColor whiteColor];
    phoneNUM.tag = 30001;
    phoneNUM.tintColor = [UIColor whiteColor];
    [phoneNUM becomeFirstResponder];
//    phoneNUM.keyboardType = UIKeyboardTypeNumberPad;
    phoneNUM.textAlignment = NSTextAlignmentLeft;
    phoneNUM.font = [UIFont fontWithName:@"Arial-BoldMT" size:27];
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    phoneNUM.inputAccessoryView = bar;
    [self.view addSubview:phoneNUM];
    
    duihao = [UIButton buttonWithType:UIButtonTypeCustom];
    duihao.frame = CGRectMake(CGRectGetMaxX(phoneNUM.frame)+width*0.03, CGRectGetMaxY(num.frame)+width*0.025, width*0.06, width*0.06);
    [self.view addSubview:duihao];
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(phoneNUM.frame)+width*0.035, width*0.9, 1)];
    xian1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xian1];
    
    UILabel *password = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xian1.frame)+width*0.04, width*0.6, width*0.06)];
    password.text = @"电话号码";
    password.textColor = [UIColor whiteColor];
    password.textAlignment = NSTextAlignmentLeft;
    password.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:password];
    
    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(width*0.05, CGRectGetMaxY(password.frame)+width*0.03, width*0.12, width*0.07);
    UIColor *color11 = Color(7, 187, 177);
    [button setTitle:@"+86" forState:UIControlStateNormal];
    [button setTitleColor:color11 forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    button.layer.cornerRadius = 4.0;
    [self.view addSubview:button];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+width*0.05, CGRectGetMaxY(password.frame)+width*0.03, width*0.6, width*0.08)];
    passWordText.backgroundColor = Color(7, 187, 177);
    passWordText.textColor = [UIColor whiteColor];
//    passWordText.secureTextEntry = YES;
    passWordText.tag = 30002;
    passWordText.tintColor = [UIColor whiteColor];
    passWordText.font = [UIFont fontWithName:@"Arial-BoldMT" size:27];
    passWordText.inputAccessoryView = bar;
    passWordText.keyboardType = UIKeyboardTypeNumberPad;
    passWordText.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passWordText];;
    
    dui = [UIButton buttonWithType:UIButtonTypeCustom];
    dui.frame = CGRectMake(CGRectGetMaxX(passWordText.frame)+width*0.05, CGRectGetMaxY(password.frame)+width*0.03, width*0.06, width*0.06);
    //    [dui setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
    [self.view addSubview:dui];
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(passWordText.frame)+width*0.02, width*0.9, 1)];
    xian2.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:xian2];
    
    UILabel *yanzhengma = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xian2.frame)+width*0.04, width*0.6, width*0.06)];
    yanzhengma.text = @"输入验证码";
    yanzhengma.textAlignment = NSTextAlignmentLeft;
    yanzhengma.textColor = [UIColor whiteColor];
    yanzhengma.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:yanzhengma];
    
    yanzheng = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(yanzhengma.frame)+width*0.03, width*0.6, width*0.08)];
    yanzheng.textAlignment = NSTextAlignmentLeft;
    yanzheng.textColor = [UIColor whiteColor];
    yanzheng.font = [UIFont fontWithName:@"Arial-BoldMT" size:27];
    yanzheng.tintColor = [UIColor whiteColor];
    yanzheng.inputAccessoryView = bar;
    yanzheng.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:yanzheng];
    
    huoqu = [UIButton buttonWithType:UIButtonTypeCustom];
    huoqu.frame = CGRectMake(width*0.68, CGRectGetMaxY(yanzhengma.frame)+width*0.03, width*0.27, width*0.08);
    [huoqu setTitle:@"获取验证码" forState:UIControlStateNormal];
    [huoqu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [huoqu addTarget:self action:@selector(huoquNum) forControlEvents:UIControlEventTouchUpInside];
    [huoqu setBackgroundColor:color11];
    huoqu.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:huoqu];
    
    UILabel *xian3 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(yanzheng.frame)+width*0.02, width*0.9, 1)];
    xian3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xian3];
}
- (void)fanhuiClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)baocun{
    
    if (phoneNUM.text.length == 0) {
        
        [self ShowMBHubWithTitleOnlyWithTitle:@"您的紧急联系人手机号未填写" withTime:1.0f];
    }else{
        
        if (passWordText.text.length == 0) {
            
            [self ShowMBHubWithTitleOnlyWithTitle:@"您的手机号输入有误" withTime:1.0f];
        }else{
            
            [SMSSDK commitVerificationCode:yanzheng.text phoneNumber:passWordText.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
                
                if (!error) {
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(sender:)]) {
                        
                        [_delegate sender:passWordText.text];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    
                }else{
                    
                    if (yanzheng.text.length == 0) {
                        
                        [self ShowMBHubWithTitleOnlyWithTitle:@"请填写验证码!" withTime:2.0f];
                    }else{
                        
                        [self ShowMBHubWithTitleOnlyWithTitle:@"验证码不正确!" withTime:2.0f];
                    }
                }
            }];
        }
    }
}
- (void)huoquNum{
    
    if (passWordText.text.length == 0) {
        
        [self ShowMBHubWithTitleOnlyWithTitle:@"您的紧急联系人手机号未填写" withTime:1.0f];
    }else{
        
        [self startTimebtn:huoqu];
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:passWordText.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            
            if (!error) {
                
                [self ShowMBHubWithTitleOnlyWithTitle:@"已发送到您的手机，请验证" withTime:1.0f];
            }else{
                
                [self ShowMBHubWithTitleOnlyWithTitle:@"系统错误，请重新获取" withTime:1.0f];
            }
        }];
    }
}
    

- (void)registerForKeyBoard{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
    
}
- (void)keyBoardShow:(NSNotification *)notic{
    
//    NSDictionary *info = [notic userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyBoardSize = [value CGRectValue].size;
//    CGFloat keyBoardY = keyBoardSize.height;
    
//    loginButton.frame = CGRectMake(width*0.825, height - keyBoardY-width*0.17, width*0.13, width*0.13);
}

- (void)valueChanged:(NSNotification *)notification{
    
    if (passWordText.text.length < 11) {
        
        UIColor *color1 = Color(7, 187, 177);
        phoneNUM.backgroundColor = color1;
        passWordText.backgroundColor = color1;
        registor.backgroundColor = color1;
        self.view.backgroundColor = color1;
        huoqu.backgroundColor = color1;
        [dui setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setTitleColor:color1 forState:UIControlStateNormal];
        
    }
    if (passWordText.text.length > 11){
        
        UIColor *color2 = Color(237, 77, 77);
        //        [duihao setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [dui setBackgroundImage:[UIImage imageNamed:@"错1.png"] forState:UIControlStateNormal];
        self.view.backgroundColor = color2;
        phoneNUM.backgroundColor = color2;
        passWordText.backgroundColor = color2;
        registor.backgroundColor = color2;
        huoqu.backgroundColor = color2;
        [button setTitleColor:color2 forState:UIControlStateNormal];
        //        [phoneNUM addSubview:duihao];
    }
    if (passWordText.text.length == 11) {
        
        UIColor *color1 = Color(7, 187, 177);
        phoneNUM.backgroundColor = color1;
        passWordText.backgroundColor = color1;
        registor.backgroundColor = color1;
        self.view.backgroundColor = color1;
        huoqu.backgroundColor = color1;
        //        [duihao setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [dui setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
        //        [phoneNUM addSubview:duihao];
        [button setTitleColor:color1 forState:UIControlStateNormal];
    }
    
    if (phoneNUM.text.length != 0) {
        
        [duihao setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
    }else {
        
        [duihao setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
}
-(void)startTimebtn:(UIButton *)btn
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:@"重新发送" forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
                btn.backgroundColor =Color(249, 98, 104);
                
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [btn setTitle:[NSString stringWithFormat:@"%@s后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                btn.userInteractionEnabled = NO;
                //                btn.backgroundColor=Color(153, 153, 153);
                [self button:btn  isBold:YES isFont:11.0f];
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
-(void)button :(UIButton *)button  isBold:(BOOL)isBold isFont:(float )fontOrBoldFont;
{
    if (isBold ==YES)
    {
        button.titleLabel.font =[UIFont fontWithName:@"Helvetica" size:fontOrBoldFont/320*ScreenWidth];
    }else
    {
        button.titleLabel.font =[UIFont fontWithName:@"STHeitiSC-Light" size:fontOrBoldFont/320*ScreenWidth];
    }
}
#pragma mark - tishi
-(void)ShowMBHubWithTitleOnlyWithTitle:(NSString *)title withTime:(float)time{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.margin = 14.f;
    hud.color=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:time];
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
