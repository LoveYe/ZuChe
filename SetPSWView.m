//
//  SetPSWView.m
//  ZuChe
//
//  Created by apple  on 2017/3/20.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "SetPSWView.h"
#import "Header.h"
#import "AFHTTPRequestOperationManager.h"
#import "ZCUserData.h"
#import "LoginView.h"
#import "ParentsViewController.h"
#import "MBProgressHUD.h"
#import "RootViewcontroller.h"
#import "HttpManager.h"

@interface SetPSWView (){
    
    CGFloat width;
    CGFloat height;
    AFHTTPRequestOperationManager *manager;
    
    UITextField *phoneNUM;
    UITextField *passWordText;
    UIButton *duihao;
    UIButton *dui;
    UIButton *end;
}
@property (nonatomic,retain)RCDraggableButton *avatar1;

@end

@implementation SetPSWView
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
    login.text = @"创建密码";
    login.textColor = [UIColor whiteColor];
    login.textAlignment = NSTextAlignmentLeft;
    login.font = [UIFont fontWithName:@"ArialMT" size:30];
    [self.view addSubview:login];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(login.frame)+width*0.15, width*0.5, width*0.06)];
    num.text = @"请输入密码";
    num.textColor = [UIColor whiteColor];
    num.textAlignment = NSTextAlignmentLeft;
    num.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:num];
    
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    
    phoneNUM = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(num.frame)+width*0.03, width*0.8, width*0.08)];
    phoneNUM.backgroundColor = Color(7, 187, 177);
    phoneNUM.tag = 10003;
    phoneNUM.font = [UIFont fontWithName:@"Arial-BoldMT" size:27];
    phoneNUM.textColor = [UIColor whiteColor];
    phoneNUM.tintColor = [UIColor whiteColor];
    phoneNUM.autocapitalizationType = UITextAutocorrectionTypeNo;
    phoneNUM.autocorrectionType = UITextAutocorrectionTypeNo;
    phoneNUM.keyboardType = UIKeyboardTypeDefault;
    phoneNUM.textAlignment = NSTextAlignmentLeft;
    phoneNUM.inputAccessoryView = bar;
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
    passWordText.tag = 10004;
    passWordText.tintColor = [UIColor whiteColor];
    passWordText.font = [UIFont fontWithName:@"Arial-BoldMT" size:27];
    passWordText.textColor = [UIColor whiteColor];
    passWordText.secureTextEntry = YES;
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
    end.frame = CGRectMake(width*0.825, CGRectGetMaxY(xian2.frame)+width*0.1, width*0.1, width*0.1);
    [end setBackgroundImage:[UIImage imageNamed:@"右1.png"] forState:UIControlStateNormal];
    [end addTarget:self action:@selector(wancheng) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:end];
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
- (void)fanhuiClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)wancheng{
    
    UITextField *password =(UITextField *)[self.view viewWithTag:10003];
    UITextField *password2 =(UITextField *)[self.view viewWithTag:10004];
    UITextField *yaoqingma =(UITextField *)[self.view viewWithTag:10005];
    
    if ([password.text  isEqualToString: password2.text] && password.text.length >= 6){
        
        NSDictionary *parameters=[NSDictionary dictionary];
        NSString * string;
        string= [NSString stringWithFormat:@"%@/api.php?op=register",NowUrl];
        
        if ([yaoqingma.text isEqualToString:@""]||[yaoqingma isKindOfClass:[NSNull class]]||yaoqingma==nil) {
            
            yaoqingma.text = self.nickname;
        }
        parameters=@{@"username":self.phoneNumber,@"password":password.text,@"nickname":self.nickname,@"yzm":self.yanzhengma};
        
        
        manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        
        [manager POST:string parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@",responseObject);
            
            if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] isEqualToString:@"恭喜您注册成功"]) {
                
                NSDictionary *parameters =[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"userid"]],@"userid", nil];
                [manager POST:[NSString stringWithFormat:@"%@api.php?op=memberinfo",NowUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSDictionary *_dic  =responseObject;
                    
                    [[ZCUserData share]saveUserInfoWithUserId:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"userid"]] username:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"username"]] descriptions:[_dic objectForKey:@"description"] mobile:[_dic objectForKey:@"mobile"] fuwu:[_dic objectForKey:@"fuwu"] jiedan:[_dic objectForKey:@"jiedan"] lianxi:[_dic objectForKey:@"lianxi"] yinxiang:[_dic objectForKey:@"yinxiang"] nickname:[_dic objectForKey:@"nickname"] thumb:[_dic objectForKey:@"thumb"] tiqian:[_dic objectForKey: @"tiqian"] xing:[_dic objectForKey:@"xing"] xingqu:[_dic objectForKey:@"xingqu"] xueli:[_dic objectForKey:@"xueli"] zhiye:[_dic objectForKey:@"zhiye"] IsLogin:YES];
                    
                    if (self.navigationController.tabBarController.selectedIndex==3) {
                        
                        RootViewcontroller *view = [[RootViewcontroller alloc] init];
                        UIWindow *window = [UIApplication sharedApplication].keyWindow;
                        window.rootViewController = view;
                    }else{
                        
                        [self.avatar1 removeFromSuperview];
                        RootViewcontroller *view = [[RootViewcontroller alloc] init];
                        UIWindow *window = [UIApplication sharedApplication].keyWindow;
                        window.rootViewController = view;
                    }
                    
                    [self ShowMBHubWithTitleOnlyWithTitle:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] withTime:1.0f];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    NSLog(@"Error%@",error);
                    
                }];
            }
            else if([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] isEqualToString:@"该手机已被注册"]){
                
                [self createPNMERROR:@"该手机已被注册"];
            }else{
                
                [self createPNMERROR:@"验证码错误"];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
        }];
    }else{
        
        [self alertView];
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
- (void)alertView{
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 10001;
    [self.view addSubview:bigView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenWidth*0.4, ScreenWidth*0.7, ScreenWidth*0.3)];
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"两次密码不一致";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
- (void)moveAll{
    
    UIView *view = [self.view viewWithTag:10001];
    [view removeFromSuperview];
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
