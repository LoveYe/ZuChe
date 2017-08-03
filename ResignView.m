//
//  ResignView.m
//  ZuChe
//
//  Created by apple  on 2017/3/20.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ResignView.h"
#import "Header.h"
#import "SetPSWView.h"
#import <SMS_SDK/SMSSDK.h>
#import "MBProgressHUD.h"
#import "HttpManager.h"
@interface ResignView (){
    
    CGFloat width;
    CGFloat height;
    
    UITextField *passWordText;
    UIButton *tijiao;
}

@end

@implementation ResignView
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [self registerForKeyBoard];
    
    [passWordText becomeFirstResponder];
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
- (void)huoquYanZhengMa{
    
    NSDictionary *dic = @{@"tel":self.phoneNumber};
    
    [HttpManager postData:dic andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_yzmdx" success:^(NSDictionary *fanhuicanshu) {
        
        UIButton *button = (UIButton *)[self.view viewWithTag:10001];
        [self startTimebtn:button];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
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
    
    UILabel *login = [[UILabel alloc] initWithFrame:CGRectMake(width*0.06, CGRectGetMaxY(fanhui.frame)+width*0.1, width*0.9, width*0.1)];
    login.text = @"输入4位验证码";
    login.textColor = [UIColor whiteColor];
    login.textAlignment = NSTextAlignmentLeft;
    login.font = [UIFont fontWithName:@"ArialMT" size:30];
    [self.view addSubview:login];
    
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    
    UILabel *password = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(login.frame)+width*0.15, width*0.5, width*0.06)];
    password.text = @"4位验证码";
    password.textColor = [UIColor whiteColor];
    password.textAlignment = NSTextAlignmentLeft;
    password.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:password];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(password.frame)+width*0.03, width*0.71, width*0.08)];
    passWordText.backgroundColor = Color(7, 187, 177);
    passWordText.textColor = [UIColor whiteColor];
    passWordText.secureTextEntry = YES;
    passWordText.tag = 30002;
    passWordText.tintColor = [UIColor whiteColor];
    [passWordText becomeFirstResponder];
    passWordText.keyboardType = UIKeyboardTypeNumberPad;
    passWordText.inputAccessoryView = bar;
    passWordText.font = [UIFont fontWithName:@"Arial-BoldMT" size:27];
    passWordText.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passWordText];;
    
    UIButton *huoqu = [UIButton buttonWithType:UIButtonTypeCustom];
    huoqu.frame = CGRectMake(width*0.65, CGRectGetMaxY(password.frame)+width*0.03, width*0.25, width*0.08);
    [huoqu setTitle:@"获取验证码" forState:UIControlStateNormal];
    [huoqu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    huoqu.tag = 10001;
    [huoqu addTarget:self action:@selector(Huoqu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:huoqu];
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(passWordText.frame)+width*0.02, width*0.9, 1)];
    xian2.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:xian2];
    
    tijiao = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiao.frame = CGRectMake(width*0.825, CGRectGetMaxY(xian2.frame)+width*0.1, width*0.13, width*0.13);
    [tijiao setBackgroundImage:[UIImage imageNamed:@"右1.png"] forState:UIControlStateNormal];
    [tijiao addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tijiao];
    
    [self huoquYanZhengMa];
}
- (void)registerForKeyBoard{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
}
- (void)keyBoardShow:(NSNotification *)notic{
    
    NSDictionary *info = [notic userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyBoardSize = [value CGRectValue].size;
    CGFloat keyBoardY = keyBoardSize.height;
    
    tijiao.frame = CGRectMake(width*0.825, height - keyBoardY-width*0.17, width*0.13, width*0.13);
}

- (void)tijiao{
    
    if (passWordText.text.length==0||[passWordText.text isEqualToString:@""]||passWordText.text==nil)
    {
        [self createPNMERROR:@"请填写验证码"];
        
    }else{
        
        SetPSWView *vc= [[SetPSWView alloc]init];
        vc.phoneNumber = self.phoneNumber;
        vc.nickname = self.nickname;
        vc.yanzhengma = passWordText.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)fanhuiClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ShowMBHubWithTitleOnlyWithTitle:(NSString *)title withTime:(float)time{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.margin = 14.f;
    hud.color=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:time];
}

- (void)valueChanged:(NSNotification *)notification{
    
    if (passWordText.text.length < 4) {
        
        UIColor *color1 = Color(7, 187, 177);
        passWordText.backgroundColor = color1;
        self.view.backgroundColor = color1;
        [tijiao setBackgroundImage:[UIImage imageNamed:@"右1.png"] forState:UIControlStateNormal];
    }
    if (passWordText.text.length > 4){
        
        [tijiao setBackgroundImage:[UIImage imageNamed:@"右1.png"] forState:UIControlStateNormal];
        UIColor *color2 = Color(237, 77, 77);
        self.view.backgroundColor = color2;;
        passWordText.backgroundColor = color2;
    }
    if (passWordText.text.length == 4) {
        
        UIColor *color1 = Color(7, 187, 177);
//        phoneNUM.backgroundColor = color1;
        passWordText.backgroundColor = color1;
//        registor.backgroundColor = color1;
        self.view.backgroundColor = color1;
        [tijiao setBackgroundImage:[UIImage imageNamed:@"右完成.png"] forState:UIControlStateNormal];
    }
}

- (void)Huoqu:(UIButton *)sender{
        
    if (self.phoneNumber.length != 11 || ![[self.phoneNumber substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
        
        [self createPNMERROR:@"您输入的手机号有误，请重新输入"];
    }
    else{
        
        [self huoquYanZhengMa];
    }
}
#pragma mark - 开始计时
-(void)startTimebtn:(UIButton *)btn{
    
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                btn.selected = YES;
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
                btn.selected = NO;
                [btn setTitle:[NSString stringWithFormat:@"%@s后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                btn.userInteractionEnabled = NO;
                btn.backgroundColor=Color(7, 187, 177);
                [self button:btn  isBold:YES isFont:11.0f];
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
-(void)button :(UIButton *)button11  isBold:(BOOL)isBold isFont:(float )fontOrBoldFont;
{
    if (isBold ==YES)
    {
        button11.titleLabel.font =[UIFont fontWithName:@"Helvetica" size:fontOrBoldFont/320*ScreenWidth];
    }else
    {
        button11.titleLabel.font =[UIFont fontWithName:@"STHeitiSC-Light" size:fontOrBoldFont/320*ScreenWidth];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [ resignFirstResponder];
    [passWordText resignFirstResponder];
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
    label.adjustsFontSizeToFitWidth = YES;
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
