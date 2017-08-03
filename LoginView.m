//
//  LoginView.m
//  ZuChe
//
//  Created by apple  on 2017/3/17.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "LoginView.h"
#import "Header.h"
#import "ForgetPSWView.h"
#import "HttpManager.h"
#import "ZCUserData.h"
#import "MBProgressHUD.h"
#import "RootViewcontroller.h"
#import "RegisterView.h"
#import "AllPages.pch"
#import <CommonCrypto/CommonCrypto.h>

#import "WMConversationViewController.h"
#import "AFNetworking.h"
#import "RCUserInfo+Addition.h"
#import "RCDataManager.h"

#import "JPUSHService.h"

@interface LoginView ()<UITextFieldDelegate,UIAlertViewDelegate,RCIMUserInfoDataSource>{
    
    CGFloat width;
    CGFloat height;
    UIActivityIndicatorView *dong;
    
    UITextField *passWordText;
    UITextField *phoneNUM;
    UIButton *registor;
    UIButton *duihao;
    UIButton *dui;
    UIButton *button;
    UIButton *loginButton;
}

@end

@implementation LoginView

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
    [forget setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forget setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forget addTarget:self action:@selector(forgetPassWord) forControlEvents:UIControlEventTouchUpInside];
    forget.titleLabel.font = [UIFont systemFontOfSize:15];;
    forget.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:forget];
    
    UILabel *login = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(fanhui.frame)+width*0.08, width*0.6, width*0.14)];
    login.text = @"登录";
    login.textColor = [UIColor whiteColor];
    login.textAlignment = NSTextAlignmentLeft;
    login.font = [UIFont fontWithName:@"ArialMT" size:35];
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
    password.text = @"密码";
    password.textColor = [UIColor whiteColor];
    password.textAlignment = NSTextAlignmentLeft;
    password.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.view addSubview:password];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(password.frame)+width*0.03, width*0.77, width*0.08)];
    passWordText.backgroundColor = Color(7, 187, 177);
    passWordText.textColor = [UIColor whiteColor];
    passWordText.secureTextEntry = YES;
    passWordText.tag = 30002;
    passWordText.tintColor = [UIColor whiteColor];
    passWordText.font = [UIFont fontWithName:@"Arial-BoldMT" size:27];
    passWordText.inputAccessoryView = bar;
    passWordText.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passWordText];;
    
    dui = [UIButton buttonWithType:UIButtonTypeCustom];
    dui.frame = CGRectMake(CGRectGetMaxX(passWordText.frame)+width*0.03, CGRectGetMaxY(password.frame)+width*0.03, width*0.06, width*0.06);
//    [dui setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
    [self.view addSubview:dui];
    
    UILabel *xian2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(passWordText.frame)+width*0.02, width*0.9, 1)];
    xian2.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:xian2];
    
    registor = [UIButton buttonWithType:UIButtonTypeCustom];
    registor.frame = CGRectMake(width*0.05, CGRectGetMaxY(xian2.frame)+width*0.07, width*0.3, width*0.08);
    registor.titleLabel.font = [UIFont systemFontOfSize:15];
    registor.backgroundColor = Color(7, 187, 177);
    [registor setTitle:@"马上注册" forState:UIControlStateNormal];
    UIColor *color = [UIColor whiteColor];
    registor.layer.cornerRadius = width*0.04;
    registor.layer.borderWidth = 1.0;
    registor.layer.borderColor = [[UIColor whiteColor] CGColor];
    [registor setTitleColor:color forState:UIControlStateNormal];
    [registor addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registor];
    
    loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(width*0.825, CGRectGetMaxY(xian2.frame)+width*0.07, width*0.13, width*0.13);
    [loginButton setBackgroundImage:[UIImage imageNamed:@"右1.png"] forState:UIControlStateNormal];
//    loginButton.backgroundColor = [UIColor whiteColor];
//    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
//    [loginButton setTitleColor:color forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)fanhuiClick{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)forgetPassWord{
    
    ForgetPSWView *view = [ForgetPSWView new];
    [self.navigationController pushViewController:view animated:YES];
}
- (void)zhuce{
    
    RegisterView *view = [[RegisterView alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}
- (void)denglu{
    
    UITextField *phone = (UITextField *)[self.view viewWithTag:30001];
    UITextField *password = (UITextField *)[self.view viewWithTag:30002];
    
    if (phone.text.length==0||[phone.text isEqualToString:@""]||phone.text==nil||password.text.length==0||[password.text isEqualToString:@""]||password.text==nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入账号或密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else if (phone.text.length != 11){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else{
        
        AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSDictionary *dict = @{@"username":phone.text,@"password":password.text};
        
        
//        [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=login" success:^(NSDictionary *fanhuicanshu) {
//            
//            NSDictionary *userdata = fanhuicanshu;
//            NSString * str=[userdata objectForKey:@"msg"];
//            if ([[userdata objectForKey:@"error"] isEqualToString:@"1"]){
//                
//                UIAlertController *al =[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
//                [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                    
//                    UIColor *color1 = Color(7, 187, 177);
//                    self.view.backgroundColor = color1;
//                    phoneNUM.backgroundColor = color1;
//                    passWordText.backgroundColor = color1;
//                    registor.backgroundColor = color1;
//                    
//                    [button setTitleColor:color1 forState:UIControlStateNormal];
//                }]];
//                
//                
//                [self presentViewController:al animated:YES completion:nil];
//                
//                UIColor *color2 = Color(237, 77, 77);
//                self.view.backgroundColor = color2;
//                phoneNUM.backgroundColor = color2;
//                passWordText.backgroundColor = color2;
//                registor.backgroundColor = color2;
//                [button setTitleColor:color2 forState:UIControlStateNormal];
//            }else{
//                
//                //                [self ShowMBHubWithTitleOnlyWithTitle:@"登陆成功！" withTime:2.0f];
//                NSLog(@"%@",[userdata objectForKey:@"userid"]);
//                NSString * userid  =[userdata objectForKey:@"userid"];
//                
//                [[ZCUserData share]saveUserInfoWithUserId:userid username:[userdata objectForKey:@"username"] descriptions:nil mobile:phone.text fuwu:nil jiedan:nil lianxi:nil yinxiang:nil nickname:nil thumb:nil tiqian:nil xing:nil xingqu:nil xueli:nil zhiye:nil  IsLogin:YES];
//                
//                
//                if ( [phone.text isEqualToString:@"15502196946"]) {
//                    
//                    [self LoginRongCould];
//                    
//                }
//                
//                
//                UIView *view = [GiFHUD new];
//                [GiFHUD setGifWithImageName:@"加载(1).gif"];
//                [GiFHUD show];
//                [self performSelector:@selector(stopit) withObject:view afterDelay:0.5];
//                
//            }
//        } Error:^(NSString *cuowuxingxi) {
//            
//        }];
        
        [manager POST:[NSString stringWithFormat:@"%@api.php?op=login",NowUrl] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@",responseObject);
            NSDictionary *userdata = responseObject;
            NSString * str=[userdata objectForKey:@"msg"];
            if ([[userdata objectForKey:@"error"] isEqualToString:@"1"]){
                
                UIAlertController *al =[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
                [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    UIColor *color1 = Color(7, 187, 177);
                    self.view.backgroundColor = color1;
                    phoneNUM.backgroundColor = color1;
                    passWordText.backgroundColor = color1;
                    registor.backgroundColor = color1;
                    
                    [button setTitleColor:color1 forState:UIControlStateNormal];
                }]];
                
                
                [self presentViewController:al animated:YES completion:nil];
                
                UIColor *color2 = Color(237, 77, 77);
                self.view.backgroundColor = color2;
                phoneNUM.backgroundColor = color2;
                passWordText.backgroundColor = color2;
                registor.backgroundColor = color2;
                [button setTitleColor:color2 forState:UIControlStateNormal];
            }else{
                
                //                [self ShowMBHubWithTitleOnlyWithTitle:@"登陆成功！" withTime:2.0f];
                NSLog(@"%@",[userdata objectForKey:@"userid"]);
                NSString * userid  =[userdata objectForKey:@"userid"];
                
                [[ZCUserData share]saveUserInfoWithUserId:userid username:[userdata objectForKey:@"username"] descriptions:nil mobile:phone.text fuwu:nil jiedan:nil lianxi:nil yinxiang:nil nickname:nil thumb:nil tiqian:nil xing:nil xingqu:nil xueli:nil zhiye:nil  IsLogin:YES];
                
                
                if ( [phone.text isEqualToString:@"15502196946"]) {
                    
                    [self LoginRongCould];
                    
                }
                
        
                UIView *view = [GiFHUD new];
                [GiFHUD setGifWithImageName:@"加载(1).gif"];
                [GiFHUD show];
                [self performSelector:@selector(stopit) withObject:view afterDelay:0.5];
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
        }];
    }
}
- (void)stopit{
    
    [GiFHUD dismiss];
    
    NSDictionary *dict = @{@"userid":[ZCUserData share].userId,@"registration_id":[JPUSHService registrationID]};
    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/tc.php?op=edit_registration" success:^(NSDictionary *fanhuicanshu) {
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
    RootViewcontroller *view = [[RootViewcontroller alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = view;
}

-(void)LoginRongCould {
    
    NSString *url = @"http://api.cn.ronghub.com/user/getToken.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    //在这post    userId 接口
    
    NSString  *userid = @"15502196946";
    NSString  *username =  @"客服";
    NSString *catTu = [NSString stringWithFormat:@"%@",@"http://wx.leisurecarlife.com/uploadfile/2017/0612/20170612070927166.png"];
    
    NSDictionary *ddd = @{@"userId":userid,@"userName":username,@"portraiUri":catTu};
    NSString *appkey = @"kj7swf8ok47u2";
    NSString *nonce = [self getRandomNonce];
    NSString *timestamp = [self getTimestamp];
    NSString *signature = [self getSignatureWithAppSecret:@"Kv26rgnvLRR" nonce:nonce timestamp:timestamp];
    
    NSLog(@"-------%@",appkey);
    NSLog(@"-------%@",nonce);
    NSLog(@"--------%@",timestamp);
    NSLog(@"---------%@",signature);
    
    [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
    [manager.requestSerializer setValue:@"Kv26rgnvLRR" forHTTPHeaderField:@"appSecret"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
    
    
    [manager POST:url parameters:ddd success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //  NSLog(@"%@",responseObject[@"token"]);
        //   [self initLoacalTestData];
              NSString *token;
//        if([aUserInfo.userId intValue] == [userid intValue]){
            token = responseObject[@"token"];
//        }
        [[RCIM sharedRCIM] connectWithToken: token success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            dispatch_async(dispatch_get_main_queue(), ^{
                
             //   [[RCIM sharedRCIM] setUserInfoDataSource:self];
            });
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
        //
    //[[RCDataManager shareManager] loginRongCloudWithUserInfo:[[RCUserInfo alloc]initWithUserId:aUserInfo.userId name:aUserInfo.name portrait:aUserInfo.portraitUri QQ:aUserInfo.QQ sex:aUserInfo.sex] withToken:token];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    
    if ([userId isEqualToString:@"15502196946"]) {
        
        RCUserInfo *user = [[RCUserInfo alloc] init];
        user.userId = userId;
        user.name =  @"客服";
        user.portraitUri = @"http://wx.leisurecarlease.com/uploadfile/2017/0612/20170612070927166.png";
        return completion(user);
    }
    return completion(nil);
}
#pragma mark - textfieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.view.backgroundColor = [UIColor redColor];
    [phoneNUM resignFirstResponder];
    [passWordText resignFirstResponder];
}
- (void)registerForKeyBoard{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
    
}
- (void)keyBoardShow:(NSNotification *)notic{
    
    NSDictionary *info = [notic userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyBoardSize = [value CGRectValue].size;
    CGFloat keyBoardY = keyBoardSize.height;
    
    loginButton.frame = CGRectMake(width*0.825, height - keyBoardY-width*0.17, width*0.13, width*0.13);
}

- (void)valueChanged:(NSNotification *)notification{
    
    if (phoneNUM.text.length < 11) {
        
        UIColor *color1 = Color(7, 187, 177);
        phoneNUM.backgroundColor = color1;
        passWordText.backgroundColor = color1;
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
        passWordText.backgroundColor = color2;
        registor.backgroundColor = color2;
        [button setTitleColor:color2 forState:UIControlStateNormal];
//        [phoneNUM addSubview:duihao];
    }
    if (phoneNUM.text.length == 11) {
        
        UIColor *color1 = Color(7, 187, 177);
        phoneNUM.backgroundColor = color1;
        passWordText.backgroundColor = color1;
        registor.backgroundColor = color1;
        self.view.backgroundColor = color1;
//        [duihao setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [duihao setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
//        [phoneNUM addSubview:duihao];
        [button setTitleColor:color1 forState:UIControlStateNormal];
    }
    
    if (passWordText.text.length > 5) {
        
        [dui setBackgroundImage:[UIImage imageNamed:@"勾.png"] forState:UIControlStateNormal];
    }if (passWordText.text.length < 6) {
        
        [dui setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    if (phoneNUM.text.length == 11 && passWordText.text.length > 5) {
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"右完成.png"] forState:UIControlStateNormal];
    }else{
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"右1.png"] forState:UIControlStateNormal];
    }
}
-(NSString *)sha1WithKey:(NSString *)key
{
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}
//获取随机数
-(NSString *)getRandomNonce
{
    NSInteger randomValue = [self getRandomNumber:100000 to:999999];
    return  [NSString stringWithFormat:@"%ld",randomValue];
}
//获取时间戳 从1970年
-(NSString *)getTimestamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval times =  [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",times];
}

//获取从 from 到  to 的随机数
-(NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}


//根据appSecret nonce timestamp 获取signature
-(NSString *)getSignatureWithAppSecret:(NSString *)appSecret nonce:(NSString *)nonce timestamp:(NSString *)timestamp
{
    NSString *sha1String = [NSString stringWithFormat:@"%@%@%@",appSecret,nonce,timestamp];
    return [self sha1WithKey:sha1String];
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
