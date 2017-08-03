// 行程-进行中
//  GoForwardViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/10/27.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "GoForwardViewController.h"
#import "Header.h"
#import "ItineraryTableViewCell.h"
#import "PaymentSuccessViewController.h"
#import "AllPages.pch"
#import "UILabel+SizeLabel.h"
#import "HttpManager.h"
#import "UIButton+WebCache.h"
#import "XQyemianViewController.h"
@interface GoForwardViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UIView *_lineLabel;
    NSArray * _arrArray;
    NSArray *_listArray;
    MBProgressHUD *HUD;
    UIImageView* imageView23;
    UILabel*tishi23;
    NSInteger ROW;
}
@property (nonatomic,retain)UIScrollView *scrollview;
@property (strong,nonatomic)UIButton * tmpBtn;
@property (strong,nonatomic)UITableView  * tableView;

@end

@implementation GoForwardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)Downn
{
    if ([ZCUserData share].isLogin==YES)
    {
        
        NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId ,@"userid", nil];
        [HttpManager arrayPostData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=zkorderlist&status=1",NowUrl] Arraysuccess:^(NSArray *arrayfanhui) {
            _arrArray=arrayfanhui;
            if (_arrArray.count==0) {
                
                if (imageView23==nil||tishi23==nil) {
                    imageView23 =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.35/2, ScreenHeight/2-ScreenWidth*0.4-ScreenWidth*0.22, ScreenWidth*0.35,ScreenWidth*0.35)];
                    imageView23.image =[UIImage imageNamed:@"大图"];
                    [self.view addSubview:imageView23];
                    
                    tishi23 =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.8+ScreenWidth*0.6, ScreenWidth*0.55, ScreenWidth*0.2)];
                    tishi23.numberOfLines =0;
                    tishi23.textAlignment =NSTextAlignmentCenter;
                    [self label:tishi23 isBold:YES isFont:14];
                    tishi23.textColor=Color(99,99, 99);
                    tishi23.text= @"您还没有订单信息";
                    [self.view addSubview:tishi23];
                }
                [self.tableView removeFromSuperview];
                
            }else
            {
                [imageView23 removeFromSuperview];
                [tishi23 removeFromSuperview];
                for (int i=0; i<_arrArray.count; i++)
                {
                    _listArray=[[_arrArray objectAtIndex:i] objectForKey:@"carlist"];
                }
                [self tableViews];
            }
            
            
        } Error:^(NSString *cuowuxingxi) {
            
            NSLog(@"Error%@",cuowuxingxi);
        }];
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([ZCUserData share].isLogin ==NO)
    {
        if (imageView23==nil||tishi23==nil) {
            imageView23 =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.4/2, ScreenHeight/2-ScreenWidth*0.4-ScreenWidth*0.17, ScreenWidth*0.4,ScreenWidth*0.4)];
            imageView23.image =[UIImage imageNamed:@"大图"];
            [self.view addSubview:imageView23];
            
            
            
            
            tishi23 =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.6+ScreenWidth*0.6, ScreenWidth*0.55, ScreenWidth*0.2)];
            tishi23.numberOfLines =0;
            tishi23.textAlignment =NSTextAlignmentCenter;
            [self label:tishi23 isBold:YES isFont:14];
            tishi23.textColor=Color(99,99, 99);
            tishi23.text= @"您还没有登录，请先登录!";
            [self.view addSubview:tishi23];
        }
        [self.tableView removeFromSuperview];
    }else
    {
        [self Downn];
        [imageView23 removeFromSuperview];
        [tishi23 removeFromSuperview];
    }
}
-(void)tableViews
{
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  0, ScreenWidth, ScreenHeight-ScreenWidth*0.13-105)style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=Color(245, 245, 245);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    //    //MJ刷新
    //    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        
    //        [self Downn];
    //        //结束刷新
    //        [_tableView.mj_header endRefreshing];
    //        
    //    }];
    //小贾自定义刷新
    [self Refresh_JXY:_tableView VOID:^{
        [self Downn];
    }];
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[_arrArray objectAtIndex:section]objectForKey:@"carlist"] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arrArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ItineraryTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell)
    {
        cell =[[ItineraryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSArray * array =[[_arrArray objectAtIndex:indexPath.section]objectForKey:@"carlist"];
    
    [cell.photo sd_setBackgroundImageWithURL:[[array objectAtIndex:indexPath.row] objectForKey:@"thumb"] forState:UIControlStateNormal];
    [cell.photo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.name.text =[NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] objectForKey:@"models"]];
    cell.address.text =[NSString stringWithFormat:@"地址：%@",[[array objectAtIndex:indexPath.row] objectForKey:@"caradd"]];
    cell.address.lineBreakMode = NSLineBreakByTruncatingHead;
    
    NSArray * array34 =[[_arrArray objectAtIndex:indexPath.section]objectForKey:@"carlist"];
    NSString *TIME= [NSString stringWithFormat:@"%@",[[array34 objectAtIndex:indexPath.row] objectForKey:@"chuche"]];
    NSLog(@"这是时间！%@",TIME);

    NSString *diyige=[[NSString alloc]init];
    if ([TIME isEqualToString:@"(null)"]) {
        diyige=@"10:00";
    }else
    {
        diyige=[NSString stringWithFormat:@"%@",[TIME componentsSeparatedByString:@" "][1]];
    }
    
    cell.date.text =[NSString stringWithFormat:@"时间：%@",diyige];
    
    cell.price.text =[NSString stringWithFormat:@"¥ %@",[[array objectAtIndex:indexPath.row] objectForKey:@"money"]];
    //    cell.shijian.text =[NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] objectForKey:@"chuche"]];
    
    float myWidth =[UILabel width:cell.name.text heightOfFatherView:cell.name.frame.size.height textFont:cell.name.font];
    
    cell.chepai.text =[NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] objectForKey:@"plate"]];
    
    float myWidths =[UILabel width:cell.chepai.text heightOfFatherView:cell.chepai.frame.size.height textFont:cell.chepai.font];
    [self label:cell.chepai isBold:NO isFont:10.0f ];
    [self label:cell.price isBold:NO isFont:16.0f ];
    
    cell.chepai.frame =CGRectMake(ScreenWidth*0.382+myWidth+ScreenWidth*0.04, ScreenWidth*0.05, myWidths, ScreenWidth*0.04);
    
    cell.carid =[NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] objectForKey:@"carid"]];
    cell.orderids=[NSString stringWithFormat:@"%@",[[_arrArray objectAtIndex:indexPath.section] objectForKey:@"orderid"]];
    cell.dingdanhao888=[NSString stringWithFormat:@"订单号:%@",[[_arrArray objectAtIndex:indexPath.section] objectForKey:@"dingdanhao"]];
    
    ROW=indexPath.row;
    
    return cell;
    
}
- (void)btnClick:(UIButton *)btn
{
    
//    ItineraryTableViewCell * cell=(ItineraryTableViewCell *)[btn superview];
//    InforFondViewController *vc =[[InforFondViewController alloc]init];
//    vc.carid =cell.carid;
//    [self.navigationController pushViewController:vc animated:YES];
//    NSLog(@"%@",cell.name.text);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return Height(19);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 9.9;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  ScreenWidth *0.26;
}
-(void)buttonSelected:(UIButton*)sender{
    if (_tmpBtn == nil){
        sender.selected = YES;
        _tmpBtn = sender;
    }
    else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        
    }
    else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        sender.selected = YES;
        _tmpBtn = sender;
    }
    
    [UIView animateWithDuration:0.3 animations:^
     {
         _lineLabel.center = CGPointMake(sender.center.x, ScreenWidth*0.13);
         
     }];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    
    UIView *sectionview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width,tableView.bounds.size.height)];
    
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, Height(3), ScreenWidth,Height(19));
    view.backgroundColor=[UIColor whiteColor];
    [sectionview addSubview:view];
    
    float nowHeight =view.frame.size.height;
    UILabel *label =[[UILabel alloc]init];
    label.frame =CGRectMake(Height(25), 0, ScreenWidth*0.7, nowHeight);
    [label setTextAlignment:NSTextAlignmentLeft];
    
    //时间前面的圆
    UIImageView *yuan=[[UIImageView alloc]initWithFrame:CGRectMake(Height(10),(nowHeight-Height(10))/2 , Height(10), Height(10))];
    [yuan setImage:[UIImage imageNamed:@"圆40-40"]];
    [view addSubview:yuan];
    NSLog(@"这是%ld",ROW);
    NSArray * array =[[_arrArray objectAtIndex:section]objectForKey:@"carlist"];
    NSString *TIME=[[NSString alloc]init];
    if (ROW>0) {
        TIME= [NSString stringWithFormat:@"%@",[[array objectAtIndex:0] objectForKey:@"chuche"]];
    }else
    {
        TIME= [NSString stringWithFormat:@"%@",[[array objectAtIndex:ROW] objectForKey:@"chuche"]];
    }
    
    
    NSString *diyige=[[NSString alloc]init];
    if ([TIME isEqualToString:@"(null)"]) {
        diyige=@"2016-03-18";
    }else
    {
        diyige=[NSString stringWithFormat:@"%@",[TIME componentsSeparatedByString:@" "][0]];
    }
    
    label.text =diyige;
    
    label.textColor =[UIColor blackColor];
    label.alpha=0.7;
    label.font=[UIFont boldSystemFontOfSize:Height(14)];
    [view addSubview:label];
    
    UIImageView*imageViewes =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.03-ScreenWidth*0.03, nowHeight/2-ScreenWidth*0.03/2, ScreenWidth*0.03, ScreenWidth*0.03)];
    imageViewes.image=[UIImage imageNamed:@"right"];
    [view addSubview:imageViewes];
    UIColor *dianhuacolor=Color(18, 152, 233)//蓝
    UIColor *jiedancolor=Color(246, 99, 107)//红
    UIColor *shenghuicolor=Color(32, 32, 32)//灰字
    
    UILabel * zhuangtai =[[UILabel alloc]initWithFrame: CGRectMake(ScreenWidth-ScreenWidth*0.07-Height(185), 0, Height(180), nowHeight)];
    NSString * string =[NSString stringWithFormat:@"%@",[[_arrArray objectAtIndex:section] objectForKey:@"status"]];
    if ([string isEqualToString:@"1"]) {
        zhuangtai.text  =@"等待车主接单";
        zhuangtai.textColor=shenghuicolor;
    }if ([string isEqualToString:@"2"]) {
        zhuangtai.text  =@"车主拒绝";
        zhuangtai.textColor=jiedancolor;
    }if ([string isEqualToString:@"3"]) {
        zhuangtai.text  =@"等待支付定金";
        zhuangtai.textColor=dianhuacolor;
    }if ([string isEqualToString:@"3.5"]) {
        zhuangtai.text  =@"等待车辆到达";
        zhuangtai.textColor=dianhuacolor;
    }if ([string isEqualToString:@"4.5"]) {
        zhuangtai.text  =@"扫描二维码";
        zhuangtai.textColor=dianhuacolor;
    }if ([string isEqualToString:@"4"]) {
        zhuangtai.text  =@"等待支付尾款";
        zhuangtai.textColor=shenghuicolor;
    }if ([string isEqualToString:@"5"]) {
        zhuangtai.text  =@"完成";
        zhuangtai.textColor=shenghuicolor;
    }if ([string isEqualToString:@"6"]) {
        zhuangtai.text  =@"已取消";
        zhuangtai.textColor=jiedancolor;
    }
    
    zhuangtai.textAlignment =NSTextAlignmentRight;
    zhuangtai.font=[UIFont systemFontOfSize:12];
    [view addSubview:zhuangtai];
    
    
    UIButton *btn =[UIButton buttonWithType: UIButtonTypeSystem];
    btn.frame =CGRectMake(0, 0, ScreenWidth, Height(30));
    btn.tag =section;
    [btn addTarget:self action:@selector(btnClickClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    return sectionview;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XQyemianViewController * pay =[[XQyemianViewController alloc]init];
    pay.orderid=[NSString stringWithFormat:@"%@",[[_arrArray objectAtIndex:indexPath.section] objectForKey:@"orderid"]];
    pay.dingdanhao8=[NSString stringWithFormat:@"订单号:%@",[[_arrArray objectAtIndex:indexPath.section] objectForKey:@"dingdanhao"]];
    [self.navigationController pushViewController:pay  animated:YES];
}
-(void)btnClickClick:(UIButton *)sender
{
    
    NSLog(@"%ld",(long)sender.tag);
    
    
    XQyemianViewController * pay =[[XQyemianViewController alloc]init];
    pay.orderid=[NSString stringWithFormat:@"%@",[[_arrArray objectAtIndex:sender.tag] objectForKey:@"orderid"]];
    pay.dingdanhao8=[NSString stringWithFormat:@"订单号:%@",[[_arrArray objectAtIndex:sender.tag] objectForKey:@"dingdanhao"]];
    [self.navigationController pushViewController:pay  animated:YES];
    
    
    //    XQyemianViewController * pay =[[XQyemianViewController alloc]init];
    //    pay.orderid =cell.orderids;
    //    pay.dingdanhao8 =cell.dingdanhao888;
    
    //    [self.navigationController pushViewController:pay animated:YES];
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
