//
//  PaymentSuccessViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/2.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "PaymentSuccessViewController.h"
#import "Header.h"
#import "PaymentSuccessTableViewCell.h"
#import "LoginView.h"
#import "OderManagementViewController.h"
#import "UILabel+SizeLabel.h"

@interface PaymentSuccessViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)UITableView  * tableView;

@end

@implementation PaymentSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =[UIColor whiteColor];
    [self addTitleViewWithTitle:@"支付成功"];
    
    
   
    
    [self tableViews];
    
    UIView *smallView= [[UIView alloc]initWithFrame:CGRectMake(0,ScreenHeight-ScreenWidth*0.16-64, ScreenWidth, ScreenWidth*0.16)];
    smallView.backgroundColor =Color(245, 245, 249);
    [self.view addSubview:smallView];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame =CGRectMake(ScreenWidth*0.031, ScreenWidth*0.02, ScreenWidth-ScreenWidth*0.031*2, ScreenWidth*0.16-ScreenWidth*0.02*2);
    button.backgroundColor =Color(0, 170, 238);
    button.layer.masksToBounds =YES;
    button.layer.cornerRadius =6.0 ;
    [button setTitle:@"查看订单" forState:UIControlStateNormal];
    [self button:button isBold:YES isFont:16.0f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget: self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [smallView addSubview:button];

}
- (void)buttonClick
{
    OderManagementViewController * oder= [[OderManagementViewController alloc]init];
    [self.navigationController pushViewController:oder  animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
}
-(void)tableViews
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  0, ScreenWidth, ScreenHeight-65-ScreenWidth*0.16)];
    self.tableView.delegate =self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=Color(245, 245, 249);
 
    [self.view addSubview:self.tableView];
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num;
    if (section ==0)
    {
        num =1;
    }else
    {
        num=3;
    }
    return num;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    else{
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (indexPath.section==0)
    {
        UILabel *xian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.3, ScreenWidth, 1)];
        xian.backgroundColor =Color(225, 225, 225);
        [cell.contentView addSubview:xian];
        
        
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.2, ScreenWidth*0.06, ScreenWidth*0.07, ScreenWidth*0.07)];
        imageView.image =[UIImage imageNamed:@"通过"];
        [cell.contentView addSubview:imageView];
        
        
        UILabel *zhuangtai =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.4, ScreenWidth*0.06, ScreenWidth*0.2, ScreenWidth*0.06)];
        zhuangtai.text=@"订金支付成功！";
        [self label:zhuangtai isBold:NO isFont:13.0f];
        [cell.contentView addSubview:zhuangtai];
        
        float labelWidth =[UILabel width:zhuangtai.text heightOfFatherView:zhuangtai.frame.size.height textFont:zhuangtai.font];
        
        imageView.frame =CGRectMake(ScreenWidth/2-(labelWidth+ScreenWidth*0.115)/2-ScreenWidth*0.02, ScreenWidth*0.06, ScreenWidth*0.115, ScreenWidth*0.115);
        zhuangtai.frame =CGRectMake(ScreenWidth/2-(labelWidth+ScreenWidth*0.115)/2-ScreenWidth*0.02+ScreenWidth*0.02+ScreenWidth*0.115, ScreenWidth*0.06+(ScreenWidth*0.115-ScreenWidth*0.06)/2, labelWidth, ScreenWidth*0.06);
        
        
        UILabel *dingdan =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.5/2, ScreenWidth*(0.06+0.115+0.03), ScreenWidth*0.5, ScreenWidth*0.05)];
         dingdan.text =@"订单号：1547895758545";
        [self label:dingdan isBold:NO isFont:13.0f];
        
        [cell.contentView addSubview:dingdan];
        
        float height =ScreenWidth*(0.43-0.3)-1;
        
        float width =ScreenWidth/2-0.5;
        
        UILabel *xian3 =[[UILabel alloc]initWithFrame:CGRectMake(width, ScreenWidth*0.3+ height/2-height*0.5/2, 1, height*0.5)];
        xian3.backgroundColor =Color(225, 225, 225);
        [cell.contentView addSubview:xian3];

        
        UILabel *yizhifu =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.3+1, width/2, height)];
        yizhifu.text =@"已支付";
        [self label:yizhifu isBold:NO isFont:13.0f];
        yizhifu.textColor =Color(50, 50, 50);
        yizhifu.textAlignment =NSTextAlignmentCenter;
        [cell.contentView addSubview:yizhifu];
        

        
        UILabel *nowPrice =[[UILabel alloc]initWithFrame:CGRectMake(width/2, ScreenWidth*0.3+1, width/2, height)];
        nowPrice.text =@"¥ 15";
        nowPrice.textColor =Color(249, 98, 104);
        [self label:nowPrice isBold:NO isFont:16.0f];
        [cell.contentView addSubview:nowPrice];
        float  fistWidth = [UILabel width:yizhifu.text heightOfFatherView:yizhifu.frame.size.height textFont:yizhifu.font];
        float  secondWidth = [UILabel width:nowPrice.text heightOfFatherView:nowPrice.frame.size.height textFont:nowPrice.font];

        yizhifu.frame =CGRectMake(width/2 - (fistWidth+secondWidth+ScreenWidth*0.04)/2, ScreenWidth*0.3+1, fistWidth, height);
        nowPrice.frame =CGRectMake(width/2 - (fistWidth+secondWidth+ScreenWidth*0.04)/2+fistWidth+ScreenWidth*0.04 , ScreenWidth*0.3+1, secondWidth, height);
        
        
        
        UILabel *shengyu =[[UILabel alloc]initWithFrame:CGRectMake(width, ScreenWidth*0.3+1, width/2, height)];
        shengyu.text =@"剩余支付";
        [self label:shengyu isBold:NO isFont:13.0f];
        shengyu.textColor =Color(50, 50, 50);
        shengyu.textAlignment =NSTextAlignmentCenter;
        [cell.contentView addSubview:shengyu];
        
        
        UILabel *shengPrice =[[UILabel alloc]initWithFrame:CGRectMake(width+ width/2, ScreenWidth*0.3+1, width/2, height)];
        shengPrice.text =@"¥ 258";
        [self label:shengPrice isBold:NO isFont:16.0f];
        shengPrice.textColor =Color(249, 98, 104);
        [cell.contentView addSubview:shengPrice];

        float  syWidth = [UILabel width:shengyu.text heightOfFatherView:shengyu.frame.size.height textFont:shengyu.font];
        float  ssWidth = [UILabel width:shengPrice.text heightOfFatherView:shengPrice.frame.size.height textFont:shengPrice.font];
        
        shengyu.frame =CGRectMake(width +(width/2 - (syWidth+ssWidth+ScreenWidth*0.04)/2), ScreenWidth*0.3+1, syWidth, height);
        shengPrice.frame =CGRectMake(width+(width/2 - (syWidth+ssWidth+ScreenWidth*0.04)/2+syWidth+ScreenWidth*0.04) , ScreenWidth*0.3+1, ssWidth, height);

        
        
        
        
        
        
        
        
        UILabel *wXian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.43-1, ScreenWidth, 1)];
        wXian.backgroundColor =Color(225, 225, 225);
        [cell.contentView addSubview:wXian];

    }
    if (indexPath.section==1)
    {
        PaymentSuccessTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell)
        {
            cell =[[PaymentSuccessTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            
        }
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;

        return cell;

    }

    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==0)
    {
        return 8;
        
    }else
        return 0;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return ScreenWidth*0.43;
        
    }else
    
    return  ScreenWidth *0.32;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
