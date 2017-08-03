//
//  PaizhaoViewController.m
//  ZuChe
//
//  Created by J.X.Y on 15/11/5.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import "PaizhaoViewController.h"
#import "AllPages.pch"
#import "MultilevelMenu.h"
@interface PaizhaoViewController ()
{
    NSString *jia;
    NSString *xian;
}
@end

@implementation PaizhaoViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    self.title = @"选择车牌";
    
    NSString* plistfile1 = [[NSBundle mainBundle]pathForResource:@"licence_plate_headers" ofType:@"plist"];
    NSMutableArray *plist=[NSMutableArray arrayWithContentsOfFile:plistfile1];
    
//    [self addTitleViewWithTitle:@"选择车牌"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(dizhi_xq:) name:@"dizhi_xq" object:nil];
    jia=[[NSString alloc]init];
    xian=[[NSString alloc]init];
    NSMutableArray * lis=[NSMutableArray arrayWithCapacity:0];
    /**
     *  构建需要数据 2层或者3层数据 (ps 2层也当作3层来处理)
     */
    NSInteger countMax=30;
    
    for (int i=0; i<countMax; i++) {
        
        rightMeun * meun=[[rightMeun alloc] init];
        meun.meunName=[NSString stringWithFormat:@"%@",[plist objectAtIndex:i]];
        NSMutableArray * sub=[NSMutableArray arrayWithCapacity:0];
        for ( int j=0; j <26; j++) {
            
            rightMeun * meun1=[[rightMeun alloc] init];
            meun1.meunName=[NSString stringWithFormat:@"%@",[plist objectAtIndex:i]];
            meun1.urlName=[NSString stringWithFormat:@"%c ",'A'+i];
            [sub addObject:meun1];
        }
        
        
        meun.nextArray=sub;
        [lis addObject:meun];
    }
    
    /**
     *  适配 ios 7 和ios 8 的 坐标系问题
     */
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    
    MultilevelMenu * view=[[MultilevelMenu alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) WithData:lis withSelectIndex:^(NSInteger left, NSInteger right,rightMeun* info) {
        
        
        xian=[NSString stringWithFormat:@"%@",info.meunName];
    }];
    
    /**
     默认是 选中第一行
     */
    view.needToScorllerIndex=0;
    
    view.isRecordLastScroll=YES;
    
    [self.view addSubview:view];
    
}
-(void)dizhi_xq:(NSNotification*)not{
    
    jia = [not object];
    NSLog(@"车牌是:%@",[xian stringByAppendingString:jia ]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"paizhao_duile" object:[xian stringByAppendingString:jia ]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
