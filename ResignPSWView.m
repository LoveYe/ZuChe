//
//  ResignPSWView.m
//  ZuChe
//
//  Created by apple  on 2017/3/17.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ResignPSWView.h"
#import "Header.h"
#import "LoginView.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "HttpManager.h"

@interface ResignPSWView (){
    
    CGFloat width;
    CGFloat height;
    AFHTTPRequestOperationManager *manager;
    
    UIButton *end;
    UIButton *duihao;
    UIButton *dui;
    UITextField *phoneNUM;
    UITextField *passWordText;
}

@end

@implementation ResignPSWView
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
    
    UILabel *login = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(fanhui.frame)+width*0.1, width*0.9, width*0.1)];
    login.text = @"重置密码";
    login.textColor = [UIColor whiteColor];
    login.textAlignment = NSTextAlignmentLeft;
    login.font = [UIFont fontWithName:@"ArialMT" size:30];
    [self.view addSubview:login];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(login.frame)+width*0.15, width*0.5, width*0.06)];
    num.text = @"请输入新密码";
    num.textColor = [UIColor whiteColor];
    num.textAlignment = NSTextAlignmentLeft;
    num.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:num];
    
    
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    
    phoneNUM = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(num.frame)+width*0.03, width*0.8, width*0.08)];
    phoneNUM.backgroundColor = Color(7, 187, 177);
    phoneNUM.textColor = [UIColor whiteColor];
//    phoneNUM.keyboardType = UIKeyboardTypeNumberPad;
    phoneNUM.textAlignment = NSTextAlignmentLeft;
    phoneNUM.inputAccessoryView = bar;
    phoneNUM.tag = 10003;
    phoneNUM.tintColor = [UIColor whiteColor];
    phoneNUM.font = [UIFont fontWithName:@"Arial-BoldMT" size:27];
    phoneNUM.autocapitalizationType = UITextAutocorrectionTypeNo;
    phoneNUM.autocorrectionType = UITextAutocorrectionTypeNo;
    phoneNUM.keyboardType = UIKeyboardTypeASCIICapable;
    phoneNUM.secureTextEntry = YES;
    [self.view addSubview:phoneNUM];
    
    duihao = [UIButton buttonWithType:UIButtonTypeCustom];
    duihao.frame = CGRectMake(CGRectGetMaxX(phoneNUM.frame)+width*0.03, CGRectGetMaxY(num.frame)+width*0.025, width*0.06, width*0.06);
    [self.view addSubview:duihao];
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(phoneNUM.frame)+width*0.02, width*0.9, 1)];
    xian1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xian1];
    
    UILabel *password = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(xian1.frame)+width*0.04, width*0.5, width*0.06)];
    password.text = @"请再输入一次";
    password.textColor = [UIColor whiteColor];
    password.textAlignment = NSTextAlignmentLeft;
    password.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:password];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(password.frame)+width*0.03, width*0.8, width*0.08)];
    passWordText.backgroundColor = Color(7, 187, 177);
    passWordText.textColor = [UIColor whiteColor];
    passWordText.tag = 10004;
    passWordText.tintColor = [UIColor whiteColor];
    passWordText.secureTextEntry = YES;
    passWordText.font = [UIFont fontWithName:@"Arial-BoldMT" size:27];
    passWordText.autocapitalizationType = UITextAutocorrectionTypeNo;
    passWordText.autocorrectionType = UITextAutocorrectionTypeNo;
    passWordText.inputAccessoryView = bar;
    passWordText.keyboardType = UIKeyboardTypeASCIICapable;
    passWordText.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passWordText];
    
    dui = [UIButton buttonWithType:UIButtonTypeCustom];
    dui.frame = CGRectMake(CGRectGetMaxX(passWordText.frame)+width*0.03, CGRectGetMaxY(password.frame)+width*0.03, width*0.06, width*0.06);
    //    [dui setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
    [self.view addSubview:dui];
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(passWordText.frame)+width*0.02, width*0.9, 1)];
    xian2.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:xian2];
    
    end = [UIButton buttonWithType:UIButtonTypeCustom];
    [end setBackgroundImage:[UIImage imageNamed:@"右1.png"] forState:UIControlStateNormal];
    [end addTarget:self action:@selector(wancheng) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:end];
}
- (void)fanhuiClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)wancheng{
    
    UITextField *password =(UITextField *)[self.view viewWithTag:10003];
    UITextField *password2 =(UITextField *)[self.view viewWithTag:10004];
    if ([password.text  isEqualToString: password2.text]){
        
        if (password.text.length>5){
            
            NSDictionary *dict = @{@"userid":self.userID,@"password":password.text};
            
            [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_uppassword" success:^(NSDictionary *fanhuicanshu) {
                
                if ([fanhuicanshu[@"msg"] isEqualToString:@"修改成功"]) {
                    
                    NSArray *array = self.navigationController.viewControllers;
                    LoginView *app = (LoginView *)([array objectAtIndex:[array count]-3]);
                    [self.navigationController popToViewController:(UIViewController *)app animated:YES];
                }else if ([fanhuicanshu[@"msg"] isEqualToString:@"用户不存在"]){
                    
                    [self createPNMERROR:@"用户不存在"];
                }
            } Error:^(NSString *cuowuxingxi) {
                
            }];
        }else{
            
            [self createPNMERROR:@"两次密码不一致"];
        }
    }
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


- (void)registerForKeyBoard{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
    
}
- (void)keyBoardShow:(NSNotification *)notic{
    
    NSDictionary *info = [notic userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyBoardSize = [value CGRectValue].size;
    CGFloat keyBoardY = keyBoardSize.height;
    
    end.frame = CGRectMake(width*0.825, height - keyBoardY-width*0.17, width*0.13, width*0.13);
}

- (void)valueChanged:(NSNotification *)notification{
    
    if(phoneNUM.text.length > 5){
        
        [duihao setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
    }else{
        
        [duihao setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    if (passWordText.text.length < phoneNUM.text.length||(passWordText.text.length == phoneNUM.text.length&&[passWordText.text isEqualToString:phoneNUM.text])) {
        
        [dui setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        UIColor *color = Color(7, 187, 177);
        self.view.backgroundColor = color;
        passWordText.backgroundColor = color;
        phoneNUM.backgroundColor = color;
    }
    else if((passWordText.text.length == phoneNUM.text.length&&![passWordText.text isEqualToString:phoneNUM.text]) || passWordText.text.length > phoneNUM.text.length){
        
        UIColor *color = Color(237, 77, 77);
        self.view.backgroundColor = color;
        passWordText.backgroundColor = color;
        phoneNUM.backgroundColor = color;
        [dui setBackgroundImage:[UIImage imageNamed:@"错1.png"] forState:UIControlStateNormal];
    }
    
    if ([phoneNUM.text isEqualToString:passWordText.text] && passWordText.text.length > 5) {
        
        [end setBackgroundImage:[UIImage imageNamed:@"右完成.png"] forState:UIControlStateNormal];
        
        [dui setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
        UIColor *color = Color(7, 187, 177);
        self.view.backgroundColor = color;
        passWordText.backgroundColor = color;
        phoneNUM.backgroundColor = color;
    }else{
        
        [end setBackgroundImage:[UIImage imageNamed:@"右1.png"] forState:UIControlStateNormal];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [phoneNUM resignFirstResponder];
    [passWordText resignFirstResponder];
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
