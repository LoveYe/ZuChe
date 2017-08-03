//
//  ItineraryViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/10/21.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "ItineraryViewController.h"
#import "Header.h"
#import "GoForwardViewController.h"
#import "AccomplishViewController.h"
#import "CancelViewController.h"
#import "ItineraryTableViewCell.h"
#import "PaymentSuccessViewController.h"
#import "AllPages.pch"
#import "UILabel+SizeLabel.h"
#import "CompleteViewController.h"
#import "NoOrderViewController.h"
#import "MessageCenterViewController.h"
#import "LoginView.h"
#import "RootViewcontroller.h"

#import "WYJPageView.h"

@interface ItineraryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>{
    
    UIView *_lineLabel;
    NSArray *_array;
    UIWebView * _webView ;
    NSArray * _ipArray ;
    UIScrollView *_scrollView;
    
    NSMutableArray * urlArray;
    UICollectionView *collectionView;
    int currentIndex;
    UIScrollView * _scroll;
    UIPageControl *_pageCon;
    UIView *vii;
    UIView *smallView;
    WYJPageView *page;
    UIImageView *backgroundImg;
    
    
    UIScrollView *_scrollView2;
    CGFloat width;
    CGFloat height;
    UIButton *jinruButton;
    NSString *dingdan;
}
@property (nonatomic,retain)UIScrollView *scrollView;
@property (strong,nonatomic)UIButton * tmpBtn;
@property (strong,nonatomic)UITableView  * tableView;

@end

@implementation ItineraryViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    self.view.backgroundColor =Color(236, 236, 236);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*0.3, ScreenWidth*0.08)];
    label.text = @"我要租车";
    label.textColor = Color(100, 100, 100);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    self.navigationItem.titleView = label;
    
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightbutton setBackgroundImage:[UIImage imageNamed:@"信息(1)"] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(sousuobtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addItemWithCustomView:@[rightbutton] isLeft:NO];
    
//    [self createView];
}
-(void)sousuobtn:(UIButton *)sender{
    
    if ([ZCUserData share].isLogin==YES) {
        
        MessageCenterViewController *filea=[[MessageCenterViewController alloc]init];
        [self.navigationController pushViewController:filea animated:YES];
    }
    else{
        
        LoginView *filea1=[[LoginView alloc]init];
        [self.navigationController pushViewController:filea1 animated:YES];
    }
    
}
//
//-(void)noodere{
//    
//    [vii removeFromSuperview];
//    
//    [self createView];
//}
- (void)createView{
    
    _scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-ScreenWidth*0.1)];
    [self.view addSubview:_scrollView2];
    _scrollView2.pagingEnabled = YES;
    _scrollView2.delegate = self;
    _scrollView2.showsHorizontalScrollIndicator = NO;
    _scrollView2.clipsToBounds = NO;
    _scrollView2.contentSize = CGSizeMake(ScreenWidth*3, 0);
    
    page = [[WYJPageView alloc] initWithFrame:CGRectMake(0, ScreenHeight-ScreenWidth*0.6, ScreenWidth, ScreenWidth*0.1)];
    page.currentPage = 0;
    page.numberOfPages = 3;
    [page setSelect:[UIImage imageNamed:@"白1.png"]];
    [page setDeselest:[UIImage imageNamed:@"白.png"]];
    //    page.currentPageIndicatorTintColor = [UIColor greenColor];
    [page addTarget:self action:@selector(pageTuens:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:page];
    
    backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-ScreenWidth*0.25)];
    backgroundImg.image = [UIImage imageNamed:@"11.jpg"];
    backgroundImg.userInteractionEnabled = YES;
    [_scrollView2 addSubview:backgroundImg];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-ScreenWidth*0.25)];
    image2.image = [UIImage imageNamed:@"22.jpg"];
    image2.userInteractionEnabled = YES;
    [_scrollView2 addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, ScreenHeight-ScreenWidth*0.25)];
    image3.image = [UIImage imageNamed:@"33.jpg"];
    image3.userInteractionEnabled = YES;
    [_scrollView2 addSubview:image3];
    
    UILabel *zi1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.93, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi1.text = @"省去所有中间环节，尽享";
    zi1.textColor = [UIColor whiteColor];
    zi1.textAlignment = NSTextAlignmentCenter;
    zi1.font = [UIFont fontWithName:@"ArialMT" size:24];
    [backgroundImg addSubview:zi1];
    UILabel *zi2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, height-ScreenWidth*0.83, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi2.text = @"信息透明为您带来的";
    zi2.textColor = [UIColor whiteColor];
    zi2.textAlignment = NSTextAlignmentCenter;
    zi2.font = [UIFont fontWithName:@"ArialMT" size:24];
    [backgroundImg addSubview:zi2];
    UILabel *jia1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight-ScreenWidth*0.73, ScreenWidth*0.8, ScreenWidth*0.1)];
    jia1.text = @"实惠价格与优质服务";
    jia1.textColor = [UIColor whiteColor];
    jia1.textAlignment = NSTextAlignmentCenter;
    jia1.font = [UIFont fontWithName:@"ArialMT" size:24];
    [backgroundImg addSubview:jia1];
    
    UILabel *zi3 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, height-ScreenWidth*0.83, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi3.text = @"完善的1对1车辆评价机制，";
    zi3.textColor = [UIColor whiteColor];
    zi3.textAlignment = NSTextAlignmentCenter;
    zi3.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image2 addSubview:zi3];
    UILabel *zi4 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, height-ScreenWidth*0.73, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi4.text = @"有效监督车辆的规范服务。";
    zi4.textColor = [UIColor whiteColor];
    zi4.textAlignment = NSTextAlignmentCenter;
    zi4.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image2 addSubview:zi4];
    
    
    UILabel *zi5 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, height-ScreenWidth*0.93, ScreenWidth*0.8, ScreenWidth*0.1)];
    zi5.text = @"以赤城执着的匠人之心，";
    zi5.textColor = [UIColor whiteColor];
    zi5.textAlignment = NSTextAlignmentCenter;
    zi5.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image3 addSubview:zi5];
    UILabel *zi6 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, height-width*0.83, width*0.8, width*0.1)];
    zi6.text = @"为您做好100%的准备，";
    zi6.textColor = [UIColor whiteColor];
    zi6.textAlignment = NSTextAlignmentCenter;
    zi6.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image3 addSubview:zi6];
    UILabel *zi7 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, height-width*0.73, width*0.8, width*0.1)];
    zi7.text = @"解决您100%的问题！";
    zi7.textColor = [UIColor whiteColor];
    zi7.textAlignment = NSTextAlignmentCenter;
    zi7.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image3 addSubview:zi7];
    
    
    jinruButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [jinruButton setTitle:@"开始新行程" forState:UIControlStateNormal];
    [jinruButton addTarget:self action:@selector(jinruNextPage:) forControlEvents:UIControlEventTouchUpInside];
    jinruButton.frame = CGRectMake(0, height-width*0.42, width, width*0.13);
    jinruButton.backgroundColor = Color(255, 87, 87);
    [self.view addSubview:jinruButton];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int count = scrollView.contentOffset.x/ScreenWidth;
    [UIView animateWithDuration:0.3 animations:^
     {
         _lineLabel.center =  CGPointMake(ScreenWidth/3/2+(ScreenWidth/3)*count, ScreenWidth*0.13);
     }];
    
    CGFloat currentPostion = _scrollView2.contentOffset.x;
    int i = (currentPostion+width/2)/width;
    page.currentPage = i;
    if (i == 0) {
        jinruButton.backgroundColor = Color(255, 87, 87);
    }
    if (i == 1) {
        
        jinruButton.backgroundColor = Color(255, 177, 7);
    }if (i == 2) {
        
        jinruButton.backgroundColor = Color(0, 97, 107);
    }
}
- (void)pageTuens:(UIPageControl *)sender{
    
    // CGSize viewSize = _scrollView.frame.size;
    // CGRect rect = CGRectMake(sender.currentPage*viewSize.width, 0, viewSize.width, viewSize.height);
    //[_scrollView scrollRectToVisible:rect animated:YES];
    
    NSInteger page1 = page.currentPage;
    [_scrollView2 setContentOffset:CGPointMake(width*page1, 0)];
}
- (void)jinruNextPage:(UIButton *)button{
    
    RootViewcontroller *view = [[RootViewcontroller alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = view;
}

- (void)itinerary{
    
    [_scrollView removeFromSuperview];
    [smallView removeFromSuperview];
     smallView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.13+1)];
    smallView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:smallView];
    NSArray * array =[NSArray arrayWithObjects:@"进行中",@"已完成",@"已取消", nil];
    for ( int i=0; i<3; i++)
    {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+100;
        btn.frame =CGRectMake(ScreenWidth/3*i, 0, ScreenWidth/3, ScreenWidth*0.13);
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        UIColor *color =Color(0, 170, 238);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.userInteractionEnabled = YES;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:color forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [smallView addSubview:btn];
        
        if (i == 0)
        {
            UIColor *color =Color(0, 136, 231);
            [btn setTintColor:color];
            
            _lineLabel = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.13, ScreenWidth/3, 0.5)];
            _lineLabel.backgroundColor = Color(0, 136, 231);
            [smallView addSubview:_lineLabel];
        }
    }
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.13+1, ScreenWidth, ScreenHeight)];
    _scrollView.contentSize = CGSizeMake( ScreenWidth*3, ScreenHeight);
    _scrollView.pagingEnabled =YES;
    _scrollView.delegate = self;
    _scrollView.bounces=NO;
    _scrollView .backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_scrollView];
    [self creatChildViewController];
}
- (void)creatChildViewController
{
    GoForwardViewController *gf =[[GoForwardViewController alloc]init];
    gf.view.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [_scrollView addSubview:gf.view];
    [self addChildViewController:gf];
    
    AccomplishViewController *av =[[AccomplishViewController alloc]init];
    av.view.frame =CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
    [_scrollView addSubview:av.view];
    [self addChildViewController:av];
    
    CompleteViewController *vc =[[CompleteViewController alloc]init];
    vc.view.frame =CGRectMake(ScreenWidth*2, 0, ScreenWidth, ScreenHeight);
    [_scrollView addSubview:vc.view];
    [self addChildViewController:vc];
}
- (void)valueChange
{
    [UIView animateWithDuration:0.5 animations:^{
        _scroll.contentOffset = CGPointMake(_pageCon.currentPage*ScreenWidth, 0);
    }];
}
-(void)buttonSelected:(UIButton*)button
{
    
    [UIView animateWithDuration:0.3 animations:^{
         
         _scrollView.contentOffset = CGPointMake(ScreenWidth*(button.tag-100), 0);
     }];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSString *jia=[[NSString alloc]init];
    
    if ([ZCUserData share].isLogin == YES) {
        
        jia = [ZCUserData share].userId;
        [self panduan];
    }else
        [self createView];
    
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBarController.tabBar setShadowImage:[UIImage new]];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_scrollView removeFromSuperview];
    [_scrollView2 removeFromSuperview];
}
- (void)panduan{
    
    __weak __typeof(self) wself = self;
    
    NSString *jia=[[NSString alloc]init];
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:jia,@"userid", nil];
    [HttpManager postData:dic andUrl:PANDUANXINGCHENG success:^(NSDictionary *fanhuicanshu) {
        dingdan=[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"error"]];
        if ([dingdan isEqualToString:@"0"]) {
            //有数据
            [wself itinerary];
        }else
        {
            //没数据
            [_scrollView2 removeFromSuperview];
            [self createView];
        }
    } Error:^(NSString *cuowuxingxi) {
        //没数据
//        XingChengController *view = [[XingChengController alloc] init];
//        [wself.navigationController pushViewController:view animated:YES];
    }];
}
- (void)kaishi:(UIButton *)sender{
    
    RootViewcontroller *view = [[RootViewcontroller alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
