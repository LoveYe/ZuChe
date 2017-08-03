//
//  ServiceCentreViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/13.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import "ServiceCentreViewController.h"
#import "TenantViewController.h"
#import "TheOwnerViewController.h"
#import "AllPages.pch"

@interface ServiceCentreViewController ()<UIScrollViewDelegate>
{
    UIButton *_give;
    UIButton *_get;
    
    UILabel  *_gixian;
    UILabel  *_gexian;
    
}
@property (nonatomic,retain)UIScrollView *scrollview;

@end

@implementation ServiceCentreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithTitle:@"服务中心"];
    
    
    _scrollview =[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight)];
    _scrollview.delegate =self;
    _scrollview.pagingEnabled =YES;
    _scrollview.scrollEnabled=NO;
    _scrollview.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeight);
    [self.view addSubview:_scrollview];
    [self viewController];
    
    
    
    _give=[UIButton buttonWithType:UIButtonTypeSystem];
    _give.frame= CGRectMake( 0, 0, ScreenWidth/2, ScreenWidth*0.125);
    
    
    UIColor *color =Color(0, 170, 238)
    [_give setTintColor:color];
    _give.titleLabel.font =[UIFont systemFontOfSize:14.0f];
    _give.backgroundColor =[UIColor whiteColor];
    
    [_give setTitle:@"我是租客" forState:UIControlStateNormal];
    [_give addTarget:self action:@selector(latesBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_give];
    _gixian=[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.125-1, ScreenWidth/2, 1)];
    //    _gixian.backgroundColor =Color(74, 163, 96);
    [_give addSubview:_gixian];
    _gixian.backgroundColor =color;
    
    
    
    
    _get =[UIButton buttonWithType:UIButtonTypeSystem];
    _get.frame= CGRectMake( ScreenWidth/2,0, ScreenWidth/2, ScreenWidth*0.125);
    [_get setTintColor:[UIColor grayColor]];
    _get.titleLabel.font =[UIFont systemFontOfSize:14.0f];
    //    _get.backgroundColor =Color(234, 234, 234);
    
    
    
    [_get setTitle:@"我是车主" forState:UIControlStateNormal];
    [_get addTarget:self action:@selector(campusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_get];
    _gexian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.125-1, ScreenWidth/2, 1)];
    _gexian.backgroundColor =Color(225, 225, 225);
    
    
    [_get addSubview:_gexian];
}
-(void)viewController
{
    
    TenantViewController*give =[[TenantViewController alloc]init];
    give.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [_scrollview addSubview:give.view];
    [self addChildViewController:give];
    
    TheOwnerViewController *get =[[TheOwnerViewController alloc]init];
    get.view.frame =CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
    [_scrollview addSubview:get.view];
    [self addChildViewController:get];
    
}
-(void)latesBtnClick
{
    [UIView animateWithDuration:0.3 animations:^{
        _scrollview.contentOffset = CGPointMake(0, 0);
        //        _get.backgroundColor=Color(234, 234, 234);
        
        UIColor *color =Color(0, 170, 238);
        
        [_give setTintColor:color];
        [_get setTintColor:[UIColor grayColor]];
        
        _give .backgroundColor =[UIColor whiteColor];
        
        _gexian.backgroundColor =Color(225, 225, 225);
        _gixian.backgroundColor =Color(0, 170, 238);
        
        
    }];
}
-(void)campusBtnClick
{
    [UIView animateWithDuration:0.3 animations:^{
        _scrollview.contentOffset = CGPointMake(ScreenWidth, 0);
        _get.backgroundColor =[UIColor whiteColor];
        
        UIColor *color =Color(0, 170, 238);
        [_get setTintColor:color];
        [_give setTintColor:[UIColor grayColor]];
        _gexian.backgroundColor =Color(0, 170, 238);
        _gixian.backgroundColor = Color(225, 225, 225);
        
    }];
    
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
