//
//  SelfViewController.m
//  ZuChe
//
//  Created by 佐途 on 16/1/26.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "MySelfViewController.h"
#import "AllPages.pch"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UILabel+SizeLabel.h"
#import "LoginView.h"
#import "RegisterView.h"
#import "GeRenZiLiaoViewController.h"
#import "MyAccountViewController.h"
#import "MyEvaluationViewController.h"
#import "MyCollectionViewController.h"
#import "FileAComplaintViewController.h"
#import "AboutUsViewController.h"
#import "ServiceCentreViewController.h"
#import "XieYiViewController.h"
#import "MessageCenterViewController.h"
#import "ShangjiaViewController.h"
#import "jxyViewController.h"
#import "YaoqinViewController.h"
#import "JiangliViewController.h"

@interface MySelfViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary * _dic;
    UIButton *login;
    UIButton *regist;
    UIButton *shangjia;
    UIButton *chezhu;
    
    UIView *contentView;
    UILabel *mobile;
    UIButton *photo;
}
@property (nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *imagearray;
@property(nonatomic,retain)NSMutableArray *titlearray;

@end

@implementation MySelfViewController

-(NSMutableArray *)imagearray
{
    if (_imagearray== nil) {
        _imagearray=[NSMutableArray arrayWithObjects:@[@""],@[@"奖励.png",@"客服中心",@"规则",@"反馈.png",@"商"],@[@"邀请好友.png",@"关于我们" ], nil];
    }
    return _imagearray;
}
-(NSMutableArray *)titlearray
{
    if (_titlearray== nil) {
        _titlearray=[NSMutableArray arrayWithObjects:@[@""],@[@"奖励中心",@"服务中心",@"平台规则",@"意见反馈",@"商家认证"],@[@"邀请好友",@"关于我们"],nil];
    }
    return _titlearray;
}

- (void)viewDidLoad
{
    self.view.backgroundColor =Color(245, 245, 245);
    [self addTitleViewWithTitle:@"我的"];
    [self tableViews];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =NO;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =YES;
    _dic=[NSDictionary dictionary];
    
    self.tabBarController.tabBar.hidden=NO;
    if ([ZCUserData share].isLogin==YES)
    {
        NSLog(@"我已经登陆了");
        
        AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSDictionary *parameters =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
        
        [manager POST:[NSString stringWithFormat:@"%@api.php?op=memberinfo",NowUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            _dic  =responseObject;
            
            [[ZCUserData share]saveUserInfoWithUserId:[ZCUserData share].userId username:[ZCUserData share].username descriptions:[_dic objectForKey:@"description"] mobile:[_dic objectForKey:@"mobile"] fuwu:[_dic objectForKey:@"fuwu"] jiedan:[_dic objectForKey:@"jiedan"] lianxi:[_dic objectForKey:@"lianxi"] yinxiang:[_dic objectForKey:@"yinxiang"] nickname:[_dic objectForKey:@"nickname"] thumb:[_dic objectForKey:@"thumb"] tiqian:[_dic objectForKey: @"tiqian"] xing:[_dic objectForKey:@"xing"] xingqu:[_dic objectForKey:@"xingqu"] xueli:[_dic objectForKey:@"xueli"] zhiye:[_dic objectForKey:@"zhiye"] IsLogin:[ZCUserData share].isLogin];
            
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error%@",error);
            
        }];
        
    }else{
        
        [self.tableView reloadData];
    }
}

- (void)tableViews
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.8)];
    view.backgroundColor =Color(62, 68, 79);
    [self.view addSubview:view];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50)];
    self.tableView.delegate=self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int  num = 0;
    if (section ==0)
    {
        num  =2;
    }
    
    if (section ==1)
    {
        num  =5;
    }if (section==2) {
        num=2;
    }
    
    return num;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
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
    
    NSArray *titarr=self.titlearray[indexPath.section];
    NSArray *imgeArray=self.imagearray[indexPath.section];
    UIImageView*imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.13/2-ScreenWidth*0.045/2, ScreenWidth*0.045, ScreenWidth*0.045)];
    
    
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.14, 0, ScreenWidth/2, ScreenWidth*0.13)];
    titleLable.textColor=Color(64, 64, 64);
    titleLable.font =Font(14);
    
    
    UIImageView*imageViewes =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.03-Height(10), ScreenWidth*0.13/2-ScreenWidth*0.03/2, ScreenWidth*0.03, ScreenWidth*0.03)];
    imageViewes.image=[UIImage imageNamed:@"right"];
    imageViewes.alpha =0.6;
    
    
    if (indexPath.section==0) {
        
        
        if (indexPath.row==0){
            
            
            if ([ZCUserData share].isLogin==YES)
            {
                
                mobile =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.17+ScreenWidth*0.1, ScreenWidth*0.5/2-ScreenWidth*0.05/2, ScreenWidth*0.3, ScreenWidth*0.05)];
                mobile.textColor =[UIColor whiteColor];
                mobile.text=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"mobile"]];
                mobile.textAlignment =NSTextAlignmentCenter;
                [self label:mobile isBold:YES isFont:15.0f];
                [cell.contentView addSubview:mobile];
                    [login removeFromSuperview];
                    [regist removeFromSuperview];
                    
                    
                    NSMutableString *phone =[[NSMutableString alloc]initWithString:[ZCUserData share].mobile];
                    
                    if ([phone isEqualToString:@""]) {
                        
                    }else
                    {
                        [phone deleteCharactersInRange:NSMakeRange(3, 6)];
                        //  添加＊＊＊ 从第三个开始
                        [phone insertString:@"******" atIndex:3];
                    }
                    
                    mobile.text =phone;
            }
            
            
            //通知
            
            
            UIButton *lingdang=[UIButton buttonWithType:UIButtonTypeCustom];
            lingdang.frame=CGRectMake(ScreenWidth-Height(36), Height(32), Height(20), Height(20));
            [lingdang addTarget:self action:@selector(lingdang:) forControlEvents:UIControlEventTouchUpInside];
            [lingdang setImage:[UIImage imageNamed:@"信息(1)"] forState:UIControlStateNormal];
            [cell.contentView addSubview:lingdang];
            cell.backgroundColor=[UIColor clearColor];
#pragma mark--🔔
            UILabel *dian=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-Height(17), Height(23), Height(5), Height(5))];
            dian.layer.masksToBounds=YES;
            if ([ZCUserData share].isLogin) {
                dian.backgroundColor=[UIColor redColor];
            }else
            {
                dian.backgroundColor=[UIColor whiteColor];
            }
            
            dian.layer.cornerRadius=dian.frame.size.height/2;
//            [cell.contentView addSubview:dian];
            
            //            UIVie3w *view =[[UIView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.3, ScreenWidth, 0)];
            //            view.backgroundColor =[UIColor whiteColor];
            //            [cell.contentView addSubview:view];
            
            UIImageView *ph =[[UIImageView alloc]init];
            ph.backgroundColor=[UIColor whiteColor];
            ph.image =[UIImage imageNamed:@"头像"];
            [cell.contentView addSubview:ph];
            
            photo =[UIButton buttonWithType:UIButtonTypeSystem];
            photo.layer.masksToBounds =YES;
            photo.layer.cornerRadius=photo.frame.size.height/2;
            [photo addTarget:self action:@selector(geRenZilLiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:photo];
            
            
            UIImageView *ph1 =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.05+ScreenWidth*0.17-Height(15), ScreenWidth*0.14+ScreenWidth*0.17-Height(15), Height(15), Height(15))];
            ph1.backgroundColor=[UIColor whiteColor];
            ph1.layer.cornerRadius=ph1.frame.size.width/2;
            ph1.image =[UIImage imageNamed:@" 我的 (8)"];
            ph1.layer.shadowColor = [UIColor blackColor].CGColor;
            ph1.layer.shadowOffset = CGSizeMake(1, 1);
            ph1.layer.shadowOpacity = 0.5;
            ph1.layer.shadowRadius = 2.0;
            
            if ([ZCUserData share].isLogin==YES)
            {
                
                ph.frame=CGRectMake(ScreenWidth*0.05, ScreenWidth*0.14, ScreenWidth*0.17+2, ScreenWidth*0.17+2);
                photo.frame=CGRectMake(ScreenWidth*0.05+1, ScreenWidth*0.14+1, ScreenWidth*0.17, ScreenWidth*0.17);
                
                
                //                UIButton *vip =[UIButton buttonWithType:UIButtonTypeSystem];
                //                vip.frame=CGRectMake(ScreenWidth-ScreenWidth*0.3, ScreenWidth*(0.5-0.08)/2, ScreenWidth*0.3, ScreenWidth*0.08);
                //                [vip  setBackgroundImage:[UIImage imageNamed:@"星(1)"] forState:UIControlStateNormal];
                //                [cell.contentView addSubview:vip];
                //
                
                UIView *view =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.33, ScreenWidth*(0.5-0.08)/2, ScreenWidth*0.33, ScreenWidth*0.08)];
                view.backgroundColor =[UIColor clearColor];
                view.layer.masksToBounds =YES;
                view.layer.cornerRadius=12.0f;
                [cell.contentView addSubview:view];
     
                UITapGestureRecognizer *tap_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dengji:)];
                [tap_tap setNumberOfTapsRequired:1];
                
                [view addGestureRecognizer:tap_tap];
                
                NSString *grade=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"grade"]];
                int grade1;
                if ([grade isEqualToString:@"(null)"]) {
                    grade1=10;
                }else
                {
                    grade1=[grade  intValue];
                }
                
                [self  addView:view grade:grade1];
                
                
                NSLog(@"我已经登陆了");
                NSURL * url =[NSURL URLWithString:[ZCUserData share].thumb];
                if ([url isEqual:@"(null)"]) {
                    [photo setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
                }else
                {
                    [photo sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
                }
                [cell.contentView addSubview:ph1];
                
                
                ph.layer.masksToBounds =YES;
                ph.layer.cornerRadius=ph.frame.size.height/2;
                
                photo.layer.masksToBounds =YES;
                photo.layer.cornerRadius=photo.frame.size.height/2;
                
            }else
            {
                
                ph.frame=CGRectMake(ScreenWidth/2-ScreenWidth*0.17/2-1, ScreenWidth*0.15, ScreenWidth*0.17+2, ScreenWidth*0.17+2);
                photo.frame=CGRectMake(ScreenWidth/2-ScreenWidth*0.17/2, ScreenWidth*0.16, ScreenWidth*0.17, ScreenWidth*0.17);
                
                [photo setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
                
                ph.layer.masksToBounds =YES;
                ph.layer.cornerRadius=ph.frame.size.height/2;
                
                [lingdang removeFromSuperview];
                [dian removeFromSuperview];
            }
            
        }else
        {
            
            UIColor *orangeColor =Color(255, 96, 48);
            UIColor *blueColor =Color(0, 170, 238);
            
            
            
            
            UIView *view =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenWidth*0.1, ScreenWidth*0.28, ScreenWidth*0.08)];
            view.layer.masksToBounds =YES;
            view.layer.cornerRadius =0.04*ScreenWidth ;
            view.layer.borderColor =orangeColor.CGColor;
            [view.layer setBorderWidth:1];
            
            UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.02, ScreenWidth*0.08/2-ScreenWidth*0.04/2, ScreenWidth*0.04, ScreenWidth*0.04)];
            [view addSubview:image];
            
            
            
            shangjia=[UIButton buttonWithType:UIButtonTypeSystem];
            shangjia.frame =CGRectMake(0, 0, ScreenWidth*0.28, ScreenWidth*0.08);
            shangjia.layer.masksToBounds =YES;
            shangjia.layer.cornerRadius =0.04*ScreenWidth ;
            [shangjia setTitleColor:orangeColor forState:UIControlStateNormal];
            
            [self button:shangjia isBold:NO isFont:11];
            
            [view addSubview:shangjia];
            
            UIView *smallView =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenWidth*0.1, ScreenWidth*0.28, ScreenWidth*0.08)];
            smallView.layer.masksToBounds =YES;
            smallView.layer.cornerRadius =0.04*ScreenWidth ;
            smallView.layer.borderColor =blueColor.CGColor;
            [smallView.layer setBorderWidth:1];
            UIImageView *images =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.02, ScreenWidth*0.08/2-ScreenWidth*0.04/2, ScreenWidth*0.04, ScreenWidth*0.04)];
            [smallView addSubview:images];
            
            
            
            chezhu=[UIButton buttonWithType:UIButtonTypeSystem];
            chezhu.frame =CGRectMake(0, 0, ScreenWidth*0.28, ScreenWidth*0.08);
            chezhu.layer.masksToBounds =YES;
            [chezhu setTitleColor:blueColor forState:UIControlStateNormal];
            [self button:chezhu isBold:NO isFont:11];
            chezhu.layer.cornerRadius =0.04*ScreenWidth ;
            [smallView addSubview:chezhu];
            
            
            
            /*******************************************************************************************/
            
            login=[UIButton buttonWithType:UIButtonTypeSystem];
            login.frame =CGRectMake(ScreenWidth*0.15, ScreenWidth*0.1, ScreenWidth*0.28, ScreenWidth*0.08);
            login.layer.masksToBounds =YES;
            login.layer.cornerRadius =0.04*ScreenWidth ;
            login.layer.borderColor =blueColor.CGColor;
            [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [login.layer setBorderWidth:1];
            [login setTitleColor:blueColor forState:UIControlStateNormal];
            [login setTitle:@"立即登录" forState:UIControlStateNormal];
            [self button:login isBold:NO isFont:12.0f];
            [login addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            
            regist=[UIButton buttonWithType:UIButtonTypeSystem];
            regist.frame =CGRectMake(ScreenWidth-ScreenWidth*0.15-ScreenWidth*0.28, ScreenWidth*0.1, ScreenWidth*0.28, ScreenWidth*0.08);
            regist.layer.masksToBounds =YES;
            regist.layer.cornerRadius =0.04*ScreenWidth ;
            UIColor *color2 =Color(255, 96, 48);
            [regist.layer setBorderWidth:1];
            regist.layer.borderColor =color2.CGColor;
            [regist setTitle:@"免费注册" forState:UIControlStateNormal];
            [self button:regist isBold:NO isFont:12.0f];
            [regist setTitleColor:color2 forState:UIControlStateNormal];
            [regist addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-0.5/2-1, ScreenWidth*0.09, 0.5, ScreenWidth*0.08)];
            xian.backgroundColor=Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
            UILabel *fenge =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.1+ScreenWidth*0.12, ScreenWidth, 0.5)];
            fenge.backgroundColor=Color(225, 225, 225);
            [cell.contentView addSubview:fenge];
            
            
            
            if ([ZCUserData share].isLogin==YES)
            {
                NSString *shangjias =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"shangjia"]];
                NSString * chezhus =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"chezhu"]];
                
                if ([shangjias isEqualToString:@"0"]&&[chezhus isEqualToString:@"0"])
                {
                    
                    [chezhu setTitle:@"   车主未认证" forState:UIControlStateNormal];
                    
                    smallView.frame =CGRectMake(ScreenWidth/2-ScreenWidth*0.28/2, ScreenWidth*0.08, ScreenWidth*0.28, ScreenWidth*0.08);
                    
                    [chezhu addTarget:self action:@selector(chezhuRenZheng) forControlEvents:UIControlEventTouchUpInside];
                    
                    images.image =[UIImage imageNamed:@"蓝加"];
                    [xian removeFromSuperview];
                    [cell.contentView addSubview:smallView];
                    
                }
                if ([shangjias isEqualToString:@"1"]&&[chezhus isEqualToString:@"1"])
                    
                {
                    smallView.frame=CGRectMake(ScreenWidth*0.15, ScreenWidth*0.08, ScreenWidth*0.28, ScreenWidth*0.08);
                    view.frame =CGRectMake(ScreenWidth-ScreenWidth*0.15-ScreenWidth*0.28, ScreenWidth*0.08, ScreenWidth*0.28, ScreenWidth*0.08);
                    images.image =[UIImage imageNamed:@"蓝勾"];
                    image.image =[UIImage imageNamed:@"黄勾"];
                    [chezhu setTitle:@"   车主已认证" forState:UIControlStateNormal];
                    [shangjia setTitle:@"   商家已认证" forState:UIControlStateNormal];
                    
                    shangjia.userInteractionEnabled =NO;
                    chezhu.userInteractionEnabled=NO;
                    
                    [cell.contentView addSubview:smallView];
                    [cell.contentView addSubview:view];
                }
                
                if ([shangjias isEqualToString:@"0"]&&[chezhus isEqualToString:@"1"])
                    
                {
                    smallView.frame=CGRectMake(ScreenWidth/2-ScreenWidth*0.28/2, ScreenWidth*0.08, ScreenWidth*0.28, ScreenWidth*0.08);
                    //                    view.frame =CGRectMake(ScreenWidth-ScreenWidth*0.15-ScreenWidth*0.28, ScreenWidth*0.08, ScreenWidth*0.28, ScreenWidth*0.08);
                    images.image =[UIImage imageNamed:@"蓝勾"];
                    //                    image.image =[UIImage imageNamed:@"黄加"];
                    [chezhu setTitle:@"   车主已认证" forState:UIControlStateNormal];
                    //                    [shangjia setTitle:@"   商家未认证" forState:UIControlStateNormal];
                    
                    //                    [shangjia addTarget:self action:@selector(shangJiaRenZheng) forControlEvents:UIControlEventTouchUpInside];
                    
                    shangjia.userInteractionEnabled =YES;
                    chezhu.userInteractionEnabled=NO;
                    [xian removeFromSuperview];
                    [cell.contentView addSubview:smallView];
                    //                    [cell.contentView addSubview:view];
                }
                if ([shangjias isEqualToString:@"1"]&&[chezhus isEqualToString:@"0"])
                    
                {
                    smallView.frame=CGRectMake(ScreenWidth*0.15, ScreenWidth*0.08, ScreenWidth*0.28, ScreenWidth*0.08);
                    view.frame =CGRectMake(ScreenWidth-ScreenWidth*0.15-ScreenWidth*0.28, ScreenWidth*0.08, ScreenWidth*0.28, ScreenWidth*0.08);
                    images.image =[UIImage imageNamed:@"蓝加"];
                    image.image =[UIImage imageNamed:@"黄勾"];
                    [chezhu setTitle:@"   车主未认证" forState:UIControlStateNormal];
                    [shangjia setTitle:@"   商家已认证" forState:UIControlStateNormal];
                    
                    
                    [chezhu addTarget:self action:@selector(chezhuRenZheng) forControlEvents:UIControlEventTouchUpInside];
                    
                    shangjia.userInteractionEnabled =NO;
                    chezhu.userInteractionEnabled=YES;
                    
                    [cell.contentView addSubview:smallView];
                    [cell.contentView addSubview:view];
                }
                
                
            }
            if ([ZCUserData share].isLogin==NO)
            {
                
                [fenge removeFromSuperview];
            }else
            {
                float fistWitdh =  (ScreenWidth-(0.5*3))/3;
                
                float fistHeight = (ScreenWidth*(0.54-0.105))-(ScreenWidth*0.1+ScreenWidth*0.08*3);
                
                float Height =ScreenWidth*0.1+ScreenWidth*0.12+0.05;
                
                for (int i =0; i<2; i++)
                {
                    UILabel *xian =[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/3*(i+1))-0.5/2, ScreenWidth*0.1+ScreenWidth*0.06*2+fistHeight/2, 0.5, ScreenWidth*0.09)];
                    xian.backgroundColor =Color(225, 225, 225);
                    [cell.contentView addSubview:xian];
                    
                }
                
                UILabel *money=[[UILabel alloc]initWithFrame:CGRectMake(0, Height, fistWitdh, fistHeight*1.2)];
                NSString *qianqian=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"money"]];
                
                NSUserDefaults * moneys =[NSUserDefaults standardUserDefaults];
                [moneys setObject:qianqian forKey:@"jines"];
                
                if ([qianqian isEqualToString:@"(null)"]) {
                    qianqian=@"0";
                }
                money.text =qianqian;
                money.textColor =Color(50, 50, 50);
                money.textAlignment =NSTextAlignmentCenter;
                [self label:money isBold:YES isFont:13.0f];
                [cell.contentView addSubview:money];
                
                float   myWidth =[UILabel width:money.text heightOfFatherView:money.frame.size.height textFont:money.font];
                
                //整个宽度／2-（钱的宽度＋元的宽度）／2
                
                
                UILabel *yuan =[[UILabel alloc]initWithFrame:CGRectMake(myWidth, Height, fistHeight*1.2, fistHeight*1.2)];
                yuan.text=@"元";
                [self label:yuan isBold:NO isFont:11.0f];
                [cell.contentView addSubview:yuan];
                yuan.textColor =Color(50, 50, 50);
                
                money.frame= CGRectMake(fistWitdh/2 -(myWidth+ScreenWidth*0.04)/2, Height, myWidth, fistHeight*1.2);
                yuan.frame =CGRectMake(fistWitdh/2 -(myWidth+ScreenWidth*0.04)/2+myWidth, Height, ScreenWidth*0.04, fistHeight*1.2);
                
                
                
                UILabel *pingjia=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh+1, Height, fistWitdh, fistHeight*1.2)];
                NSString *geshu=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"pingcount"]];
                if ([geshu isEqualToString:@"(null)"]) {
                    geshu=@"0";
                }
                pingjia.text =geshu;
                pingjia.textColor =Color(50, 50, 50);
                pingjia.textAlignment =NSTextAlignmentCenter;
                [self label:pingjia isBold:YES isFont:13.0f];
                [cell.contentView addSubview:pingjia];
                
                float   twoWidth =[UILabel width:pingjia.text heightOfFatherView:pingjia.frame.size.height textFont:pingjia.font];
                
                UILabel *ge =[[UILabel alloc]initWithFrame:CGRectMake(myWidth, Height, fistHeight*1.2, fistHeight*1.2)];
                ge.text=@"个";
                [self label:ge isBold:NO isFont:11.0f];
                [cell.contentView addSubview:ge];
                ge.textColor =Color(50, 50, 50);
                
                pingjia.frame= CGRectMake(fistWitdh+0.5+fistWitdh/2 -(twoWidth+ScreenWidth*0.04)/2, Height, twoWidth, fistHeight*1.2);
                ge.frame =CGRectMake(fistWitdh+0.5+fistWitdh/2 -(twoWidth+ScreenWidth*0.04)/2+twoWidth, Height, ScreenWidth*0.04, fistHeight*1.2);
                
                
                UILabel *shoucang=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh*2+2, Height, fistWitdh, fistHeight*1.2)];
                 NSString *cangcount=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"cangcount"]];
                if ([cangcount isEqualToString:@"(null)"]) {
                    cangcount=@"0";
                }
                shoucang.text =cangcount;
                shoucang.textColor =Color(50, 50, 50);
                shoucang.textAlignment =NSTextAlignmentCenter;
                [self label:shoucang isBold:YES isFont:13.0f];
                [cell.contentView addSubview:shoucang];
                
                
                float   threeWidth =[UILabel width:shoucang.text heightOfFatherView:shoucang.frame.size.height textFont:shoucang.font];
                UILabel *liang =[[UILabel alloc]initWithFrame:CGRectMake(myWidth, Height, fistHeight*1.2, fistHeight*1.2)];
                liang.text=@"辆";
                [self label:liang isBold:NO isFont:11.0f];
                [cell.contentView addSubview:liang];
                liang.textColor =Color(50, 50, 50);
                
                shoucang.frame= CGRectMake(fistWitdh*2+1+fistWitdh/2 -(threeWidth+ScreenWidth*0.04)/2, Height, threeWidth, fistHeight*1.2);
                liang.frame =CGRectMake(fistWitdh*2+1+fistWitdh/2 -(threeWidth+ScreenWidth*0.04)/2+threeWidth, Height, ScreenWidth*0.04, fistHeight*1.2);
                
                
                
                /*********************************************************事先说明：上面是服务器传来的活数据，下面是title**********************************************************************/
                
                UILabel *jdLvs=[[UILabel alloc]initWithFrame:CGRectMake(0, Height+fistHeight*0.8, fistWitdh, fistHeight)];
                jdLvs.text =@"现金余额";
                jdLvs.textColor =Color(100, 100, 100);
                jdLvs.textAlignment =NSTextAlignmentCenter;
                [self label:jdLvs isBold:NO isFont:11.0f];
                [cell.contentView addSubview:jdLvs];
                
                
                
                UILabel *fuwus=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh+1, Height+fistHeight*0.8, fistWitdh, fistHeight)];
                fuwus.text =@"订单评价";
                fuwus.textColor =Color(100, 100, 100);
                [self label:fuwus isBold:NO isFont:11.0f];
                fuwus.textAlignment =NSTextAlignmentCenter;
                [cell.contentView addSubview:fuwus];
                
                
                UILabel *times=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh*2+2, Height+fistHeight*0.8, fistWitdh, fistHeight)];
                times.text =@"我的收藏";
                times.textColor =Color(100, 100, 100);
                [self label:times isBold:NO isFont:11.0f];
                times.textAlignment =NSTextAlignmentCenter;
                [cell.contentView addSubview:times];
                
                for (int i=0; i<3; i++) {
                    UIButton *btnanniu=[[UIButton alloc]initWithFrame:CGRectMake(i*ScreenWidth/3,ScreenWidth*0.435-Height(60)-ScreenWidth*0.04, ScreenWidth/3, Height(60))];
                    btnanniu.backgroundColor=[UIColor clearColor];
                    btnanniu.tag=i+500;
                    [btnanniu addTarget:self action:@selector(zhangfuanniu:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btnanniu];
                }
            }
            if ([ZCUserData share].isLogin==YES)
            {
                NSLog(@"我已经登陆了");
                
                [login removeFromSuperview];
                [regist removeFromSuperview];
                
                
                NSMutableString *phone =[[NSMutableString alloc]initWithString:[ZCUserData share].mobile];
                
                if ([phone isEqualToString:@""]) {
                    
                }else
                {
                    [phone deleteCharactersInRange:NSMakeRange(3, 6)];
                    //  添加＊＊＊ 从第三个开始
                    [phone insertString:@"******" atIndex:3];
                }
                
                mobile.text =phone;
                
                
                
            }else
            {
                [cell.contentView addSubview:login];
                [cell.contentView addSubview:regist];
                [chezhu removeFromSuperview];
                [shangjia removeFromSuperview];
                NSLog(@"我还没有登陆了");
                [mobile removeFromSuperview];
                
            }
        }
    }
    if (indexPath.section==1) {
        
        titleLable.text=[NSString stringWithFormat:@"%@",[titarr objectAtIndex:indexPath.row]];
        imageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",[imgeArray objectAtIndex:indexPath.row]]];
        
        [cell.contentView addSubview:titleLable];
        [cell.contentView addSubview:imageViewes];
        [cell.contentView addSubview:imageView];
        
        if (indexPath.row==0)
        {
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 0.5)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
        }
        if (indexPath.row==1)
        {
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 0.5)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
        }
        if (indexPath.row==2)
        {
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 0.5)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
        }
        if (indexPath.row==3)
        {
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 0.5)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
        }
        if (indexPath.row==4)
        {
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 0.5)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
        }
        if (indexPath.row==5)
        {
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.13-1, ScreenWidth, 0.5)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
        }
    }if (indexPath.section==2) {
        
        titleLable.text=[NSString stringWithFormat:@"%@",[titarr objectAtIndex:indexPath.row]];
        imageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",[imgeArray objectAtIndex:indexPath.row]]];
        
        [cell.contentView addSubview:titleLable];
        [cell.contentView addSubview:imageViewes];
        [cell.contentView addSubview:imageView];
        
        if (indexPath.row==0)
        {
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 0.5)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
        }
        if (indexPath.row==1)
        {
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 0.5)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
        }
    }
    
    
    
    
    
    return cell;
}
-(void)shangJiaRenZheng
{
    NSLog(@"商家未认证，车主未认证");
    
}
-(void)chezhuRenZheng
{
    NSLog(@"车主未认证，商家未认证");
}

-(void)geRenZilLiaoBtnClick
{
    if ([ZCUserData share].isLogin==YES) {
        GeRenZiLiaoViewController *vc =[[GeRenZiLiaoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        LoginView *vc =[[LoginView alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int num=0;
    if (indexPath.section==0)
    {
        
        if (indexPath.row==0)
        {
            
            num =ScreenWidth*(0.3 +0.105);
            
        }else
        {
            if ([ZCUserData share].isLogin==YES) {
                num =ScreenWidth*0.4;
            }else
            {
                num =ScreenWidth*0.1+ScreenWidth*0.08*2;
            }
            
            
        }
    }else
    {
        num=ScreenWidth*0.13;
    }
    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(void)loginBtnClick{
    
    LoginView *log =[[LoginView alloc]init];
    [self.navigationController pushViewController:log animated:YES];
}
-(void)registerBtnClick
{
    RegisterView *regiseter =[[RegisterView alloc]init];
    [self.navigationController pushViewController:regiseter animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==2)
    {
        return 0;
    }else
        
        return Height(9.9);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 9.9)];
    
    if (section==0) {
        UIColor *cooo=Color(245, 245, 245);
        [headerView setBackgroundColor:cooo];
    }else
    {
        [headerView setBackgroundColor:[UIColor clearColor]];
    }
    
    return headerView;
    
}
-(void)zhangfuanniu:(UIButton *)sender
{
    NSLog(@"uij::%@",[NSString stringWithFormat:@"%ld",(long)sender.tag]);
    if (sender.tag==500) {
        NSLog(@"这是账户按钮");
        NSString *qianqian=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"money"]];
        NSString *dongjiemoney=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"dongjiemoney"]];
        MyAccountViewController *vc =[[MyAccountViewController alloc]init];
        vc.qianqian=qianqian;
        vc.dongjiemoney=dongjiemoney;
        [self.navigationController pushViewController:vc animated:YES];
    }if (sender.tag==501) {
        NSLog(@"这是评价按钮");
        MyEvaluationViewController *vc =[[MyEvaluationViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }if (sender.tag==502) {
        NSLog(@"这是收藏按钮");
        MyCollectionViewController *vc= [[MyCollectionViewController alloc]init];
        [self.navigationController pushViewController:vc  animated:YES];
        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            JiangliViewController *filea=[[JiangliViewController alloc]init];
            [self.navigationController pushViewController:filea animated:YES];
        }
        if (indexPath.row==1) {
            ServiceCentreViewController *filea=[[ServiceCentreViewController alloc]init];
            [self.navigationController pushViewController:filea animated:YES];
        }
        if (indexPath.row==2) {
            XieYiViewController *vc=[[XieYiViewController alloc]init];
            vc.xieyititle=@"平台规则";
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==3) {
            FileAComplaintViewController *filea=[[FileAComplaintViewController alloc]init];
            [self.navigationController pushViewController:filea animated:YES];
        }
        if (indexPath.row==4)
        {
            ShangjiaViewController *shangjias=[[ShangjiaViewController alloc]init];
            [self.navigationController pushViewController:shangjias animated:YES];
        }
        if (indexPath.row==5)
        {
            XieYiViewController *vc=[[XieYiViewController alloc]init];
            vc.xieyititle=@"用户协议";
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }if (indexPath.section==2) {
        if (indexPath.row==1) {
            AboutUsViewController *filea=[[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:filea animated:YES];
        }if (indexPath.row==0) {
            YaoqinViewController *jxy=[[YaoqinViewController alloc]init];
            [self.navigationController pushViewController:jxy animated:YES];
        }
    }
}
-(void)lingdang:(UIButton *)sender
{
    if ([ZCUserData share].isLogin==YES) {
        MessageCenterViewController *filea=[[MessageCenterViewController alloc]init];
        [self.navigationController pushViewController:filea animated:YES];
    }else
    {
        
        LoginView *filea1=[[LoginView alloc]init];
        [self.navigationController pushViewController:filea1 animated:YES];
    }
    
}
-(void)dengji:(UITapGestureRecognizer *)sender
{
    RankViewController *rank=[[RankViewController alloc]init];
    [self.navigationController pushViewController:rank animated:YES ];
}
@end
