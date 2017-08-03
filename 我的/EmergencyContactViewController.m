//
//  EmergencyContactViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/17.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import "EmergencyContactViewController.h"
#import "AllPages.pch"
#import <SMS_SDK/SMSSDK.h>
@interface EmergencyContactViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField*_phone;
    UITextField*_name;
    UITextField*_yzma;
    
}
@property (nonatomic,retain)UITableView*tableView;
@end

@implementation EmergencyContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   // [self addTitleViewWithTitle:@"紧急联系人"];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*0.3, ScreenWidth*0.08)];
    label.text = @"紧急联系人";
    label.textColor = Color(100, 100, 100);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    self.navigationItem.titleView = label;
    
    self.view.backgroundColor =Color(245, 245, 249);
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.48)];
    self.tableView.backgroundColor=Color(245, 245, 249);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.scrollEnabled =NO;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    UIButton *login =[UIButton buttonWithType:UIButtonTypeSystem];
    login.frame =CGRectMake(ScreenWidth*0.03, ScreenWidth*(0.48+0.12), ScreenWidth-ScreenWidth*0.06, ScreenWidth*0.125);
    login.backgroundColor =Color(0, 170, 238);
    login.layer.masksToBounds =YES;
    login.layer.cornerRadius =6.0 ;
    [login setTitle:@"确 定" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self button:login isBold:YES isFont:16.0f];
    [self.view addSubview:login];
    [login addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }else{
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    UIColor * grayColor =Color(153, 153, 153);
    
    UILabel *xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 1)];
    xian.backgroundColor =Color(225, 225, 225);
    [cell.contentView addSubview:xian];
    
    if (indexPath.row==0)
    {
        _name =[[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, 0, ScreenWidth-ScreenWidth*0.08, ScreenWidth*0.13)];
        _name.placeholder =@"请填写紧急联系人的姓名";
        //    phone.backgroundColor=[UIColor yellowColor];
        _name.keyboardType=UIKeyboardTypeASCIICapable;
        [_name setValue:grayColor forKeyPath:@"_placeholderLabel.textColor"];
        [_name setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [cell.contentView addSubview:_name];
        
    }
    
    if (indexPath.row==1)
    {
        _phone =[[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, 0, ScreenWidth-ScreenWidth*0.08, ScreenWidth*0.13)];
        _phone.placeholder =@"请填写紧急联系人的手机号码";
        //    phone.backgroundColor=[UIColor yellowColor];
        _phone.keyboardType=UIKeyboardTypeNumberPad;
        [_phone setValue:grayColor forKeyPath:@"_placeholderLabel.textColor"];
        _phone.delegate=self;
        _phone.tag=109;
        [_phone setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [cell.contentView addSubview:_phone];
    }
    if (indexPath.row==2)
    {
        
        xian.frame =CGRectMake(0, ScreenWidth*0.13-1, ScreenWidth, 1);
        _yzma =[[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth*0.04,  0, ScreenWidth-ScreenWidth*0.6-ScreenWidth*0.03, ScreenWidth*0.13)];
        //        password.backgroundColor=[UIColor yellowColor];
        _yzma.keyboardType=UIKeyboardTypeASCIICapable;
        _yzma.placeholder =@"请输入验证码";
        [_yzma setValue:grayColor forKeyPath:@"_placeholderLabel.textColor"];
        [_yzma setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [cell.contentView addSubview:_yzma];
        
        
        
        UIButton *huoqu =[UIButton buttonWithType:UIButtonTypeSystem];
        huoqu.frame= CGRectMake(ScreenWidth-ScreenWidth*0.06-ScreenWidth*0.03-ScreenWidth*0.27, ScreenWidth*0.13/2- ScreenWidth*0.08/2,ScreenWidth*0.27 , ScreenWidth*0.08);
        huoqu.backgroundColor =Color(7, 187, 177);
        [huoqu setTitle:@"获取验证码" forState:UIControlStateNormal];
        [huoqu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self button:huoqu  isBold:YES isFont:12.0f];
        huoqu.layer.masksToBounds =YES;
        huoqu.layer.cornerRadius =4.0 ;
        [huoqu addTarget:self action:@selector(huoquBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:huoqu];
        
    }
    
    
    
    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"zheshi1phone"];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)loginBtnClick
{
    
    if (_name.text.length==0||_name.text==nil||[_name.text isEqualToString:@""])
    {
        [self ShowMBHubWithTitleOnlyWithTitle:@"您的紧急联系人姓名未填写" withTime:1.0f];
        
    }else
    {
        if (_phone.text.length==0||_phone.text ==nil||[_phone.text isEqualToString:@""])
        {
            [self ShowMBHubWithTitleOnlyWithTitle:@"您的紧急联系人手机号未填写" withTime:1.0f];
            
        }else
        {
            
            if (_phone.text.length!=11||![[_phone.text substringToIndex:1] isEqualToString:@"1"]){
                [self ShowMBHubWithTitleOnlyWithTitle:@"您的手机号输入有误" withTime:1.0f];
                
            }else{
                
                [SMSSDK commitVerificationCode:_yzma.text phoneNumber:_phone.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
                    
                    if (!error)
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:_phone.text forKey:@"zheshi1phone"];
                        [self.navigationController popViewControllerAnimated:YES];
                        [self ShowMBHubWithTitleOnlyWithTitle:@"验证码正确!" withTime:2.0f];
                    }
                    else
                    {
                        if (_yzma.text.length==0||[_yzma.text isEqualToString:@""]||_yzma.text==nil)
                        {
                            
                            [self ShowMBHubWithTitleOnlyWithTitle:@"请填写验证码!" withTime:2.0f];
                            
                        }else
                        {
                            [self ShowMBHubWithTitleOnlyWithTitle:@"验证码不正确!" withTime:2.0f];
                            
                        }
                    }
                }];
                
            }
            
        }
    }
    
    
    
    
}
- (void)huoquBtnClick:(UIButton*)btn
{
    if (_phone.text.length==0||_phone.text ==nil||[_phone.text isEqualToString:@""])
    {
        [self ShowMBHubWithTitleOnlyWithTitle:@"您的紧急联系人手机号未填写" withTime:1.0f];
        
    }else
    {
        [self startTimebtn:btn];
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phone.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if(!error){
                [self ShowMBHubWithTitleOnlyWithTitle:@"已发送到您的手机，请验证" withTime:1.0f];
                
                
            }else{
                
                [self ShowMBHubWithTitleOnlyWithTitle:@"系统错误，请重新获取" withTime:1.0f];
            }
            
        }];
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenWidth*0.13;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==109) {
        
    }
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
