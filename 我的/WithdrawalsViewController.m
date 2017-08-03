//
//  WithdrawalsViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/12.
//  Copyright © 2015年 佐途. All rights reserved.
//
//
#import "WithdrawalsViewController.h"
#import "AllPages.pch"

@interface WithdrawalsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)UITableView *tableView;

@end

@implementation WithdrawalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"提现"];
    
    self.view.backgroundColor =Color(245, 245, 249);
    
    [self tableViews];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}

- (void)tableViews
{
    UILabel *tishi =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, 0, ScreenWidth, ScreenWidth*0.1)];
    tishi.textColor =Color(100, 100, 100);
    [self label:tishi isBold:NO isFont:12.0f];
    tishi.text=@"请填写本人银行的开户卡号";
    [self.view addSubview:tishi];
    
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.1, ScreenWidth, ScreenWidth*0.65)];
    self.tableView.delegate= self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor=Color(245, 245, 249);
    self.tableView.scrollEnabled =NO;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    
    
    UIButton *tijiao =[UIButton buttonWithType:UIButtonTypeSystem];
    tijiao.frame =CGRectMake(ScreenWidth*0.03, ScreenHeight-ScreenWidth*0.125*3.5, ScreenWidth-ScreenWidth*0.06, ScreenWidth*0.125);
    tijiao.backgroundColor =Color(0, 170, 238);
    tijiao.layer.masksToBounds =YES;
    [self button:tijiao isBold:YES isFont:14.0f];
    [tijiao setTitle:@"提 交" forState:UIControlStateNormal];
    [tijiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tijiao.layer.cornerRadius =6.0f;
    [tijiao addTarget:self action:@selector(tijiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tijiao];
    
}
-(void)tijiaoBtnClick
{
    
    UITextField *name=(UITextField *)[self.view viewWithTag:10001];
    UITextField *kahao=(UITextField *)[self.view viewWithTag:10002];
    UITextField *kaifu=(UITextField *)[self.view viewWithTag:10003];
    UITextField *money=(UITextField *)[self.view viewWithTag:10004];
    
    if (name.text.length!=0) {
        if (kahao.text.length!=0) {
            if (kaifu.text.length!=0) {
                if (money.text.length!=0) {
                    if ([kahao.text isEqualToString:kaifu.text])
                    {
                        if ([money.text isEqualToString:@"0"])
                        {
                            [XWAlterview showmessage:@"温馨提示" subtitle:@"请输入正确的金额" cancelbutton:@"确定"];

                        }else
                        {
                            NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
                            float  yue =[[NSString stringWithFormat:@"%@",[user objectForKey:@"jines"]] floatValue];
                            float  xianjin =[[NSString stringWithFormat:@"%@",money.text] floatValue];
                            
                            
                            NSLog(@"我的余额%f",yue);
                            NSLog(@"我的现金%f",xianjin);
                            
                            float jieguo = yue-xianjin;
                            
                            NSLog(@"%f",jieguo);
                            if (yue-xianjin>=0)
                            {
                                
                                [GiFHUD setGifWithImageName:@"闲车HUD1.gif"];
                                [GiFHUD showWithOverlay];
                                
                                NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [ZCUserData share].username,@"username",
                                                   name.text,@"name",
                                                   kahao.text,@"kaihuhang",
                                                   kaifu.text,@"kahao",
                                                   money.text,@"money",
                                                   [ZCUserData share].userId,@"userid",nil];
                                
                                NSLog(@"%@",dic);
                                [HttpManager postData:dic andUrl:TIXIAN success:^(NSDictionary *fanhuicanshu) {
                                    if ([[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"error"]] isEqualToString:@"0"]) {
                                        [GiFHUD dismiss];
                                        
                                        NSLog(@"提现成功了么%@",fanhuicanshu);
                                        NSLog(@"%@",[fanhuicanshu objectForKey:@"msg"]);
                                        NSUserDefaults * user= [NSUserDefaults standardUserDefaults];
                                        float xianJin =[[NSString stringWithFormat:@"%@",[user objectForKey:@"jines"]] floatValue];
                                        if ([[fanhuicanshu objectForKey:@"error"]isEqualToString:@"0"])
                                        {
                                            float tixianJinE=[[NSString stringWithFormat:@"%@",money.text] floatValue];
                                            NSString *jine =[NSString stringWithFormat:@"%0.2f",xianJin-tixianJinE];
                                            [user setObject:jine forKey:@"jines"];
                                            NSLog(@"最终的余额%@",[user objectForKey:@"jines"]);
                                            [self.navigationController popViewControllerAnimated:YES];
                                            
                                        }
                                        
                                        [XWAlterview showmessage:@"温馨提示" subtitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]] cancelbutton:@"确定"];
                                        
                                        
                                        
                                        
                                    }
                                } Error:^(NSString *cuowuxingxi) {
                                    
                                    NSLog(@"%@",cuowuxingxi);
                                }];

                            }else
                            {
                                [XWAlterview showmessage:@"温馨提示" subtitle:@"请输入正确的金额" cancelbutton:@"确定"];

                            }

                        }

                    }else
                    {
                        [XWAlterview showmessage:@"温馨提示" subtitle:@"您的支付宝账号不同" cancelbutton:@"确定"];

                    }
                    
                }else
                {
                   [XWAlterview showmessage:@"温馨提示" subtitle:@"请填写您要提现的金额" cancelbutton:@"确定"];
                }
            }else
            {
                [XWAlterview showmessage:@"温馨提示" subtitle:@"请填写您的开户银行" cancelbutton:@"确定"];
            }
        }else
        {
            [XWAlterview showmessage:@"温馨提示" subtitle:@"请填写您的卡号" cancelbutton:@"确定"];
        }
    }else
    {
        [XWAlterview showmessage:@"温馨提示" subtitle:@"请填写您的名字" cancelbutton:@"确定"];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num =0;
    if (section==0)
    {
        num=3;
    }else
    {
        num=2;
    }
    return num;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1)
    {
        return 0;
    }else
        
        return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }else{
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    NSMutableArray * array =[NSMutableArray arrayWithObjects:@"姓名",@"支付宝账号",@"确认支付宝账号", nil];
    NSMutableArray * array2 =[NSMutableArray arrayWithObjects:@"可提现",@"提现金额",nil];
    
    UILabel* title =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.12/2-ScreenWidth*0.06/2, ScreenWidth*0.5, ScreenWidth*0.06)];
    [self label:title isBold:NO isFont:13.0f];
    title.textColor =Color(64, 64, 64);
    [cell.contentView addSubview:title];
    
    
    
    UITextField *name =[[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.64, 0, ScreenWidth*0.6, ScreenWidth*0.12)];
    UIColor * grayColor =Color(153, 153, 153);
    name.textAlignment=NSTextAlignmentRight;
    [name setValue:grayColor forKeyPath:@"_placeholderLabel.textColor"];
    [name setValue:[UIFont fontWithName:@"STHeitiSC" size:15] forKeyPath:@"_placeholderLabel.font"];
    name.font =[UIFont fontWithName:@"STHeitiSC-Light" size:15];
    
    [cell.contentView addSubview:name];
    UILabel*xian =[[UILabel alloc]init];
    xian.backgroundColor =Color(225, 225, 225);
    [cell.contentView addSubview:xian];
    
    
    if (indexPath.section==0)
    {
        title.text =[array objectAtIndex:indexPath.row];
        if (indexPath.row==0)
        {
            name.tag =10001;
            name.placeholder =@"请输入您的姓名";
            xian.frame=CGRectMake(ScreenWidth*0.04, ScreenWidth*0.12-1, ScreenWidth-ScreenWidth*0.08, 1);
            
        }
        if (indexPath.row==1)
        {
            name.tag =10002;
            name.placeholder =@"请输入支付宝账号";
            xian.frame=CGRectMake(ScreenWidth*0.04, ScreenWidth*0.12-1, ScreenWidth-ScreenWidth*0.08, 1);
            
        }
        
        if (indexPath.row==2)
        {
            name.tag =10003;
            name.placeholder =@"请再次输入支付宝账号";
            xian.frame=CGRectMake(0, ScreenWidth*0.12-1, ScreenWidth, 1);
            
            
        }
        
    }else
    {
        title.text =[array2 objectAtIndex:indexPath.row];
        if (indexPath.row==0)
        {
            name.enabled=NO;
            NSUserDefaults * jine =[NSUserDefaults standardUserDefaults ];
            
            name.text =[NSString stringWithFormat:@"¥ %@",[jine objectForKey:@"jines"]];
            xian.frame=CGRectMake(ScreenWidth*0.04, ScreenWidth*0.12-1, ScreenWidth-ScreenWidth*0.08, 1);
            
            
        }
        else
        {
            name.tag =10004;
            name.placeholder =@"请填写提现金额";
            name.keyboardType=UIKeyboardTypeNumberPad;
            xian.frame=CGRectMake(0, ScreenWidth*0.12-1, ScreenWidth, 1);
            
        }
    }
    
    
    
    
    
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenWidth *0.12;
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
