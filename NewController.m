//
//  NewController.m
//  ZuChe
//
//  Created by apple  on 2017/2/14.
//  Copyright © 2017年 佐途. All rights reserved.
//

#define CHGIFAnimationDict @[\
@{@"pattern":@"PullToRefresh_%03d.png",@"drawingStart":@0,@"drawingEnd":@73,@"loadingStart":@73,@"loadingEnd":@140}\
]

#define GifRefreshControlHeight 70.0
static char UIScrollViewGifPullToRefresh;

#import "NewController.h"
#import "Header.h"
#import "LoginView.h"
#import "CarInfoModel.h"
#import "ZCUserData.h"
#import "AFHTTPRequestOperationManager.h"
#import "HttpManager.h"
#import "SDWebImage/UIImageView+WebCache.h"

#import "CarOwnerCell.h"
#import "CarOwnerList2.h"

#import "UIScrollView+GifPullToRefresh.h"
#import <objc/runtime.h>

#import "ParentsViewController.h"
#import "TiJiaoViewController.h"

#import "AddYourCars.h"
#import "CarShenheView.h"
#import "CarYearView.h"
#import "LoginView.h"

#import "WYJPageView.h"

#define URL_PATN @"http://wx.leisurecarlease.com/api.php?op=api_carlist"
#define Font(F) [UIFont fontWithName:@"STHeitiSC-Light" size:(F)/320.0*ScreenWidth]
#define Height(H) (H)/320.0*ScreenWidth


@interface NewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    CGFloat width;
    
    NSDictionary *Dicttt;
    NSMutableArray *countArray;
//    CarOwnerCell *cell;
    
    UIImageView *iconImage;
    
    UIButton *btn12;
    UIView *vii;

    UILabel *name;
    UIScrollView *_scrollView;
    WYJPageView *page;
    UIImageView *backgroundImg;
    UIButton *jinruButton;
}

@end

@implementation NewController

- (void)viewWillAppear:(BOOL)animated{
    
    if ([ZCUserData share].isLogin == YES) {
        
        [self downLoad];
    }else
        [self createView];
    
//    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil];
//    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.tabBarController.tabBar setHidden:NO];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [_tableView removeFromSuperview];
    [_scrollView removeFromSuperview];
    [jinruButton removeFromSuperview];
}
- (void)createView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, ScreenHeight-width*0.1)];
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.clipsToBounds = NO;
    _scrollView.alwaysBounceHorizontal = NO;
    _scrollView.contentSize = CGSizeMake(width*3, 0);
    
    page = [[WYJPageView alloc] initWithFrame:CGRectMake(0, ScreenHeight-width*0.6, width, width*0.1)];
    page.currentPage = 0;
    page.numberOfPages = 3;
    [page setSelect:[UIImage imageNamed:@"白1.png"]];
    [page setDeselest:[UIImage imageNamed:@"白.png"]];
    //    page.currentPageIndicatorTintColor = [UIColor greenColor];
    [page addTarget:self action:@selector(pageTuens:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:page];
    
    backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, ScreenHeight-width*0.25)];
    backgroundImg.image = [UIImage imageNamed:@"图1.jpg"];
    backgroundImg.userInteractionEnabled = YES;
    [_scrollView addSubview:backgroundImg];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, ScreenHeight-width*0.25)];
    image2.image = [UIImage imageNamed:@"图2.jpg"];
    image2.userInteractionEnabled = YES;
    [_scrollView addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(width*2, 0, width, ScreenHeight-width*0.25)];
    image3.image = [UIImage imageNamed:@"图3.jpg"];
    image3.userInteractionEnabled = YES;
    [_scrollView addSubview:image3];
    
    UILabel *zi1 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, ScreenHeight-width*0.83, width*0.8, width*0.1)];
    zi1.text = @"丰富您的闲暇时间和";
    zi1.textColor = [UIColor whiteColor];
    zi1.textAlignment = NSTextAlignmentCenter;
    zi1.font = [UIFont fontWithName:@"ArialMT" size:24];
    [backgroundImg addSubview:zi1];
    UILabel *zi2 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, ScreenHeight-width*0.73, width*0.8, width*0.1)];
    zi2.text = @"闲置车辆，赚取额外收入!";
    zi2.textColor = [UIColor whiteColor];
    zi2.textAlignment = NSTextAlignmentCenter;
    zi2.font = [UIFont fontWithName:@"ArialMT" size:24];
    [backgroundImg addSubview:zi2];
    
    UILabel *zi3 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, ScreenHeight-width*0.83, width*0.8, width*0.1)];
    zi3.text = @"将来自各行各业的优秀人才";
    zi3.textColor = [UIColor whiteColor];
    zi3.textAlignment = NSTextAlignmentCenter;
    zi3.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image2 addSubview:zi3];
    UILabel *zi4 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, ScreenHeight-width*0.73, width*0.8, width*0.1)];
    zi4.text = @"迎入您的社交圈!";
    zi4.textColor = [UIColor whiteColor];
    zi4.textAlignment = NSTextAlignmentCenter;
    zi4.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image2 addSubview:zi4];
    
    
    UILabel *zi5 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, ScreenHeight-width*0.93, width*0.8, width*0.1)];
    zi5.text = @"加入这个充满激情的车主社";
    zi5.textColor = [UIColor whiteColor];
    zi5.textAlignment = NSTextAlignmentCenter;
    zi5.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image3 addSubview:zi5];
    UILabel *zi6 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, ScreenHeight-width*0.83, width*0.8, width*0.1)];
    zi6.text = @"区,尽享闲车租赁的24小时";
    zi6.textColor = [UIColor whiteColor];
    zi6.textAlignment = NSTextAlignmentCenter;
    zi6.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image3 addSubview:zi6];
    UILabel *zi7 = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, ScreenHeight-width*0.73, width*0.8, width*0.1)];
    zi7.text = @"全天候支持";
    zi7.textColor = [UIColor whiteColor];
    zi7.textAlignment = NSTextAlignmentCenter;
    zi7.font = [UIFont fontWithName:@"ArialMT" size:24];
    [image3 addSubview:zi7];
    
    jinruButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [jinruButton setTitle:@"发布新车源" forState:UIControlStateNormal];
    [jinruButton addTarget:self action:@selector(jinruNextPage:) forControlEvents:UIControlEventTouchUpInside];
    jinruButton.frame = CGRectMake(0, ScreenHeight-width*0.13-64-44, width, width*0.13);
    jinruButton.backgroundColor = Color(255, 87, 87);
    [self.view addSubview:jinruButton];
    
}
- (void)jinruNextPage:(UIButton *)button{
    
    NSLog(@"发布车辆");
    if ([ZCUserData share].isLogin==YES) {
        
        //        [backgroundImg removeFromSuperview];
        
        TiJiaoViewController *view=[[TiJiaoViewController alloc]init];
        view.hidesBottomBarWhenPushed = YES;view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];

        
        [self.navigationController pushViewController:view animated:NO];
    }else{
        
        LoginView *view = [[LoginView alloc] init];
        [self.navigationController pushViewController:view animated:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat currentPostion = _scrollView.contentOffset.x;
    
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
    [_scrollView setContentOffset:CGPointMake(width*page1, 0)];
    
}


// ********************************************
- (void)downLoad{
    
    [btn12 removeFromSuperview];
    
    NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:
                              [ZCUserData share].userId,@"userid",nil];
    
    [HttpManager postData:parameters andUrl:URL_PATN success:^(NSDictionary *fanhuicanshu) {
        
        NSMutableArray *panduan = fanhuicanshu[@"carlist"];
        
        if (panduan.count == 0) {
            
            [_scrollView removeFromSuperview];
            [self createView];
        }else{
            
            countArray = [NSMutableArray arrayWithArray:fanhuicanshu[@"carlist"]];
            Dicttt = fanhuicanshu[@"userinfo"];
            
            btn12=[UIButton buttonWithType:UIButtonTypeCustom];
            btn12.frame=CGRectMake(0, (countArray.count)*(ScreenWidth*0.2125), ScreenWidth, width*0.2125);
            btn12.backgroundColor=Color(240, 240, 240);
            [btn12 setTitle:@"添加新车源" forState:UIControlStateNormal];
            btn12.titleLabel.font = Font(13);
            [btn12 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(width/2+width*0.06, width*0.06, width*0.09, width*0.09)];
            imageview.image = [UIImage imageNamed:@"++.png"];
            [btn12 addSubview:imageview];
            
            [btn12 setTitleEdgeInsets:UIEdgeInsetsMake(0, -ScreenWidth*0.05, 0, ScreenWidth*0.05)];
            [btn12 addTarget:self action:@selector(btnchick:) forControlEvents:UIControlEventTouchUpInside];
            [vii removeFromSuperview];
            
            [_tableView reloadData];
            // 新建tableView
            [self createTableView];
            
            [_tableView  addSubview:btn12];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn12.frame), width, 1)];
            label.backgroundColor = Color(227, 227, 227);
            [_tableView addSubview:label];
            
        }
        
    } Error:^(NSString *cuowuxingxi) {
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"5001" forKey:@"nayiduan"];
    
    width = self.view.frame.size.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width*0.3, width*0.08)];
    label.text = @"我的车辆";
    label.textColor = Color(100, 100, 100);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    self.navigationItem.titleView = label;
    
    self.view.backgroundColor = Color(240, 240, 240);
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, self.view.frame.size.height-49)];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = YES;
    [self.view addSubview:_tableView];
    
    _tableView.backgroundColor = Color(240, 240, 240);
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIColor *color = Color(227, 227, 227);
    [_tableView setSeparatorColor:color];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(downLoad) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
}
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    // 此处添加刷新tableView数据的代码
    [refreshControl endRefreshing];
    [_tableView reloadData];// 刷新tableView即可
}
#pragma mark - reloadCell
-(void)Refresh_JXY:(UITableView *)TABLEVIEW VOID:(Refresh)VOID{
    
    NSMutableArray *drawingImgs = [NSMutableArray array];
    NSMutableArray *loadingImgs = [NSMutableArray array];
    NSUInteger drawingStart = [CHGIFAnimationDict[0][@"drawingStart"] intValue];
    NSUInteger drawingEnd = [CHGIFAnimationDict[0][@"drawingEnd"] intValue];
    NSUInteger laodingStart = [CHGIFAnimationDict[0][@"loadingStart"] intValue];
    NSUInteger loadingEnd = [CHGIFAnimationDict[0][@"loadingEnd"] intValue];
    for (NSUInteger i  = drawingStart; i <= drawingEnd; i++) {
        
        NSString *fileName = [NSString stringWithFormat:CHGIFAnimationDict[0][@"pattern"],i];
        [drawingImgs addObject:[UIImage imageNamed:fileName]];
    }
    
    for (NSUInteger i  = laodingStart; i <= loadingEnd; i++) {
        
        NSString *fileName = [NSString stringWithFormat:CHGIFAnimationDict[0][@"pattern"],i];
        [loadingImgs addObject:[UIImage imageNamed:fileName]];
    }
    
    __weak UITableView *tempScrollView = TABLEVIEW;
    
    [TABLEVIEW addPullToRefreshWithDrawingImgs:drawingImgs andLoadingImgs:loadingImgs andActionHandler:^{
        [tempScrollView performSelector:@selector(didFinishPullToRefresh) withObject:nil afterDelay:1];
        VOID();
    }];
    
}
- (void)addPullToRefreshWithDrawingImgs:(NSArray*)drawingImgs andLoadingImgs:(NSArray*)loadingImgs andActionHandler:(void (^)(void))actionHandler{
    
    CHGifRefreshControl *view = [[CHGifRefreshControl alloc] initWithFrame:CGRectMake(0, -GifRefreshControlHeight, self.view.frame.size.width, GifRefreshControlHeight)];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        view.originalContentInsectY = 0;
    }
    
    view.scrollView = (UIScrollView *)self.view;
    view.pullToRefreshActionHandler = actionHandler;
    view.drawingImgs = drawingImgs;
    view.loadingImgs = loadingImgs;
    [self.view addSubview:view];
    self.refreshControl = view;
}
- (void)setRefreshControl:(CHGifRefreshControl *)pullToRefreshView {
    [self willChangeValueForKey:@"UIScrollViewGifPullToRefresh"];
    objc_setAssociatedObject(self, &UIScrollViewGifPullToRefresh,
                             pullToRefreshView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"UIScrollViewGifPullToRefresh"];
}
// ******************************************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return countArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return width*0.2125;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stac = @"stac";
    
    CarOwnerCell *cell = [tableView dequeueReusableCellWithIdentifier:stac];
    if (!cell) {
        
        cell = [[CarOwnerCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stac];
    }
    NSDictionary *dic = countArray[indexPath.row];
    cell.username = dic[@"name"];
    cell.sex = dic[@"sex"];
    cell.model = dic;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = Color(240, 240, 240);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = countArray[indexPath.row];
    if ([dic[@"status"] intValue] == 1||[dic[@"status"] isEqualToString:@""]) {
        
        AddYourCars *view = [[AddYourCars alloc] init];
        view.catid = dic[@"carid"];
        
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }if ([dic[@"status"] intValue] == 3) {
        
        CarShenheView *view = [[CarShenheView alloc] init];
        view.carid = dic[@"carid"];
        
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



-(void)btnchick:(UIButton *)sender
{
    //    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:sender];
    //    [self performSelector:@selector(todoSomething:) withObject:sender afterDelay:0.3f];
    
    if ([ZCUserData share].isLogin==YES) {
        
        TiJiaoViewController *view = [[TiJiaoViewController alloc]init];
        
        view.hidesBottomBarWhenPushed = YES;view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController pushViewController:view animated:NO];
    }else
    {
        LoginView *lodin=[[LoginView alloc]init];
        [self.navigationController pushViewController:lodin animated:YES];
    }
}
#pragma mark - Delete cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        NSDictionary *dic = countArray[indexPath.row];
        
        if ([dic[@"status"] intValue] == 2 || [dic[@"status"] intValue] == 3) {
            
            
        }else{
            
            NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:dic[@"carid"],@"carid",[ZCUserData share].userId,@"userid", nil];
            [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_delcar" success:^(NSDictionary *fanhuicanshu) {
                
                [countArray removeObjectAtIndex:indexPath.row];
                
                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
                [refreshControl beginRefreshing];
                [refreshControl addTarget:self action:@selector(downLoad) forControlEvents:UIControlEventValueChanged];
                [_tableView addSubview:refreshControl];
                [refreshControl beginRefreshing];
                [self refreshClick:refreshControl];
                [self downLoad];
            } Error:^(NSString *cuowuxingxi) {
                
            }];
            
            // button的位置发生改变
            btn12.frame=CGRectMake(0, (countArray.count)*(ScreenWidth*0.3125)+1, ScreenWidth, Height(35));
        }
    }
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
