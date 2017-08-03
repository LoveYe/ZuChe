//
//  MyCollectionViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/13.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "AllPages.pch"
//#import "PaymentSuccessTableViewCell.h"
#import "HttpManager.h"
#import "UIImageView+WebCache.h"
#import "UILabel+SizeLabel.h"
#import "ZCUserData.h"
#import "SXFirsttableViewModel.h"
#import "ShoucangController.h"
#import "LoginView.h"

@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float myWidths;
    UIImageView*   _imageView;
    UILabel*_tishi;
    NSMutableArray *arrayList;;
}
@property (strong,nonatomic)UITableView  * tableView;
@property (strong,nonatomic)NSMutableArray *listArray;
@end

@implementation MyCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self addTitleViewWithTitle:@"我的收藏"];
    if ([ZCUserData share].isLogin==NO)
    {
        [self myCollectIsEmpty];
    }
    else
    {
        if (!_listArray)
        {
            _listArray =[NSMutableArray array];
        }
        
        [GiFHUD setGifWithImageName:@"动态gif.gif"];
        [GiFHUD showWithOverlay];
        [self tableViews];
        
        NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
        arrayList=[NSMutableArray array];
        NSLog(@"%@",dict);
        [HttpManager arrayPostData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=my_shoucang",NowUrl] Arraysuccess:^(NSArray *arrayfanhui) {
            NSLog(@"%@",arrayfanhui);
            arrayList=(NSMutableArray *)arrayfanhui;
            for (NSDictionary * dict in arrayfanhui)
            {
                SXFirsttableViewModel *model=[SXFirsttableViewModel ViewWithDictionary:dict];
                [_listArray addObject:model];
            }
            [GiFHUD dismiss];
            [self.tableView reloadData];
            
            if (_listArray.count==0){
                
                [self myCollectIsEmpty];
            }
        } Error:^(NSString *cuowuxingxi) {
            NSLog(@"%@",cuowuxingxi);
        }];
    }
}
//收藏为空
-(void)myCollectIsEmpty{
    
    [self.tableView removeFromSuperview];
    
    CGFloat width = self.view.frame.size.width;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(20, 40, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(kaishi:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"无收藏.jpg"];
    image.userInteractionEnabled = YES;
    [self.view addSubview:image];
    
    UILabel *da = [[UILabel alloc] initWithFrame:CGRectMake(width*0.7, width*0.3, width*0.2, width*0.1)];
    da.text = @"收藏";
    da.textAlignment = NSTextAlignmentRight;
    da.adjustsFontSizeToFitWidth = YES;
    da.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:35];
    da.textColor = [UIColor whiteColor];
    [image addSubview:da];
    
    UILabel *xiao = [[UILabel alloc] initWithFrame:CGRectMake(width*0.3, CGRectGetMaxY(da.frame)+20, width*0.6, width*0.1)];
    xiao.text = @"您还没有收藏任何车辆";
    xiao.textColor = [UIColor whiteColor];
    xiao.textAlignment = NSTextAlignmentRight;
    xiao.adjustsFontSizeToFitWidth = YES;
    xiao.font = [UIFont fontWithName:@"AmericanTypewriter" size:20];
    [image addSubview:xiao];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-width*0.13-64, width, width*0.13);
    button.backgroundColor = Color(0, 215, 200);
    [button setTitle:@"开始探索" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(kaishi:) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:button];
    
//    ShoucangController *view = [[ShoucangController alloc] init];
//    [self.navigationController pushViewController:view animated:YES];
}
- (void)kaishi:(UIButton *)sender{
    
    RootViewcontroller *view = [[RootViewcontroller alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = view;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    if ([ZCUserData share].isLogin == NO) {
        
        LoginView *view = [[LoginView alloc] init];
        view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:view animated:NO];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
-(void)tableViews
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  0, ScreenWidth, ScreenHeight-65)];
    self.tableView.delegate =self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=Color(245, 245, 249);
    [self.view addSubview:self.tableView];
    
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    int num;
    //    if (section ==0)
    //    {
    //        num =1;
    //    }else
    //    {
    //        num=3;
    //    }
    return 1;
}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
////    PaymentSuccessTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
////    if (!cell)
////    {
////        cell =[[PaymentSuccessTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
////        
////    }
////    cell.selectionStyle=UITableViewCellSelectionStyleNone;
////    [cell.photo sd_setImageWithURL:[[_listArray objectAtIndex:indexPath.section] objectForKey:@"thumb"] placeholderImage:[UIImage imageNamed:@"placeholder_100x100@2x.png"]];
////    cell.title.text =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"models"]] ;
////    cell.chepai.text =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"plate"]] ;
////    cell.jiage.text =[NSString stringWithFormat:@"¥ %@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"carmoney"]] ;
////    
////    
////    myWidths =[UILabel width:cell.jiage.text heightOfFatherView:cell.jiage.frame.size.height textFont:cell.jiage.font];
////    cell.jiage.frame =CGRectMake(ScreenWidth*0.031*2+ScreenWidth*0.42, ScreenWidth*0.138, myWidths, ScreenWidth*0.05);
////    cell.lucheng.text =[NSString stringWithFormat:@"/%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"cargongli"]];
////    cell.lucheng.frame =CGRectMake(ScreenWidth*0.031*2+ScreenWidth*0.42+myWidths+1, ScreenWidth*0.143, ScreenWidth*0.34, ScreenWidth*0.04);
////    
////    
////    cell.jiedanlv.text =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"jiedan"]] ;
////    cell.fuwu.text =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"fuwu"]] ;
////    
////    
////    NSString * str=[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"tiqian"]] ;
////    if (str==nil||[str isEqualToString:@""]||[str isKindOfClass:[NSNull class]])
////    {
////        cell.time.text=@"0";
////    }else
////    {
////        cell.time.text =str;
////
////    }
//    static NSString *addcell=@"addcell";
////    AddchezhuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:addcell];
////    
////    if (!cell) {
////        cell=[[[NSBundle mainBundle] loadNibNamed:@"AddchezhuTableViewCell" owner:self options:nil] firstObject];
////    }
////    cell.shenhe.hidden=YES;
////    cell.tuijian.layer.borderWidth=0.5;
////    cell.tuijian.layer.borderColor=[UIColor colorWithRed:82/255.0 green:203/255.0 blue:255/255.0 alpha:1].CGColor;
////    cell.tuijian.layer.cornerRadius = 3.0;
////    cell.selectionStyle=UITableViewCellSelectionStyleNone;
////    cell.Autojiedan.transform=CGAffineTransformMakeRotation(M_PI/-4);
////    cell.Autojiedan.font=Font(9);
////    cell.Yjiedan.hidden=YES;
////    [self label:cell.tuijian isBold:YES isFont:10.0f];
////    [self label:cell.urlTitle isBold:NO isFont:12.5f];
////    [self label:cell.paizhao isBold:NO isFont:9.5f];
////    [self label:cell.qian isBold:YES isFont:13];
////    [self label:cell.timeKm isBold:NO isFont:10.0f];
////    [self label:cell.baifenbi isBold:NO isFont:11.5f];
////    [self label:cell.fuwu isBold:NO isFont:11.5f];
////    [self label:cell.tiqian isBold:NO isFont:11.5f];
////    [self label:cell.wenzitiqian isBold:NO isFont:11.0f];
////    [self label:cell.wenzifuwu isBold:NO isFont:11.0f];
////    [self label:cell.wenzijiedan isBold:NO isFont:11.0f];
//    SXFirsttableViewModel *model=_listArray[indexPath.section];
////    [cell confit:model];
////
////    cell.qian.text=[NSString stringWithFormat:@"%@",[[arrayList objectAtIndex:indexPath.row] objectForKey:@"carmoney"]];
////    cell.timeKm.text=[NSString stringWithFormat:@"/%@",[[arrayList objectAtIndex:indexPath.row] objectForKey:@"cargongli"]];
////    return cell;
//    
//}
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return _listArray.count;
}
-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  ScreenWidth *0.32;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    InforFondViewController *infor=[[InforFondViewController alloc]init];
//    NSString * string =[NSString stringWithFormat:@"%@",[[arrayList objectAtIndex:indexPath.section] objectForKey:@"carid"]];
//    infor.carid=string;
//    [self.navigationController pushViewController:infor animated:YES];
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
